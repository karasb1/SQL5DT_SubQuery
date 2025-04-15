create database Academy;
go
use Academy;
go

create table Curators (
    Id int identity(1,1) primary key,
    Name nvarchar(max) not null,
    Surname nvarchar(max) not null
);

create table Students (
    Id int identity(1,1) primary key,
    Name nvarchar(max) not null,
    Rating int not null check (Rating between 0 and 5),
    Surname nvarchar(max) not null
);

create table Teachers (
    Id int identity(1,1) primary key,
    IsProfessor bit not null default 0,
    Name nvarchar(max) not null,
    Salary money not null check (Salary > 0),
    Surname nvarchar(max) not null
);

create table Subjects (
    Id int identity(1,1) primary key,
    Name nvarchar(100) not null unique
);

create table Faculties (
    Id int identity(1,1) primary key,
    Name nvarchar(100) not null unique
);

create table Departments (
    Id int identity(1,1) primary key,
    Building int not null check (Building between 1 and 5),
    Financing money not null default 0 check (Financing >= 0),
    Name nvarchar(100) not null unique,
    FacultyId int not null
);

create table Groups (
    Id int identity(1,1) primary key,
    Name nvarchar(10) not null unique,
    Year int not null check (Year between 1 and 5),
    DepartmentId int not null
);

create table GroupsCurators (
    Id int identity(1,1) primary key,
    CuratorId int not null,
    GroupId int not null
);

create table GroupsLectures (
    Id int identity(1,1) primary key,
    GroupId int not null,
    LectureId int not null
);

create table GroupsStudents (
    Id int identity(1,1) primary key,
    GroupId int not null,
    StudentId int not null
);

create table Lectures (
    Id int identity(1,1) primary key,
    Date date not null check (Date <= getdate()),
    SubjectId int not null,
    TeacherId int not null
);


insert into Curators (Name, Surname) values
('John', 'Doe'),
('Jane', 'Smith'),
('Alice', 'Johnson'),
('Bob', 'Brown');

insert into Faculties (Name) values
('Faculty of Science'),
('Faculty of Arts'),
('Faculty of Engineering'),
('Computer Science');

insert into Departments (Building, Financing, Name, FacultyId) values
(1, 100000, 'Department of Physics', 1),
(2, 200000, 'Software Development', 1),
(3, 150000, 'Department of Literature', 2),
(4, 250000, 'Department of Civil Engineering', 3),
(5, 150000, 'Department of Medicine', 4);

insert into Groups (Name, Year, DepartmentId) values
('CS101', 1, 1),
('CS102', 2, 1),
('D221', 1, 4),
('MED101', 1, 5),
('ENG201', 2, 3),
('ART301', 3, 2),
('PHY401', 4, 1),
('BIO501', 5, 2),
('CHEM601', 1, 3),
('MATH701', 2, 4),
('PHY801', 3, 5),
('BIO901', 4, 1),
('CHEM1001', 5, 2),
('MATH1101', 1, 3),
('PHY1201', 2, 4),
('BIO1301', 3, 5);

insert into GroupsCurators (CuratorId, GroupId) values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(1, 2),
(2, 3),
(3, 4),
(4, 1);

insert into GroupsLectures (GroupId, LectureId) values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(1, 5),
(2, 6),
(3, 7),
(4, 8),
(1, 9),
(2, 10),
(3, 11),
(4, 12),
(1, 13),
(2, 14),
(3, 15);

insert into GroupsStudents (GroupId, StudentId) values
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(4, 6);

insert into Subjects (Name) values
('Mathematics'),
('Physics'),
('Chemistry'),
('Biology'),
('Literature');

insert into Teachers (IsProfessor, Name, Salary, Surname) values
(1, 'Dr. Alice', 80000, 'Johnson'),
(0, 'Mr. Bob', 60000, 'Brown'),
(1, 'Prof. Charlie', 90000, 'Davis'),
(0, 'Ms. Eve', 70000, 'Wilson');

insert into Lectures (Date, SubjectId, TeacherId) values
('2023-09-01', 1, 1),
('2023-09-02', 2, 2),
('2023-09-03', 3, 3),
('2023-09-04', 4, 4),
('2023-09-05', 5, 1),
('2023-09-06', 1, 2),
('2023-09-07', 2, 3),
('2023-09-08', 3, 4),
('2023-09-09', 4, 1),
('2023-09-10', 5, 2),
('2023-09-11', 1, 3),
('2023-09-12', 2, 4),
('2023-09-13', 3, 1),
('2023-09-14', 4, 2),
('2023-09-15', 5, 3);

