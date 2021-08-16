sudo apt-get update
sudo apt-get -y install openjdk-8-jre
java -version
curl -sL http://apt.wavesplatform.com/apt-key.gpg | sudo apt-key add -
sudo add-apt-repository "deb https://apt.wavesplatform.com/ xenial mainnet"
sudo apt update
sudo apt install waves

echo "Installing base58 binary"
apt -y install base58

echo "Edit the configuration file /usr/share/waves/conf/waves.conf"
echo "start service by sudo systemctl start waves.service"
echo "enable autoload: sudo systemctl enable waves.service"
echo "to check serive: journalctl -u waves.service -f"