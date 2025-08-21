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

// Teaching Performance Chart endpoint with evaluation period filter
app.get('/api/teaching-performance/:staffCode', async (req, res) => {
  try {
    const { staffCode } = req.params;
    const { evaluateid } = req.query;
    
    let query = 'SELECT category, lecture_score, lab_score, display_order FROM teaching_performance WHERE staff_code = ?';
    let params = [staffCode];
    
    // Add evaluation period filter if provided
    if (evaluateid) {
      query += ' AND evaluateid = ?';
      params.push(evaluateid);
    } else {
      // Default to most recent active period (evaluateid 9 = 1/2025)
      query += ' AND evaluateid = 9';
    }
    
    query += ' ORDER BY display_order';
    
    const [rows] = await pool.query(query, params);
    
    if (rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'No teaching performance data found for this staff code and evaluation period'
      });
    }
    
    res.json({
      success: true,
      data: rows
    });
  } catch (error) {
    console.error('Error fetching teaching performance data:', error);
    res.status(500).json({
      success: false,
      message: 'Internal server error',
      error: error.message
    });
  }
});

// Research Performance Chart endpoint with evaluation period filter
app.get('/api/research-performance/:staffCode', async (req, res) => {
  try {
    const { staffCode } = req.params;
    const { evaluateid } = req.query;
    
    let query = 'SELECT category, level4_score, level6_score, level7_score, display_order FROM research_performance WHERE staff_code = ?';
    let params = [staffCode];
    
    // Add evaluation period filter if provided
    if (evaluateid) {
      query += ' AND evaluateid = ?';
      params.push(evaluateid);
    } else {
      // Default to most recent active period (evaluateid 9 = 1/2025)
      query += ' AND evaluateid = 9';
    }
    
    query += ' ORDER BY display_order';
    
    const [rows] = await pool.query(query, params);
    
    if (rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'No research performance data found for this staff code and evaluation period'
      });
    }
    
    res.json({
      success: true,
      data: rows
    });
  } catch (error) {
    console.error('Error fetching research performance data:', error);
    res.status(500).json({
      success: false,
      message: 'Internal server error',
      error: error.message
    });
  }
});

// Academic Service Performance Chart endpoint with evaluation period filter
app.get('/api/academic-service-performance/:staffCode', async (req, res) => {
  try {
    const { staffCode } = req.params;
    const { evaluateid } = req.query;
    
    let query = 'SELECT category, internal_score, external_score, non_revenue_score, revenue_score, display_order FROM academic_service_performance WHERE staff_code = ?';
    let params = [staffCode];
    
    // Add evaluation period filter if provided
    if (evaluateid) {
      query += ' AND evaluateid = ?';
      params.push(evaluateid);
    } else {
      // Default to most recent active period (evaluateid 9 = 1/2025)
      query += ' AND evaluateid = 9';
    }
    
    query += ' ORDER BY display_order';
    
    const [rows] = await pool.query(query, params);
    
    if (rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'No academic service performance data found for this staff code and evaluation period'
      });
    }
    
    res.json({
      success: true,
      data: rows
    });
  } catch (error) {
    console.error('Error fetching academic service performance data:', error);
    res.status(500).json({
      success: false,
      message: 'Internal server error',
      error: error.message
    });
  }
});

// KPI endpoint - Get KPI percentages by staff code and evaluation period
app.get('/api/kpi/:staffCode', async (req, res) => {
  try {
    const { staffCode } = req.params;
    const { evaluateid } = req.query;
    
    // Default to evaluation period 8 if not specified
    const evalId = evaluateid || 8;
    
    // Fetch KPI data from percentage table filtered by evaluateid
    const [rows] = await pool.query(
      'SELECT staff_code, staff_name, domain1_weight, domain2_weight, domain3_weight, domain4_weight, domain5_weight FROM percentage WHERE staff_code = ? AND evaluateid = ?',
      [staffCode, evalId]
    );

    if (rows.length === 0) {
      return res.status(404).json({ error: 'Staff member not found' });
    }

    const staffData = rows[0];
    
    // Transform data into frontend format
    const kpiData = {
      staffCode: staffData.staff_code,
      staffName: staffData.staff_name,
      categories: [
        {
          name: 'Teaching',
          weight: parseFloat(staffData.domain1_weight) || 0,
          value: parseFloat(staffData.domain1_weight) || 0,
          color: '#1e40af',
          bgColor: '#dbeafe',
          textColor: '#1e40af'
        },
        {
          name: 'Research',
          weight: parseFloat(staffData.domain2_weight) || 0,
          value: parseFloat(staffData.domain2_weight) || 0,
          color: '#0891b2',
          bgColor: '#cffafe',
          textColor: '#0891b2'
        },
        {
          name: 'Academic Service',
          weight: parseFloat(staffData.domain3_weight) || 0,
          value: parseFloat(staffData.domain3_weight) || 0,
          color: '#059669',
          bgColor: '#d1fae5',
          textColor: '#059669'
        },
        {
          name: 'Administration',
          weight: parseFloat(staffData.domain4_weight) || 0,
          value: parseFloat(staffData.domain4_weight) || 0,
          color: '#7c3aed',
          bgColor: '#ede9fe',
          textColor: '#7c3aed'
        },
        {
          name: 'Arts and Culture',
          weight: parseFloat(staffData.domain5_weight) || 0,
          value: parseFloat(staffData.domain5_weight) || 0,
          color: '#dc2626',
          bgColor: '#fecaca',
          textColor: '#dc2626'
        }
      ]
    };

    // Calculate totals
    const totalScore = kpiData.categories.reduce((sum, cat) => sum + cat.value, 0);
    
    res.json({
      ...kpiData,
      totalScore: totalScore.toFixed(2),
      performanceLevel: totalScore >= 90 ? 'Excellent' : totalScore >= 80 ? 'Good' : totalScore >= 70 ? 'Satisfactory' : 'Needs Improvement'
    });

  } catch (error) {
    console.error('Error fetching KPI data:', error);
    res.status(500).json({ error: 'Failed to fetch KPI data' });
  }
});

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



