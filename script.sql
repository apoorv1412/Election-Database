create database if not exists election_database;

use election_database;

drop table if exists voter;

create table voter (
per_name varchar(20) not null,
age int unsigned not null, 
aadhaar_number int unsigned not null, 
has_voted enum('Y', 'N') not null, 
address varchar(50) not null, 
gender enum('M', 'F', 'O') not null,
primary key(aadhaar_number)
);

drop table if exists party;

create table party (
par_name varchar(20) not null, 
party_id int unsigned not null,
symbol varchar(20) not null,
primary key(party_id)
);

drop table if exists votes_for;

create table votes_for (
aadhaar_number int unsigned not null, 
constituency_id int unsigned not null,
party_id int unsigned not null,
primary key(aadhaar_number)
); 

drop table if exists candidate;

create table candidate (
per_name varchar(20) not null,
aadhaar_number int unsigned not null, 
constituency_id int unsigned not null,
party_id int unsigned not null,
gender enum('M', 'F', 'O') not null,
primary key(aadhaar_number)
);

drop table if exists constituency;

create table constituency (
`state` varchar(20) not null, 
constituency_id int unsigned not null,
c_name varchar(20) not null,
population int unsigned not null, 
primary key(constituency_id)
);

drop table if exists lives_in;

create table lives_in (
aadhaar_number int unsigned not null, 
constituency_id int unsigned not null,
primary key(aadhaar_number)
);

drop table if exists works_for;

create table works_for (
aadhaar_number int unsigned not null, 
par_name varchar(20) not null,
primary key(aadhaar_number)
);

insert into voter value ('dale', 21, 1000, 'Y', '231 blackwood street', 'M');
insert into voter value ('brooklyn', 19, 1001, 'N', '49 edward street', 'M');
insert into voter value ('cindy', 32, 1002, 'Y', '819 redwood block', 'F');
insert into voter value ('ross', 29, 1003, 'Y', '221B Baker Street', 'M');
insert into voter value ('rachel', 27, 1004, 'Y', '21 Jump Street', 'F');
insert into voter value ('joey', 63, 1005, 'N', '51 Spooner Street', 'M');
insert into voter value ('monica', 42, 1006, 'Y', '9 Elm Street', 'F');
insert into voter value ('phoebe', 76, 1007, 'Y', '17 Okhla Industrial Estate', 'F');
insert into voter value ('chandler', 39, 1008, 'N', '14 King Road', 'M');
insert into voter value ('ursula', 57, 1009, 'Y', '22 Jump Street', 'F');

insert into candidate value ('ross', 1003, 1, 500, 'M');
insert into candidate value ('rachel', 1004, 2, 501, 'F');
insert into candidate value ('phoebe', 1007, 3, 500, 'F');
insert into candidate value ('monica', 1006, 1, 501, 'F');
insert into candidate value ('chandler', 1008, 2, 500, 'M');

insert into constituency value ('Ohio', 1, 'Winterfell', 2000);
insert into constituency value ('Nebraska', 2, 'Riverlands', 10000);
insert into constituency value ('Ohio', 3, 'Dorne', 30000);
insert into constituency value ('Ohio', 4, 'Asshai', 7000);
insert into constituency value ('Nebraska', 5, 'Quarth', 5000);

insert into lives_in value (1000, 1);
insert into lives_in value (1001, 3);
insert into lives_in value (1002, 5);
insert into lives_in value (1003, 1);
insert into lives_in value (1004, 2);
insert into lives_in value (1005, 4);
insert into lives_in value (1006, 2);
insert into lives_in value (1007, 1);
insert into lives_in value (1008, 3);
insert into lives_in value (1009, 3);

insert into works_for value (1003, 'republican');
insert into works_for value (1004, 'democrat');
insert into works_for value (1007, 'republican');
insert into works_for value (1006, 'democrat');
insert into works_for value (1008, 'republican');


insert into party value ('republican', 500, 'elephant');
insert into party value ('democrat', 501, 'donkey');

insert into votes_for value (1000, 1, 501);
insert into votes_for value (1002, 5, 501);
insert into votes_for value (1003, 1, 501);
insert into votes_for value (1004, 2, 500);
insert into votes_for value (1006, 2, 501);
insert into votes_for value (1007, 1, 500);
insert into votes_for value (1009, 3, 500);
