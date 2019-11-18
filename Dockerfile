FROM centos/nodejs-10-centos7
MAINTAINER Chris Nuland
RUN ls
RUN cp /main.js $HOME/main.js
RUN cp /package.json $HOME/package.json
EXPOSE 8080