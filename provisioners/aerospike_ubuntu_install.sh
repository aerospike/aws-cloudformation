#!/bin/bash

echo '[DEBUG] Installing packages ........................................'
sudo apt update && sudo apt upgrade -y
sudo apt -y install curl && sudo apt install wget 
sudo apt -y install python && sudo apt -y install python3
sudo apt -y install python3-pip
sudo pip3 install future


# Script to install aerospike on Ubuntu, Ref - https://www.aerospike.com/docs/operations/install/linux/ubuntu

echo '[DEBUG] Downloading Aerospike tools ........................................'

 # Get Aerospike Database for Ubuntu 20.04, todo: should we parametrize the url for multiple ubuntu versions ? 
wget -O aerospike.tgz 'https://www.aerospike.com/enterprise/download/server/latest/artifact/ubuntu20'
tar -xvf aerospike.tgz

# Install Aerospike Database and Tools 

# cd aerospike-server-<community_or_enterprise>-<aerospike_version>-<ubuntu_version>/
# todo: parameterize for multiple aerospike versions
cd aerospike-server-enterprise-5.5.0.3-ubuntu20.04

echo '[DEBUG] Installing Aerospike ........................................'

sudo ./asinstall

