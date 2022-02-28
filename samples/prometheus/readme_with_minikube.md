## Prometheus, kube-state-metrics, Metrics Server, Grafana Example
1. Running `k get pods --all-namespaces` will confirm that only stuff is deployed from the kube-stystem and the
   kubernetes-dashboard namespaces are deployed. You would expect metrics-server, kube-state-metrics, Grafana and
   Prometheus to run in their own namespace
2. Run `k create namespace monitoring` to create a `monitoring` namespace.
3. In the terminal go to dir `DockerAndKubernetesCourseCode/samples/prometheus`
4. Run `k create -f ./ -R` to get kube-state-metrics, Grafana, and Prometheus resources in place.
   1. This initiale yielded: 
      error: unable to recognize "metrics-server/kubernetes/metrics-apiservice.yaml": no matches for kind "APIService" 
      in version "apiregistration.k8s.io/v1beta1
   2. So we updated `samples/prometheus/metrics-server/kubernetes/metrics-apiservice.yaml:2`
      `apiVersion: apiregistration.k8s.io/v1 # instead of apiregistration.k8s.io/v1beta1`
   3. Then we ran `k apply -f metrics-server/kubernetes/metrics-apiservice.yaml`
5. Run `k get pods --all-namespaces ` to see pods from all namespaces not only the default onto which we usually deploy.
6. Run ` k get pods --namespace=monitoring` to see pods from our deployments onto our new monitoring namespace
7. Run `k get services --namespace=monitoring` to see all services from our deployments onto our new monitoring namespace
8. We need to run `minikube service --url grafana -n monitoring` and `minikube service --url prometheus-service -n monitoring`
    to get the url's to open both dashboards in a browser as localhost won't work with minikube, but the url's
    returned by the previous commands are a combination of a fixed ip address and the internal port listed with 
    `k get services -n monitoring`
9. Visit http://192.168.49.2:30000 (instead of http://localhost:30000 on Docker Desktop) to view Prometheus.
10. Click on Graph. Select a metric from the drop-down (next to the Execute button) and then click Execute. You can switch between the Graph view and Console view.
11. Visit http://192.168.49.2:32000 (instead of http://localhost:32000 on Docker Desktop) to view the Grafana dashboard.
12. Login with `admin` and `admin` for the username and password. You can reset the password on the next screen or click `Skip`.
13. On the `Welcome to Grafana` page click `New dashboard`.
14. Click the drop-down item named `Home` in the upper-left corner of the screen.
15. Select `Import dashboard` from the available options.
16. Enter an ID value of `10000` into the `Grafana.com Dashboard` textbox and click `Load`. This will load the `Cluster Monitoring for Kubernetes` dashboard.

     Note: You can find a list of pre-configured dashboards at https://grafana.com/grafana/dashboards. Each one will have an id you can copy into the Grafana `Import dashboard` screen.

17. On the next screen you'll see a `Select a Prometheus data source` drop-down. Select `prometheus` from the list and click `Import`. Your dashboard will now load.
18. Click on the `Cluster Monitoring for Kubernetes` drop-down in the uppper-left corner of the screen. Go back through the steps to import a dashboard but this time enter an ID of `8588`. This will load the `Kubernetes Deployment Statefulset Daemonset metrics` dashboard.
19. If you click on the dashboard name drop-down in the upper-left corner of the screen you'll see both of your dashboards listed and can now switch between them.
20. Import the dashboard with an ID of `10694`. This dashboard is called `Container Statistics`. 
21. From here you can load other dashboards or create your own!

**NOTE**: The Metrics Server YAML has been modified to enable it to run in more simple Kubernetes scenarios like Docker Desktop. Details about the modifications made can be found at https://blog.codewithdan.com/enabling-metrics-server-for-kubernetes-on-docker-desktop. You'll want to remove the `--kubelet-insecure-tls` arg in `metrics-server/kubernetes/metrics-server-deployment.yaml` for more real-world scenarios.

## Removing Resources

To remove all of the monitoring resources run `kubectl delete -f ./ -R`.

## Additional Details

Get more details on Prometheus at https://prometheus.io/docs/prometheus/latest/getting_started and https://devopscube.com/setup-prometheus-monitoring-on-kubernetes.

A list of Pod Metrics provided by kube-state-metrics can be found at https://github.com/kubernetes/kube-state-metrics/blob/master/docs/pod-metrics.md. 

Another option for getting Prometheus going using only Docker Compose and Docker Swarm can be found at:

https://github.com/vegasbrianc/prometheus

The yaml files used here were originally created by Bibin Wilson (thanks for the great work Bibin!) and documented at:
- https://devopscube.com/setup-prometheus-monitoring-on-kubernetes
- https://devopscube.com/setup-kube-state-metrics
- https://devopscube.com/setup-grafana-kubernetes/

