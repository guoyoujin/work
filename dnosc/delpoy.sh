#!/bin/bash

path=/home/tongxin/zhouwei/dnosc
docker_image_name=dnosc-$(date +'%Y%m%d%H%M%S')

pull_code() {
	cd ${path} && git pull origin master
	if [ $? -eq 0 ]; then
		echo "[info] pull git master success"
		return 0
	else
		echo "[error] pull code error"
		return 1
	fi
}

docker_build() {
	cd ${path} && sudo docker build -t ${docker_image_name} ./
	if [ $? -eq 0 ]; then
		echo "[success] docker images $docker_image_name  build finished "
		return 0
	else
		echo "[error] docker images build error"
		echo "check docker images for  more info"
		return 1
	fi
}

container_restart() {
	sudo docker stop dnosc
	sudo docker rm dnosc
	sudo docker run -d --name dnosc -v /etc/openvpn/openvpn-status.log:/etc/openvpn/openvpn-status.log -p 8000:80 ${docker_image_name}
	echo -e "\033[32m $(sudo docker inspect dnosc | grep Status) \033[0m"
}

main() {
	pull_code
	if [ $? -eq 0 ]; then
		docker_build
		if [ $? -eq 0 ]; then
			container_restart
		else
			return 1
		fi
	else
		return 1
	fi
}

main
