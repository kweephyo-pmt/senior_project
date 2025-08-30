#!/bin/bash

# Deploy frontend with all required environment variables
gcloud run deploy senior-project \
  --source=. \
  --region=asia-southeast1 \
  --allow-unauthenticated \
  --set-env-vars="FIREBASE_API_KEY=AIzaSyAm7B_bdMezQ-rqFjScE593hGGCVBa7VZ0,FIREBASE_AUTH_DOMAIN=curriculum-statistics.firebaseapp.com,FIREBASE_PROJECT_ID=curriculum-statistics,FIREBASE_STORAGE_BUCKET=curriculum-statistics.firebasestorage.app,FIREBASE_MESSAGING_SENDER_ID=51782680110,FIREBASE_APP_ID=1:51782680110:web:6bc2a46eb9f791892a29bf,VITE_API_BASE_URL=https://eport.mfu.ac.th/api/master,VITE_API_USERNAME=sombi,VITE_API_PASSWORD=kTzQmR7pWv9LbYD,VITE_EVALUATE_ID=9,VITE_API_LANG=en,VITE_STAFF_CODE_UNDERGRADUATE=67212038,VITE_STAFF_CODE_GRADUATE=46212058,BACKEND_API_URL=https://senior-project-backend-51782680110.asia-southeast1.run.app,NUXT_PUBLIC_BACKEND_API_URL=https://senior-project-backend-51782680110.asia-southeast1.run.app,NUXT_PUBLIC_FIREBASE_API_KEY=AIzaSyAm7B_bdMezQ-rqFjScE593hGGCVBa7VZ0,NUXT_PUBLIC_FIREBASE_AUTH_DOMAIN=curriculum-statistics.firebaseapp.com,NUXT_PUBLIC_FIREBASE_PROJECT_ID=curriculum-statistics,NUXT_PUBLIC_FIREBASE_STORAGE_BUCKET=curriculum-statistics.firebasestorage.app,NUXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID=51782680110,NUXT_PUBLIC_FIREBASE_APP_ID=1:51782680110:web:6bc2a46eb9f791892a29bf"

echo "Frontend deployed successfully!"
echo "URL: https://senior-project-51782680110.asia-southeast1.run.app"
