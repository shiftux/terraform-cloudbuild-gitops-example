project="$(terraform output project | sed 's#\"##g')"
zone="$(terraform output zone | sed 's#\"##g')"
cluster_name="$(terraform output cluster_name | sed 's#\"##g')"
cluster="gke_${project}_${zone}_${cluster_name}"

gcloud container clusters get-credentials \
    --project "$project" \
    --zone "$zone" \
    "$cluster_name"

kubectl config set-context "$cluster_name" --cluster="$cluster" --user="$cluster" --namespace=twint
kubectl config use-context "$cluster_name"
