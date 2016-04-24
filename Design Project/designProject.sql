--Frank Siderio--
--Design Project--

--this is only here incase I need to re do something --
drop table if exists Players cascade;
drop table if exists Player_Character cascade;
drop table if exists Player_Match cascade;
drop table if exists Stages cascade;
drop table if exists OmegaStage cascade;
drop table if exists RegStage cascade;
drop table if exists specialEffects cascade;
drop table if exists Characters cascade;
drop table if exists Character_Match cascade;
drop table if exists Match cascade;
drop table if exists Tier cascade;
drop table if exists Moves cascade;
drop table if exists Items cascade;



--Players Table--
create table Players (
    pid          char(4) unique not null,
    userName     text    not null,
    password     varchar(20)    not null,
    firstName    text,   
    lastName     text,
    dob          date    not null,
    favCharacter text,
    favStage     text,   
  primary key (pid)
);

--Characters Table--
create table Characters (
    cid          char(4) unique not null,
    name         text not null,
    description  text,
    class        text not null,
    origin       text not null,
  primary key(cid)
);

--Tier Table--
create table Tier (
    name   text not null,
    level  text not null,
    cid    char(4)  not null references Characters(cid),
  primary key(name, level)
);

--Player_Character Table--
create table Player_Character (
    pid  char(4)  not null references Players(pid),
    cid  char(4)  not null references Characters(cid),
  primary key(pid, cid)
);

--Stages Table--
create table Stages (
    sid          char(4) unique not null,
    name         text not null,
    description  text,
    origin       text,
    song         text not null,
  primary key(sid)
);

--RegStage Table--
create table RegStage (
    sid  char(4)  not null references Stages(sid),
    size integer not null,
    check (size > 0),
  primary key(sid)
);

--Special Effects Table--
create table specialEffects (
    eID  char(4) unique not null,
    sid  char(4)  not null references Stages(sid),
    name text,
    description  text,
    damage       integer,
    check (damage > 0),
  primary key(eID, sid)
);
--OmegaStage Table--
Create table OmegaStage (
    sid          char(4)  not null references Stages(sid),
    defaultSize  integer not null,
    check (defaultSize > 0),
  primary key(sid)
);

--Match Table--
Create table Match (
    matchID       char(4) unique not null,
    date          date not null,
    time          integer, 
    type          text not null,
    stockLives    integer, 
    numOfPlayers  integer not null,
    sid           char(4) unique not null references Stages(sid),
    check (time > 0),
    check(stockLives > 0),
    check(numOfPlayers >= 2),
  primary key(matchID, sid)
);

--Player_Match Table--
create Table Player_Match (
    pid      char(4)  not null references Players(pid),
    matchID  char(4)  not null references Match(matchID),
  Primary key(pid, matchID)
);

--Character_Match Table--
create table Character_Match (
    cid       char(4)  not null references Characters(cid),
    matchID   char(4)  not null references Match(matchID),
  Primary key(cid, matchID)
);

--Moves Table--
create table Moves (
    moveID  char(4) unique not null,
    cid     char(4) not null references Characters(cid),
    name    text not null,
    damage  integer,
    check(damage > 0),
  Primary key(moveID, cid)
);

--Items--
create table Items (
    itemID       char(4) unique not null,
    name         text not null,
    description  text,
    damageGiven  integer not null,
    matchID      char(4) not null references Match(matchID),
    check (damageGiven > 0),
  Primary key(itemID)
);

--Inserts into Players Table--
insert into Players (pid, userName, password, firstName, lastName, dob, favCharacter, favStage)
values('p000', 'FrankBond007', 'IamAwesome', 'Frank', 'Siderio', '02/19/1996', 'Pikachu', 'Final Destination');

insert into Players (pid, userName, password, firstName, lastName, dob, favCharacter, favStage)
values('p001', 'baseballDude', 'tgife@34567', 'John', 'Doe', '07/9/1996', 'Bowser', 'Final Destination');

insert into Players (pid, userName, password, firstName, lastName, dob, favCharacter, favStage)
values('p002', 'coolDude5', 'IamCool', 'Josh', 'Smith', '12/11/1995', 'Link', 'Battlefied');

insert into Players (pid, userName, password, firstName, lastName, dob, favCharacter, favStage)
values('p003', 'jamesGriff', 'IamAnicePerson', 'James', 'Griffin', '06/9/1995', 'Marth', 'Dream Land');

--Inserts into Characters Table--
insert into Characters(cid, name, description, class, origin)
values('c000', 'Pikachu', 'Down B', 'lightweight', 'pokemon');

insert into Characters(cid, name, description, class, origin)
values('c001', 'Marth', 'Uses a sword', 'middleweight', 'fire emblem');

insert into Characters(cid, name, description, class, origin)
values('c002', 'Bowser', 'Is a big dude', 'heavyweight', 'Mario');

