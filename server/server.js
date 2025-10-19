const express = require('express');
const cors = require('cors');
const pool = require('./config/db');

const app = express();

// Middleware
app.use(cors({
  origin: [
    'http://localhost:3000', // Local development
    'https://senior-project-51782680110.asia-southeast1.run.app', // Production frontend
    'https://curriculum-statistics.web.app', // Firebase hosting if used
    'https://app.som-bi.work.gd', // Your custom domain
  ],
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));
app.use(express.json());

// Routes
// Health check endpoint
app.get('/api/health', async (req, res) => {
  try {
    // Test database connection
    const [result] = await pool.query('SELECT 1 + 1 AS result');
    res.json({
      status: 'ok',
      database: 'connected',
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Database connection error:', error);
    res.status(500).json({
      status: 'error',
      database: 'disconnected',
      error: error.message
    });
  }
});

// Self-development endpoint
app.get('/api/self-development/:staffCode', async (req, res) => {
  try {
    const { staffCode } = req.params;
    const { evaluateid } = req.query;
    
    let query = 'SELECT staffcode, title, date, type, location, evaluateid FROM self_development WHERE staffcode = ?';
    let params = [staffCode];
    
    if (evaluateid) {
      query += ' AND evaluateid = ?';
      params.push(evaluateid);
    }
    
    query += ' ORDER BY date DESC';
    
    const [rows] = await pool.query(query, params);
    
    res.json({
      success: true,
      data: rows,
      count: rows.length
    });
  } catch (error) {
    console.error('Error fetching self-development data:', error);
    res.status(500).json({
      success: false,
      error: error.message
    });
  }
});

// Evaluation Periods endpoint
app.get('/api/evaluation-periods', async (req, res) => {
  try {
    const [rows] = await pool.query(
      'SELECT evaluateid, evaluatename, evaluatestartdate, evaluateenddate, is_active FROM evaluation_periods ORDER BY evaluateid DESC'
    );
    
    res.json({
      success: true,
      data: rows
    });
  } catch (error) {
    console.error('Error fetching evaluation periods:', error);
    res.status(500).json({
      success: false,
      message: 'Internal server error',
      error: error.message
    });
  }
});


// Research Performance Chart endpoint removed - Frontend uses MFU API directly

// Academic Service Performance Chart endpoint removed - Frontend uses MFU API directly

// KPI endpoint removed - Frontend uses useMfuKpiApi composable to call MFU API directly

// Lecturer Dashboard API endpoints
// Get lecturer profile by staff code
app.get('/api/lecturer/profile/:staffCode', async (req, res) => {
  try {
    const { staffCode } = req.params;
    
    // Fetch lecturer profile from database
    const [rows] = await pool.query(
      'SELECT staff_code, staff_name, phone, location, program, position FROM lecturer_profiles WHERE staff_code = ?',
      [staffCode]
    );

    if (rows.length === 0) {
      // Return default profile structure if not found
      return res.json({
        staffCode,
        phone: 'n/a',
        location: 'n/a',
        program: 'n/a',
        position: 'n/a'
      });
    }

    const profile = rows[0];
    res.json({
      staffCode: profile.staff_code,
      phone: profile.phone || 'n/a',
      location: profile.location || 'n/a',
      program: profile.program || 'n/a',
      position: profile.position || 'n/a'
    });

  } catch (error) {
    console.error('Error fetching lecturer profile:', error);
    res.status(500).json({ error: 'Failed to fetch lecturer profile' });
  }
});

// Get lecturer education by staff code
app.get('/api/lecturer/education/:staffCode', async (req, res) => {
  try {
    const { staffCode } = req.params;
    
    const [rows] = await pool.query(
      'SELECT degree, institution, year FROM lecturer_education WHERE staff_code = ? ORDER BY year DESC',
      [staffCode]
    );

    res.json(rows);

  } catch (error) {
    console.error('Error fetching lecturer education:', error);
    res.status(500).json({ error: 'Failed to fetch lecturer education' });
  }
});

// Get lecturer research areas by staff code
app.get('/api/lecturer/research/:staffCode', async (req, res) => {
  try {
    const { staffCode } = req.params;
    
    const [rows] = await pool.query(
      'SELECT research_area FROM lecturer_research_areas WHERE staff_code = ? ORDER BY id',
      [staffCode]
    );

    const researchAreas = rows.map(row => row.research_area);
    res.json(researchAreas);

  } catch (error) {
    console.error('Error fetching lecturer research areas:', error);
    res.status(500).json({ error: 'Failed to fetch lecturer research areas' });
  }
});



// Administration Performance Chart endpoint removed - Not used by frontend

// Budget API endpoints
// Get budget overview for a staff member by staff code
app.get('/api/budget/overview/:staffCode', async (req, res) => {
  try {
    const { staffCode } = req.params;
    const evaluateid = req.query.evaluateid || 9;

    // Get budget categories with totals
    const [categories] = await pool.query(
      'SELECT * FROM budget_categories WHERE staff_code = ? AND evaluateid = ?',
      [staffCode, evaluateid]
    );

    if (categories.length === 0) {
      return res.status(404).json({ error: 'No budget data found for this staff member' });
    }

    // Calculate totals
    const totalBudget = categories.reduce((sum, cat) => sum + parseFloat(cat.total_budget), 0);
    const totalSpent = categories.reduce((sum, cat) => sum + parseFloat(cat.spent_amount), 0);
    const researchProjects = categories.find(cat => cat.name === 'Research Project');
    const researchAmount = researchProjects ? parseFloat(researchProjects.total_budget) : 0;

    // Get project count for research
    const [projectCount] = await pool.query(
      'SELECT COUNT(*) as count FROM budget_projects bp JOIN budget_categories bc ON bp.category_id = bc.id WHERE bc.name = "Research Project" AND bp.staff_code = ? AND bp.evaluateid = ?',
      [staffCode, evaluateid]
    );

    res.json({
      totalBudget,
      totalSpent,
      spentPercentage: totalBudget > 0 ? ((totalSpent / totalBudget) * 100).toFixed(1) : 0,
      researchAmount,
      researchProjectCount: projectCount[0].count,
      categories: categories.map(cat => ({
        name: cat.name,
        spent: parseFloat(cat.spent_amount),
        total: parseFloat(cat.total_budget),
        color: cat.color
      }))
    });
  } catch (error) {
    console.error('Error fetching budget overview:', error);
    res.status(500).json({ error: 'Failed to fetch budget overview' });
  }
});

// Get budget projects/details for a staff member by staff code
app.get('/api/budget/projects/:staffCode', async (req, res) => {
  try {
    const { staffCode } = req.params;
    const evaluateid = req.query.evaluateid || 9;

    const [projects] = await pool.query(`
      SELECT 
        bp.id,
        bp.title,
        bp.budget_amount,
        bp.duration,
        bc.name as category
      FROM budget_projects bp
      JOIN budget_categories bc ON bp.category_id = bc.id
      WHERE bp.staff_code = ? AND bp.evaluateid = ?
      ORDER BY bp.created_at DESC
    `, [staffCode, evaluateid]);

    // Get owners for each project
    const projectsWithOwners = await Promise.all(
      projects.map(async (project) => {
        const [owners] = await pool.query(
          'SELECT owner_name, is_primary FROM project_owners WHERE project_id = ? AND evaluateid = ? ORDER BY is_primary DESC',
          [project.id, evaluateid]
        );

        const ownersList = owners.map(o => o.owner_name);
        const primaryOwner = owners.find(o => o.is_primary)?.owner_name;

        return {
          title: project.title,
          owner: primaryOwner || ownersList[0],
          owners: ownersList.length > 1 ? ownersList : undefined,
          budget: parseFloat(project.budget_amount),
          duration: project.duration,
          category: project.category
        };
      })
    );

    res.json(projectsWithOwners);
  } catch (error) {
    console.error('Error fetching budget projects:', error);
    res.status(500).json({ error: 'Failed to fetch budget projects' });
  }
});

// Create new budget project
app.post('/api/budget/projects', async (req, res) => {
  try {
    const { title, categoryName, budgetAmount, duration, staffCode, evaluateid = 9, owners = [] } = req.body;

    // Get category ID
    const [category] = await pool.query(
      'SELECT id FROM budget_categories WHERE name = ? AND staff_code = ? AND evaluateid = ?',
      [categoryName, staffCode, evaluateid]
    );

    if (category.length === 0) {
      return res.status(404).json({ error: 'Category not found' });
    }

    // Insert project
    const [result] = await pool.query(
      'INSERT INTO budget_projects (title, category_id, budget_amount, duration, year, staff_code, evaluateid) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [title, category[0].id, budgetAmount, duration, 2025, staffCode, evaluateid]
    );

    const projectId = result.insertId;

    // Insert owners
    if (owners.length > 0) {
      const ownerValues = owners.map((owner, index) => [projectId, owner, index === 0]);
      await pool.query(
        'INSERT INTO project_owners (project_id, owner_name, is_primary) VALUES ?',
        [ownerValues]
      );
    }

    // Update category spent amount
    await pool.query(
      'UPDATE budget_categories SET spent_amount = spent_amount + ? WHERE id = ?',
      [budgetAmount, category[0].id]
    );

    res.json({ success: true, projectId });
  } catch (error) {
    console.error('Error creating budget project:', error);
    res.status(500).json({ error: 'Failed to create budget project' });
  }
});

// Update budget project
app.put('/api/budget/projects/:projectId', async (req, res) => {
  try {
    const { projectId } = req.params;
    const { title, budgetAmount, duration, owners = [] } = req.body;

    // Get old budget amount to adjust category totals
    const [oldProject] = await pool.query(
      'SELECT budget_amount, category_id FROM budget_projects WHERE id = ?',
      [projectId]
    );

    if (oldProject.length === 0) {
      return res.status(404).json({ error: 'Project not found' });
    }

    const oldAmount = parseFloat(oldProject[0].budget_amount);
    const categoryId = oldProject[0].category_id;

    // Update project
    await pool.query(
      'UPDATE budget_projects SET title = ?, budget_amount = ?, duration = ? WHERE id = ?',
      [title, budgetAmount, duration, projectId]
    );

    // Update owners
    await pool.query('DELETE FROM project_owners WHERE project_id = ?', [projectId]);
    if (owners.length > 0) {
      const ownerValues = owners.map((owner, index) => [projectId, owner, index === 0]);
      await pool.query(
        'INSERT INTO project_owners (project_id, owner_name, is_primary) VALUES ?',
        [ownerValues]
      );
    }

    // Update category spent amount
    const amountDifference = budgetAmount - oldAmount;
    await pool.query(
      'UPDATE budget_categories SET spent_amount = spent_amount + ? WHERE id = ?',
      [amountDifference, categoryId]
    );

    res.json({ success: true });
  } catch (error) {
    console.error('Error updating budget project:', error);
    res.status(500).json({ error: 'Failed to update budget project' });
  }
});

// Delete budget project
app.delete('/api/budget/projects/:projectId', async (req, res) => {
  try {
    const { projectId } = req.params;

    // Get project details to adjust category totals
    const [project] = await pool.query(
      'SELECT budget_amount, category_id FROM budget_projects WHERE id = ?',
      [projectId]
    );

    if (project.length === 0) {
      return res.status(404).json({ error: 'Project not found' });
    }

    const budgetAmount = parseFloat(project[0].budget_amount);
    const categoryId = project[0].category_id;

    // Delete project (owners will be deleted by CASCADE)
    await pool.query('DELETE FROM budget_projects WHERE id = ?', [projectId]);

    // Update category spent amount
    await pool.query(
      'UPDATE budget_categories SET spent_amount = spent_amount - ? WHERE id = ?',
      [budgetAmount, categoryId]
    );

    res.json({ success: true });
  } catch (error) {
    console.error('Error deleting budget project:', error);
    res.status(500).json({ error: 'Failed to delete budget project' });
  }
});

// Lecturer Publications endpoint with evaluation period filter
app.get('/api/lecturer/publications/:staffCode', async (req, res) => {
  try {
    const { staffCode } = req.params;
    const { evaluateid, limit } = req.query;
    
    let query = 'SELECT id, title, authors, venue, year, link, evaluateid FROM lecturer_publications WHERE staff_code = ?';
    let params = [staffCode];
    
    // Add evaluation period filter if provided
    if (evaluateid) {
      query += ' AND evaluateid = ?';
      params.push(evaluateid);
    }
    // If no evaluateid specified, show all publications
    
    query += ' ORDER BY year DESC, title ASC';
    
    // Add limit if provided
    if (limit) {
      query += ' LIMIT ?';
      params.push(parseInt(limit));
    }
    
    const [rows] = await pool.query(query, params);
    
    if (rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'No publications found for this staff member'
      });
    }
    
    res.json({
      success: true,
      data: rows
    });

  } catch (error) {
    console.error('Error fetching lecturer publications:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch publications data'
    });
  }
});

