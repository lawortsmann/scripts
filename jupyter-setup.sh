CONDA_DIR=$(conda info --base)

JUPYTER_CONFIG_FILE="${HOME}/.jupyter/jupyter_config.py"

JUPYTER_SERVICE_FILE="/etc/systemd/system/jupyter-notebook.service"

mkdir -p $(dirname $JUPYTER_CONFIG_FILE) && touch $JUPYTER_CONFIG_FILE

cat << EOF > $JUPYTER_CONFIG_FILE
# ip and port
c.NotebookApp.ip = '*'
c.NotebookApp.port = 8000
c.NotebookApp.allow_remote_access = True
c.NotebookApp.open_browser = False
c.NotebookApp.quit_button = False
# c.NotebookApp.certfile = u'/absolute/path/to/your/certificate/fullchain.pem'
# c.NotebookApp.keyfile = u'/absolute/path/to/your/certificate/privkey.pem'
# password
c.NotebookApp.password = u'argon2:\$argon2id\$v=19\$m=10240,t=10,p=8\$4ui/nshB4gaO3KqpAgjHKg\$A09ef8gCMj9I2EKmOHLsdJecXTJjY2xAXOjNYxZWmGY'
c.NotebookApp.allow_password_change = False
# default locations
c.NotebookApp.base_url = '/'
c.NotebookApp.default_url = '/tree'
c.NotebookApp.notebook_dir = '${HOME}'
EOF

sudo cat << EOF > $JUPYTER_SERVICE_FILE
[Unit]
Description=Jupyter-Notebook Daemon

[Service]
Type=simple
ExecStart=/bin/bash -c "${CONDA_DIR}/bin/jupyter-notebook --config ${JUPYTER_CONFIG_FILE}"
WorkingDirectory=${HOME}
User=$(whoami)
Group=$(whoami)
PIDFile=/run/jupyter-notebook.pid
Restart=on-failure
RestartSec=60s

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload

sudo systemctl enable jupyter-notebook.service

sudo systemctl start jupyter-notebook.service

sudo systemctl status jupyter-notebook
