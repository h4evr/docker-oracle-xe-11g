docker-oracle-xe-11g
============================

Oracle Express Edition 11g Release 2 on CentOS 7.

### Installation
```
docker pull h4evr/oracle-xe-11g
```

Run with 22 and 1521 ports opened:
```
docker run -d -p 49160:22 -p 49161:1521 h4evr/oracle-xe-11g
```

Connect database with following setting:
```
hostname: localhost
port: 49161
sid: xe
username: system
password: Password1
```

Password for SYS & SYSTEM
```
Password1
```

Login by SSH
```
ssh root@localhost -p 49160
password: admin
```
