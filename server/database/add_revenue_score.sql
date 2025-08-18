-- Add revenue_score column to academic_service_performance table
ALTER TABLE academic_service_performance 
ADD COLUMN revenue_score DECIMAL(10,2) DEFAULT 0 AFTER non_revenue_score;

-- Update existing data with revenue scores
-- For demonstration, adding revenue scores to Academic Service Activities category
UPDATE academic_service_performance 
SET revenue_score = 27 
WHERE category = 'Academic Service Activities' AND staff_code = '6531503172' AND evaluateid = 9;

UPDATE academic_service_performance 
SET revenue_score = 20 
WHERE category = 'Academic Service Activities' AND staff_code = '6531503172' AND evaluateid = 8;

UPDATE academic_service_performance 
SET revenue_score = 25 
WHERE category = 'Academic Service Activities' AND staff_code = '6531503017' AND evaluateid = 9;

UPDATE academic_service_performance 
SET revenue_score = 18 
WHERE category = 'Academic Service Activities' AND staff_code = '6531503017' AND evaluateid = 8;

UPDATE academic_service_performance 
SET revenue_score = 30 
WHERE category = 'Academic Service Activities' AND staff_code = '6531503069' AND evaluateid = 9;

UPDATE academic_service_performance 
SET revenue_score = 22 
WHERE category = 'Academic Service Activities' AND staff_code = '6531503070' AND evaluateid = 9;

UPDATE academic_service_performance 
SET revenue_score = 35 
WHERE category = 'Academic Service Activities' AND staff_code = '6531503074' AND evaluateid = 9;

UPDATE academic_service_performance 
SET revenue_score = 28 
WHERE category = 'Academic Service Activities' AND staff_code = '6531503137' AND evaluateid = 9;

UPDATE academic_service_performance 
SET revenue_score = 30 
WHERE category = 'Academic Service Activities' AND staff_code = '6531503174' AND evaluateid = 9;

UPDATE academic_service_performance 
SET revenue_score = 32 
WHERE category = 'Academic Service Activities' AND staff_code = '6531503176' AND evaluateid = 9;

UPDATE academic_service_performance 
SET revenue_score = 26 
WHERE category = 'Academic Service Activities' AND staff_code = '6631205226' AND evaluateid = 9;
