-- Complete Arts & Culture Performance System with Evaluation Periods
-- Import this single file to set up arts culture performance table

-- 1. Create arts_culture_performance table
CREATE TABLE IF NOT EXISTS arts_culture_performance (
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

-- 2. Insert arts culture performance data for multiple evaluation periods
INSERT INTO arts_culture_performance (staff_code, evaluateid, category, score, display_order) VALUES
-- Staff 6531503172 (Dr. Phyo Min Thein) - Current period (1/2025)
('6531503172', 9, 'Arts & Culture Conservation Performance', 0, 1),
('6531503172', 9, 'Organization development or participation', 0, 2),
('6531503172', 9, 'Self-development', 5, 3),
('6531503172', 9, 'Student Development activites', 5, 4),
('6531503172', 9, 'MFU-arranged arts & culture conservation activities', 5, 5),

-- Staff 6531503172 - Previous period (2/2024)
('6531503172', 8, 'Arts & Culture Conservation Performance', 0, 1),
('6531503172', 8, 'Organization development or participation', 0, 2),
('6531503172', 8, 'Self-development', 4, 3),
('6531503172', 8, 'Student Development activites', 4, 4),
('6531503172', 8, 'MFU-arranged arts & culture conservation activities', 4, 5),

-- Staff 6531503017 (Dr. Siriporn Thanakit) - Current period (1/2025)
('6531503017', 9, 'Arts & Culture Conservation Performance', 0, 1),
('6531503017', 9, 'Organization development or participation', 0, 2),
('6531503017', 9, 'Self-development', 6, 3),
('6531503017', 9, 'Student Development activites', 6, 4),
('6531503017', 9, 'MFU-arranged arts & culture conservation activities', 6, 5),

-- Staff 6531503017 - Previous period (2/2024)
('6531503017', 8, 'Arts & Culture Conservation Performance', 0, 1),
('6531503017', 8, 'Organization development or participation', 0, 2),
('6531503017', 8, 'Self-development', 5, 3),
('6531503017', 8, 'Student Development activites', 5, 4),
('6531503017', 8, 'MFU-arranged arts & culture conservation activities', 5, 5),

-- Staff 6531503069 (Dr. Rattana Choosri) - Current period (1/2025)
('6531503069', 9, 'Arts & Culture Conservation Performance', 0, 1),
('6531503069', 9, 'Organization development or participation', 0, 2),
('6531503069', 9, 'Self-development', 7, 3),
('6531503069', 9, 'Student Development activites', 7, 4),
('6531503069', 9, 'MFU-arranged arts & culture conservation activities', 7, 5),

-- Staff 6531503070 (Dr. Suwanna Phakdee) - Current period (1/2025)
('6531503070', 9, 'Arts & Culture Conservation Performance', 0, 1),
('6531503070', 9, 'Organization development or participation', 0, 2),
('6531503070', 9, 'Self-development', 4, 3),
('6531503070', 9, 'Student Development activites', 4, 4),
('6531503070', 9, 'MFU-arranged arts & culture conservation activities', 4, 5),

-- Staff 6531503074 (Dr. Niran Jaikla) - Current period (1/2025)
('6531503074', 9, 'Arts & Culture Conservation Performance', 0, 1),
('6531503074', 9, 'Organization development or participation', 0, 2),
('6531503074', 9, 'Self-development', 8, 3),
('6531503074', 9, 'Student Development activites', 8, 4),
('6531503074', 9, 'MFU-arranged arts & culture conservation activities', 8, 5),

-- Staff 6531503137 (Dr. Kamon Bualert) - Current period (1/2025)
('6531503137', 9, 'Arts & Culture Conservation Performance', 0, 1),
('6531503137', 9, 'Organization development or participation', 0, 2),
('6531503137', 9, 'Self-development', 5, 3),
('6531503137', 9, 'Student Development activites', 5, 4),
('6531503137', 9, 'MFU-arranged arts & culture conservation activities', 5, 5),

-- Staff 6531503174 (Dr. Supansa Chaising) - Current period (1/2025)
('6531503174', 9, 'Arts & Culture Conservation Performance', 0, 1),
('6531503174', 9, 'Organization development or participation', 0, 2),
('6531503174', 9, 'Self-development', 6, 3),
('6531503174', 9, 'Student Development activites', 6, 4),
('6531503174', 9, 'MFU-arranged arts & culture conservation activities', 6, 5),

-- Staff 6531503176 (Dr. Korawit Fakkhong) - Current period (1/2025)
('6531503176', 9, 'Arts & Culture Conservation Performance', 0, 1),
('6531503176', 9, 'Organization development or participation', 0, 2),
('6531503176', 9, 'Self-development', 7, 3),
('6531503176', 9, 'Student Development activites', 7, 4),
('6531503176', 9, 'MFU-arranged arts & culture conservation activities', 7, 5),

-- Staff 6631205226 (Dr. Wipob Suttinun) - Current period (1/2025)
('6631205226', 9, 'Arts & Culture Conservation Performance', 0, 1),
('6631205226', 9, 'Organization development or participation', 0, 2),
('6631205226', 9, 'Self-development', 5, 3),
('6631205226', 9, 'Student Development activites', 5, 4),
('6631205226', 9, 'MFU-arranged arts & culture conservation activities', 5, 5);
