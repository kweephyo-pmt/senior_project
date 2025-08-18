-- Complete Administration Performance System with Evaluation Periods
-- Import this single file to set up administration performance table

-- 1. Create administration_performance table
CREATE TABLE IF NOT EXISTS administration_performance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    staff_code VARCHAR(20) NOT NULL,
    evaluateid INT NOT NULL,
    category VARCHAR(100) NOT NULL,
    score DECIMAL(10,2) DEFAULT 0,
    display_order INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (evaluateid) REFERENCES evaluation_periods(evaluateid),
    INDEX idx_staff_evaluate (staff_code, evaluateid),
    INDEX idx_display_order (display_order)
);

-- 2. Insert administration performance data for multiple evaluation periods
INSERT INTO administration_performance (staff_code, evaluateid, category, score, display_order) VALUES
-- Staff 6531503172 (Dr. Phyo Min Thein) - Current period (1/2025)
('6531503172', 9, 'Academic Administration assigned by the School or University', 0, 1),
('6531503172', 9, 'Coordination with Guest Lecturer', 0, 2),
('6531503172', 9, 'Course Coordination', 10, 3),
('6531503172', 9, 'University\'s Committee or Committee-Appointed Working Group', 25, 4),
('6531503172', 9, 'School\'s Committee or Committee-Appointed Working Group', 20, 5),
('6531503172', 9, 'School Committee', 0, 6),
('6531503172', 9, 'Curricular Committee', 0, 7),
('6531503172', 9, 'Administrative duty assigned by the school', 60, 8),

-- Staff 6531503172 - Previous period (2/2024)
('6531503172', 8, 'Academic Administration assigned by the School or University', 0, 1),
('6531503172', 8, 'Coordination with Guest Lecturer', 0, 2),
('6531503172', 8, 'Course Coordination', 8, 3),
('6531503172', 8, 'University\'s Committee or Committee-Appointed Working Group', 20, 4),
('6531503172', 8, 'School\'s Committee or Committee-Appointed Working Group', 15, 5),
('6531503172', 8, 'School Committee', 0, 6),
('6531503172', 8, 'Curricular Committee', 0, 7),
('6531503172', 8, 'Administrative duty assigned by the school', 50, 8),

-- Staff 6531503017 (Dr. Siriporn Thanakit) - Current period (1/2025)
('6531503017', 9, 'Academic Administration assigned by the School or University', 0, 1),
('6531503017', 9, 'Coordination with Guest Lecturer', 0, 2),
('6531503017', 9, 'Course Coordination', 12, 3),
('6531503017', 9, 'University\'s Committee or Committee-Appointed Working Group', 30, 4),
('6531503017', 9, 'School\'s Committee or Committee-Appointed Working Group', 25, 5),
('6531503017', 9, 'School Committee', 0, 6),
('6531503017', 9, 'Curricular Committee', 0, 7),
('6531503017', 9, 'Administrative duty assigned by the school', 65, 8),

-- Staff 6531503017 - Previous period (2/2024)
('6531503017', 8, 'Academic Administration assigned by the School or University', 0, 1),
('6531503017', 8, 'Coordination with Guest Lecturer', 0, 2),
('6531503017', 8, 'Course Coordination', 9, 3),
('6531503017', 8, 'University\'s Committee or Committee-Appointed Working Group', 22, 4),
('6531503017', 8, 'School\'s Committee or Committee-Appointed Working Group', 18, 5),
('6531503017', 8, 'School Committee', 0, 6),
('6531503017', 8, 'Curricular Committee', 0, 7),
('6531503017', 8, 'Administrative duty assigned by the school', 55, 8),

-- Staff 6531503069 (Dr. Rattana Choosri) - Current period (1/2025)
('6531503069', 9, 'Academic Administration assigned by the School or University', 0, 1),
('6531503069', 9, 'Coordination with Guest Lecturer', 0, 2),
('6531503069', 9, 'Course Coordination', 15, 3),
('6531503069', 9, 'University\'s Committee or Committee-Appointed Working Group', 35, 4),
('6531503069', 9, 'School\'s Committee or Committee-Appointed Working Group', 30, 5),
('6531503069', 9, 'School Committee', 0, 6),
('6531503069', 9, 'Curricular Committee', 0, 7),
('6531503069', 9, 'Administrative duty assigned by the school', 70, 8),

