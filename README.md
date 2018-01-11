# sharelatex-dockerized
One container per service deployment of Sharelatex


cd sharelatex-node
docker build -t sharelatex-node .
cd ..
docker-compose build
docker-compose up -d

Start by creating an admin account 
docker exec -it sharelatex-web grunt user:create-admin --email admin@example.com

or via the launchpad
http://localhost:8080/launchpad