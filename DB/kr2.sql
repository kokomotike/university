drop table if exists Children;
create table Children
(
    TabNo int             not null,
    Name  varchar(30)     null,
    Born  date            null,
    Sex   enum ('m', 'f') null
);

drop table if exists Departments;
create table Departments
(
    DepNo int         not null
        primary key,
    Name  varchar(30) null
);

drop table if exists Employees;
create table Employees
(
    TabNo  int            not null
        primary key,
    DepNo  int            not null,
    Name   varchar(30)    null,
    Post   varchar(70)    not null,
    Salary decimal(10, 3) null,
    Born   date           null,
    Phone  varchar(15)    null,
    Sex    varchar(1)     null,
    constraint Employees_ibfk_1
        foreign key (DepNo) references Departments (DepNo)
);

create index DepNo
    on Employees (DepNo);

insert into Children (TabNo, Name, Born, Sex) values (23,  'Ilya',  '1987-02-19', 'm');
insert into Children (TabNo, Name, Born, Sex) values (988, 'Vadim', '1995-05-03', 'm');
insert into Children (TabNo, Name, Born, Sex) values (23,  'Anna',  '1989-12-26', 'f');
insert into Children (TabNo, Name, Born, Sex) values (909, 'Inna',  '2008-01-25', 'f');
insert into Children (TabNo, Name, Born, Sex) values (909, 'Roman', '2006-11-21', 'm');
insert into Children (TabNo, Name, Born, Sex) values (909, 'Anton', '2009-03-06', 'm');
insert into Children (TabNo, Name, Born, Sex) values (110, 'Olga',  '2001-07-18', 'f');

insert into Departments (DepNo, Name) values (1, 'Planning Department');
insert into Departments (DepNo, Name) values (2, 'Accounting');
insert into Departments (DepNo, Name) values (3, 'Human Resource');
insert into Departments (DepNo, Name) values (4, 'Quality Control Department');
insert into Departments (DepNo, Name) values (5, 'Administration');

insert into Employees (TabNo, DepNo, Name, Post, Salary, Born, Phone, Sex) values (2,   3, 'Suhova K.A',  'Manager',             48500.000, '1948-06-08', '115-12-69', 'f');
insert into Employees (TabNo, DepNo, Name, Post, Salary, Born, Phone, Sex) values (23,  2, 'Malova L.A.', 'Main Accountant',     59240.000, '1954-11-24', '114-24-55', 'f');
insert into Employees (TabNo, DepNo, Name, Post, Salary, Born, Phone, Sex) values (34,  3, 'Perova K.B.', 'Systems Coordinator', 32000.000, '1985-04-24', null,        'f');
insert into Employees (TabNo, DepNo, Name, Post, Salary, Born, Phone, Sex) values (56,  5, 'Pavlov A.A.', 'Director',            80000.000, '1968-05-05', '115-33-44', 'm');
insert into Employees (TabNo, DepNo, Name, Post, Salary, Born, Phone, Sex) values (87,  5, 'Kotova I.M.', 'Secretary',           35000.000, '1990-09-16', '115-33-65', 'f');
insert into Employees (TabNo, DepNo, Name, Post, Salary, Born, Phone, Sex) values (88,  5, 'Krol A.P.',   'Dep.Director',        70000.000, '1974-04-18', '115-33-01', 'm');
insert into Employees (TabNo, DepNo, Name, Post, Salary, Born, Phone, Sex) values (100, 2, 'Volkov L.D.', 'Programmer',          46500.000, '1982-10-16', null,        'm');
insert into Employees (TabNo, DepNo, Name, Post, Salary, Born, Phone, Sex) values (110, 2, 'Burov G.O.',  'Accountant',          42880.000, '1975-05-22', '115-46-32', 'm');
insert into Employees (TabNo, DepNo, Name, Post, Salary, Born, Phone, Sex) values (130, 2, 'Lukina H.H.', 'Accountant',          42880.000, '1979-07-12', '115-46-32', 'f');
insert into Employees (TabNo, DepNo, Name, Post, Salary, Born, Phone, Sex) values (819, 1, 'Tamm L.V.',   'Economist',           43500.000, '1985-11-13', '115-91-19', 'f');
insert into Employees (TabNo, DepNo, Name, Post, Salary, Born, Phone, Sex) values (829, 1, 'Durova A.V.', 'Economist',           43500.000, '1978-10-03', '115-26-12', 'f');
insert into Employees (TabNo, DepNo, Name, Post, Salary, Born, Phone, Sex) values (909, 1, 'Serova T.V.', 'Main Programmer',     48500.000, '1981-10-20', '115-91-19', 'f');
insert into Employees (TabNo, DepNo, Name, Post, Salary, Born, Phone, Sex) values (988, 1, 'Rumin V.P.',  'Manager',             48500.000, '1970-02-01', '115-26-12', 'm');

SELECT *
FROM Employees e
WHERE EXISTS(SELECT *
             FROM Children c
             WHERE c.TabNo = e.TabNo
               AND c.Sex = 'm')

  AND EXISTS(SELECT *
             FROM Children
             WHERE Children.TabNo = e.TabNo
               AND Children.Sex = 'f');

select * from Employees;

SELECT youngC.name AS youngChild, youngC.born AS young_born
FROM Children oldC, Children youngC
WHERE oldC.tabno=youngC.tabno -- ???????????? ???????? ??????????
  AND oldC.born<youngC.born  -- ???????? ???????????? ??????????????
  AND oldC.Sex = 'f'  -- ?????????????? - ?????????????? (????????????)
  And youngC.Sex = 'm'; -- ?????????????? - ?????????????? (????????)

-- ?????????????? ?????????????????????? ?? ???????????? ????????????
select d.DepNo, d.Name, COUNT(*) as Count_Emp from Departments d
    inner join Employees e on d.DepNo = e.DepNo group by e.DepNo;

select d.DepNo, e.Sex, COUNT(d.DepNo) from Departments d
    inner join Employees e on d.DepNo = e.DepNo group by d.DepNo, e.Sex ;

select Departments.DepNo, Departments.Name
from Departments
         right join (select DepNo
                     from (select DepNo
                           from Employees
                           group by DepNo, Sex
                           order by DepNo) as e_by_dep_and_sex
                     group by DepNo
                     having count(*) = 1) as gender_spec_deps on Departments.DepNo = gender_spec_deps.DepNo;

SELECT TabNo, DepNo, Name, Born, TIMESTAMPDIFF(YEAR,Born,CURDATE()) AS age
       FROM Employees;



