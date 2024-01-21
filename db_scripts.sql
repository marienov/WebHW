-- DB & tables
CREATE DATABASE port_manager if not exists;


create table ferry ( 
    id uuid PRIMARY KEY,
    name character varying(200) not null,
    car_place integer NOT NULL,
    load_place integer NOT NULL)
    ;

create table destination ( 
    id UUID PRIMARY KEY ,
    name VARCHAR(200) not null)
;


create table trip ( 
    id UUID PRIMARY KEY ,
    ferry_id UUID REFERENCES ferry,
    dest_id UUID REFERENCES destination,
    loads UUID[] default '{}')
;


create table load ( 
    id UUID PRIMARY KEY ,
    name VARCHAR(200) not null,
    type VARCHAR(4) not null,
    car_type INTEGER default 0,
    trip_id UUID REFERENCES trip)
;



-- User (actions: select, insert, update, delete)

CREATE ROLE pm_admin LOGIN ENCRYPTED PASSWORD 'admin';
GRANT  select, insert, update, delete on load, ferry, destination, trip TO tm_admin;

-- SQL Queries
select * from tasklist order by position;

select * from tasks order by tasklist_id, position;

insert into tasklist (id, name, position) values (<id>, <name>, <pos>);

insert into tasks (id, text, position, tasklist_id) values (<id>, <name>, <pos>, <tasklist_id>);
update tasklist set tasks = array_append(tasks, <id>) where id = <tasklist_id>;

update tasks set text = <text>, position = <position> where id = <id>;

select tasklist_id from tasks where id = <task_id>;
delete from tasks where id = <task_id>;
update tasklist set tasks = array_remove(tasks, <task_id>) where id = <tasklist_id>;


update tasks set tasklist_id = <dest_tasklist_id> where id = <task_id>;
update tasklist set tasks = array_append(tasks, <task_id>) where id = <dest_tasklist_id>;
update tasklist set tasks = array_remove(tasks, <task_id>) where id = <src_tasklist_id>;




