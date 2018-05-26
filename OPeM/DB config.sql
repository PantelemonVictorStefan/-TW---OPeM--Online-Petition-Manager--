create table petitii(id int not null primary key,category varchar2(20),title varchar2(100),description varchar2(1000),target int,votes int,tags varchar2(100),name varchar2(50),email varchar2(50),created_at DATE,expires_at DATE);
/
set serveroutput on;
create or replace procedure add_petitie(p_cat in varchar2,title in varchar2,description in varchar2,target in int,tags in varchar2,p_name in varchar2, email in varchar2,expires_at in varchar2,p_id out int)
as
v_id integer;
begin
select nvl(max(id),0)+1 into v_id from petitii;
--DBMS_OUTPUT.PUT_LINE(v_id||' '||p_cat||' '||title||' '||description||' '||target||' '||0||' '||tags||' '||p_name||' '||email||' '||sysdate||' '||to_date(expires_at,'DD.MM.YYYY'));
if(to_date(expires_at,'YYYY-MM-DD')>sysdate)
then
insert into petitii values(v_id,p_cat,title,description,target,0,tags,p_name,email,sysdate,to_date(expires_at,'YYYY-MM-DD'));
end if;
p_id:=v_id;
end add_petitie;
