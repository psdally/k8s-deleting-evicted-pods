#!/bin/bash
# Loop through all Namespaces
for namespace in $(kubectl get namespace -o=json |  jq -r '.items[] .metadata.name') ; do
  echo "Processing namespace ${namespace}"
 
  # Get the list of Pods, then select the items that have been evicted, sort by the startTime (ascending),
  # then select all but the most recent 3.  Then pass just the names of those Pods to kubectl to be deleted
  kubectl -n ${namespace} get pod -o=json | jq '[.items[] | select(.status.reason=="Evicted")] | sort_by(.status.startTime) | .[0:-3]' | jq -r '.[] .metadata.name' | xargs --no-run-if-empty kubectl -n ${namespace} delete pod

done

