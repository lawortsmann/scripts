if [ "$(command -v conda)" ]
then
  echo "removing existing conda installation..."
  CONDA_DIR=$(conda info --base)
  conda init --all --reverse
  rm -rf ${CONDA_DIR}
  rm -rf ${HOME}/.conda/
  rm -f ${HOME}/.condarc
  echo "success, please restart shell and rerun script."
  exit
fi

echo "downloading miniconda3..."

# DOWNLOAD_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest"
DOWNLOAD_URL="https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3"

if [ $(uname) = "Darwin" ]
then
  wget -O miniconda3.sh "$DOWNLOAD_URL-MacOSX-$(uname -m).sh"
else
  wget -O miniconda3.sh "$DOWNLOAD_URL-$(uname)-$(uname -m).sh"
fi

echo "installing conda..."

bash miniconda3.sh -b -f -p "${HOME}/conda"

echo "setting up conda..."

source "${HOME}/conda/etc/profile.d/conda.sh"
conda activate
conda init --all
conda update -y conda
conda config --add channels conda-forge
conda config --set channel_priority strict

conda install -y \
  numpy \
  pandas \
  scipy \
  scikit-learn \
  xarray \
  netcdf4 \
  dask \
  jax \
  flax \
  jaxopt \
  optax \
  matplotlib \
  plotly \
  dash \
  flask \
  notebook \
  google-cloud-bigquery \
  google-auth \
  db-dtypes \
  pytables \
  isort \
  black \
  flake8 \
  mypy \
  pytest

conda update -y --all

echo "cleaning up..."

conda clean -y --all
rm -f miniconda3.sh

echo "testing..."

python -V
python -c "import numpy; print(f'numpy version: {numpy.__version__}')"
python -c "import pandas; print(f'pandas version: {pandas.__version__}')"
python -c "import scipy; print(f'scipy version: {scipy.__version__}')"

echo "success, please restart shell."
