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
insert into voter value ('phoebe', 76, 1007, 'N', '17 Okhla Industrial Estate', 'F');
insert into voter value ('chandler', 39, 1008, 'Y', '14 King Road', 'M');
insert into voter value ('ursula', 57, 1009, 'N', '22 Jump Street', 'F');

insert into candidate value ('ross', 1003, 1, 500, 'M');
insert into candidate value ('rachel', 1004, 2, 501, 'F');
insert into candidate value ('phoebe', 1007, 3, 500, 'F');
insert into candidate value ('monica', 1006, 1, 501, 'F');
insert into candidate value ('chandler', 1008, 2, 500, 'M');
insert into candidate value ('joey', 1005, 5, 500, 'M');

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

/*Queries*/

# Query 1: Select names of all candidates who belong to Republican party.
SELECT per_name 
FROM candidate INNER JOIN works_for ON candidate.aadhaar_number = works_for.aadhaar_number 
WHERE works_for.par_name = "republican";

# Query 2: Count the number of voters having age<=30.
SELECT COUNT(age) 
FROM voter 
WHERE voter.age<=30;

# Query 3: Select the party id which won the maximum votes. (Change to name)
SELECT par_name
FROM party
WHERE party_id in (
	SELECT party_id
	FROM votes_for GROUP BY party_id HAVING COUNT(party_id)=(
		SELECT MAX(count)
		FROM (
			SELECT party_id, COUNT(party_id) count
			FROM votes_for GROUP BY party_id) as P1
		) 
	);

# Query 4: Select names of those voters who voted for Democrat candidate in Winterfell.
SELECT per_name
FROM voter
WHERE voter.aadhaar_number in (
	SELECT aadhaar_number
	FROM votes_for
	WHERE votes_for.constituency_id = (
		SELECT constituency_id
		FROM constituency
		WHERE c_name = "Winterfell"
		)
		and votes_for.party_id = (
		SELECT party_id
		FROM party
		WHERE par_name = "democrat"
		)
	);

# Query 5: Select names of female voters who did not exercise their right to vote.
SELECT per_name
FROM voter
WHERE has_voted = 'N' and gender = 'F';

# Query 6: Select the winner of the Dorne constituency
SELECT *
FROM candidate
WHERE constituency_id = (
	SELECT constituency_id
	FROM constituency
	WHERE c_name = "Dorne"
	) and party_id = (
    SELECT party_id
	FROM (SELECT *
		FROM votes_for
		WHERE votes_for.constituency_id = (
			SELECT constituency_id
			FROM constituency
			WHERE c_name = "Dorne"
		)) as x GROUP BY party_id HAVING COUNT(party_id)=(
			SELECT MAX(count)
			FROM (
				SELECT party_id, COUNT(party_id) count
				FROM (SELECT *
					FROM votes_for
					WHERE votes_for.constituency_id = (
						SELECT constituency_id
						FROM constituency
						WHERE c_name = "Dorne"
					)) as y GROUP BY party_id) as P1) 
			);

# Query 7: Select the names of all candidates who work for the party with symbol Donkey.
SELECT per_name
FROM candidate INNER JOIN works_for ON candidate.aadhaar_number = works_for.aadhaar_number
WHERE works_for.par_name = (
	SELECT par_name
	FROM party
	WHERE party.symbol = "donkey");
    
# Query 8: Print details of voters living in Nebraska state.
SELECT *
FROM voter LEFT JOIN lives_in ON voter.aadhaar_number = lives_in.aadhaar_number
WHERE lives_in.constituency_id in (
	SELECT constituency_id
	FROM constituency
	WHERE state = "Nebraska");
    
# Query 9: Print the population of Ohio state.
SELECT SUM(population)
FROM constituency
WHERE state = "Ohio";