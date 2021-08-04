#!/bin/bash

target=$1
maxuser=$2
username=$3
password=$4
user_rid_start=1000

Red="\033[0;91m"          # Red
Green="\033[0;92m"        # Green
Yellow="\033[0;93m"       # Yellow
Reset='\033[0m'

if ! $(which rpcclient >/dev/null); then	

	echo "[-] rpcclient is not found on your system"

else
	if [[ -z $target ]] && [[ -z $maxuser ]]; then

		echo "[-] Usage : $0 <target-ip> <max-user-to-enum> <username> <password>"
		echo "[-] Example : $0 127.0.0.1 50 'fooname' 'barpass' "
		echo "[-] If username and password are empty, $0 will try to use anonymous auth/null session"
	
	else

		if [[ -z $username ]] && [[ -z $password ]]; then
			username=''
			password=''
		fi
		
		echo "[+] Using '$username':'$password' for authentication"
		
		if $(rpcclient -U "$username%$password" $target -c "quit;" >/dev/null); then

			sid=$(rpcclient -U "$username%$password" -c "lsaquery; quit" $target | cut -d " " -f3 | tail -n1)
			echo "[+] Domain SID: $sid"
			
			permissions_check=$(rpcclient -U "$username%$password" -c "lookupsids $sid-1000;quit" $target)
			if ! [[ $permissions_check == *"NT_STATUS"* ]]; then

				echo "[+] Enumerating $maxuser users by cycling RID: "
				echo -e $Yellow
				for rid in $(seq $user_rid_start $(($user_rid_start+$maxuser)))
					do 
					rpcclient -U "$username%$password" -c "lookupsids $sid-$rid;quit" $target
					# Uncomment this line below for parallel execution.
					# (rpcclient -U "$username%$password" -c "lookupsids $sid-$rid;quit" $target)
				done
				echo -e $Reset

				echo "[+] Additional enumeration with lsaenumsids: "
				echo -e $Yellow
				sids=$(rpcclient -U "$username%$password" -c "lsaenumsid;quit" $target | sed '1,2d')
				while IFS= read -r sid
					do rpcclient -U "$username%$password" -c "lookupsids $sid;quit" $target
				done <<< $sids
			else
			echo -e $Red"[-] Access denied"
			fi
		else
			echo -e $Red
			echo "[-] Authentication failed"
		fi
	fi
fi
