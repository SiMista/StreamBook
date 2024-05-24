 connect sys as sysdba;
-- Script pour configurer la session et créer l'utilisateur dummy
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER dummy IDENTIFIED BY dummy;
GRANT ALL PRIVILEGES TO dummy;
