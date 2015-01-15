FROM centos:centos7

MAINTAINER Diogo Francisco Costa <diogo.francisco.costa@celfocus.com>

ADD init.ora /
ADD initXETemp.ora /
ADD oracle-xe-11.2.0-1.0.x86_64.rpm /

RUN yum install -y libaio flex bc net-tools
RUN yum install -y openssh-server
RUN yum install -y /oracle-xe-11.2.0-1.0.x86_64.rpm

RUN mkdir /var/lock/subsys

RUN mv /init.ora /u01/app/oracle/product/11.2.0/xe/config/scripts
RUN mv /initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts

RUN sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora; \
        echo -e "8080\n1521\nPassword1\nPassword1\nn\n\n" > /tmp/oraclexe.config; \
        /etc/init.d/oracle-xe configure < /tmp/oraclexe.config; \
        rm /tmp/oraclexe.config

RUN mkdir -p /ufe/datafiles && chown -R oracle:dba /ufe/datafiles

# import all SQL scripts
USER oracle
RUN . /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh && for i in $(find /sqlscripts -name '*.sql'); do echo -e "@$i\nexit;\n" | sqlplus / as sysdba; done
USER root

RUN echo 'export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe' >> /etc/bash.bashrc
RUN echo 'export PATH=$ORACLE_HOME/bin:$PATH' >> /etc/bash.bashrc
RUN echo 'export ORACLE_SID=XE' >> /etc/bash.bashrc

# Remove installation files
RUN rm /oracle-xe-11.2.0-1.0.x86_64.rpm

EXPOSE 22
EXPOSE 1521
EXPOSE 8080

CMD sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora; \
	service oracle-xe start; \
	/usr/sbin/sshd -D
