-- Student Management System Database Script

-- Drop tables if they exist
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Admins;

-- Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL
);

-- Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Age INT,
    Gender VARCHAR(10),
    DOB DATE,
    Contact VARCHAR(15),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Courses table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Enrollments table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Admins table (Optional: for login)
CREATE TABLE Admins (
    AdminID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL
);

-- Insert sample data into Departments
INSERT INTO Departments (DepartmentName) VALUES
('Computer Science'),
('Electrical Engineering'),
('Mechanical Engineering');

-- Insert sample data into Students
INSERT INTO Students (Name, Age, Gender, DOB, Contact, DepartmentID) VALUES
('John Doe', 20, 'Male', '2004-01-15', '9876543210', 1),
('Jane Smith', 22, 'Female', '2002-03-25', '9123456780', 2);

-- Insert sample data into Courses
INSERT INTO Courses (CourseName, DepartmentID) VALUES
('Data Structures', 1),
('Digital Circuits', 2),
('Thermodynamics', 3);

-- Enroll students in courses
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate) VALUES
(1, 1, '2024-06-01'),
(2, 2, '2024-06-05');

-- Insert sample admin (Optional)
INSERT INTO Admins (Username, Password) VALUES
('admin', 'admin123'); -- For demo only, no hashing!
