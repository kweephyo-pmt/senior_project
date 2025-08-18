-- Complete Research Performance System with Evaluation Periods
-- Import this single file to set up research performance table

-- 1. Create research_performance table
CREATE TABLE IF NOT EXISTS research_performance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    staff_code VARCHAR(20) NOT NULL,
    evaluateid INT NOT NULL,
    category VARCHAR(100) NOT NULL,
    level4_score DECIMAL(10,2) DEFAULT 0,
    level6_score DECIMAL(10,2) DEFAULT 0,
    level7_score DECIMAL(10,2) DEFAULT 0,
    display_order INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (evaluateid) REFERENCES evaluation_periods(evaluateid),
    INDEX idx_staff_evaluate (staff_code, evaluateid),
    INDEX idx_display_order (display_order)
);

-- 2. Insert research performance data for multiple evaluation periods
INSERT INTO research_performance (staff_code, evaluateid, category, level4_score, level6_score, level7_score, display_order) VALUES
-- Staff 6531503172 (Dr. Phyo Min Thein) - Current period (1/2025)
('6531503172', 9, 'Other Academic Work assigned by the School', 10, 0, 0, 1),
('6531503172', 9, 'Other Academic Work', 0, 0, 0, 2),
('6531503172', 9, 'Patented Inventions', 0, 0, 0, 3),
('6531503172', 9, 'Composition of textbooks, Books, and interactive/e-Learning Materials', 50, 0, 0, 4),
('6531503172', 9, 'Academic Articles', 0, 0, 0, 5),
('6531503172', 9, 'Research Publication', 25, 30, 30, 6),
('6531503172', 9, 'Research Studies', 7, 8, 0, 7),

-- Staff 6531503172 - Previous period (2/2024)
('6531503172', 8, 'Other Academic Work assigned by the School', 8, 0, 0, 1),
('6531503172', 8, 'Other Academic Work', 5, 0, 0, 2),
('6531503172', 8, 'Patented Inventions', 0, 0, 0, 3),
('6531503172', 8, 'Composition of textbooks, Books, and interactive/e-Learning Materials', 45, 0, 0, 4),
('6531503172', 8, 'Academic Articles', 12, 0, 0, 5),
('6531503172', 8, 'Research Publication', 20, 25, 28, 6),
('6531503172', 8, 'Research Studies', 6, 7, 0, 7),

-- Staff 6431703502 (Dr. Apinya Wongkham) - Current period (1/2025)
('6431703502', 9, 'Other Academic Work assigned by the School', 12, 0, 0, 1),
('6431703502', 9, 'Other Academic Work', 8, 0, 0, 2),
('6431703502', 9, 'Patented Inventions', 0, 0, 0, 3),
('6431703502', 9, 'Composition of textbooks, Books, and interactive/e-Learning Materials', 55, 0, 0, 4),
('6431703502', 9, 'Academic Articles', 15, 0, 0, 5),
('6431703502', 9, 'Research Publication', 28, 32, 35, 6),
('6431703502', 9, 'Research Studies', 9, 10, 0, 7),

-- Staff 6531503017 (Dr. Siriporn Thanakit) - Current period (1/2025)
('6531503017', 9, 'Other Academic Work assigned by the School', 9, 0, 0, 1),
('6531503017', 9, 'Other Academic Work', 6, 0, 0, 2),
('6531503017', 9, 'Patented Inventions', 0, 0, 0, 3),
('6531503017', 9, 'Composition of textbooks, Books, and interactive/e-Learning Materials', 48, 0, 0, 4),
('6531503017', 9, 'Academic Articles', 10, 0, 0, 5),
('6531503017', 9, 'Research Publication', 22, 28, 32, 6),
('6531503017', 9, 'Research Studies', 8, 9, 0, 7),

-- Staff 6531503069 (Dr. Rattana Choosri) - Current period (1/2025)
('6531503069', 9, 'Other Academic Work assigned by the School', 11, 0, 0, 1),
('6531503069', 9, 'Other Academic Work', 7, 0, 0, 2),
('6531503069', 9, 'Patented Inventions', 0, 0, 0, 3),
('6531503069', 9, 'Composition of textbooks, Books, and interactive/e-Learning Materials', 52, 0, 0, 4),
('6531503069', 9, 'Academic Articles', 13, 0, 0, 5),
('6531503069', 9, 'Research Publication', 26, 31, 33, 6),
('6531503069', 9, 'Research Studies', 8, 9, 0, 7),

