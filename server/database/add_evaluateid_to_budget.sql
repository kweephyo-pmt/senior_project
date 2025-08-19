-- Add evaluateid column to budget tables to link with evaluation periods

-- Add evaluateid to budget_categories table
ALTER TABLE budget_categories 
ADD COLUMN evaluateid INT NOT NULL DEFAULT 9 AFTER year,
ADD KEY idx_evaluateid (evaluateid),
ADD CONSTRAINT budget_categories_evaluateid_fk 
FOREIGN KEY (evaluateid) REFERENCES evaluation_periods(evaluateid);

-- Add evaluateid to budget_projects table  
ALTER TABLE budget_projects
ADD COLUMN evaluateid INT NOT NULL DEFAULT 9 AFTER year,
ADD KEY idx_evaluateid (evaluateid),
ADD CONSTRAINT budget_projects_evaluateid_fk
FOREIGN KEY (evaluateid) REFERENCES evaluation_periods(evaluateid);

-- Update existing records to use current active evaluation period (evaluateid = 9)
UPDATE budget_categories SET evaluateid = 9 WHERE evaluateid IS NULL OR evaluateid = 0;
UPDATE budget_projects SET evaluateid = 9 WHERE evaluateid IS NULL OR evaluateid = 0;

-- Update indexes to include evaluateid
ALTER TABLE budget_categories DROP KEY idx_staff_year;
ALTER TABLE budget_categories ADD KEY idx_staff_evaluate (staff_code, evaluateid);

ALTER TABLE budget_projects DROP KEY idx_staff_year;  
ALTER TABLE budget_projects ADD KEY idx_staff_evaluate (staff_code, evaluateid);
