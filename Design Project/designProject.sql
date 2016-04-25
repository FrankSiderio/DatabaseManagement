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
    cName         text not null,
    cDescription  text,
    class        text not null,
    cOrigin       text not null,
  primary key(cid)
);

--Tier Table--
create table Tier (
    tName   text not null,
    level  text not null,
    cid    char(4)  not null references Characters(cid),
  primary key(tName, level)
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
    sName         text not null,
    sDescription  text,
    sOrigin       text,
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
    seName text,
    seDescription  text,
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
    mName    text not null,
    damage  integer,
    check(damage > 0),
  Primary key(moveID, cid)
);

--Items--
create table Items (
    itemID       char(4) unique not null,
    iName         text not null,
    iDescription  text,
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
insert into Characters(cid, cName, cDescription, class, cOrigin)
values('c000', 'Pikachu', 'Down B', 'lightweight', 'pokemon');

insert into Characters(cid, cName, cDescription, class, cOrigin)
values('c001', 'Marth', 'Uses a sword', 'middleweight', 'fire emblem');

insert into Characters(cid, cName, cDescription, class, cOrigin)
values('c002', 'Bowser', 'Is a big dude', 'heavyweight', 'Mario');

insert into Characters(cid, cName, cDescription, class, cOrigin)
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

insert into Player_Character(pid, cid)
values('p003', 'c001');

--Inserts into stages table--
insert into Stages(sid, sName, sDescription, sOrigin, song)
values ('s000', 'Final Destination', 'Good stage', 'some place', 'a song');

insert into Stages(sid, sName, sDescription, sOrigin, song)
values ('s001', 'Dream Land', 'nice stage', 'a place', 'dream song');

insert into Stages(sid, sName, sDescription, sOrigin, song)
values ('s002', 'Battlefield', 'a good stage', 'a nice place', 'a good song');

insert into Stages(sid, sName, sDescription, sOrigin, song)
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
insert into specialEffects(eID, sid, seName, seDescription, damage)
values('e000', 's001', 'wind', 'wind', 1);

insert into specialEffects(eID, sid, seName, seDescription, damage)
values('e001', 's003', 'bombs', 'blow stuff up', 10);

--Inserts into Tier Table--
insert into Tier(tName, level, cid)
values('Tier 1', 'B', 'c000');

insert into Tier(tName, level, cid)
values('Tier 2', 'A', 'c001');

insert into Tier(tName, level, cid)
values('Tier 3', 'A', 'c002');

insert into Tier(tName, level, cid)
values('Tier 1', 'A', 'c003');

--Inserts into Moves Table--
insert into Moves(moveID, cid, mName, damage)
values('m000', 'c000', 'down B', 10);

insert into Moves(moveID, cid, mName, damage)
values('m001', 'c001', 'B Special', 15);

insert into Moves(moveID, cid, mName, damage)
values('m002', 'c002', 'neutral B', 7);

insert into Moves(moveID, cid, mName, damage)
values('m003', 'c003', 'Side smash', 12);

--Inserts into Items Table--
insert into Items(itemID, iName, iDescription, damageGiven, matchID)
values('i000', 'bat', 'one hit KO', 250, 'm000');

insert into Items(itemID, iName, iDescription, damageGiven, matchID)
values('i001', 'bomb', 'blows stuff up', 10, 'm001');

insert into Items(itemID, iName, iDescription, damageGiven, matchID)
values('i002', 'gun', 'shoots stuff', 5, 'm002');

insert into Items(itemID, iName, iDescription, damageGiven, matchID)
values('i003', 'mine', 'explodes when activated', 20, 'm003');



--Views--

--View into the Players table--
create view playerInfo as
select p.firstName, p.userName, p.favCharacter, p.favStage
from Players p

select *
from playerInfo

--View into Players, Characters--
drop view if exists PlayerCharacter 
create view PlayerCharacter as
select Characters.*, userName, firstName, favCharacter
from Players, Characters, Player_Character
where Players.pid = Player_Character.pid
  and Characters.cid = Player_Character.cid

select * 
from PlayerCharacter

--View into the match--
--view without items--
drop view if Exists matchView
create view matchView as
select m.matchID, m.date, m.time, m.type, m.stockLives, m.numOfPlayers, 
       s.sid, s.sName, s.origin, s.song, c.name, p.firstName
from match m, stages s, Characters c, Character_Match cm, Players p, Player_Match pm
where m.sid = s.sid
  and c.cid = cm.cid
  and cm.matchID = m.matchID
  and p.pid = pm.pid
  and pm.matchID = m.matchID

--View into the item and match table--
drop view if exists itemMatchView
create view itemMatchView as
select i.iName, i.description, i.damageGiven, m.matchID, m.date, m.time, m.type, m.stockLives, m.numOfPlayers, s.sid, s.sName
from match m, Items i, Stages s
where i.matchID = m.matchID
  and m.sid = s.sid

--View into players, characters, match, items, stages--
--view with items--
drop view if exists matchViewItems
create view matchViewItems as
select m.matchID, m.date, m.time, m.type, m.stockLives, m.numOfPlayers, s.sid, s.sName, s.origin, s.song, c.name, p.firstName, i.itemID, i.iName, i.damageGiven
from match m, stages s, Characters c, Character_Match cm, Players p, Player_Match pm, Items i
where m.sid = s.sid
  and c.cid = cm.cid
  and cm.matchID = m.matchID
  and p.pid = pm.pid
  and pm.matchID = m.matchID
  and i.matchID = m.matchID

--for fun--
--View into the entire db--
drop view if exists dbView
create view dbView as
select p.pid, p.firstName, p.lastName, p.dob, p.favCharacter, p.favStage,
       m.matchID, m.date, m.time, m.type, m.stockLives, m.numOfPlayers,
       s.*, c.*,
       i.itemID, i.iName, i.iDescription, i.damageGiven,
       t.tName, t.level,
       mo.moveID, mo.mName, mo.damage
from Players p, Match m, Player_Match pm, Stages s, Characters c, Player_Character pc, Character_Match cm,
     Items i, Tier t, Moves mo
where p.pid = pm.pid
  and pm.matchID = m.matchID
  and m.sid = s.sid
  and c.cid = cm.cid
  and p.pid = pc.pid
  and c.cid = pc.cid
  and c.cid = cm.cid
  and i.matchID = m.matchID
  and t.cid = c.cid
  and mo.cid = c.cid

select * 
from dbView
	

--Query Reports--

--Avg Match Time--
select avg(Time)
from Match m

--Character with the strongest move--
select c.cid, c.cName, mo.mName, mo.damage as highestDamage
from Characters c, Moves mo
where c.cid = mo.cid
order by mo.damage desc
limit 1

--Strongest Special Effect--
select se.seName, se.seDescription, se.damage, s.sid, s.sName
from specialEffects se, Stages s
where se.sid = s.sid
order by se.damage desc
limit 1

--Player who uses the character with the strongest move--
select p.pid, p.firstName, c.cid, c.cName, mo.mName, mo.damage
from Characters c, Players p, Player_Character pc, Moves mo
where p.pid = pc.pid
  and pc.cid = c.cid
  and c.cid = mo.cid
order by mo.damage desc
limit 1;
 
--Returns the Players and characters who have played on a stage with special effects--
select p.firstName, c.cName, s.sName, se.seName, se.damage
from Players p, Characters c, Stages s, specialEffects se, Match m, 
     Player_Match pm, Character_Match cm
where se.sid = s.sid
  and s.sid = m.sid
  and m.matchID = cm.matchID
  and c.cid = cm.cid
  and p.pid = pm.pid
  and pm.matchID = m.matchID

--Players who have played on the stage Final Destination-- 

  

--Store Procedures--

--Returns the players who have played on the passed in stage--
create or replace function playerStage(text, REFCURSOR) returns REFCURSOR as
$$
declare
  stage     text      := $1;
  resultSet REFCURSOR := $2;

begin
  open resultSet for
    select p.pid, p.firstName, p.lastName
    from Players p, Player_Match pm, Stages s, Match m
    where p.pid = pm.pid
      and pm.matchID = m.matchID
      and m.sid = s.sid
      and s.sName = stage;
  return resultSet;
end;
$$
language plpgsql;

--test--
select playerStage('Final Destination', 'results');
fetch all from results;

--Returns Characters that have played on the passed in stage--
create or replace function characterStage(text, REFCURSOR) returns REFCURSOR as
$$
declare
  stage text          := $1;
  resultSet REFCURSOR := $2;

begin 
  open resultSet for
  select c.cid, c.cName, c.class
  from Characters c, Character_Match cm, Match m, Stages s
  where c.cid = cm.cid
    and cm.matchID = m.matchID
    and m.sid = s.sid
    and s.sName = stage;
  return resultSet;
end;
$$
language plpgsql;

--test--
select characterStage('Final Destination', 'results');
fetch all from results;

--Returns what players AND characters have played on the passed in stage--
create or replace function playerCharacterStage(text, REFCURSOR) returns REFCURSOR as
$$
declare
  stage text          := $1;
  resultSet REFCURSOR := $2;

begin
  open resultSet for
  select p.pid, p.userName, c.cid, c.cName
  from Players p, Characters c, Player_Match pm, Character_Match cm, Match m, Stages s
  where p.pid = pm.pid
    and pm.matchID = m.matchID
    and c.cid = cm.cid
    and cm.matchID = m.matchID
    and m.sid = s.sid
    and s.sName = stage;
  return resultSet;
end;
$$
language plpgsql;

--test--
select playerCharacterStage('Final Destination', 'results');
fetch all from results;

--returns all the moves for the passed in character--
create or replace function characterMoves(text, REFCURSOR) returns REFCURSOR as 
$$
declare
  character text      := $1; 
  resultSet REFCURSOR := $2;

begin
  open resultSet for
  select c.cName, mo.moveID, mo.mName, mo.damage, c.cid
  from Moves mo, Characters c
  where c.cid = mo.cid
    and c.cName = character;
  return resultSet;
end;
$$
language plpgsql;

--test--
select characterMoves('Pikachu', 'results');
fetch all from results;

create or replace function add_RegStage() returns trigger as
$BODY$
    begin
        insert into RegStage values (NEW.sid, NEW.size);
    return NEW;
    End;
$BODY$
language plpgsql; 



--Triggers--
create trigger add_RegStage
after insert or update on Stages
for each row
execute procedure add_RegStage();

insert into Stages(sid, sName, sDescription, sOrigin, song)
values ('s004', 'Wii Fit', 'nice stage', 'some place', 'wii fit song');

--
