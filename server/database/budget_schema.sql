-- Budget Management Database Schema
-- Create database tables for lecturer budget functionality

-- Budget Categories Table
CREATE TABLE IF NOT EXISTS budget_categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    color VARCHAR(7) NOT NULL, -- Hex color code
    total_budget DECIMAL(10,2) NOT NULL DEFAULT 0,
    spent_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    year INT NOT NULL DEFAULT 2025,
    lecturer_id VARCHAR(100) NOT NULL, -- Firebase UID
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Budget Projects/Details Table
CREATE TABLE IF NOT EXISTS budget_projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    category_id INT NOT NULL,
    budget_amount DECIMAL(10,2) NOT NULL,
    duration VARCHAR(50) NOT NULL,
    year INT NOT NULL DEFAULT 2025,
    lecturer_id VARCHAR(100) NOT NULL, -- Firebase UID
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES budget_categories(id) ON DELETE CASCADE
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

-- Insert mockup data for budget categories
INSERT INTO budget_categories (name, color, total_budget, spent_amount, year, lecturer_id) VALUES
('Self Development', '#3B82F6', 10000.00, 6400.00, 2025, 'mock_lecturer_1'),
('Academic Service Project', '#EC4899', 42000.00, 14112.00, 2025, 'mock_lecturer_1'),
('Research Project', '#8B5CF6', 18000.00, 5472.00, 2025, 'mock_lecturer_1'),
('Guest Speaker', '#10B981', 15000.00, 1800.00, 2025, 'mock_lecturer_1'),
('Guest Lecturer', '#F59E0B', 15000.00, 1800.00, 2025, 'mock_lecturer_1'),
('Student Activity', '#EF4444', 15000.00, 1800.00, 2025, 'mock_lecturer_1');

-- Insert mockup data for budget projects
INSERT INTO budget_projects (title, category_id, budget_amount, duration, year, lecturer_id) VALUES
('Guest Speaker 130S305', 4, 12000.00, '6 Month', 2025, 'mock_lecturer_1'),
('SoM Project', 3, 8000.00, '6 Month', 2025, 'mock_lecturer_1'),
('Guest Lecturer 130S305', 5, 5000.00, '6 Month', 2025, 'mock_lecturer_1'),
('Professional Development Workshop', 1, 6400.00, '3 Month', 2025, 'mock_lecturer_1'),
('Community Service Initiative', 2, 14112.00, '12 Month', 2025, 'mock_lecturer_1'),
('Student Research Competition', 6, 1800.00, '2 Month', 2025, 'mock_lecturer_1');

-- Insert mockup data for project owners
INSERT INTO project_owners (project_id, owner_name, is_primary) VALUES
(1, 'Dr. Supansa Chaising', TRUE),
(2, 'Dr. Korawit Fakkhong', TRUE),
(2, 'Dr. Supansa Chaising', FALSE),
(2, 'Dr. John Smith', FALSE),
(3, 'Dr. Supansa Chaising', TRUE),
(4, 'Dr. Korawit Fakkhong', TRUE),
(5, 'Dr. Supansa Chaising', TRUE),
(5, 'Dr. Jane Doe', FALSE),
(6, 'Dr. Korawit Fakkhong', TRUE);
