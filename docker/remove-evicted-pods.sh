#!/bin/bash
# Get the list of Pods, then select the items that have been evicted, sort by the startTime (ascending),
# then select all but the most recent 3.  Then pass just the names of those Pods to kubectl to be deleted
kubectl get pod -o=json | jq '[.items[] | select(.status.reason=="Evicted")] | sort_by(.status.startTime) | .[0:-3]' | jq -r '.[] .metadata.name' | xargs --no-run-if-empty kubectl delete pod
