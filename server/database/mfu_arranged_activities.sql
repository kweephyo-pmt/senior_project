-- MFU Arranged Activities Table for Domain 5: Arts and Culture Conservation Performance
-- Simplified table matching frontend requirements

-- Drop existing table if it exists
DROP TABLE IF EXISTS mfu_arranged_activities;

CREATE TABLE IF NOT EXISTS mfu_arranged_activities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    staff_code VARCHAR(20) NOT NULL,
    project_name VARCHAR(500) NOT NULL,
    activity_level INT NOT NULL,
    evaluateid INT NOT NULL DEFAULT 9,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_staff_code (staff_code),
    INDEX idx_evaluateid (evaluateid)
);

-- Insert sample data matching the frontend mockup
INSERT INTO mfu_arranged_activities (staff_code, project_name, activity_level, evaluateid) VALUES

-- Sample data for all staff members (evaluateid = 9)
('6431703502', 'Cultural Heritage Workshop', 1, 9),
('6431703502', 'Traditional Arts Festival', 2, 9),
('6431703502', 'Community Engagement Program', 3, 9),
('6431703502', 'Local Culture Documentation', 4, 9),
('6431703502', 'Arts Conservation Training', 5, 9),
('6431703502', 'Cultural Exchange Initiative', 6, 9),

('6531503017', 'Cultural Heritage Workshop', 1, 9),
('6531503017', 'Traditional Arts Festival', 2, 9),
('6531503017', 'Community Engagement Program', 3, 9),
('6531503017', 'Local Culture Documentation', 4, 9),
('6531503017', 'Arts Conservation Training', 5, 9),
('6531503017', 'Cultural Exchange Initiative', 6, 9),

('6531503069', 'Cultural Heritage Workshop', 1, 9),
('6531503069', 'Traditional Arts Festival', 2, 9),
('6531503069', 'Community Engagement Program', 3, 9),
('6531503069', 'Local Culture Documentation', 4, 9),
('6531503069', 'Arts Conservation Training', 5, 9),
('6531503069', 'Cultural Exchange Initiative', 6, 9),

('6531503070', 'Cultural Heritage Workshop', 1, 9),
('6531503070', 'Traditional Arts Festival', 2, 9),
('6531503070', 'Community Engagement Program', 3, 9),
('6531503070', 'Local Culture Documentation', 4, 9),
('6531503070', 'Arts Conservation Training', 5, 9),
('6531503070', 'Cultural Exchange Initiative', 6, 9),

('6531503074', 'Cultural Heritage Workshop', 1, 9),
('6531503074', 'Traditional Arts Festival', 2, 9),
('6531503074', 'Community Engagement Program', 3, 9),
('6531503074', 'Local Culture Documentation', 4, 9),
('6531503074', 'Arts Conservation Training', 5, 9),
('6531503074', 'Cultural Exchange Initiative', 6, 9),

('6531503137', 'Cultural Heritage Workshop', 1, 9),
('6531503137', 'Traditional Arts Festival', 2, 9),
('6531503137', 'Community Engagement Program', 3, 9),
('6531503137', 'Local Culture Documentation', 4, 9),
('6531503137', 'Arts Conservation Training', 5, 9),
('6531503137', 'Cultural Exchange Initiative', 6, 9),

('6531503172', 'Cultural Heritage Workshop', 1, 9),
('6531503172', 'Traditional Arts Festival', 2, 9),
('6531503172', 'Community Engagement Program', 3, 9),
('6531503172', 'Local Culture Documentation', 4, 9),
('6531503172', 'Arts Conservation Training', 5, 9),
('6531503172', 'Cultural Exchange Initiative', 6, 9),

('6531503174', 'Cultural Heritage Workshop', 1, 9),
('6531503174', 'Traditional Arts Festival', 2, 9),
('6531503174', 'Community Engagement Program', 3, 9),
('6531503174', 'Local Culture Documentation', 4, 9),
('6531503174', 'Arts Conservation Training', 5, 9),
('6531503174', 'Cultural Exchange Initiative', 6, 9),

('6531503176', 'Cultural Heritage Workshop', 1, 9),
('6531503176', 'Traditional Arts Festival', 2, 9),
('6531503176', 'Community Engagement Program', 3, 9),
('6531503176', 'Local Culture Documentation', 4, 9),
('6531503176', 'Arts Conservation Training', 5, 9),
('6531503176', 'Cultural Exchange Initiative', 6, 9),

('6631205226', 'Cultural Heritage Workshop', 1, 9),
('6631205226', 'Traditional Arts Festival', 2, 9),
('6631205226', 'Community Engagement Program', 3, 9),
('6631205226', 'Local Culture Documentation', 4, 9),
('6631205226', 'Arts Conservation Training', 5, 9),
('6631205226', 'Cultural Exchange Initiative', 6, 9),

-- Sample data for evaluateid = 8 (previous evaluation period)
('6431703502', 'Cultural Heritage Workshop', 1, 8),
('6431703502', 'Traditional Arts Festival', 2, 8),
('6431703502', 'Community Engagement Program', 3, 8),
('6431703502', 'Local Culture Documentation', 4, 8),

('6531503017', 'Cultural Heritage Workshop', 1, 8),
('6531503017', 'Traditional Arts Festival', 2, 8),
('6531503017', 'Community Engagement Program', 3, 8),
('6531503017', 'Local Culture Documentation', 4, 8),
('6531503017', 'Arts Conservation Training', 5, 8),

('6531503069', 'Cultural Heritage Workshop', 1, 8),
('6531503069', 'Traditional Arts Festival', 2, 8),
('6531503069', 'Community Engagement Program', 3, 8),
('6531503069', 'Arts Conservation Training', 5, 8),

('6531503070', 'Cultural Heritage Workshop', 1, 8),
('6531503070', 'Traditional Arts Festival', 2, 8),
('6531503070', 'Local Culture Documentation', 4, 8),
('6531503070', 'Cultural Exchange Initiative', 6, 8),

('6531503074', 'Cultural Heritage Workshop', 1, 8),
('6531503074', 'Traditional Arts Festival', 2, 8),
('6531503074', 'Community Engagement Program', 3, 8),
('6531503074', 'Local Culture Documentation', 4, 8),

('6531503137', 'Cultural Heritage Workshop', 1, 8),
('6531503137', 'Traditional Arts Festival', 2, 8),
('6531503137', 'Arts Conservation Training', 5, 8),
('6531503137', 'Cultural Exchange Initiative', 6, 8),

('6531503172', 'Cultural Heritage Workshop', 1, 8),
('6531503172', 'Traditional Arts Festival', 2, 8),
('6531503172', 'Community Engagement Program', 3, 8),
('6531503172', 'Arts Conservation Training', 5, 8),

('6531503174', 'Cultural Heritage Workshop', 1, 8),
('6531503174', 'Traditional Arts Festival', 2, 8),
('6531503174', 'Local Culture Documentation', 4, 8),
('6531503174', 'Cultural Exchange Initiative', 6, 8),

('6531503176', 'Cultural Heritage Workshop', 1, 8),
('6531503176', 'Community Engagement Program', 3, 8),
('6531503176', 'Local Culture Documentation', 4, 8),
('6531503176', 'Arts Conservation Training', 5, 8),

('6631205226', 'Cultural Heritage Workshop', 1, 8),
('6631205226', 'Traditional Arts Festival', 2, 8),
('6631205226', 'Community Engagement Program', 3, 8),
('6631205226', 'Cultural Exchange Initiative', 6, 8);
