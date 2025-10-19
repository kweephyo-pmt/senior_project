#!/bin/bash

# Deploy backend with all required environment variables
gcloud run deploy senior-project-backend \
  --source=./server \
  --region=asia-southeast1 \
  --allow-unauthenticated 
echo "Backend deployed successfully!"
echo "URL: https://senior-project-backend-51782680110.asia-southeast1.run.app"
