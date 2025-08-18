-- Complete Teaching Performance System with Evaluation Periods
-- Import this single file to set up both tables

-- 1. Create evaluation_periods table
CREATE TABLE IF NOT EXISTS evaluation_periods (
    evaluateid INT PRIMARY KEY,
    evaluatename VARCHAR(50) NOT NULL,
    evaluatestartdate DATE NOT NULL,
    evaluateenddate DATE NOT NULL,
    is_active TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert evaluation periods data
INSERT INTO evaluation_periods (evaluateid, evaluatename, evaluatestartdate, evaluateenddate, is_active) VALUES
(1, '1/2021', '2021-01-01', '2021-06-30', 0),
(2, '2/2021', '2021-07-01', '2021-12-31', 0),
(3, '1/2022', '2022-01-01', '2022-06-30', 0),
(4, '2/2022', '2022-07-01', '2022-12-31', 0),
(5, '1/2023', '2023-01-01', '2023-06-30', 0),
(6, '2/2023', '2023-07-01', '2023-12-31', 0),
(7, '1/2024', '2024-01-01', '2024-06-30', 0),
(8, '2/2024', '2024-07-01', '2024-12-31', 0),
(9, '1/2025', '2025-01-01', '2025-06-30', 1);

-- 2. Drop existing teaching_performance table if it exists
DROP TABLE IF EXISTS teaching_performance;

-- 3. Create updated teaching_performance table with evaluateid foreign key
CREATE TABLE teaching_performance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    staff_code VARCHAR(20) NOT NULL,
    evaluateid INT NOT NULL,
    category VARCHAR(100) NOT NULL,
    lecture_score DECIMAL(10,2) DEFAULT 0,
    lab_score DECIMAL(10,2) DEFAULT 0,
    display_order INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (evaluateid) REFERENCES evaluation_periods(evaluateid),
    INDEX idx_staff_evaluate (staff_code, evaluateid),
    INDEX idx_display_order (display_order)
);

-- 4. Insert teaching performance data for multiple evaluation periods
INSERT INTO teaching_performance (staff_code, evaluateid, category, lecture_score, lab_score, display_order) VALUES
-- Staff 6531503172 (Dr. Phyo Min Thein) - Current period (1/2025)
('6531503172', 9, 'Other Teaching Tasks Assigned by the Academic Office', 8.5, 7.8, 1),
('6531503172', 9, 'Thesis Oversight Duties', 9.2, 8.8, 2),
('6531503172', 9, 'Student Projects or Special Issues', 7.6, 8.2, 3),
('6531503172', 9, 'Student Internships', 8.9, 8.5, 4),
('6531503172', 9, 'Graduate Teaching', 8.3, 7.9, 5),
('6531503172', 9, 'Undergraduate Teaching', 8.7, 8.1, 6),

-- Staff 6531503172 - Previous period (2/2024)
('6531503172', 8, 'Other Teaching Tasks Assigned by the Academic Office', 7.8, 7.2, 1),
('6531503172', 8, 'Thesis Oversight Duties', 8.5, 8.1, 2),
('6531503172', 8, 'Student Projects or Special Issues', 7.1, 7.8, 3),
('6531503172', 8, 'Student Internships', 8.2, 7.9, 4),
('6531503172', 8, 'Graduate Teaching', 7.9, 7.5, 5),
('6531503172', 8, 'Undergraduate Teaching', 8.1, 7.7, 6),

-- Staff 6431703502 (Dr. Apinya Wongkham) - Current period (1/2025)
('6431703502', 9, 'Other Teaching Tasks Assigned by the Academic Office', 9.1, 8.7, 1),
('6431703502', 9, 'Thesis Oversight Duties', 9.4, 9.2, 2),
('6431703502', 9, 'Student Projects or Special Issues', 8.2, 8.8, 3),
('6431703502', 9, 'Student Internships', 9.3, 8.9, 4),
('6431703502', 9, 'Graduate Teaching', 8.8, 8.4, 5),
('6431703502', 9, 'Undergraduate Teaching', 9.0, 8.6, 6),

-- Staff 6531503017 (Dr. Siriporn Thanakit) - Current period (1/2025)
('6531503017', 9, 'Other Teaching Tasks Assigned by the Academic Office', 8.7, 8.2, 1),
('6531503017', 9, 'Thesis Oversight Duties', 9.0, 8.6, 2),
('6531503017', 9, 'Student Projects or Special Issues', 7.8, 8.4, 3),
('6531503017', 9, 'Student Internships', 8.8, 8.3, 4),
('6531503017', 9, 'Graduate Teaching', 8.4, 8.0, 5),
('6531503017', 9, 'Undergraduate Teaching', 8.6, 8.2, 6),

-- Staff 6531503069 (Dr. Rattana Choosri) - Current period (1/2025)
('6531503069', 9, 'Other Teaching Tasks Assigned by the Academic Office', 8.3, 7.9, 1),
('6531503069', 9, 'Thesis Oversight Duties', 8.9, 8.5, 2),
('6531503069', 9, 'Student Projects or Special Issues', 7.5, 8.1, 3),
('6531503069', 9, 'Student Internships', 8.7, 8.2, 4),
('6531503069', 9, 'Graduate Teaching', 8.1, 7.7, 5),
('6531503069', 9, 'Undergraduate Teaching', 8.4, 8.0, 6),

