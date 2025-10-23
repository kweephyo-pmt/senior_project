#!/bin/bash

# Deploy backend with Cloud SQL connection
gcloud run deploy senior-project-backend \
  --source=./server \
  --region=asia-southeast1 \
  --allow-unauthenticated \
  --add-cloudsql-instances=curriculum-statistics:asia-southeast1:senior-project-db \
  --set-env-vars="DB_HOST=/cloudsql/curriculum-statistics:asia-southeast1:senior-project-db,DB_USER=root,DB_PASSWORD=,DB_NAME=senior_project"

echo "Backend deployed successfully!"
echo "URL: https://senior-project-backend-51782680110.asia-southeast1.run.app"
