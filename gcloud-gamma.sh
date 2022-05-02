#! /bin/bash
gcloud beta compute --project=lawortsmann instances create gamma \
   --zone=us-central1-a \
   --machine-type=e2-standard-16 \
   --subnet=default \
   --network-tier=STANDARD \
   --no-restart-on-failure \
   --maintenance-policy=TERMINATE \
   --preemptible \
   --service-account=lawortsmann@appspot.gserviceaccount.com \
   --scopes=https://www.googleapis.com/auth/cloud-platform \
   --tags=http-server,https-server,jupyter-server \
   --image-project=debian-cloud \
   --image-family=debian-10 \
   --metadata-from-file=startup-script=setup-script.sh \
   --boot-disk-size=256GB \
   --boot-disk-type=pd-ssd \
   --boot-disk-device-name=gamma \
   --no-shielded-secure-boot \
   --shielded-vtpm \
   --shielded-integrity-monitoring \
   --reservation-affinity=any

echo " "
echo "========================================"
echo "=   will ssh onto machine in 30sec...  ="
echo "========================================"
echo " "

sleep 30

clear

sleep 1

gcloud compute ssh lawortsmann@gamma --zone=us-central1-a

# gcloud compute --project=lawortsmann instances delete gamma --zone=us-central1-a