-- Staff 6531503070 (Dr. Suwanna Phakdee) - Current period (1/2025)
('6531503070', 9, 'Academic Administration assigned by the School or University', 0, 1),
('6531503070', 9, 'Coordination with Guest Lecturer', 0, 2),
('6531503070', 9, 'Course Coordination', 8, 3),
('6531503070', 9, 'University\'s Committee or Committee-Appointed Working Group', 20, 4),
('6531503070', 9, 'School\'s Committee or Committee-Appointed Working Group', 15, 5),
('6531503070', 9, 'School Committee', 0, 6),
('6531503070', 9, 'Curricular Committee', 0, 7),
('6531503070', 9, 'Administrative duty assigned by the school', 45, 8),

-- Staff 6531503074 (Dr. Niran Jaikla) - Current period (1/2025)
('6531503074', 9, 'Academic Administration assigned by the School or University', 0, 1),
('6531503074', 9, 'Coordination with Guest Lecturer', 0, 2),
('6531503074', 9, 'Course Coordination', 18, 3),
('6531503074', 9, 'University\'s Committee or Committee-Appointed Working Group', 40, 4),
('6531503074', 9, 'School\'s Committee or Committee-Appointed Working Group', 35, 5),
('6531503074', 9, 'School Committee', 0, 6),
('6531503074', 9, 'Curricular Committee', 0, 7),
('6531503074', 9, 'Administrative duty assigned by the school', 80, 8),

-- Staff 6531503137 (Dr. Kamon Bualert) - Current period (1/2025)
('6531503137', 9, 'Academic Administration assigned by the School or University', 0, 1),
('6531503137', 9, 'Coordination with Guest Lecturer', 0, 2),
('6531503137', 9, 'Course Coordination', 11, 3),
('6531503137', 9, 'University\'s Committee or Committee-Appointed Working Group', 28, 4),
('6531503137', 9, 'School\'s Committee or Committee-Appointed Working Group', 22, 5),
('6531503137', 9, 'School Committee', 0, 6),
('6531503137', 9, 'Curricular Committee', 0, 7),
('6531503137', 9, 'Administrative duty assigned by the school', 58, 8),

-- Staff 6531503174 (Dr. Supansa Chaising) - Current period (1/2025)
('6531503174', 9, 'Academic Administration assigned by the School or University', 0, 1),
('6531503174', 9, 'Coordination with Guest Lecturer', 0, 2),
('6531503174', 9, 'Course Coordination', 14, 3),
('6531503174', 9, 'University\'s Committee or Committee-Appointed Working Group', 32, 4),
('6531503174', 9, 'School\'s Committee or Committee-Appointed Working Group', 28, 5),
('6531503174', 9, 'School Committee', 0, 6),
('6531503174', 9, 'Curricular Committee', 0, 7),
('6531503174', 9, 'Administrative duty assigned by the school', 68, 8),

-- Staff 6531503176 (Dr. Korawit Fakkhong) - Current period (1/2025)
('6531503176', 9, 'Academic Administration assigned by the School or University', 0, 1),
('6531503176', 9, 'Coordination with Guest Lecturer', 0, 2),
('6531503176', 9, 'Course Coordination', 16, 3),
('6531503176', 9, 'University\'s Committee or Committee-Appointed Working Group', 38, 4),
('6531503176', 9, 'School\'s Committee or Committee-Appointed Working Group', 32, 5),
('6531503176', 9, 'School Committee', 0, 6),
('6531503176', 9, 'Curricular Committee', 0, 7),
('6531503176', 9, 'Administrative duty assigned by the school', 75, 8),

-- Staff 6631205226 (Dr. Wipob Suttinun) - Current period (1/2025)
('6631205226', 9, 'Academic Administration assigned by the School or University', 0, 1),
('6631205226', 9, 'Coordination with Guest Lecturer', 0, 2),
('6631205226', 9, 'Course Coordination', 13, 3),
('6631205226', 9, 'University\'s Committee or Committee-Appointed Working Group', 30, 4),
('6631205226', 9, 'School\'s Committee or Committee-Appointed Working Group', 25, 5),
('6631205226', 9, 'School Committee', 0, 6),
('6631205226', 9, 'Curricular Committee', 0, 7),
('6631205226', 9, 'Administrative duty assigned by the school', 62, 8);