insert into Students (Name, Rating, Surname) values
('Alice', 4, 'Smith'),
('Bob', 3, 'Johnson'),
('Charlie', 5, 'Brown'),
('David', 2, 'Davis'),
('Eve', 4, 'Wilson'),
('Frank', 3, 'Garcia'),
('Grace', 5, 'Martinez'),
('Heidi', 2, 'Hernandez'),
('Ivan', 4, 'Lopez'),
('Judy', 3, 'Gonzalez'),
('Karl', 5, 'Perez'),
('Leo', 2, 'Wilson'),
('Mallory', 4, 'Anderson'),
('Nina', 3, 'Thomas'),
('Oscar', 5, 'Taylor'),
('Peggy', 2, 'Moore'),
('Quentin', 4, 'Jackson'),
('Rupert', 3, 'White'),
('Sybil', 5, 'Harris'),
('Trent', 2, 'Martin'),
('Uma', 4, 'Thompson'),
('Victor', 3, 'Garcia'),
('Walter', 5, 'Martinez'),
('Xena', 2, 'Robinson'),
('Yara', 4, 'Clark'),
('Zane', 3, 'Rodriguez');


select Building
from Departments
group by Building
having sum(Financing) > 100000;

select G.Name
from Groups g
join Departments D on G.DepartmentId = D.Id
where G.Year = 5 and D.Name = 'Software Development' and G.Id in (
    select GL.GroupId
    from GroupsLectures GL
    group by GL.GroupId
    having count(GL.LectureId) > 10
);

select G.Name
from Groups G
join GroupsStudents GS on G.Id = GS.GroupId
join Students S on GS.StudentId = S.Id
group by G.Name
having avg(S.Rating) > (
    select avg(S2.Rating)
    from Groups G2
    join GroupsStudents GS2 on G2.Id = GS2.GroupId
    join Students S2 on GS2.StudentId = S2.Id
    where G2.Name = 'D221'
);

select T.Surname, T.Name
from Teachers T
group by T.Surname, T.Name
having avg(T.Salary) > (
    select avg(T2.Salary)
    from Teachers T2
    where T2.IsProfessor = 1
);

select G.Name
from Groups G
join GroupsCurators GC on G.Id = GC.GroupId
group by G.Name
having count(GC.CuratorId) > 1;

select G.Name
from Groups G
join GroupsStudents GS on G.Id = GS.GroupId
join Students S on GS.StudentId = S.Id
group by G.Name
having avg(S.Rating) < (
    select min(Average_Rating)
    from (
        select avg(S2.Rating) as Average_Rating
        from Groups G2
        join GroupsStudents GS2 on G2.Id = GS2.GroupId
        join Students S2 on GS2.StudentId = S2.Id
        where G2.Year = 5
        group by G2.Name
    ) as Avg_Ratings
);

select F.Name
from Faculties F
join Departments D on F.Id = D.FacultyId
group by F.Name
having sum(D.Financing) > (
    select sum(D2.Financing)
    from Faculties F2
    join Departments D2 on F2.Id = D2.FacultyId
    where F2.Name = 'Computer Science'
);

select S.Name, T.Surname + ' ' + T.Name as FullName
from Lectures L
join Subjects S on L.SubjectId = S.Id
join Teachers T on L.TeacherId = T.Id
group by S.Name, T.Surname, T.Name
having count(L.Id) = (
    select max(LCount)
    from (
        select count(L2.Id) as LCount
        from Lectures L2
        join Subjects S2 on L2.SubjectId = S2.Id
        join Teachers T2 on L2.TeacherId = T2.Id
        group by S2.Name, T2.Surname, T2.Name
    ) as L2_Counts
);

select S.Name
from Subjects S
join Lectures L on S.Id = L.SubjectId
group by S.Name
having count(L.Id) = (
    select min(LCount)
    from (
        select count(L2.Id) as LCount
        from Lectures L2
        group by L2.SubjectId
    ) as L2_Counts
);

select
(select count(S.Id)
    from Students S
    join GroupsStudents GS on S.Id = GS.StudentId
    join Groups G on GS.GroupId = G.Id
    join Departments D on G.DepartmentId = D.Id
    where D.Name = 'Software Development') as StudentCount,
(select count(S.Id)
    from Subjects S
    join Lectures L on S.Id = L.SubjectId
    join Teachers T on L.TeacherId = T.Id
    join Departments D on T.Id = D.Id
    where D.Name = 'Software Development') as SubjectCount;

drop database Academy;

/*
 Запити
1. Вивести номери корпусів, якщо сумарний фонд фінансування розташованих у них кафедр перевищує 100 000.
2. Вивести назви груп 5-го курсу кафедри “Software Development”,
які мають понад 10 пар на перший тиждень.
3. Вивести назви груп, які мають рейтинг (середній рейтинг
усіх студентів групи) більший, ніж рейтинг групи “D221”.
4. Вивести прізвища та імена викладачів, ставка яких вища
за середню ставку професорів.
5. Вивести назви груп, які мають більше одного куратора.
6. Вивести назви груп, які мають рейтинг (середній рейтинг
усіх студентів групи) менший, ніж мінімальний рейтинг
груп 5-го курсу.
7. Вивести назви факультетів, сумарний фонд фінансування кафедр яких більший за сумарний фонд фінансування
кафедр факультету “Computer Science”.
8. Вивести назви дисциплін та повні імена викладачів, які
читають найбільшу кількість лекцій з них.
9. Вивести назву дисципліни, за якою читається найменше
лекцій.
10. Вивести кількість студентів та дисциплін, що читаються
на кафедрі “Software Development”.
 */