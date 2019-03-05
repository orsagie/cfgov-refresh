FROM centos:7
ENV CFGOV_PATH=/src/cfgov-refresh\
    STATIC_PATH=/src/cfgov-refresh/cfgov/static_built\
    APACHE_SERVER_ROOT=/src/cfgov-refresh/apache\
    APACHE_WWW_PATH=/src/cfgov-refresh/apache/www\
    CFGOV_SANDBOX=/src/cfgov-refresh/sandbox\
    APACHE_PROCESS_COUNT=4\
    ERROR_LOG=/proc/self/fd/1
RUN yum install -y epel-release && \
    yum-config-manager --enable cr && \
    yum update -y && \
    yum -y install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm && \
    yum -y install httpd mod_wsgi which gcc gcc-c++ kernel-devel mailcap make postgresql10 postgresql10-devel python-devel && \
    yum clean all
ADD  https://bootstrap.pypa.io/get-pip.py /src/get-pip.py
COPY requirements /src/requirements
COPY extend-environment.sh /etc/profile.d/extend-environment.sh
RUN python /src/get-pip.py && pip install -r /src/requirements/local.txt
