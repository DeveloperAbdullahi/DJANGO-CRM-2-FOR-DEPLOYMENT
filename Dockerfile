FROM python:3.6

WORKDIR /app

# Intall dependencies


RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt update
RUN  apt install -y git ruby-dev nodejs postgresql-client redis-server wkhtmltopdf
RUN  gem install compass sass
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nodejs \
    npm
RUN  npm -g install less
COPY requirements.txt /app/
RUN  pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir redis
COPY ./entrypoint.sh .
RUN ["chmod","+x","entrypoint.sh"]

ENTRYPOINT ["bash","/app/entrypoint.sh"]
#ENTRYPOINT ["tail", "-f" ,"/dev/null"]
