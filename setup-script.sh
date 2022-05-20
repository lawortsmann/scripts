#! /bin/bash
echo "starting setup..."

sudo apt-get update -y

if [[ -f /etc/setup_complete ]]; then exit 0; fi

echo "running setup..."

sudo apt-get install -y wget git htop

sudo -i -u lawortsmann bash << EOF
gcloud secrets versions access latest --secret="github" >> /home/lawortsmann/.ssh/id_rsa

chmod 400 /home/lawortsmann/.ssh/id_rsa

git config --global core.editor "vim"

git config --global user.email "lawortsmann@gmail.com"

git config --global user.name "Luke Wortsmann"

EOF

echo "success!"

touch /etc/setup_complete
