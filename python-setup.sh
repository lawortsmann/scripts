#
#   Tear down and rebuild miniforge3
#

if [ "$(command -v conda)" ]
then
  echo "removing existing conda installation..."
  CONDA_DIR=$(conda info --base)
  conda deactivate
  conda init --reverse
  rm -rf ${CONDA_DIR}
  rm -rf ${HOME}/.conda/
  rm -f ${HOME}/.condarc
  echo "success, please restart shell and rerun script."
  exit
fi

echo "downloading miniforge3..."

MINIFORGE_URL="https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3"

if [ $(uname) = "Darwin" ]
then
  curl -fsSLo Miniforge3.sh "$MINIFORGE_URL-MacOSX-$(uname -m).sh"
else
  wget -O Miniforge3.sh "$MINIFORGE_URL-$(uname)-$(uname -m).sh"
fi

echo "installing conda..."

bash Miniforge3.sh -b -f -p ${HOME}/miniforge3

rm -f Miniforge3.sh

echo "setting up conda..."

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

echo ""

${HOME}/miniforge3/bin/python -V
${HOME}/miniforge3/bin/python -c "import numpy; print(f'numpy version:   {numpy.__version__}')"
${HOME}/miniforge3/bin/python -c "import pandas; print(f'pandas version:  {pandas.__version__}')"
${HOME}/miniforge3/bin/python -c "import scipy; print(f'scipy version:   {scipy.__version__}')"
${HOME}/miniforge3/bin/python -c "import xarray; print(f'xarray version:  {xarray.__version__}')"
${HOME}/miniforge3/bin/python -c "import torch; print(f'pytorch version: {torch.__version__}')"

echo "success, please restart shell."