// Research Studies endpoint - Get research studies for a staff member
app.get('/api/research-studies/:staffCode', async (req, res) => {
  try {
    const { staffCode } = req.params;
    const { evaluateid } = req.query;
    
    // Default to evaluation period 9 if not specified
    const evalId = evaluateid || 9;
    
    const [rows] = await pool.query(
      `SELECT 
        id,
        staff_code,
        evaluateid,
        level,
        project_name,
        created_at,
        updated_at
      FROM research_studies 
      WHERE staff_code = ? AND evaluateid = ?
      ORDER BY level ASC`,
      [staffCode, evalId]
    );

    if (rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'No research studies found for this staff member'
      });
    }

    res.json({
      success: true,
      data: rows
    });

  } catch (error) {
    console.error('Error fetching research studies:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch research studies data',
      error: error.message
    });
  }
});

// Research Publications endpoint - Get research publications for a staff member
app.get('/api/research-publications/:staffCode', async (req, res) => {
  try {
    const { staffCode } = req.params;
    const { evaluateid } = req.query;
    
    // Default to evaluation period 9 if not specified
    const evalId = evaluateid || 9;
    
    const [rows] = await pool.query(
      `SELECT 
        id,
        staff_code,
        evaluateid,
        level,
        project_name,
        created_at,
        updated_at
      FROM research_publications 
      WHERE staff_code = ? AND evaluateid = ?
      ORDER BY level ASC`,
      [staffCode, evalId]
    );

    if (rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'No research publications found for this staff member'
      });
    }

    res.json({
      success: true,
      data: rows
    });

  } catch (error) {
    console.error('Error fetching research publications:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch research publications data',
      error: error.message
    });
  }
});


// Staff Code Lookup endpoint - Get staff code from lecturer_profiles by email
app.post('/api/lecturer/lookup-staffcode', async (req, res) => {
  try {
    const { email } = req.body;
    
    if (!email) {
      return res.status(400).json({
        success: false,
        message: 'Email is required'
      });
    }
    
    // Query lecturer_profiles table for staff code
    const [rows] = await pool.execute(
      `SELECT staff_code, staff_name 
       FROM lecturer_profiles 
       WHERE email = ? 
       LIMIT 1`,
      [email]
    );
    
    if (rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Staff member not found for this email'
      });
    }
    
    const staff = rows[0];
    res.json({
      success: true,
      staffCode: staff.staff_code,
      staffName: staff.staff_name
    });
    
  } catch (error) {
    console.error('Error looking up staff code:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to lookup staff code',
      error: error.message
    });
  }
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Something went wrong!' });
});

const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
