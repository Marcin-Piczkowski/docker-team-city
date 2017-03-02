export TC_AGENT_PROJECT=/home/marcin/git/docker-team-city/volumes/project
export TC_AGENT_CONF=/home/marcin/git/docker-team-city/volumes/agent-conf
export TC_AGENT_LOGS=/home/marcin/git/docker-team-city/volumes/agent-logs
export TC_AGENT_M2=/home/marcin/git/docker-team-city/volumes/.m2
export TC_SERVER_URL=172.17.0.1:4444

docker run -it --name tc-agent  \
    -v $TC_AGENT_CONF:/data/teamcity_agent/conf \
    -v $TC_AGENT_LOGS:/opt/buildagent/logs \
    -v $TC_AGENT_PROJECT:/root/project  \
    -v $TC_AGENT_M2:/root/.m2  \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e SERVER_URL=$TC_SERVER_URL \
    tc-agent
