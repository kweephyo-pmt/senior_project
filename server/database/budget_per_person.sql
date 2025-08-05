-- Budget Management Database Schema - Per Person
-- Create database tables for lecturer budget functionality with individual user data

-- Budget Categories Table (per staff member)
CREATE TABLE IF NOT EXISTS budget_categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    color VARCHAR(7) NOT NULL, -- Hex color code
    total_budget DECIMAL(10,2) NOT NULL DEFAULT 0,
    spent_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    year INT NOT NULL DEFAULT 2025,
    staff_code VARCHAR(20) NOT NULL, -- Staff code extracted from email
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_staff_year (staff_code, year)
);

-- Budget Projects/Details Table (per staff member)
CREATE TABLE IF NOT EXISTS budget_projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    category_id INT NOT NULL,
    budget_amount DECIMAL(10,2) NOT NULL,
    duration VARCHAR(50) NOT NULL,
    year INT NOT NULL DEFAULT 2025,
    staff_code VARCHAR(20) NOT NULL, -- Staff code extracted from email
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES budget_categories(id) ON DELETE CASCADE,
    INDEX idx_staff_year (staff_code, year)
);

-- Project Owners Table (for projects with multiple owners)
CREATE TABLE IF NOT EXISTS project_owners (
    id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT NOT NULL,
    owner_name VARCHAR(100) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES budget_projects(id) ON DELETE CASCADE
);

