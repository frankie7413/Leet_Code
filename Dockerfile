FROM ruby:2.7

RUN apt-get update && apt-get install vim -y

RUN mkdir /myapp
WORKDIR /myapp

COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
