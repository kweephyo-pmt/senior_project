-- Add budget data for staff 6531503172 with evaluateid 8

-- First, add budget categories for staff 6531503172 with evaluateid 8
INSERT INTO budget_categories (name, color, total_budget, spent_amount, year, staff_code, evaluateid, created_at, updated_at) VALUES
('Self Development', '#3B82F6', 9500.00, 5700.00, 2025, '6531503172', 8, NOW(), NOW()),
('Academic Service Project', '#EC4899', 38000.00, 12920.00, 2025, '6531503172', 8, NOW(), NOW()),
('Research Project', '#8B5CF6', 16000.00, 4800.00, 2025, '6531503172', 8, NOW(), NOW()),
('Guest Speaker', '#10B981', 13500.00, 1620.00, 2025, '6531503172', 8, NOW(), NOW()),
('Guest Lecturer', '#F59E0B', 13500.00, 1620.00, 2025, '6531503172', 8, NOW(), NOW()),
('Student Activity', '#EF4444', 13500.00, 1620.00, 2025, '6531503172', 8, NOW(), NOW());

-- Add budget projects for staff 6531503172 with evaluateid 8
INSERT INTO budget_projects (title, category_id, budget_amount, duration, year, staff_code, evaluateid, created_at, updated_at) VALUES
-- Self Development project (using the category ID that will be created above)
('Professional Skills Workshop', (SELECT id FROM budget_categories WHERE name = 'Self Development' AND staff_code = '6531503172' AND evaluateid = 8), 5700.00, '3 Month', 2025, '6531503172', 8, NOW(), NOW()),

-- Academic Service Project
('Academic Conference Organization', (SELECT id FROM budget_categories WHERE name = 'Academic Service Project' AND staff_code = '6531503172' AND evaluateid = 8), 12920.00, '10 Month', 2025, '6531503172', 8, NOW(), NOW()),

-- Research Project
('Data Analytics Research', (SELECT id FROM budget_categories WHERE name = 'Research Project' AND staff_code = '6531503172' AND evaluateid = 8), 4800.00, '5 Month', 2025, '6531503172', 8, NOW(), NOW()),

-- Guest Speaker
('Industry Expert Speaker Series', (SELECT id FROM budget_categories WHERE name = 'Guest Speaker' AND staff_code = '6531503172' AND evaluateid = 8), 1620.00, '2 Month', 2025, '6531503172', 8, NOW(), NOW());