-- Staff Information Table (mapping email to staff details)
CREATE TABLE IF NOT EXISTS staff_budget_info (
    id INT AUTO_INCREMENT PRIMARY KEY,
    staff_code VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    staff_name VARCHAR(100) NOT NULL,
    department VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert staff information for the provided emails
INSERT INTO staff_budget_info (staff_code, email, staff_name, department) VALUES
('6431703502', '6431703502@lamduan.mfu.ac.th', 'Dr. Apinya Wongkham', 'School of Management'),
('6531503017', '6531503017@lamduan.mfu.ac.th', 'Dr. Siriporn Thanakit', 'School of Management'),
('6531503069', '6531503069@lamduan.mfu.ac.th', 'Dr. Rattana Choosri', 'School of Management'),
('6531503070', '6531503070@lamduan.mfu.ac.th', 'Dr. Suwanna Phakdee', 'School of Management'),
('6531503074', '6531503074@lamduan.mfu.ac.th', 'Dr. Niran Jaikla', 'School of Management'),
('6531503137', '6531503137@lamduan.mfu.ac.th', 'Dr. Kamon Bualert', 'School of Management'),
('6531503172', '6531503172@lamduan.mfu.ac.th', 'Dr. Phyo Min Thein', 'School of Management'),
('6531503174', '6531503174@lamduan.mfu.ac.th', 'Dr. Supansa Chaising', 'School of Management'),
('6531503176', '6531503176@lamduan.mfu.ac.th', 'Dr. Korawit Fakkhong', 'School of Management'),
('6631205226', '6631205226@lamduan.mfu.ac.th', 'Dr. Wipob Suttinun', 'School of Management');

-- Insert budget categories for each staff member (2025)
INSERT INTO budget_categories (name, color, total_budget, spent_amount, year, staff_code) VALUES
-- Dr. Apinya Wongkham (6431703502)
('Self Development', '#3B82F6', 12000.00, 7200.00, 2025, '6431703502'),
('Academic Service Project', '#EC4899', 45000.00, 15300.00, 2025, '6431703502'),
('Research Project', '#8B5CF6', 20000.00, 6000.00, 2025, '6431703502'),
('Guest Speaker', '#10B981', 18000.00, 2160.00, 2025, '6431703502'),
('Guest Lecturer', '#F59E0B', 16000.00, 1920.00, 2025, '6431703502'),
('Student Activity', '#EF4444', 14000.00, 1680.00, 2025, '6431703502'),

-- Dr. Siriporn Thanakit (6531503017)
('Self Development', '#3B82F6', 11000.00, 6600.00, 2025, '6531503017'),
('Academic Service Project', '#EC4899', 40000.00, 13600.00, 2025, '6531503017'),
('Research Project', '#8B5CF6', 22000.00, 6600.00, 2025, '6531503017'),
('Guest Speaker', '#10B981', 17000.00, 2040.00, 2025, '6531503017'),
('Guest Lecturer', '#F59E0B', 15000.00, 1800.00, 2025, '6531503017'),
('Student Activity', '#EF4444', 13000.00, 1560.00, 2025, '6531503017'),

-- Dr. Rattana Choosri (6531503069)
('Self Development', '#3B82F6', 10500.00, 6300.00, 2025, '6531503069'),
('Academic Service Project', '#EC4899', 38000.00, 12920.00, 2025, '6531503069'),
('Research Project', '#8B5CF6', 19000.00, 5700.00, 2025, '6531503069'),
('Guest Speaker', '#10B981', 16000.00, 1920.00, 2025, '6531503069'),
('Guest Lecturer', '#F59E0B', 14500.00, 1740.00, 2025, '6531503069'),
('Student Activity', '#EF4444', 12500.00, 1500.00, 2025, '6531503069'),

-- Dr. Suwanna Phakdee (6531503070)
('Self Development', '#3B82F6', 13000.00, 7800.00, 2025, '6531503070'),
('Academic Service Project', '#EC4899', 47000.00, 15980.00, 2025, '6531503070'),
('Research Project', '#8B5CF6', 21000.00, 6300.00, 2025, '6531503070'),
('Guest Speaker', '#10B981', 19000.00, 2280.00, 2025, '6531503070'),
('Guest Lecturer', '#F59E0B', 17000.00, 2040.00, 2025, '6531503070'),
('Student Activity', '#EF4444', 15000.00, 1800.00, 2025, '6531503070'),

-- Dr. Niran Jaikla (6531503074)
('Self Development', '#3B82F6', 9500.00, 5700.00, 2025, '6531503074'),
('Academic Service Project', '#EC4899', 35000.00, 11900.00, 2025, '6531503074'),
('Research Project', '#8B5CF6', 17000.00, 5100.00, 2025, '6531503074'),
('Guest Speaker', '#10B981', 15000.00, 1800.00, 2025, '6531503074'),
('Guest Lecturer', '#F59E0B', 13500.00, 1620.00, 2025, '6531503074'),
('Student Activity', '#EF4444', 11500.00, 1380.00, 2025, '6531503074'),

-- Dr. Kamon Bualert (6531503137)
('Self Development', '#3B82F6', 11500.00, 6900.00, 2025, '6531503137'),
('Academic Service Project', '#EC4899', 42000.00, 14280.00, 2025, '6531503137'),
('Research Project', '#8B5CF6', 20500.00, 6150.00, 2025, '6531503137'),
('Guest Speaker', '#10B981', 17500.00, 2100.00, 2025, '6531503137'),
('Guest Lecturer', '#F59E0B', 16000.00, 1920.00, 2025, '6531503137'),
('Student Activity', '#EF4444', 14000.00, 1680.00, 2025, '6531503137'),

-- Dr. Phyo Min Thein (6531503172)
('Self Development', '#3B82F6', 10000.00, 6400.00, 2025, '6531503172'),
('Academic Service Project', '#EC4899', 42000.00, 14112.00, 2025, '6531503172'),
('Research Project', '#8B5CF6', 18000.00, 5472.00, 2025, '6531503172'),
('Guest Speaker', '#10B981', 15000.00, 1800.00, 2025, '6531503172'),
('Guest Lecturer', '#F59E0B', 15000.00, 1800.00, 2025, '6531503172'),
('Student Activity', '#EF4444', 15000.00, 1800.00, 2025, '6531503172'),

-- Dr. Supansa Chaising (6531503174)
('Self Development', '#3B82F6', 12500.00, 7500.00, 2025, '6531503174'),
('Academic Service Project', '#EC4899', 44000.00, 14960.00, 2025, '6531503174'),
('Research Project', '#8B5CF6', 19500.00, 5850.00, 2025, '6531503174'),
('Guest Speaker', '#10B981', 18000.00, 2160.00, 2025, '6531503174'),
('Guest Lecturer', '#F59E0B', 16500.00, 1980.00, 2025, '6531503174'),
('Student Activity', '#EF4444', 14500.00, 1740.00, 2025, '6531503174'),

-- Dr. Korawit Fakkhong (6531503176)
('Self Development', '#3B82F6', 10800.00, 6480.00, 2025, '6531503176'),
('Academic Service Project', '#EC4899', 41000.00, 13940.00, 2025, '6531503176'),
('Research Project', '#8B5CF6', 18500.00, 5550.00, 2025, '6531503176'),
('Guest Speaker', '#10B981', 16000.00, 1920.00, 2025, '6531503176'),
('Guest Lecturer', '#F59E0B', 15500.00, 1860.00, 2025, '6531503176'),
('Student Activity', '#EF4444', 13500.00, 1620.00, 2025, '6531503176'),

-- Dr. Wipob Suttinun (6631205226)
('Self Development', '#3B82F6', 9800.00, 5880.00, 2025, '6631205226'),
('Academic Service Project', '#EC4899', 36000.00, 12240.00, 2025, '6631205226'),
('Research Project', '#8B5CF6', 17500.00, 5250.00, 2025, '6631205226'),
('Guest Speaker', '#10B981', 15500.00, 1860.00, 2025, '6631205226'),
('Guest Lecturer', '#F59E0B', 14000.00, 1680.00, 2025, '6631205226'),
('Student Activity', '#EF4444', 12000.00, 1440.00, 2025, '6631205226');

-- Sample budget projects for each staff member
INSERT INTO budget_projects (title, category_id, budget_amount, duration, year, staff_code) VALUES
-- Dr. Apinya Wongkham projects
('Professional Development Workshop', 1, 7200.00, '3 Month', 2025, '6431703502'),
('Community Service Initiative', 2, 15300.00, '12 Month', 2025, '6431703502'),
('AI Research Project', 3, 6000.00, '6 Month', 2025, '6431703502'),
('Guest Speaker Series', 4, 2160.00, '2 Month', 2025, '6431703502'),

-- Dr. Siriporn Thanakit projects
('Leadership Training Program', 7, 6600.00, '4 Month', 2025, '6531503017'),
('Academic Conference Organization', 8, 13600.00, '8 Month', 2025, '6531503017'),
('Marketing Research Study', 9, 6600.00, '5 Month', 2025, '6531503017'),

-- Dr. Rattana Choosri projects
('Digital Skills Workshop', 13, 6300.00, '3 Month', 2025, '6531503069'),
('Student Mentorship Program', 14, 12920.00, '10 Month', 2025, '6531503069'),
('Business Analytics Project', 15, 5700.00, '4 Month', 2025, '6531503069'),

-- Dr. Suwanna Phakdee projects
('Advanced Excel Training', 19, 7800.00, '2 Month', 2025, '6531503070'),
('Quality Assurance Initiative', 20, 15980.00, '12 Month', 2025, '6531503070'),
('Supply Chain Research', 21, 6300.00, '6 Month', 2025, '6531503070'),

-- Dr. Niran Jaikla projects
('Teaching Methodology Workshop', 25, 5700.00, '3 Month', 2025, '6531503074'),
('Student Activity Coordination', 26, 11900.00, '9 Month', 2025, '6531503074'),
('Economics Research Project', 27, 5100.00, '5 Month', 2025, '6531503074'),

-- Dr. Kamon Bualert projects
('Research Methodology Training', 31, 6900.00, '4 Month', 2025, '6531503137'),
('Academic Service Committee', 32, 14280.00, '12 Month', 2025, '6531503137'),
('Finance Research Study', 33, 6150.00, '6 Month', 2025, '6531503137'),

-- Dr. Phyo Min Thein projects (existing data)
('Professional Development Workshop', 37, 6400.00, '3 Month', 2025, '6531503172'),
('Community Service Initiative', 38, 14112.00, '12 Month', 2025, '6531503172'),
('SoM Project', 39, 5472.00, '6 Month', 2025, '6531503172'),
('Guest Speaker 130S305', 40, 1800.00, '2 Month', 2025, '6531503172'),

-- Dr. Supansa Chaising projects
('Curriculum Development', 43, 7500.00, '5 Month', 2025, '6531503174'),
('International Conference', 44, 14960.00, '8 Month', 2025, '6531503174'),
('Management Research Project', 45, 5850.00, '6 Month', 2025, '6531503174'),

-- Dr. Korawit Fakkhong projects
('Innovation Workshop', 49, 6480.00, '3 Month', 2025, '6531503176'),
('Academic Excellence Program', 50, 13940.00, '10 Month', 2025, '6531503176'),
('Technology Integration Study', 51, 5550.00, '4 Month', 2025, '6531503176'),

-- Dr. Wipob Suttinun projects
('Skills Enhancement Program', 55, 5880.00, '3 Month', 2025, '6631205226'),
('Community Outreach Initiative', 56, 12240.00, '9 Month', 2025, '6631205226'),
('Business Strategy Research', 57, 5250.00, '5 Month', 2025, '6631205226');

-- Insert project owners
INSERT INTO project_owners (project_id, owner_name, is_primary) VALUES
-- Sample owners for various projects
(1, 'Dr. Apinya Wongkham', TRUE),
(2, 'Dr. Apinya Wongkham', TRUE),
(3, 'Dr. Apinya Wongkham', TRUE),
(4, 'Dr. Apinya Wongkham', TRUE),
(5, 'Dr. Siriporn Thanakit', TRUE),
(6, 'Dr. Siriporn Thanakit', TRUE),
(7, 'Dr. Siriporn Thanakit', TRUE),
(8, 'Dr. Rattana Choosri', TRUE),
(9, 'Dr. Rattana Choosri', TRUE),
(10, 'Dr. Rattana Choosri', TRUE),
(11, 'Dr. Suwanna Phakdee', TRUE),
(12, 'Dr. Suwanna Phakdee', TRUE),
(13, 'Dr. Suwanna Phakdee', TRUE),
(14, 'Dr. Niran Jaikla', TRUE),
(15, 'Dr. Niran Jaikla', TRUE),
(16, 'Dr. Niran Jaikla', TRUE),
(17, 'Dr. Kamon Bualert', TRUE),
(18, 'Dr. Kamon Bualert', TRUE),
(19, 'Dr. Kamon Bualert', TRUE),
(20, 'Dr. Phyo Min Thein', TRUE),
(21, 'Dr. Phyo Min Thein', TRUE),
(22, 'Dr. Phyo Min Thein', TRUE),
(23, 'Dr. Phyo Min Thein', TRUE),
(24, 'Dr. Supansa Chaising', TRUE),
(25, 'Dr. Supansa Chaising', TRUE),
(26, 'Dr. Supansa Chaising', TRUE),
(27, 'Dr. Korawit Fakkhong', TRUE),
(28, 'Dr. Korawit Fakkhong', TRUE),
(29, 'Dr. Korawit Fakkhong', TRUE),
(30, 'Dr. Wipob Suttinun', TRUE),
(31, 'Dr. Wipob Suttinun', TRUE),
(32, 'Dr. Wipob Suttinun', TRUE);
