create database casedb;
use casedb;
create table students ( 
student_id int primary key,
email varchar(255),
full_name varchar(255),
dob date,
phone varchar (20),
address text);
INSERT INTO STUDENTS (student_id, email, full_name, dob, phone, address)
values (1, "john.doe@example.com", "johndoe", "2000-05-12", "1234567891", "123 main st,anytown,usa"),
(2, 'jane.smith@example.com', 'Jane Smith', '2001-03-20', '+1 987-654-3210', '456 Elm St, Somewhere, USA'),
    (3, 'alex.brown@example.com', 'Alex Brown', '1999-11-10', '+1 555-123-4567', '789 Oak Ave, Anytown, USA'),
    (4, 'mary.johnson@example.com', 'Mary Johnson', '2002-08-05', '+1 777-888-9999', '567 Maple Rd, Elsewhere, USA'),
    (5, 'priya.chavan@example.com', 'priya chavan', '2003-09-05', '+ 7755442266', 'talegaon dabhade ,pune ');
select * from students;    
CREATE TABLE TEACHERS (
    teacher_id INT PRIMARY KEY,
    email VARCHAR(255),
    full_name VARCHAR(255),
    dob DATE,
    phone VARCHAR(20),
    specialty VARCHAR(100)
);
INSERT INTO TEACHERS (teacher_id, email, full_name, dob, phone, specialty)
VALUES
    (101, 'alice.smith@example.com', 'Alice Smith', '1985-09-10', '+1 123-456-7890', 'Mathematics'),
    (102, 'bob.jones@example.com', 'Bob Jones', '1978-03-25', '+1 987-654-3210', 'History'),
    (103, 'carol.wilson@example.com', 'Carol Wilson', '1990-07-15', '+1 555-123-4567', 'Science'),
    (104, 'rutu,surve@example.com', 'rutuja surve', '1999-08-15', '+1 888-478-4789', 'history'),
    (105, 'bloom.12@example.com', 'bloom doe', '1999-08-17', '+1 111-252-6369', 'arts');
select * from TEACHERS;
CREATE TABLE ENROLLMENT (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    classroom_id INT,
    enrollment_date DATE);
  INSERT INTO ENROLLMENT (enrollment_id, student_id, classroom_id, enrollment_date)
VALUES
    (1001, 1, 101, '2024-08-01'),
    (1002, 2, 102, '2024-08-02'),
    (1003, 3, 101, '2024-08-03'),
    (1004, 4, 103, '2024-09-01'),
    (1005, 5, 104, '2024-10-02'),
    (1006, 6, 105, '2024-10-03');
select * from ENROLLMENT;
CREATE TABLE CLASSROOMS (
    classroom_id INT PRIMARY KEY,
    grade VARCHAR(255),
    section VARCHAR(255)
);
INSERT INTO CLASSROOMS (classroom_id, grade, section)
VALUES
    (1, '1st grade', 'A'),
    (2, '2nd grade', 'B'),
    (3, '3rd grade', 'C'),
    (4, '4th grade', 'D'),
    (5, '5th grade', 'E');
select * from classrooms;

CREATE TABLE COURSES (
    course_id INT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT
);
INSERT INTO COURSES (course_id, name, description)
VALUES
    (1, 'Mathematics', 'Advanced algebra and calculus'),
    (2, 'History', 'World history from ancient civilizations to modern times'),
    (3, 'Computer Science', 'Introduction to programming and algorithms'),
    (4, 'Geography', 'the earth and its atmosphere'),
    (5, 'English', 'the language of England');
select * from courses;
    
CREATE TABLE MARKS (
    mark_id INT PRIMARY KEY,
    course_id INT,
    student_id INT,
    mark DECIMAL(5, 2), -- Assuming a decimal grade (e.g., 95.50)
    mark_date DATE
);
INSERT INTO MARKS (mark_id, course_id, student_id, mark, mark_date)
VALUES
    (1, 101, 201, 95.50, '2024-08-28'),
    (2, 102, 202, 88.75, '2024-08-29'),
    (3, 103, 203, 78.00, '2024-08-30'),
    (4, 104, 204, 85.00, '2024-09-25'),
    (5,105, 305, 80.00, '2024-10-26');
select * from marks;


-- 1.  Create a report that shows the FullName from the students table sorted by fullName
select Full_name from students order by Full_name;

-- 2. Create a report that shows the teacher_id, full_name, emails and Phone from the TEACHERS table sorted by Phone.
select teacher_id, full_name, email, phone from TEACHERS order by phone;

-- 3.  Create a report that shows all the student_ID in lowercase letter and renamed as ID from the students table.
select lower(student_id) as ID from students;

-- 4.  Create a report that shows the enrollment_id, student_id, classroom_id from the  ENROLLMENT table sorted by the enrollment_id in descending order then by classroom_id in ascending order.
select enrollment_id, student_id, classroom_id from ENROLLMENT order by enrollment_id desc, classroom_id asc;
    
-- 5. Find the total number of students enrolled in each students
select count(*) from students group by student_id;

-- 6. List the teachers along with the number of students they teach.
select t.Full_name as teachername, count(distinct s.student_id) as numberofstudent
from TEACHERS t left join students s on t.teacher_id = s.student_id
group by t.teacher_id, t.Full_name;

-- 7. Count the number of students in each DOB
select count(*) from students group by DOB;

-- 8. List the enrollment taken by a specific student.
select e.enrollment_id, e.student_id from students s join 
TEACHERS t on s.student_id = t.teacher_id
join ENROLLMENT e on t.teacher_id = e.student_id
where s.student_id = "your_student_id_here";

