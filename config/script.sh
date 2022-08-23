#!/bin/bash

j=1
k=32
#recuperation du nom d'utilisateur
user=$( whoami )
#recuperation du nom / adresse ip de l'hote
host=$( hostname --all-ip-addresses | awk '{print$2;}' )
#si nouvelle instance
if [ "$j" -eq 1 ]
then
	#vidage du fichier iptables.txt
	: > iptable.txt
	#suppression de la configuration ssh
	: | sudo tee /home/$user/.ssh/config
	#suppression des cles authorisees precedement
	head -n 1 /home/$user/.ssh/authorized_keys | sudo tee /home/$user/.ssh/authorized_keys
	head -n 1 /home/$user/.ssh/known_hosts | sudo tee /home/$user/.ssh/known_hosts
fi

#pour chaque machine a creer
for ((i=$j; i <= $k; i++));
do
	#le numero de la vm
	machNum=$((i+100))
	#creation de la vm avec la bonne configuration
	multipass launch -n PC$machNum --mem 512m --cloud-init cloud-config.yaml
	#recuperation de l'adresse ip de la vm nouvellement cree
	ip=$( multipass list | awk 'END{print $3;}' )
	#ajout de son adresse ip au fichier listant toutes les adresses
	echo $ip >> iptable.txt

	#envoie d'un fichier de configuration sur la vm nouvellement cree
	sshpass -p "admin" scp -o StrictHostKeyChecking=no config.txt ubuntu@$ip:
	#installation des packets necessaires sur la vm et transmission de la cle ssh 
	sshpass -p "admin" ssh ubuntu@$ip "sudo hwclock --hctosys && sudo localedef -i fr_FR -f UTF-8 fr_FR.UTF-8 && \
	sleep 2 && sudo apt update && sudo apt -y install iperf && sudo apt -y install sshpass && \
	sudo apt -y install net-tools && sudo sysctl net.core.somaxconn=65536 && \
	sudo sysctl net.ipv4.tcp_retries1=10 && sudo sysctl net.ipv4.tcp_retries2=20 && \
	sudo sysctl net.ipv4.tcp_syn_retries=127 && sudo sysctl net.ipv4.tcp_synack_retries=127 && \
	ssh-keygen -f /home/ubuntu/.ssh/id_rsa -q -N '""' && \
	sshpass -p 'admin' ssh-copy-id -o StrictHostKeyChecking=no $user@$host && \
	cat config.txt | cat - /etc/ssh/ssh_config > temp && sudo mv temp /etc/ssh/ssh_config && rm config.txt"
	
	#ajout de la vm a la banque des machines distantes connues
	echo "Host PC$i" | sudo tee -a /home/$user/.ssh/config
	echo "User ubuntu" | sudo tee -a /home/$user/.ssh/config
	echo "Hostname $ip" | sudo tee -a /home/$user/.ssh/config
	echo "" | sudo tee -a /home/$user/.ssh/config
done

#nombre de vm cree pendant l'execution courante du script
n=$((k-j))
if [ "$j" -eq 1 ]
then 
	tail -n $((n+1)) /home/$user/.ssh/authorized_keys > newkeys.txt
else
	tail -n $((n+1)) /home/$user/.ssh/authorized_keys > newkeys.txt
fi

#envoi des cles ssh vers toutes les vm creees
for ((i=1; i<=$k; i++));
do
	if [ $i -lt $j ]
	then
		sshpass -p "admin" scp newkeys.txt PC$i:
		sshpass -p "admin" ssh PC$i "cat newkeys.txt | sudo tee -a /home/ubuntu/.ssh/authorized_keys && rm newkeys.txt"
	else
		sshpass -p "admin" scp /home/$user/.ssh/authorized_keys PC$i:
		sshpass -p "admin" ssh PC$i "cat authorized_keys | sudo tee -a /home/ubuntu/.ssh/authorized_keys && rm authorized_keys"
	fi
done
