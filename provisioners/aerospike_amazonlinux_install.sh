
# Install Aerospike on Amazon linux 2, Ref - https://www.aerospike.com/docs/operations/install/tools/amazon_linux/index.html

# Install required packages
echo '[DEBUG] Installing packages ........................................'
sudo yum install -y wget
sudo yum install -y tar
sudo yum install -y xz
sudo yum install -y gzip
sudo yum install -y python3
sudo yum install -y python-pip
sudo yum install -y java
sudo pip install future
sudo yum install shadow-utils.x86_64 -y

echo '[DEBUG] Downloading Aerospike tools ........................................'
wget -O aerospike-tools.tgz 'https://www.aerospike.com/download/tools/latest/artifact/el7'
tar -xvf aerospike-tools.tgz

echo '[DEBUG] Installing Aerospike ........................................'
cd aerospike-tools-5.1.0-el7/
sudo ./asinstall