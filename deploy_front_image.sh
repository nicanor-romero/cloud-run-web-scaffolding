echo "Building image"

export CLOUDSDK_PYTHON=/usr/bin/python

# Edit these values
gcp_account="my_email_for_gcp@gmail.com"
gcp_project_name="my-project-name"
image_name="my-image-name"
cloud_run_name="my-image-name"

docker build -t us.gcr.io/${gcp_project_name}/$image_name .

previous_account=$(gcloud config get-value account)
previous_project=$(gcloud config get-value project)

tmp_account=$gcp_account
tmp_project=$gcp_project_name

echo "Setting temporary values"
echo "account=$tmp_account"
echo "project=$tmp_project"
gcloud config set account $tmp_account
gcloud config set project $tmp_project

echo "Pushing image"

docker push us.gcr.io/${gcp_project_name}/${image_name}

echo "Deploying image"

gcloud run services update ${cloud_run_name} --image=us.gcr.io/${gcp_project_name}/${image_name}:latest

echo "Restoring previous values"
echo "account=$previous_account"
echo "project=$previous_project"
gcloud config set account $previous_account
gcloud config set project $previous_project