-- Staff 6531503070 (Dr. Suwanna Phakdee) - Current period (1/2025)
('6531503070', 9, 'Other Teaching Tasks Assigned by the Academic Office', 8.9, 8.6, 1),
('6531503070', 9, 'Thesis Oversight Duties', 9.3, 9.0, 2),
('6531503070', 9, 'Student Projects or Special Issues', 8.0, 8.7, 3),
('6531503070', 9, 'Student Internships', 9.1, 8.8, 4),
('6531503070', 9, 'Graduate Teaching', 8.6, 8.2, 5),
('6531503070', 9, 'Undergraduate Teaching', 8.8, 8.4, 6),

-- Staff 6531503074 (Dr. Niran Jaikla) - Current period (1/2025)
('6531503074', 9, 'Other Teaching Tasks Assigned by the Academic Office', 8.2, 7.8, 1),
('6531503074', 9, 'Thesis Oversight Duties', 8.8, 8.4, 2),
('6531503074', 9, 'Student Projects or Special Issues', 7.4, 8.0, 3),
('6531503074', 9, 'Student Internships', 8.6, 8.1, 4),
('6531503074', 9, 'Graduate Teaching', 8.0, 7.6, 5),
('6531503074', 9, 'Undergraduate Teaching', 8.3, 7.9, 6),

-- Staff 6531503137 (Dr. Kamon Bualert) - Current period (1/2025)
('6531503137', 9, 'Other Teaching Tasks Assigned by the Academic Office', 9.0, 8.8, 1),
('6531503137', 9, 'Thesis Oversight Duties', 9.3, 9.1, 2),
('6531503137', 9, 'Student Projects or Special Issues', 8.1, 8.6, 3),
('6531503137', 9, 'Student Internships', 9.2, 8.9, 4),
('6531503137', 9, 'Graduate Teaching', 8.7, 8.3, 5),
('6531503137', 9, 'Undergraduate Teaching', 8.9, 8.5, 6),

-- Staff 6531503174 (Dr. Supansa Chaising) - Current period (1/2025)
('6531503174', 9, 'Other Teaching Tasks Assigned by the Academic Office', 8.8, 8.4, 1),
('6531503174', 9, 'Thesis Oversight Duties', 9.1, 8.7, 2),
('6531503174', 9, 'Student Projects or Special Issues', 7.9, 8.5, 3),
('6531503174', 9, 'Student Internships', 9.0, 8.6, 4),
('6531503174', 9, 'Graduate Teaching', 8.5, 8.1, 5),
('6531503174', 9, 'Undergraduate Teaching', 8.7, 8.3, 6),

-- Staff 6531503176 (Dr. Korawit Fakkhong) - Current period (1/2025)
('6531503176', 9, 'Other Teaching Tasks Assigned by the Academic Office', 8.7, 8.3, 1),
('6531503176', 9, 'Thesis Oversight Duties', 9.0, 8.6, 2),
('6531503176', 9, 'Student Projects or Special Issues', 7.7, 8.3, 3),
('6531503176', 9, 'Student Internships', 8.9, 8.5, 4),
('6531503176', 9, 'Graduate Teaching', 8.2, 7.8, 5),
('6531503176', 9, 'Undergraduate Teaching', 8.5, 8.1, 6),

-- Staff 6631205226 (Dr. Wipob Suttinun) - Current period (1/2025)
('6631205226', 9, 'Other Teaching Tasks Assigned by the Academic Office', 8.6, 8.2, 1),
('6631205226', 9, 'Thesis Oversight Duties', 8.9, 8.5, 2),
('6631205226', 9, 'Student Projects or Special Issues', 7.6, 8.1, 3),
('6631205226', 9, 'Student Internships', 8.8, 8.4, 4),
('6631205226', 9, 'Graduate Teaching', 8.1, 7.7, 5),
('6631205226', 9, 'Undergraduate Teaching', 8.4, 8.0, 6),

-- Add some historical data for comparison (2/2024 period)
-- Staff 6431703502 - Previous period (2/2024)
('6431703502', 8, 'Other Teaching Tasks Assigned by the Academic Office', 8.8, 8.4, 1),
('6431703502', 8, 'Thesis Oversight Duties', 9.1, 8.7, 2),
('6431703502', 8, 'Student Projects or Special Issues', 7.9, 8.5, 3),
('6431703502', 8, 'Student Internships', 8.9, 8.5, 4),
('6431703502', 8, 'Graduate Teaching', 8.5, 8.1, 5),
('6431703502', 8, 'Undergraduate Teaching', 8.7, 8.3, 6),

-- Staff 6531503017 - Previous period (2/2024)
('6531503017', 8, 'Other Teaching Tasks Assigned by the Academic Office', 8.4, 8.0, 1),
('6531503017', 8, 'Thesis Oversight Duties', 8.7, 8.3, 2),
('6531503017', 8, 'Student Projects or Special Issues', 7.3, 7.9, 3),
('6531503017', 8, 'Student Internships', 8.5, 8.1, 4),
('6531503017', 8, 'Graduate Teaching', 7.8, 7.4, 5),
('6531503017', 8, 'Undergraduate Teaching', 8.2, 7.8, 6);
