# add the service file
sudo cp jupyter-notebook.service /etc/systemd/system/
# let the daemon reload all the service files
sudo systemctl daemon-reload
# (optional) "enable" -> started when the computer boots
sudo systemctl enable jupyter-notebook.service
# start the service
sudo systemctl start jupyter-notebook.service
# status
sudo systemctl status jupyter-notebook
