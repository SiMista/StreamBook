@echo off

:: Démarrer les conteneurs Oracle
docker run -d -p 1521:1521 --name oracle-europe container-registry.oracle.com/database/enterprise:21.3.0.0
docker run -d -p 1522:1521 --name oracle-asia container-registry.oracle.com/database/enterprise:21.3.0.0

:: Attendre que les conteneurs soient complètement démarrés
timeout /t 80

:: Configurer l'instance oracle-europe
echo Configuring oracle-europe...
docker exec -it oracle-europe bash -c "source /home/oracle/.bashrc; sqlplus / as sysdba <<EOF
ALTER SESSION SET \"_ORACLE_SCRIPT\"=true;
CREATE USER dummy IDENTIFIED BY dummy;
GRANT ALL PRIVILEGES TO dummy;
EXIT;
EOF"

:: Configurer l'instance oracle-asia
echo Configuring oracle-asia...
docker exec -it oracle-asia bash -c "source /home/oracle/.bashrc; sqlplus / as sysdba <<EOF
ALTER SESSION SET \"_ORACLE_SCRIPT\"=true;
CREATE USER dummy IDENTIFIED BY dummy;
GRANT ALL PRIVILEGES TO dummy;
EXIT;
EOF"

echo Configuration completed.
