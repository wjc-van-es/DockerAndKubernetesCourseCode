## Installing the Kubernetes Dashboard

- https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
- https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md
- https://github.com/kubernetes/dashboard

With minikube the Kubernetes Dashboard is already installed and available to you.

#### Step to use:
1. In a bash terminal just run `minikube start`

    `kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml`

2. Now with minikube running we can run in the same or a new bash terminal 
   ```
   $ minikube dashboard
   🤔  Verifying dashboard health ...
   🚀  Launching proxy ...
   🤔  Verifying proxy health ...
   🎉  Opening http://127.0.0.1:35347/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/ in your default browser...
   Opening in existing browser session.
   [12037:12037:0100/000000.833006:ERROR:sandbox_linux.cc(378)] InitializeSandbox() called with multiple threads in process gpu-process.

   ```
3. Now the url displayed will open in your a new window of your default browser.
4. To stop it press CTRL+C