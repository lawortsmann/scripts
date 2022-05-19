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

wget -O /home/lawortsmann/Miniforge3.sh "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"

bash /home/lawortsmann/Miniforge3.sh -b -f -p /home/lawortsmann/miniforge3

rm -f /home/lawortsmann/Miniforge3.sh

/home/lawortsmann/miniforge3/bin/conda init

/home/lawortsmann/miniforge3/bin/conda install -y python=3.8

/home/lawortsmann/miniforge3/bin/conda install -y \
  numpy \
  pandas \
  scipy \
  scikit-learn \
  xarray \
  netcdf4 \
  dask \
  matplotlib \
  plotly \
  dash \
  notebook \
  isort \
  black \
  flake8 \
  mypy \
  pytest

/home/lawortsmann/miniforge3/bin/conda update -y --all

/home/lawortsmann/miniforge3/bin/conda clean -y --all

EOF

echo "success!"

touch /etc/setup_complete
