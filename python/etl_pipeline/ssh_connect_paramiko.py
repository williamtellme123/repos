# /usr/bin/python3
from __future__ import print_function
import paramiko
from paramiko import SSHClient
from getpass import getpass

# Written by: Billy Rogers
# August 5, 2018
#     login to remote.server.net
def main():

    try:
        ssh = paramiko.SSHClient()
        # try:
        #     pw = getpass("Enter ssh password")
        # except Exception as e:
        #     print('Error Occured : %s', e)
        k = paramiko.RSAKey.from_private_key_file("/Users/xyz/.ssh/ubuntu_rsa", password="1234")
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect( hostname = "remote.server.net"
                   , port=22222
                   , username = "xyz"
                   , pkey = k )
    except  (paramiko.BadHostKeyException, paramiko.AuthenticationException, paramiko.SSHException, paramiko.socket.error) as e:
        print (e)
    try:
        stdin , stdout, stderr = ssh.exec_command('pwd')
        print(stdout.read())
        if stdout.read():
            print(stderr.read())
        stdin , stdout, stderr = ssh.exec_command("cd /mnt/data/Customer\ Master\ File; pwd; ls")
        for line in stdout:
            print(line)
    except Exception as e:
        print("Command line error: %s", e)

    try:
        ssh.close()
    except Exception as e:
        print("Closing error: %s", e)

if __name__ == "__main__":
	main()