insert into Characters(cid, name, description, class, origin)
values('c003', 'Link', 'Has a lot of items', 'middleweight', 'Zelda');

--Inserts into Player_Character Table--
insert into Player_Character(pid, cid)
values ('p000', 'c000');

insert into Player_Character(pid, cid)
values ('p001', 'c002');

insert into Player_Character(pid, cid)
values ('p000', 'c002');

insert into Player_Character(pid, cid)
values ('p002', 'c003');

--Inserts into stages table--
insert into Stages(sid, name, description, origin, song)
values ('s000', 'Final Destination', 'Good stage', 'some place', 'a song');

insert into Stages(sid, name, description, origin, song)
values ('s001', 'Dream Land', 'nice stage', 'a place', 'dream song');

insert into Stages(sid, name, description, origin, song)
values ('s002', 'Battlefield', 'a good stage', 'a nice place', 'a good song');

insert into Stages(sid, name, description, origin, song)
values ('s003', 'Donkey Kong Land', 'big stage', 'a place', 'kong song');

--Inserts into match table--
insert into Match(matchID, date, time, type, stockLives, numOfPlayers, sid)
values('m000', '01/2/2016', '100', 'Stock', 2, 2, 's000');

insert into Match(matchID, date, time, type, stockLives, numOfPlayers, sid)
values('m001', '01/2/2016', '200', 'Stock', 2, 2, 's001');

insert into Match(matchID, date, time, type, stockLives, numOfPlayers, sid)
values('m002', '01/2/2016', '300', 'Stock', 2, 2, 's002');

insert into Match(matchID, date, time, type, stockLives, numOfPlayers, sid)
values('m003', '01/2/2016', '400', 'Stock', 2, 2, 's003');

--Inserts into Player_Match Table--
insert into Player_Match(pid, matchID)
values('p000', 'm000');

insert into Player_Match(pid, matchID)
values('p001', 'm001');

insert into Player_Match(pid, matchID)
values('p002', 'm002');

insert into Player_Match(pid, matchID)
values('p003', 'm003');

--Inserts into Character_Match--
insert into Character_Match(cid, matchID)
values('c000', 'm000');

insert into Character_Match(cid, matchID)
values('c001', 'm001');

insert into Character_Match(cid, matchID)
values('c002', 'm002');

insert into Character_Match(cid, matchID)
values('c003', 'm003');

--Inserts into OmegaStage Table--
insert into OmegaStage(sid, defaultSize)
values('s000', 10);

insert into OmegaStage(sid, defaultSize)
values('s002', 12);

--Inserts into RegStage Table--
insert into RegStage(sid, size)
values('s001', 8);

insert into RegStage(sid, size)
values('s002', 15);

--Inserts into specialEffects Table--
insert into specialEffects(eID, sid, name, description, damage)
values('e000', 's001', 'wind', 'wind', 1);

insert into specialEffects(eID, sid, name, description, damage)
values('e001', 's003', 'bombs', 'blow stuff up', 10);

--Inserts into Tier Table--
insert into Tier(name, level, cid)
values('Tier 1', 'B', 'c000');

insert into Tier(name, level, cid)
values('Tier 2', 'A', 'c001');

insert into Tier(name, level, cid)
values('Tier 3', 'A', 'c002');

insert into Tier(name, level, cid)
values('Tier 1', 'A', 'c003');

--Inserts into Moves Table--
insert into Moves(moveID, cid, name, damage)
values('m000', 'c000', 'down B', 10);

insert into Moves(moveID, cid, name, damage)
values('m001', 'c001', 'B Special', 15);

insert into Moves(moveID, cid, name, damage)
values('m002', 'c002', 'neutral B', 7);

insert into Moves(moveID, cid, name, damage)
values('m003', 'c003', 'Side smash', 12);

--Inserts into Items Table--
insert into Items(itemID, name, description, damageGiven, matchID)
values('i000', 'bat', 'one hit KO', 250, 'm000');

insert into Items(itemID, name, description, damageGiven, matchID)
values('i001', 'bomb', 'blows stuff up', 10, 'm001');

insert into Items(itemID, name, description, damageGiven, matchID)
values('i002', 'gun', 'shoots stuff', 5, 'm002');

insert into Items(itemID, name, description, damageGiven, matchID)
values('i003', 'mine', 'explodes when activated', 20, 'm003');



--Views--

--View into the Players table--
create view playerInfo as
select Players.firstName, Players.userName, Players.favCharacter, Players.favStage
from Players

select *
from playerInfo


--Players who have played on the stage Final Destination-- 
select Players.firstName
from Players, Player_Match, Stages, Match
where Players.pid = Player_Match.pid
  and Player_Match.matchID = Match.matchID
  and Match.sid = Stages.sid
  and Stages.name = 'Final Destination'

select *
from Players
