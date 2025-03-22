create database Hospital;
go
use Hospital;
go


create table Departments (
    Id int identity(1,1) primary key,
    Building int not null check (Building between 1 and 5),
    Name nvarchar(100) not null unique
);

create table Doctors (
    Id int identity(1,1) primary key,
    Name nvarchar(max) not null,
    Surname nvarchar(max) not null,
    Salary money not null check (Salary > 0),
    Premium money not null check (Premium >= 0) default 0
);

create table DoctorExaminations (
    Id int identity(1,1) primary key,
    StartTime time not null check (StartTime between '08:00' and '18:00'),
    EndTime time not null,
    DoctorId int not null foreign key references Doctors(Id),
    ExaminationId int not null foreign key references Examinations(Id),
    WardId int not null foreign key references Wards(Id)
);

create table Donations (
    Id int identity(1,1) primary key,
    Amount money not null check (Amount > 0),
    Date date not null default getdate() check (Date <= getdate()),
    DepartmentId int not null foreign key references Departments(Id),
    SponsorId int not null foreign key references Sponsors(Id)
);

create table Examinations (
    Id int identity(1,1) primary key,
    Name nvarchar(100) not null unique
);

create table Sponsors (
    Id int identity(1,1) primary key,
    Name nvarchar(100) not null unique
);

create table Wards (
    Id int identity(1,1) primary key,
    Name nvarchar(20) not null unique,
    Places int not null check (Places >= 1),
    DepartmentId int not null foreign key references Departments(Id)
);

insert into Departments (Building, Name) values
(1, 'Cardiology'),
(1, 'Neurology'),
(2, 'Oncology'),
(2, 'Gynecology'),
(3, 'Pediatrics'),
(3, 'Dermatology'),
(4, 'Ophthalmology'),
(4, 'Otolaryngology'),
(5, 'Urology'),
(5, 'Orthopedics');
insert into Doctors (Name, Surname, Salary, Premium) values
('Anthony', 'Davis', 1000, 100),
('Jane', 'Doe', 1200, 200),
('Jack', 'Smith', 1500, 300),
('Jill', 'Smith', 2000, 400),
('James', 'Johnson', 2500, 500),
('Thomas', 'Gerada', 1000, 600);

insert into Examinations (Name) values
('Blood test'),
('MRI'),
('X-ray'),
('Ultrasound'),
('CT scan'),
('Endoscopy');

insert into Sponsors (Name) values
('John Doe'),
('Jane Doe'),
('Jack Smith'),
('Jill Smith'),
('James Johnson'),
('Jenny Johnson');

insert into Wards (Name, Places, DepartmentId) values
('Cardiology 1', 10, 1),
('Cardiology 2', 10, 1),
('Neurology 1', 10, 2),
('Neurology 2', 10, 2),
('Oncology 1', 10, 3),
('Oncology 2', 10, 3),
('Gynecology 1', 10, 4),
('Gynecology 2', 10, 4),
('Pediatrics 1', 10, 5),
('Pediatrics 2', 10, 5),
('Dermatology 1', 10, 6),
('Dermatology 2', 10, 6),
('Ophthalmology 1', 10, 7),
('Ophthalmology 2', 10, 7),
('Otolaryngology 1', 10, 8),
('Otolaryngology 2', 10, 8),
('Urology 1', 10, 9),
('Urology 2', 10, 9),
('Orthopedics 1', 10, 10),
('Orthopedics 2', 10, 10);

insert into Donations (Amount, DepartmentId, SponsorId) values
(1000, 1, 1),
(2000, 2, 2),
(3000, 3, 3),
(4000, 4, 4),
(5000, 5, 5),
(6000, 6, 6);

insert into DoctorExaminations (StartTime, EndTime, DoctorId, ExaminationId, WardId) values
('08:00', '10:00', 1, 1, 1),
('10:00', '12:00', 2, 2, 2),
('12:00', '14:00', 3, 3, 3),
('14:00', '16:00', 4, 4, 4),
('16:00', '18:00', 5, 5, 5),
('08:00', '10:00', 6, 6, 6);


select Name
from Departments
where Building = (select Building from Departments where Name = 'Cardiology');

select Name
from Departments
where Building = (select Building from Departments where Name = 'Gastroenterology')
or Building = (select Building from Departments where Name = 'General Surgery');

select Surname
from Doctors
where Salary > (select Salary from Doctors where Name = 'Thomas' and Surname = 'Gerada');

select Name
from Wards
where Places > (select avg(Places) from Wards where DepartmentId = (select Id from Departments where Name = 'Microbiology'));

select Name
from Doctors
where Salary + Premium - 100 > (select Salary from Doctors where Name = 'Anthony' and Surname = 'Davis');

select Name
from Departments
where Id in (select DepartmentId from DoctorExaminations, Wards where DoctorId = (select Id from Doctors where Name = 'Joshua' and Surname = 'Bell'));

select Name
from Sponsors
where Id not in (select SponsorId from Donations where DepartmentId in (select Id from Departments where Name = 'Neurology' or Name = 'Oncology'));

select Surname
from Doctors
where Id in (select DoctorId from DoctorExaminations where StartTime between '12:00' and '15:00');