# howto: https://hub.docker.com/r/jetbrains/teamcity-server/


docker pull jetbrains/teamcity-server

export TC_DATA=/home/marcin/git/docker-team-city/volumes/data
export TC_LOGS=/home/marcin/git/docker-team-city/volumes/logs
export TC_PORT=4444

docker run -it --name tc-server  \
    -v $TC_DATA:/data/teamcity_server/datadir \
    -v $TC_LOGS:/opt/teamcity/logs  \
    -p $TC_PORT:8111 \
    jetbrains/teamcity-server