// Administration Performance Chart endpoint with evaluation period filter
app.get('/api/administration-performance/:staffCode', async (req, res) => {
  try {
    const { staffCode } = req.params;
    const { evaluateid } = req.query;
    
    let query = 'SELECT category, score, display_order FROM administration_performance WHERE staff_code = ?';
    let params = [staffCode];
    
    // Add evaluation period filter if provided
    if (evaluateid) {
      query += ' AND evaluateid = ?';
      params.push(evaluateid);
    } else {
      // Default to most recent active period (evaluateid 9 = 1/2025)
      query += ' AND evaluateid = 9';
    }
    
    query += ' ORDER BY display_order';
    
    const [rows] = await pool.query(query, params);
    
    if (rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'No administration performance data found for this staff member'
      });
    }
    
    res.json({
      success: true,
      data: rows
    });

  } catch (error) {
    console.error('Error fetching administration performance data:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch administration performance data'
    });
  }
});

// Arts & Culture Performance Chart endpoint with evaluation period filter
app.get('/api/arts-culture-performance/:staffCode', async (req, res) => {
  try {
    const { staffCode } = req.params;
    const { evaluateid } = req.query;
    
    let query = 'SELECT category, score, display_order FROM arts_culture_performance WHERE staff_code = ?';
    let params = [staffCode];
    
    // Add evaluation period filter if provided
    if (evaluateid) {
      query += ' AND evaluateid = ?';
      params.push(evaluateid);
    } else {
      // Default to most recent active period (evaluateid 9 = 1/2025)
      query += ' AND evaluateid = 9';
    }
    
    query += ' ORDER BY display_order';
    
    const [rows] = await pool.query(query, params);
    
    if (rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'No arts culture performance data found for this staff member'
      });
    }
    
    res.json({
      success: true,
      data: rows
    });

  } catch (error) {
    console.error('Error fetching arts culture performance data:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch arts culture performance data'
    });
  }
});

// MFU Arranged Activities endpoint for Domain 5: Arts and Culture
app.get('/api/mfu-arranged-activities/:staffCode', async (req, res) => {
  try {
    const { staffCode } = req.params;
    const { evaluateid } = req.query;
    
    let query = `
      SELECT 
        id,
        staff_code,
        project_name,
        activity_level,
        evaluateid,
        created_at
      FROM mfu_arranged_activities 
      WHERE staff_code = ?
    `;
    
    const params = [staffCode];
    
    if (evaluateid) {
      query += ' AND evaluateid = ?';
      params.push(evaluateid);
    }
    
    query += ' ORDER BY activity_level ASC, created_at DESC';
    
    const [rows] = await pool.query(query, params);
    
    res.json({
      success: true,
      data: rows,
      count: rows.length,
      message: rows.length > 0 ? 'MFU arranged activities retrieved successfully' : 'No MFU arranged activities found for this staff member'
    });
  } catch (error) {
    console.error('Error fetching MFU arranged activities:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch MFU arranged activities',
      error: error.message
    });
  }
});

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

// Overall Performance endpoint - Get overall performance by staff code and evaluation period
app.get('/api/overall-performance/:staffCode', async (req, res) => {
  try {
    const { staffCode } = req.params;
    const { evaluateid } = req.query;
    
    // Default to evaluation period 9 if not specified
    const evalId = evaluateid || 9;
    
    // Fetch overall performance data
    const [rows] = await pool.query(
      `SELECT 
        staff_code,
        staff_name,
        academic_performance,
        behavior_score,
        total_score,
        performance_level,
        evaluateid,
        created_at,
        updated_at
      FROM overall_performance 
      WHERE staff_code = ? AND evaluateid = ?
      ORDER BY created_at DESC
      LIMIT 1`,
      [staffCode, evalId]
    );

    if (rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'No overall performance data found for this staff code and evaluation period'
      });
    }

    const performanceData = rows[0];
    
    res.json({
      success: true,
      data: {
        staffCode: performanceData.staff_code,
        staffName: performanceData.staff_name,
        academicPerformance: parseFloat(performanceData.academic_performance),
        behavior: parseFloat(performanceData.behavior_score),
        totalScore: parseFloat(performanceData.total_score),
        performanceLevel: performanceData.performance_level,
        evaluateid: performanceData.evaluateid,
        createdAt: performanceData.created_at,
        updatedAt: performanceData.updated_at
      }
    });

  } catch (error) {
    console.error('Error fetching overall performance data:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch overall performance data',
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
