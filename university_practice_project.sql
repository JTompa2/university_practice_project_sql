CREATE DATABASE university_practice_project;
USE university_practice_project;

-- Create the Students table
CREATE TABLE Students (
  StudentID INT PRIMARY KEY,
  Name VARCHAR(100),
  Age INT
);

-- Create the Courses table
CREATE TABLE Courses (
  CourseID INT PRIMARY KEY,
  CourseName VARCHAR(100),
  Credits INT
);

-- Create the Professors table
CREATE TABLE Professors (
  ProfessorID INT PRIMARY KEY,
  Name VARCHAR(100),
  Department VARCHAR(100)
);

-- Create the Grades table
CREATE TABLE Grades (
  GradeID INT PRIMARY KEY,
  StudentID INT,
  CourseID INT,
  ProfessorID INT,
  GradeValue DECIMAL(5,2),
  FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
  FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
  FOREIGN KEY (ProfessorID) REFERENCES Professors(ProfessorID)
);

-- Insert sample data into the Students table
INSERT INTO Students (StudentID, Name, Age)
VALUES
  (1, 'Juan Soto', 22),
  (2, 'Manny Machado', 13),
  (3, 'Fernando Tatis', 23);

-- Insert sample data into the Courses table
INSERT INTO Courses (CourseID, CourseName, Credits)
VALUES
  (1, 'Botany', 3),
  (2, 'Biology', 4),
  (3, 'Chemistry', 3);

-- Insert sample data into the Professors table
INSERT INTO Professors (ProfessorID, Name, Department)
VALUES
  (1, 'Dr. Shintori', 'Botany'),
  (2, 'Dr. Tanaka', 'Biology'),
  (3, 'Dr. Mister', 'Chemistry');

-- Insert sample data into the Grades table
INSERT INTO Grades (GradeID, StudentID, CourseID, ProfessorID, GradeValue)
VALUES
  (1, 1, 1, 1, 85),
  (2, 1, 2, 2, 92),
  (3, 2, 1, 1, 78),
  (4, 2, 3, 3, 88),
  (5, 3, 2, 2, 95),
  (6, 3, 3, 3, 82);
  
SELECT ProfessorID, AVG(GradeValue) AS AverageGrade
FROM Grades
GROUP BY ProfessorID;

SELECT StudentID, MAX(GradeValue) AS TopGrade
FROM Grades
GROUP BY StudentID;

SELECT s.StudentID, s.Name, c.CourseName
FROM Students s
JOIN Grades g ON s.StudentID = g.StudentID
JOIN Courses c ON g.CourseID = c.CourseID
ORDER BY s.Name, c.CourseName;

SELECT c.CourseID, c.CourseName, AVG(g.GradeValue) AS AverageGrade
FROM Courses c
JOIN Grades g ON c.CourseID = g.CourseID
GROUP BY c.CourseID, c.CourseName
ORDER BY AverageGrade ASC;

SELECT s.StudentID, s.Name AS StudentName, p.ProfessorID, p.Name AS ProfessorName, COUNT(*) AS CommonCoursesCount
FROM Students s
JOIN Grades gs ON s.StudentID = gs.StudentID
JOIN Grades gp ON gs.CourseID = gp.CourseID
JOIN Professors p ON gp.ProfessorID = p.ProfessorID
WHERE s.StudentID <> p.ProfessorID
GROUP BY s.StudentID, s.Name, p.ProfessorID, p.Name
ORDER BY CommonCoursesCount DESC;


