1. Difference between a container and a Virtual machine
    Container - Isolated process
    VM - Entire OS 

2. Difference between Registry vs repository?
    registries: docker.io, ECR, ghr
    repository: Custom name like httpd, mysqld

3. Docker data directory? /var/lib/docker/{volumes,containers, networks}

4. You made a change in a running container? How do you create an image out of it? 
    docker exec -it alpine:latest /bin/bash
    docker commit <container_id_or_name> <new_image_name>:<tag>
    docker image ls
    docker tag <new_image_name>:<tag> <new_image_name>:<new_tag>

5. how do you copy an image from one machine to another without using internet?
    docker save -o /tmp/my-image.tar my-image:latest
    scp /tmp/my-image.tar user@destination_machine:/path/to/destination or rsync
    docker load -i /tmp/my-image.tar
    docker image ls

6. How do you understand the CMD and entrypoint of a container image?
    docker inspect

7. How do you expose a container ?
    -p 8080:80 - user define
    -P - Docker random ports - Image Expose instruction - check in image inspect

8. What are docker random ports?
    The ephemeral port range for Docker containers is 32768 to 61000

9. How do you share data to a container?    bind mount host directory on the container 
    Dynamic data storage in volumes
    argument: -v 

docker volume create mysql_vol
docker network create --driver bridge mynet
docker container run --name mysql -d --network mynet -e MYSQL_ROOT_PASSWORD="helloadmin@123" -e MYSQL_DATABASE="wordpress" -e MYSQL_USER="wp_user" -e MYSQL_PASSWORD="wpuser@123" -v mysql_vol:/var/lib/mysql/ mysql:debian
docker volume create wordpress_vol
docker container run --name wordpress -d -p 80:80 --network mynet -e WORDPRESS_DB_HOST="mysql" -e WORDPRESS_DB_USER="wp_user" -e WORDPRESS_DB_PASSWORD="wpuser@123" -e WORDPRESS_DB_NAME="wordpress" -v wordpress_vol:/var/www/html/ wordpress:latest

10. Docker volume vs bind mount
        volumes - secure way - no permission issue
        bind mount - permission issue

docker container run --name nginx1 -d -p 8081:80 -v /opt/test:/usr/share/nginx/html nginx:alpine

11. Docker networking mode - bridge, host, none, overlay
        bridge - 2 container communicate
        host - host ip tables being used for container
        
        docker network create --driver bridge my_bridge_network
        docker network create --driver host my_host_network
        docker network create --driver overlay my_overlay_network (used in docker swarm)
        docker network ls

13. Docker file instructions:
        FROM
        COPY
        ADD
        RUN
        WORKDIR
        ENV - pass when starting container for the application
        ARG - pass when building container image
        USER
        EXPOSE
        CMD
        ENTRYPOINT

14. Difference between CMD and ENTRYPOINT
15. Difference between ENV and ARG
16. Difference between ADD and COPY
17. Dangling images ? images without tag
18. Docker system prune
19. What is docker-compose ? Check a sample docker-compose file - services, networks, volumes
        docker-compose up -d
        docker-compose down
