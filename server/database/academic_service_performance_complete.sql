-- Complete Academic Service Performance System with Evaluation Periods
-- Import this single file to set up academic service performance table

-- 1. Create academic_service_performance table
CREATE TABLE IF NOT EXISTS academic_service_performance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    staff_code VARCHAR(20) NOT NULL,
    evaluateid INT NOT NULL,
    category VARCHAR(100) NOT NULL,
    internal_score DECIMAL(10,2) DEFAULT 0,
    external_score DECIMAL(10,2) DEFAULT 0,
    non_revenue_score DECIMAL(10,2) DEFAULT 0,
    display_order INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (evaluateid) REFERENCES evaluation_periods(evaluateid),
    INDEX idx_staff_evaluate (staff_code, evaluateid),
    INDEX idx_display_order (display_order)
);

-- 2. Insert academic service performance data for multiple evaluation periods
INSERT INTO academic_service_performance (staff_code, evaluateid, category, internal_score, external_score, non_revenue_score, display_order) VALUES
-- Staff 6531503172 (Dr. Phyo Min Thein) - Current period (1/2025)
('6531503172', 9, 'Other types of Academic Service Provided', 0, 0, 0, 1),
('6531503172', 9, 'Academic Reviewer', 5, 0, 0, 2),
('6531503172', 9, 'External Committee/Advisor/Member', 0, 0, 0, 3),
('6531503172', 9, 'Performance as an Invited Lecturer or Speaker', 27, 27, 0, 4),
('6531503172', 9, 'Academic Service Activities', 0, 0, 27, 5),

-- Staff 6531503172 - Previous period (2/2024)
('6531503172', 8, 'Other types of Academic Service Provided', 3, 0, 0, 1),
('6531503172', 8, 'Academic Reviewer', 4, 0, 0, 2),
('6531503172', 8, 'External Committee/Advisor/Member', 8, 0, 0, 3),
('6531503172', 8, 'Performance as an Invited Lecturer or Speaker', 22, 24, 0, 4),
('6531503172', 8, 'Academic Service Activities', 0, 0, 25, 5),

-- Staff 6431703502 (Dr. Apinya Wongkham) - Current period (1/2025)
('6431703502', 9, 'Other types of Academic Service Provided', 5, 0, 0, 1),
('6431703502', 9, 'Academic Reviewer', 8, 0, 0, 2),
('6431703502', 9, 'External Committee/Advisor/Member', 12, 0, 0, 3),
('6431703502', 9, 'Performance as an Invited Lecturer or Speaker', 30, 32, 0, 4),
('6431703502', 9, 'Academic Service Activities', 0, 0, 30, 5),

-- Staff 6531503017 (Dr. Siriporn Thanakit) - Current period (1/2025)
('6531503017', 9, 'Other types of Academic Service Provided', 2, 0, 0, 1),
('6531503017', 9, 'Academic Reviewer', 6, 0, 0, 2),
('6531503017', 9, 'External Committee/Advisor/Member', 9, 0, 0, 3),
('6531503017', 9, 'Performance as an Invited Lecturer or Speaker', 25, 28, 0, 4),
('6531503017', 9, 'Academic Service Activities', 0, 0, 26, 5),

-- Staff 6531503069 (Dr. Rattana Choosri) - Current period (1/2025)
('6531503069', 9, 'Other types of Academic Service Provided', 4, 0, 0, 1),
('6531503069', 9, 'Academic Reviewer', 7, 0, 0, 2),
('6531503069', 9, 'External Committee/Advisor/Member', 11, 0, 0, 3),
('6531503069', 9, 'Performance as an Invited Lecturer or Speaker', 28, 30, 0, 4),
('6531503069', 9, 'Academic Service Activities', 0, 0, 28, 5),

-- Staff 6531503070 (Dr. Suwanna Phakdee) - Current period (1/2025)
('6531503070', 9, 'Other types of Academic Service Provided', 1, 0, 0, 1),
('6531503070', 9, 'Academic Reviewer', 5, 0, 0, 2),
('6531503070', 9, 'External Committee/Advisor/Member', 8, 0, 0, 3),
('6531503070', 9, 'Performance as an Invited Lecturer or Speaker', 24, 26, 0, 4),
('6531503070', 9, 'Academic Service Activities', 0, 0, 25, 5),

-- Staff 6531503074 (Dr. Niran Jaikla) - Current period (1/2025)
('6531503074', 9, 'Other types of Academic Service Provided', 6, 0, 0, 1),
('6531503074', 9, 'Academic Reviewer', 9, 0, 0, 2),
('6531503074', 9, 'External Committee/Advisor/Member', 13, 0, 0, 3),
('6531503074', 9, 'Performance as an Invited Lecturer or Speaker', 32, 35, 0, 4),
('6531503074', 9, 'Academic Service Activities', 0, 0, 32, 5),

-- Staff 6531503137 (Dr. Kamon Bualert) - Current period (1/2025)
('6531503137', 9, 'Other types of Academic Service Provided', 0, 0, 0, 1),
('6531503137', 9, 'Academic Reviewer', 4, 0, 0, 2),
('6531503137', 9, 'External Committee/Advisor/Member', 7, 0, 0, 3),
('6531503137', 9, 'Performance as an Invited Lecturer or Speaker', 21, 23, 0, 4),
('6531503137', 9, 'Academic Service Activities', 0, 0, 22, 5),

-- Staff 6531503174 (Dr. Supansa Chaising) - Current period (1/2025)
('6531503174', 9, 'Other types of Academic Service Provided', 7, 0, 0, 1),
('6531503174', 9, 'Academic Reviewer', 10, 0, 0, 2),
('6531503174', 9, 'External Committee/Advisor/Member', 14, 0, 0, 3),
('6531503174', 9, 'Performance as an Invited Lecturer or Speaker', 34, 37, 0, 4),
('6531503174', 9, 'Academic Service Activities', 0, 0, 35, 5),

-- Staff 6531503176 (Dr. Korawit Fakkhong) - Current period (1/2025)
('6531503176', 9, 'Other types of Academic Service Provided', 3, 0, 0, 1),
('6531503176', 9, 'Academic Reviewer', 6, 0, 0, 2),
('6531503176', 9, 'External Committee/Advisor/Member', 10, 0, 0, 3),
('6531503176', 9, 'Performance as an Invited Lecturer or Speaker', 26, 29, 0, 4),
('6531503176', 9, 'Academic Service Activities', 0, 0, 27, 5),

-- Staff 6631205226 (Dr. Wipob Suttinun) - Current period (1/2025)
('6631205226', 9, 'Other types of Academic Service Provided', 4, 0, 0, 1),
('6631205226', 9, 'Academic Reviewer', 7, 0, 0, 2),
('6631205226', 9, 'External Committee/Advisor/Member', 11, 0, 0, 3),
('6631205226', 9, 'Performance as an Invited Lecturer or Speaker', 29, 31, 0, 4),
('6631205226', 9, 'Academic Service Activities', 0, 0, 29, 5);