-- Staff 6531503070 (Dr. Suwanna Phakdee) - Current period (1/2025)
('6531503070', 9, 'Other Academic Work assigned by the School', 10, 0, 0, 1),
('6531503070', 9, 'Other Academic Work', 5, 0, 0, 2),
('6531503070', 9, 'Patented Inventions', 0, 0, 0, 3),
('6531503070', 9, 'Composition of textbooks, Books, and interactive/e-Learning Materials', 49, 0, 0, 4),
('6531503070', 9, 'Academic Articles', 11, 0, 0, 5),
('6531503070', 9, 'Research Publication', 24, 29, 31, 6),
('6531503070', 9, 'Research Studies', 7, 8, 0, 7),

-- Staff 6531503074 (Dr. Niran Jaikla) - Current period (1/2025)
('6531503074', 9, 'Other Academic Work assigned by the School', 13, 0, 0, 1),
('6531503074', 9, 'Other Academic Work', 9, 0, 0, 2),
('6531503074', 9, 'Patented Inventions', 0, 0, 0, 3),
('6531503074', 9, 'Composition of textbooks, Books, and interactive/e-Learning Materials', 56, 0, 0, 4),
('6531503074', 9, 'Academic Articles', 16, 0, 0, 5),
('6531503074', 9, 'Research Publication', 29, 33, 36, 6),
('6531503074', 9, 'Research Studies', 10, 11, 0, 7),

-- Staff 6531503137 (Dr. Kamon Bualert) - Current period (1/2025)
('6531503137', 9, 'Other Academic Work assigned by the School', 8, 0, 0, 1),
('6531503137', 9, 'Other Academic Work', 4, 0, 0, 2),
('6531503137', 9, 'Patented Inventions', 0, 0, 0, 3),
('6531503137', 9, 'Composition of textbooks, Books, and interactive/e-Learning Materials', 46, 0, 0, 4),
('6531503137', 9, 'Academic Articles', 9, 0, 0, 5),
('6531503137', 9, 'Research Publication', 21, 27, 30, 6),
('6531503137', 9, 'Research Studies', 6, 7, 0, 7),

-- Staff 6531503174 (Dr. Supansa Chaising) - Current period (1/2025)
('6531503174', 9, 'Other Academic Work assigned by the School', 14, 0, 0, 1),
('6531503174', 9, 'Other Academic Work', 10, 0, 0, 2),
('6531503174', 9, 'Patented Inventions', 0, 0, 0, 3),
('6531503174', 9, 'Composition of textbooks, Books, and interactive/e-Learning Materials', 58, 0, 0, 4),
('6531503174', 9, 'Academic Articles', 18, 0, 0, 5),
('6531503174', 9, 'Research Publication', 31, 35, 38, 6),
('6531503174', 9, 'Research Studies', 11, 12, 0, 7),

-- Staff 6531503176 (Dr. Korawit Fakkhong) - Current period (1/2025)
('6531503176', 9, 'Other Academic Work assigned by the School', 9, 0, 0, 1),
('6531503176', 9, 'Other Academic Work', 6, 0, 0, 2),
('6531503176', 9, 'Patented Inventions', 0, 0, 0, 3),
('6531503176', 9, 'Composition of textbooks, Books, and interactive/e-Learning Materials', 47, 0, 0, 4),
('6531503176', 9, 'Academic Articles', 12, 0, 0, 5),
('6531503176', 9, 'Research Publication', 23, 28, 31, 6),
('6531503176', 9, 'Research Studies', 7, 8, 0, 7),

-- Staff 6631205226 (Dr. Wipob Suttinun) - Current period (1/2025)
('6631205226', 9, 'Other Academic Work assigned by the School', 11, 0, 0, 1),
('6631205226', 9, 'Other Academic Work', 7, 0, 0, 2),
('6631205226', 9, 'Patented Inventions', 0, 0, 0, 3),
('6631205226', 9, 'Composition of textbooks, Books, and interactive/e-Learning Materials', 51, 0, 0, 4),
('6631205226', 9, 'Academic Articles', 14, 0, 0, 5),
('6631205226', 9, 'Research Publication', 27, 32, 34, 6),
('6631205226', 9, 'Research Studies', 9, 10, 0, 7);
