#! /bin/bash
gcloud beta compute --project=lawortsmann instances create alpha \
   --zone=us-central1-a \
   --machine-type=e2-small \
   --subnet=default \
   --address=35.209.191.43 \
   --network-tier=STANDARD \
   --maintenance-policy=MIGRATE \
   --service-account=lawortsmann@appspot.gserviceaccount.com \
   --scopes=https://www.googleapis.com/auth/cloud-platform \
   --tags=http-server,https-server,jupyter-server \
   --image-project=debian-cloud \
   --image-family=debian-10 \
   --metadata-from-file=startup-script=setup-script.sh \
   --boot-disk-size=25GB \
   --boot-disk-type=pd-balanced \
   --boot-disk-device-name=alpha \
   --no-shielded-secure-boot \
   --shielded-vtpm \
   --shielded-integrity-monitoring \
   --reservation-affinity=none

echo " "
echo "========================================"
echo "=   will ssh onto machine in 90sec...  ="
echo "========================================"
echo " "

sleep 90

clear

sleep 1

gcloud compute ssh lawortsmann@alpha --zone=us-central1-a

# gcloud compute --project=lawortsmann instances delete alpha --zone=us-central1-a
