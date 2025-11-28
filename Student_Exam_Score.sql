create database exam;
use exam;
select*from student_exam_scores;

-- 1. Find students who studied more than 8 hours -- 
SELECT student_id, hours_studied, exam_score
FROM student_exam_scores
WHERE hours_studied > 8;

-- 2. Maximum hours studied -- 
SELECT MAX(hours_studied) AS max_hours
FROM student_exam_scores;

-- 3 Group students by attendance category -- 
SELECT 
  CASE 
    WHEN attendance_percent >= 90 THEN 'Excellent'
    WHEN attendance_percent >= 75 THEN 'Good'
    WHEN attendance_percent >= 60 THEN 'Average'
    ELSE 'Poor'
  END AS attendance_category,
  COUNT(*) AS student_count
FROM student_exam_scores
GROUP BY attendance_category;

-- 4. Get top 5 highest exam scorers --
SELECT student_id, exam_score
FROM student_exam_scores
ORDER BY exam_score DESC
LIMIT 5;

-- 5. Get bottom 5 lowest exam scorers--
SELECT student_id, exam_score
FROM student_exam_scores
ORDER BY exam_score ASC
LIMIT 5;

-- 6  Find students with both poor attendance (<60) and low exam score (<30)--
SELECT student_id, attendance_percent, exam_score
FROM student_exam_scores
WHERE attendance_percent < 60 AND exam_score < 30;

-- 8 Students who studied more than average study hours -- 
SELECT student_id, hours_studied
FROM student_exam_scores
WHERE hours_studied > (SELECT AVG(hours_studied) FROM student_exam_scores);

-- 9 Students with lowest attendance but still scored above 35 -- 
SELECT student_id, attendance_percent, exam_score
FROM student_exam_scores
WHERE attendance_percent = (SELECT MIN(attendance_percent) FROM student_exam_scores)
AND exam_score > 35;

-- 10 Students with the highest score -- 
SELECT student_id, exam_score
FROM student_exam_scores
WHERE exam_score = (SELECT MAX(exam_score) FROM student_exam_scores);

-- 11. Students with less than 5 hours sleep--
SELECT student_id, sleep_hours, exam_score
FROM student_exam_scores
WHERE sleep_hours < 5;

-- 12. Find students who improved compared to previous scores--
SELECT student_id, previous_scores, exam_score
FROM student_exam_scores
WHERE exam_score > previous_scores;

-- 13. Find students whose exam score is less than previous score--
SELECT student_id, previous_scores, exam_score
FROM student_exam_scores
WHERE exam_score < previous_scores;

-- 14 Students who scored above average -- 
SELECT student_id, exam_score
FROM student_exam_scores;

-- 15 Rank students by exam score -- 
SELECT student_id, exam_score,
       RANK() OVER (ORDER BY exam_score DESC) AS score_rank
FROM student_exam_scores;


-- 16. Average score by sleep range--
SELECT 
  CASE 
    WHEN sleep_hours >= 8 THEN 'Well Rested'
    WHEN sleep_hours >= 6 THEN 'Moderate Sleep'
    ELSE 'Sleep Deprived'
  END AS sleep_category,
  AVG(exam_score) AS avg_score
FROM student_exam_scores
GROUP BY sleep_category;

-- 17. Count of students scoring more than 40--
SELECT COUNT(*) AS high_scorers
FROM student_exam_scores
WHERE exam_score > 40;

-- 18. Top 3 students with highest improvement (exam_score - previous_scores)--
SELECT student_id, (exam_score - previous_scores) AS improvement
FROM student_exam_scores
ORDER BY improvement DESC
LIMIT 3;

-- 19. Top 3 students with highest decline--
SELECT student_id, (exam_score - previous_scores) AS decline
FROM student_exam_scores
ORDER BY decline ASC
LIMIT 3;

-- 19. Students with perfect attendance (100%)--
SELECT student_id, exam_score
FROM student_exam_scores
WHERE attendance_percent = 100;

-- 20. Distribution of scores in ranges--
SELECT 
  CASE 
    WHEN exam_score >= 40 THEN 'High'
    WHEN exam_score >= 30 THEN 'Medium'
    ELSE 'Low'
  END AS score_category,
  COUNT(*) AS student_count
FROM student_exam_scores
GROUP BY score_category;
