-- Add evaluation period connection to budget system
-- This script updates existing budget tables to include evaluateid

-- 1. Add evaluateid column to budget_categories table
ALTER TABLE budget_categories 
ADD COLUMN evaluateid INT NOT NULL DEFAULT 9 AFTER year,
ADD INDEX idx_staff_evaluate (staff_code, evaluateid),
ADD FOREIGN KEY (evaluateid) REFERENCES evaluation_periods(evaluateid);

-- 2. Add evaluateid column to budget_projects table  
ALTER TABLE budget_projects
ADD COLUMN evaluateid INT NOT NULL DEFAULT 9 AFTER year,
ADD INDEX idx_staff_evaluate_projects (staff_code, evaluateid),
ADD FOREIGN KEY (evaluateid) REFERENCES evaluation_periods(evaluateid);

-- 3. Update existing data to use current active evaluation period (evaluateid = 9)
UPDATE budget_categories SET evaluateid = 9 WHERE evaluateid IS NULL OR evaluateid = 0;
UPDATE budget_projects SET evaluateid = 9 WHERE evaluateid IS NULL OR evaluateid = 0;

-- 4. Create sample data for previous evaluation period (evaluateid = 8) for testing
-- Duplicate some existing budget categories for previous period
INSERT INTO budget_categories (name, color, total_budget, spent_amount, year, staff_code, evaluateid, created_at, updated_at)
SELECT name, color, total_budget * 0.8, spent_amount * 0.7, 2024, staff_code, 8, '2024-07-01 00:00:00', '2024-12-31 23:59:59'
FROM budget_categories 
WHERE staff_code = '6531503172' AND evaluateid = 9
LIMIT 3;

-- 5. Create sample budget projects for previous period
INSERT INTO budget_projects (title, category_id, budget_amount, duration, year, staff_code, evaluateid, created_at, updated_at)
SELECT 
    CONCAT(title, ' (Previous Period)'),
    (SELECT id FROM budget_categories WHERE staff_code = bp.staff_code AND evaluateid = 8 LIMIT 1),
    budget_amount * 0.9,
    duration,
    2024,
    staff_code,
    8,
    '2024-07-01 00:00:00',
    '2024-12-31 23:59:59'
FROM budget_projects bp
WHERE staff_code = '6531503172' AND evaluateid = 9
LIMIT 2;
