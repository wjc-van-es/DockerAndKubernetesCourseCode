## Docker and Kubernetes Course

https://codewithdan.com/products/docker-kubernetes

View the **Kubernetes for Developers: Core Concepts** video course on Pluralsight:

https://app.pluralsight.com/library/courses/kubernetes-developers-core-concepts/table-of-contents

### Things to remember when using minikube (on linux) instead of Docker Desktop
1. A session on the bash terminal starts with `minikube start`
2. Creating the kubectl alias should include `alias k="minikube kubectl --"`
   1. Whenever you need to use Docker images that are build locally like with `docker-compose build`
      1. Change the imagePullPolicy from IfNotPresent to Never inside your deployment yaml files or minikube will try to
         pull the images from remote anyway. So `spec.template.spec.containers[0].imagePullPolicy=Never`
      2. run `eval $(minikube docker-env)` in each linux bash with minikube terminal session or minikube cannot find the
         locally build Docker images.
3. When you execute a service e.g. a loadbalancer, you won't be able to use localhost as the default machine on your host.
4. Instead run `minikube service --url ${service-name}` to get the url to use in the host environment (browser and curl)
   e.g. for service `nginx-green-test` you will get a different ip address rather than `localhost` (or `127.0.0.1`)
   or the cluster-ip `10.110.197.26` namely `192.168.49.2`, which you then combine with the internal port 31888
   that you could already derive from the `k get services`. 
   So the external port 9001 is never used with minikube, as you would with Docker Desktop `http://localhost:9001`
   ```
   $ k get services
   NAME               TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
   kubernetes         ClusterIP      10.96.0.1       <none>        443/TCP          33m
   nginx-blue-test    LoadBalancer   10.99.142.250   <pending>     9000:30270/TCP   15m
   nginx-green-test   LoadBalancer   10.110.197.26   <pending>     9001:31888/TCP   8s
   nginx-service      LoadBalancer   10.98.197.88    <pending>     80:31492/TCP     16m
   $ minikube service --url nginx-green-test
   http://192.168.49.2:31888
   $ curl -s http://192.168.49.2:31888 | grep "h1"
   <h1>Green App</h1>
   ```
5. You stop the session with `minikube stop`