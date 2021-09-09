
## rpcenumsid

A script for brute-forcing SIDs to enumerate AD user accounts. This tool utilizes `rpcclient` from Samba client (wrapper).
```
$ sudo apt-get install smbclient
```

Usage:
```
$ ./rpcenumsid.sh <target-ip> <max-user-to-enum> <username> <password>
```

If username and password are not supplied, this script will try to use anonymous auth/null session

Example: 

```shell
$ ./rpcenumsid.sh 172.16.2.100 5 userfoo superpassword
[+] Using '****':'****' for authentication
[+] Domain SID: S-1-5-21-4************-3************-3************

[*] Enumerating 5 users by cycling RID: 

S-1-5-21-4************-3************-3************-1000 InternalCorp\DC$ (1)
S-1-5-21-4************-3************-3************-1001 *unknown*\*unknown* (8)
S-1-5-21-4************-3************-3************-1002 *unknown*\*unknown* (8)
S-1-5-21-4************-3************-3************-1003 *unknown*\*unknown* (8)
S-1-5-21-4************-3************-3************-1004 *unknown*\*unknown* (8)
S-1-5-21-4************-3************-3************-1005 *unknown*\*unknown* (8)

[*] Additional enumeration with lsaenumsids: 

S-1-5-93-2-2 User Manager\ContainerUser (5)
S-1-5-93-2-1 User Manager\ContainerAdministrator (5)
S-1-5-90-0 *unknown*\*unknown* (8)
S-1-5-9 NT AUTHORITY\ENTERPRISE DOMAIN CONTROLLERS (5)
S-1-5-82-3006700770-424185619-1745488364-794895919-4004696415 IIS APPPOOL\DefaultAppPool (5)
S-1-5-80-3139157870-2983391045-3678747466-658725712-1809340420 NT SERVICE\WdiServiceHost (5)
S-1-5-80-0 NT SERVICE\ALL SERVICES (5)
S-1-5-6 NT AUTHORITY\SERVICE (5)
S-1-5-32-568 BUILTIN\IIS_IUSRS (4)
S-1-5-32-559 BUILTIN\Performance Log Users (4)
S-1-5-32-554 BUILTIN\Pre-Windows 2000 Compatible Access (4)
S-1-5-32-551 BUILTIN\Backup Operators (4)
S-1-5-32-550 BUILTIN\Print Operators (4)
S-1-5-32-549 BUILTIN\Server Operators (4)
S-1-5-32-548 BUILTIN\Account Operators (4)
S-1-5-32-545 BUILTIN\Users (4)
S-1-5-32-544 BUILTIN\Administrators (4)                                                                                       
S-1-5-21-4************-3************-3************-1140 InternalCorp\F.Kennedy (1)                                                    
S-1-5-21-4************-3************-3************-1135 InternalCorp\***** (1)                                                
S-1-5-20 NT AUTHORITY\NETWORK SERVICE (5)                                                                                     
S-1-5-19 NT AUTHORITY\LOCAL SERVICE (5)                                                                                       
S-1-5-11 NT AUTHORITY\Authenticated Users (5)                                                                                 
S-1-1-0 \Everyone (5)                                                                                                         
                                                                                                                              
[+] Done
```