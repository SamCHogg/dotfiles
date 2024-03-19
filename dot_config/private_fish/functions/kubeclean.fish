function kubeclean
	kubectl get pods | grep -E -- 'Evicted|Error' | awk '{print $1}' | xargs kubectl delete pod
end