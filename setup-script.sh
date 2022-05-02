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

MINIFORGE_URL="https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3"

if [ $(uname) = "Darwin" ]
then
  curl -fsSLo ${HOME}/Miniforge3.sh "$MINIFORGE_URL-MacOSX-$(uname -m).sh"
else
  wget -O ${HOME}/Miniforge3.sh "$MINIFORGE_URL-$(uname)-$(uname -m).sh"
fi

bash ${HOME}/Miniforge3.sh -b -f -p ${HOME}/miniforge3

rm -f ${HOME}/Miniforge3.sh

${HOME}/miniforge3/bin/conda init

${HOME}/miniforge3/bin/conda install -y python=3.8

${HOME}/miniforge3/bin/conda install -y \
  numpy \
  pandas \
  scipy \
  scikit-learn \
  pytorch \
  xarray \
  netcdf4 \
  dask \
  matplotlib \
  plotly \
  dash \
  flask \
  flask-caching \
  gunicorn \
  notebook \
  pyarrow \
  pyathena \
  google-cloud-bigquery \
  beautifulsoup4 \
  isort \
  black \
  flake8 \
  mypy \
  pytest

${HOME}/miniforge3/bin/conda update -y --all

${HOME}/miniforge3/bin/conda clean -y --all

EOF

echo "success!"

touch /etc/setup_complete
