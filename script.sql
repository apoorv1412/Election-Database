create database if not exists election_database;

use election_database;

drop table if exists voter;

create table voter (
name varchar(20) not null,
age int unsigned not null, 
aadhaar_number int unsigned not null, 
has_voted enum('Y', 'N') not null, 
address varchar(50) not null, 
gender enum('M', 'F', 'O') not null,
primary key(aadhaar_number)
);

drop table if exists party;

create table party (
name varchar(20) not null, 
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
aadhaar_number int unsigned not null, 
constituency_id int unsigned not null,
party_id int unsigned not null,
name varchar(20) not null,
gender enum('M', 'F', 'O') not null,
primary key(aadhaar_number)
);

drop table if exists constituency;

create table constituency (
`state` varchar(20) not null, 
constituency_id int unsigned not null,
name varchar(20) not null,
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
party_id int unsigned not null,
primary key(aadhaar_number)
);