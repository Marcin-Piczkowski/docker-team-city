
Setup

## Using docker-compose
1. Configure
Update "volumes" mappings in docker-compose.yml

```
 tc-server:
    ....
    volumes:
      - /home/marcin/tools/teamcity/data:/data/teamcity_server/datadir
      - /home/marcin/tools/teamcity/logs:/opt/teamcity/logs
```


```
  tc-agent:
    ....
    volumes:
      - /home/marcin/tools/teamcity/agent-conf:/data/teamcity_agent/conf
      - /home/marcin/tools/teamcity/project:/root/project
      - /home/marcin/tools/teamcity/.m2:/root/.m2
```

`/root/project` is a folder in agent container where you should put you mvn project which you want to build
`/root/.m2` is a maven repository


2. Build and start containers using docker-compose

```
docker-compose up
```

## Using docker
1. Configure

Update env variables in scripts:
* `run.sh`
* `run-agent.sh`

2. Run docker daemon on socket:
```
sudo service stop docker
sudo nohup docker daemon -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock &
```

3. Build agent image
Run `./build-agent.sh`

4. Run containers

`run.sh`
`run-agent.sh`

There are two ways of running docker in docker container described [here](https://hub.docker.com/r/jetbrains/teamcity-agent/)
We chose option 1)

>Docker from the host (in this case you will benefit from the caches shared between the host and all your containers, but drawback is the security issue - your build actually can harm your host Docker, so it is on your own risk)
>

You should ssh to TC agent container and check the docker is correctly linked to docker host socket

`docker exec -it <container id> /bin/bash`

`docker ps` - should print TC docker containers running on docker host

## TC build configuration

Example project configs are committed in volumes/data. To use them you need to map volumes/data path to data/teamcity_server/datadir in TC server container.
For this purpose update `run.sh` and set env. TC_DATA to volumes/data absolute path.

In `run-agent.sh` set env. TC_AGENT_PROJECT to shared folder containing your projects to build. This folder is shared with TC agent.


References:
* Official TC docker builds:
 - server: https://hub.docker.com/r/jetbrains/teamcity-server/
 - agent:  https://hub.docker.com/r/jetbrains/teamcity-agent/
