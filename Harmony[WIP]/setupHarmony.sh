HARMONY_DIR="harmony"
HMY_TOOL="curl -LO https://harmony.one/hmycli"
ERROR_CODE=0


echo "Making harmony dir: $HARMONY_DIR"
mkdir $HARMONY_DIR 
cd $HARMONY_DIR

echo "Download CLI tool..."
`$HMY_TOOL`
mv hmycli hmy
chmod +x hmy
read what

echo "Harmony cookbook..."
echo `./hmy --node="https://api.s0.t.hmny.io" cookbook`

echo "Setting up BLS Keys..."
./hmy keys generate-bls-keys --count 1 --shard 1 --passphrase
echo "copy the output above. we would need it in a few, and also your password handy."

echo "Making bls keys folder..."
mkdir -p .hmy/blskeys

echo "Copying bls keys to the folder."
cp *.key .hmy/blskeys

echo "Paste your public here [everything but .key]:"
read publicKey

./hmy --node="https://api.s0.t.hmny.io" utility shard-for-bls $publicKey

echo "Please type your password:"
read password 
echo '$password' > .hmy/blskeys/$publicKey.pass

ls .hmy/blskeys/
echo "Above should be <your-public-key>.key and <your-public-key>.pass"


echo "Now I will be downloading Rclone."
curl https://rclone.org/install.sh | sudo bash

echo "Creating rclone config file"
rclone config file

echo "Pushing content in rclone.config"
cat<<-EOF > ~/.config/rclone/rclone.conf
[release]
type = s3
provider = AWS
env_auth = false
region = us-west-1
acl = public-read
server_side_encryption = AES256
storage_class = REDUCED_REDUNDANCY
EOF

echo"We are ready to sync the shards. Do you want to continue (y/n)?"
read input 

if [ $input = "n" ]
then 
	echo "Thanks for using the script. Please dont forget to star the repo. ut helps."
fi 

echo "Thanks for continueing..."
echo "Do you want to do MainNet or TestNet. (main/test/exit)?"
read network 

case $network in 
	main)
		echo "Main net sync"
		;;
	test)
		echo "Test net sync"
                ;;
	exit)
		echo "Thanks for using the script. Please dont forget to star the repo. ut helps."
                ;;
esac 

exir $ERROR_CODE