sudo docker system prune -a -f
cd api
sudo docker build -t mhib/tlcbackend .
sudo docker run -d --name tlc-backend -p 80:80 mhib/tlcbackend
cd ..
cd frontend
sudo docker build -t mhib/tlcfrontend .
sudo docker run -d --name tlc-frontend -p 80:80 mhib/tlcfrontend
cd ..
sudo docker-compose up -d