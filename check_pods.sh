# Set a timeout limit (adjust as needed)
TIMEOUT_SECONDS=600  # 10 minutes

# Start a timer to track elapsed time
start_time=$(date +%s)

# Loop until all pods are in the "Running" state or until timeout is reached
while true; do
  # Get the list of pods in the namespace
  kubectl get pods
  pod_status=$(kubectl get pods -o jsonpath='{range .items[*]}{.status.phase}{"\n"}{end}')
  
  # Count the number of pods in the "Running" state
  running_pods=$(echo "$pod_status" | grep -c "Running")
  
  # Count the total number of pods
  total_pods=$(echo "$pod_status" | wc -l)
  
  echo "Running pods: $running_pods / $total_pods"
  
  # Check if all pods are in the "Running" state
  if [[ ! "$pod_status" =~ "Pending" ]]; then
    echo "All pods are running and ready."
    break
  fi
  
  # Check if the timeout has been reached
  current_time=$(date +%s)
  elapsed_time=$((current_time - start_time))
  if [ "$elapsed_time" -ge "$TIMEOUT_SECONDS" ]; then
    echo "Timeout reached. Not all pods are running."
    exit 1
  fi
  
  # Sleep for a few seconds before checking again (adjust as needed)
  sleep 1
done