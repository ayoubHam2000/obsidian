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