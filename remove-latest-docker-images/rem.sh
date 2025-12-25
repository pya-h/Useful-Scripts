sudo docker image ls -q | head -n 10 | sudo xargs -r docker rmi


# remove all unused things:
sudo docker system prune -a --volumes

