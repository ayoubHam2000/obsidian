Docker compose uses YAML format to run multi containers at once.

- Yaml file can have .yml or .  yaml as extension
- [Yaml Syntax](https://docs.ansible.com/ansible/latest/reference_appendices/YAMLSyntax.html)


```yml
version: "3"

services:
  vote:
    build: ./vote
    command: python app.py
    volumes:
     - ./vote:/app
    ports:
      - "5000:80"
    networks:
      - front-tier
      - back-tier

  result:
    build: ./result
    command: nodemon server.js
    volumes:
      - ./result:/app
    ports:
      - "5001:80"
      - "5858:5858"
    networks:
      - front-tier
      - back-tier

  worker:
    build:
      context: ./worker
    depends_on:
      - "redis"
      - "db"
    networks:
      - back-tier

  redis:
    image: redis:alpine
    container_name: redis
    ports: ["6379"]
    networks:
      - back-tier

  db:
    image: postgres:9.4
    container_name: db
    volumes:
      - "db-data:/var/lib/postgresql/data"
    networks:
      - back-tier
    environment:
      POSTGRES_HOST_AUTH_METHOD: trust

volumes:
  db-data:

networks:
  front-tier:
  back-tier:
```

##  Commands

* docker-compose -f \[FileOutname\] down
* docker-compose -f \[FileOutname\] up -d
* docker-compose ps
* docker-compose config //If there are no issues, it will print a rendered copy of your Docker Compose YAML file
* docker-compose config -q
* docker-compose pull
* docker-compose build
	* docker-compose build --no-cache
	* docker-compose build --help
* docker-compose start
- docker-compose stop
- docker-compose restart
- docker-compose pause //docker-compose pause db **or** docker-compose unpause db
- docker-compose unpause
- docker-compose top //docker-compose top db
- docker-compose logs
- docker-compose events
- docker-compose exec worker ping -c 3 db // This will launch a new process in the already running worker container and ping the db container three times, as seen here
- docker-compose up -d --scale vote=3
- docker-compose rm
- docker-compose kill