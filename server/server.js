const express = require('express');
const cors = require('cors');
const pool = require('./config/db');

const app = express();

// Middleware
app.use(cors({
  origin: 'http://localhost:3000', // Your Nuxt frontend URL
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

// KPI endpoint - Get KPI percentages by staff code
app.get('/api/kpi/:staffCode', async (req, res) => {
  try {
    const { staffCode } = req.params;
    
    // Fetch KPI data from percentage table
    const [rows] = await pool.query(
      'SELECT staff_code, staff_name, domain1_weight, domain2_weight, domain3_weight, domain4_weight, domain5_weight FROM percentage WHERE staff_code = ?',
      [staffCode]
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

// Budget API endpoints
// Get budget overview for a lecturer
app.get('/api/budget/overview/:lecturerId', async (req, res) => {
  try {
    const { lecturerId } = req.params;
    const year = req.query.year || 2025;

    // Get budget categories with totals
    const [categories] = await pool.query(
      'SELECT * FROM budget_categories WHERE lecturer_id = ? AND year = ?',
      [lecturerId, year]
    );

    // Calculate totals
    const totalBudget = categories.reduce((sum, cat) => sum + parseFloat(cat.total_budget), 0);
    const totalSpent = categories.reduce((sum, cat) => sum + parseFloat(cat.spent_amount), 0);
    const researchProjects = categories.find(cat => cat.name === 'Research Project');
    const researchAmount = researchProjects ? parseFloat(researchProjects.total_budget) : 0;

    // Get project count for research
    const [projectCount] = await pool.query(
      'SELECT COUNT(*) as count FROM budget_projects bp JOIN budget_categories bc ON bp.category_id = bc.id WHERE bc.name = "Research Project" AND bp.lecturer_id = ? AND bp.year = ?',
      [lecturerId, year]
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

// Get budget projects/details for a lecturer
app.get('/api/budget/projects/:lecturerId', async (req, res) => {
  try {
    const { lecturerId } = req.params;
    const year = req.query.year || 2025;

    const [projects] = await pool.query(`
      SELECT 
        bp.id,
        bp.title,
        bp.budget_amount,
        bp.duration,
        bc.name as category
      FROM budget_projects bp
      JOIN budget_categories bc ON bp.category_id = bc.id
      WHERE bp.lecturer_id = ? AND bp.year = ?
      ORDER BY bp.created_at DESC
    `, [lecturerId, year]);

    // Get owners for each project
    const projectsWithOwners = await Promise.all(
      projects.map(async (project) => {
        const [owners] = await pool.query(
          'SELECT owner_name, is_primary FROM project_owners WHERE project_id = ? ORDER BY is_primary DESC',
          [project.id]
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
    const { title, categoryName, budgetAmount, duration, lecturerId, year = 2025, owners = [] } = req.body;

    // Get category ID
    const [category] = await pool.query(
      'SELECT id FROM budget_categories WHERE name = ? AND lecturer_id = ? AND year = ?',
      [categoryName, lecturerId, year]
    );

    if (category.length === 0) {
      return res.status(400).json({ error: 'Category not found' });
    }

    // Insert project
    const [result] = await pool.query(
      'INSERT INTO budget_projects (title, category_id, budget_amount, duration, year, lecturer_id) VALUES (?, ?, ?, ?, ?, ?)',
      [title, category[0].id, budgetAmount, duration, year, lecturerId]
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

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Something went wrong!' });
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
