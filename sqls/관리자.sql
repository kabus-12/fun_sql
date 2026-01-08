select * from all_users;

alter session set "_ORACLE_SCRIPT"=true;

-- scott(사용자) / tiger(비밀번호) /일반사용자권한.

create user hr
identified by hr
default tablespace users
temporary tablespace temp;

grant connect, resource, unlimited tablespace to hr;