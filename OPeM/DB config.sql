create table petitii(id int not null primary key,category varchar2(20),title varchar2(100),description varchar2(1000),target int,votes int,tags varchar2(100),name varchar2(50),email varchar2(50),created_at DATE,expires_at DATE);
/
create table semnaturi(id int not null primary key,id_petitie not null,email varchar2(50),confirmed number(1),code number(4),CONSTRAINT fk_semnaturi_id_petitie FOREIGN KEY (id_petitie) REFERENCES petitii(id));
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
/
create or replace package apex_mail_p
is
   g_smtp_host      varchar2 (256)     := 'localhost';
   g_smtp_port      pls_integer        := 1925;
   g_smtp_domain    varchar2 (256)     := 'gmail.com';
   g_mailer_id constant varchar2 (256) := 'Mailer by Oracle UTL_SMTP';
   -- send mail using UTL_SMTP
   procedure mail (
      p_sender in varchar2
    , p_recipient in varchar2
    , p_subject in varchar2
    , p_message in varchar2
   );
end;
/
create or replace package body apex_mail_p
is
   -- Write a MIME header
   procedure write_mime_header (
      p_conn in out nocopy utl_smtp.connection
    , p_name in varchar2
    , p_value in varchar2
   )
   is
   begin
      utl_smtp.write_data ( p_conn
                          , p_name || ': ' || p_value || utl_tcp.crlf
      );
   end;
   procedure mail (
      p_sender in varchar2
    , p_recipient in varchar2
    , p_subject in varchar2
    , p_message in varchar2
   )
   is
      l_conn           utl_smtp.connection;
      nls_charset    varchar2(255);
   begin
      -- get characterset
      select value
      into   nls_charset
      from   nls_database_parameters
      where  parameter = 'NLS_CHARACTERSET';
      -- establish connection and autheticate
      l_conn   := utl_smtp.open_connection (g_smtp_host, g_smtp_port);
      utl_smtp.ehlo(l_conn, g_smtp_domain);  
      utl_smtp.command(l_conn, 'auth login');
      utl_smtp.command(l_conn,utl_encode.text_encode('email@email.email', nls_charset, 1));
      utl_smtp.command(l_conn, utl_encode.text_encode('parola', nls_charset, 1));
      -- set from/recipient
      utl_smtp.command(l_conn, 'MAIL FROM: <'||p_sender||'>');
      utl_smtp.command(l_conn, 'RCPT TO: <'||p_recipient||'>');
      -- write mime headers
      utl_smtp.open_data (l_conn);
      write_mime_header (l_conn, 'From', p_sender);
      write_mime_header (l_conn, 'To', p_recipient);
      write_mime_header (l_conn, 'Subject', p_subject);
      write_mime_header (l_conn, 'Content-Type', 'text/plain');
      write_mime_header (l_conn, 'X-Mailer', g_mailer_id);
      utl_smtp.write_data (l_conn, utl_tcp.crlf);
      -- write message body
      utl_smtp.write_data (l_conn, p_message);
      utl_smtp.close_data (l_conn);
      -- end connection
      utl_smtp.quit (l_conn);
   exception
      when others
      then
         begin
           utl_smtp.quit(l_conn);
         exception
           when others then
             null;
         end;
         raise_application_error(-20000,'Failed to send mail due to the following error: ' || sqlerrm);   
   end;
end;
/
set serveroutput on;
create or replace procedure cerere_semnare_petitie(p_id in int,p_email in varchar2,p_out out int)
as
v_aux int;
v_code number(4);
begin
select nvl(count(*),0) into v_aux from petitii where id=p_id and expires_at>sysdate;
if(v_aux=1)
then
    p_out:=0;
    select nvl(count(*),0) into v_aux from semnaturi where id_petitie=p_id and email=p_email;
    if(v_aux=0)
    then
        select nvl(max(id),0)+1 into v_aux from semnaturi;
        v_code:=FLOOR(DBMS_RANDOM.VALUE(1000,9999));
        insert into semnaturi values(v_aux,p_id,p_email,0,v_code);
        apex_mail_p.mail('depunepetitie@gmail.com', p_email, 'Validation code', v_code);
        p_out:=v_aux;
    else
        select confirmed into v_aux from semnaturi where id_petitie=p_id and email=p_email;
        if(v_aux=0)
        then
            v_code:=FLOOR(DBMS_RANDOM.VALUE(1000,9999));
            update semnaturi set code=v_code where id_petitie=p_id and email=p_email;
            apex_mail_p.mail('depunepetitie@gmail.com', p_email, 'Validation code', v_code);
            select id into p_out from semnaturi where id_petitie=p_id and email=p_email;
        else
            p_out:=0;
        end if;
    end if;
else
p_out:=-1;
end if;
end cerere_semnare_petitie;
/
set serveroutput on;
create or replace procedure semneaza_petitie(p_id in int,p_code number,p_out out int)
as
v_code number(4);
v_id_petitie int;
begin
p_out:=0;
select code into v_code from semnaturi where id=p_id;
if(v_code=p_code)
then
    select id_petitie into v_id_petitie from semnaturi where id=p_id;
    update semnaturi set confirmed=1 where id=p_id;
    update petitii set votes=(select sum(confirmed) from semnaturi where id_petitie = v_id_petitie) where id=v_id_petitie and EXPIRES_AT>sysdate;
    p_out:=1;
end if;
end semneaza_petitie;
