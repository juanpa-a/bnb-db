# FROM ubuntu:20.04

# ENV DEBIAN_FRONTEND=noninteractive

# RUN apt update
# RUN apt install apache2 -y
# RUN apt install postgresql -y 
# RUN apt install pgadmin3 -y

# # Set up postgres
# USER postgres
# RUN /etc/init.d/postgresql start && \ 
#   psql --command "CREATE USER admin WITH SUPERUSER PASSWORD 'admin'" && \
#   psql --command "CREATE DATABASE airbnb"

# # Set up pgAdmin to listen on all interfaces and enable browser access
# USER root

# RUN mkdir /etc/pgadmin3 && touch /etc/pgadmin3/pgadmin3.conf && \
#     sed -i "s/127.0.0.1/0.0.0.0/" /etc/pgadmin3/pgadmin3.conf

# RUN echo "ServerName pgadmin" >> /etc/apache2/apache2.conf && \
#     sed -i "s/^#\s*ServerName\s*www.example.com/ServerName pgadmin/g" /etc/apache2/sites-enabled/000-default.conf && \
#     sed -i "s/^#\s*Include\s*ports.conf/Include ports.conf/g" /etc/apache2/apache2.conf && \
#     echo "listen_addresses = '*'" >> /etc/postgresql/12/main/postgresql.conf && \
#     echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/12/main/pg_hba.conf && \
#     su - postgres -c "service postgresql restart"

# # Start services
# EXPOSE 5432 80
# # CMD service postgresql start && service apache2 start && sleep infinity 
# CMD service postgresql start && service apache2 start && pgadmin3 && sleep infinity



# # Expose ports for PostgreSQL and pgAdmin

# # Expose ports for PostgreSQL and pgAdmin
# # EXPOSE 5432 80




FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update

# RUN curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
RUN sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
RUN apt install pgadmin4
RUN apt install pgadmin4-web 
RUN /usr/pgadmin4/bin/setup-web.sh

RUN apt install apache2 -y
RUN apt install postgresql -y

# # Set up postgres
# USER postgres
# RUN /etc/init.d/postgresql start && \
#     psql --command "CREATE USER admin WITH SUPERUSER PASSWORD 'admin'" && \
#     psql --command "CREATE DATABASE airbnb"

# # Set up pgAdmin to listen on all interfaces and enable browser access
# USER root

# RUN echo "ServerName pgadmin" >> /etc/apache2/apache2.conf && \
#     echo "Listen 80" >> /etc/apache2/ports.conf && \
#     sed -i "s/^#\s*ServerName\s*www.example.com/ServerName pgadmin/g" /etc/apache2/sites-enabled/000-default.conf && \
#     sed -i "s/^#\s*Include\s*ports.conf/Include ports.conf/g" /etc/apache2/apache2.conf && \
#     echo "listen_addresses = '*'" >> /etc/postgresql/12/main/postgresql.conf && \
#     echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/12/main/pg_hba.conf && \
#     su - postgres -c "service postgresql restart"

# # Start services
# EXPOSE 5432 80

# # Start PostgreSQL and pgAdmin
# CMD service postgresql start && /usr/pgadmin4/bin/python3 /usr/pgadmin4/web/pgAdmin4.py

# # Expose ports for PostgreSQL and pgAdmin
# EXPOSE 5432 80