-- 9. Find the teacher who teaches the most courses.
select t.teacher_id, count(c.course_id) as num_courses
from teachers t join courses c on t.teacher_id = c.course_id
group by t.teacher_id order by num_courses desc
limit 1;

-- 10. Get the top N students based on their average marks.
select mark_id, avg(mark) from marks group by mark_id order by mark desc limit 1;

-- 11. Retrieve the students who have taken a specific course.
SELECT s.student_id, s.Full_name
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM courses sc
    WHERE sc.course_id = s.student_id
    AND sc.course_id = 'your_course_id_here'
);

-- 12. Find the students who have the same phone number.
select phone, count(*) from students group by phone having count(*) > 2;

-- 13. Calculate the total marks obtained by each student.
select mark, sum(mark) from marks group by mark;

-- 14. Find the students who are enrolled in multiple courses.
select distinct(s.student_id)
from students s join courses c on 
s.student_id = c.course_id;

-- 15. Retrieve the students who live in a specific address.
select Full_name, address from students where address="789 Oak Ave, Anytown, USA";

-- 20. List the courses that have no enrolled students.
select course_id, name from courses where course_id not in
(select distinct(course_id) from students);

-- 21. Retrieve the teachers who specialize in a specific subject.
select * from TEACHERS where specialty="Mathematics";

-- 22. Find the students who were enrolled on a specific date.
select * from enrollment where enrollment_date ='2024-08-01' and enrollment_date = '2024-10-03' ;

-- 23. List the courses taught by a specific teacher.
select description from courses where course_id = 4;

-- 24. Retrieve the students who have the highest and lowest marks.
select student_id,min(mark) from marks where student_id = 202 group by mark;

-- 25. Calculate the total number of enrolled students.
select count(*)  as total_students from students;

-- 26. Retrieve the students who have taken courses in a specific grade.
SELECT DISTINCT s.student_id, s.full_name
FROM students s
JOIN enrollment r ON s.student_id = r.student_id
JOIN marks c ON r.student_id = c.mark_id
WHERE mark < 88 ;

-- 27. List the courses taken by students .
SELECT DISTINCT c.description
FROM students s
JOIN enrollment r ON s.student_id = r.student_id
JOIN courses c ON r.student_id = c.course_id;

-- 28. Find the students make upper case full name.
select upper(full_name) from students;

-- 29. Retrieve the teachers who were born before a specific date.
select * from teachers;
SELECT teacher_id, full_name
FROM teachers
WHERE dob < '1990-01-01';

-- 30. List the courses taken by students with a specific phone number. in sql query
SELECT DISTINCT c.name
FROM students s
JOIN enrollment e ON s.student_id = e.student_id
JOIN courses c ON e.student_id = c.course_id
WHERE s.phone = '555-123-4567';

-- 31. Retrieve the teachers who teach courses with a specific description.
SELECT DISTINCT t.teacher_id, t.full_name
FROM teachers t
JOIN courses ct ON t.teacher_id = ct.course_id
WHERE ct.description= 'World history from ancient civilizations to modern times';

-- 32.Calculate the overall pass percentage for each grade.
select * from classrooms;
select count(*) as total_student from classrooms where section =" A " and section = "D";

-- 33. Calculate the total number of enrolled students in each grade.
select grade, count(*) as total_student from classrooms group by grade;

-- 34. List the courses taken by students with a specific email domain.
SELECT DISTINCT c.name
FROM students s
JOIN enrollment e ON s.student_id = e.student_id
JOIN courses c ON e.student_id = c.course_id
WHERE s.email LIKE '%@example.com';

-- 35.  Create a report that shows the average, minimum and maximum  of all marks as Averagemark, Minimum_mark and Maximum_mark respectively.
select avg(mark) as averagemarks, min(mark) as minimum_mark, max(mark) as maximum_mark from marks;

-- 36. Find the students who have taken courses in a specific classroom.
SELECT DISTINCT s.student_id, s.full_name
FROM students s
JOIN enrollment e ON s.student_id = e.student_id
join classrooms c on e.student_id = c.classroom_id
WHERE c.classroom_id = '4';

-- 37. Retrieve the teachers who teach courses with a specific course ID.
SELECT *
FROM teachers t
JOIN courses ct ON t.teacher_id = ct.course_id
WHERE t.teacher_id = '101';

-- 38. Calculate the total number of enrolled students in each classroom.
select count(*) as total_student from students group by student_id;

-- 39. Create a report that shows the fullName of all students that do not have letter A as the second alphabet in their fullname.
select full_name from students where full_name not like "_A";

-- 40. find the max mark from all marks table
select max(mark) from marks;

-- 41. craete report on fullname, email , address in sort phone way all the students ]
select full_name,email,address from students order by phone;

-- 42. create a report on fullname , student_id from students where adrees starting a or b
select full_name, student_id from students where address like "A%" or address like "B%";

-- 43. 
select * from enrollment where enrollment_date='2024-09-01';

-- 44. 
select * from marks where mark <> 100;

-- 45.
select * from marks where mark_date='2024-10-26';

-- 46.
select * from classrooms;
select * from classrooms where section = 'A';

-- 47.
select * from marks where mark < '99';

-- 48. 
select * from marks where mark < '50';

-- 49.
select course_id, name, description from courses where name ='Computer Science';

-- 50. List the courses taken by students with a specific dob range.
select * from students where dob between '2000-05-12' and '2000-05-12';

