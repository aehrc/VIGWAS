
#!bin/bash

###>>> run all command one by one <<<###
echo "run all command one by one."
echo "DO NOT run this script in bash"
exit

####### Setup instruction for >>>ViGWAS<<< on a fresh ubuntu (tested on Ubuntu 18.04 64bit)

cd ~

### Install python3.6 and pip
sudo apt-get update
sudo apt-get install -y python3 python3-pip pbzip2 maven git

### set default python version to 3.6
echo "alias python='python3'" >> ~/.bashrc
echo "alias pip='pip3'" >> ~/.bashrc
source ~/.bashrc

### check python version
python --version
pip --version

### install java 8
# need to press 'Enter' while installing
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
# need to accept agreement
sudo apt-get install -y oracle-java8-installer
javac -version
sudo apt install oracle-java8-set-default

### install hail, ipython and jypyter
pip install hail ipython jupyter 
echo "export PATH=$PATH:~/.local/bin/" >> ~/.bashrc
source ~/.bashrc

### install spark 2.2.3
wget https://www-eu.apache.org/dist/spark/spark-2.2.3/spark-2.2.3-bin-hadoop2.7.tgz
tar zxvf spark-2.2.3-bin-hadoop2.7.tgz
echo "export PATH=$PATH:~/spark-2.2.3-bin-hadoop2.7"      >> ~/.bashrc
echo "export PATH=$PATH:~/spark-2.2.3-bin-hadoop2.7/bin"  >> ~/.bashrc
echo "export PATH=$PATH:~/spark-2.2.3-bin-hadoop2.7/jars" >> ~/.bashrc
echo "export SPARK_HOME=~/spark-2.2.3-bin-hadoop2.7" >> .bashrc
source ~/.bashrc

### install maven and VariantSpark
git clone https://github.com/aehrc/VariantSpark.git

### Build VariantSpark (Takes some time)
cd VariantSpark/
# Open the pom file to change the spark version to the one we download
nano pom.xml
# look for spark version 2.2.1 and change it to 2.2.3 (most likely on line 74)
# save and exis by pressing "ctrl+o"  then "Enter" then "ctrl+x"
mvn clean install

### Donlowad and extract ViGWAS
cd ~
wget https://bioinformatics.csiro.au/public/files/ViGWAS.tar.gz
tar zxvf ViGWAS.tar.gz

### run notebook server

jupyter notebook --no-browser --port=8888 --NotebookApp.token='' --notebook-dir=~/ViGWAS
### open browser and enter 'localhost:888' in the address bar

#>>>> if you want to run jupyter on server or and AWS EC2 instance and remotley connect to it
# jupyter notebook --no-browser --port=8888 --NotebookApp.token='' --notebook-dir=~/ViGWAS --ip="server_address"
#>>>> then on your local browser type this address
# server_address:8888

