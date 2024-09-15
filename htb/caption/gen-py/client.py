from thrift import Thrift
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
    if __name__ == '__main__':
        main()