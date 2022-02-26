## Instructions

Note that Docker Desktop must be installed and running (Kubernetes support must also be enabled) or another Kubernetes
option such as Minikube can be used.

1. `cd` into the root of this folder in a command window
2. `$ minikube start`
3. `$ alias k="minikube kubectl --"`
4. minikube needs to be set to the existing docker configuration or it won't be able to find locally build Docker
   images.
    1. Therefore, run `eval $(minikube docker-env)` in every bash terminal that will use minikube with locally build
       Docker images. For a Windows powershell use `minikube docker-env | Invoke-Expression` instead.
       See https://stackoverflow.com/questions/42564058/how-to-use-local-docker-images-with-minikube
    2. Furthermore, minikube will try to pull Docker images from remote Docker repos unless you set imagePullPolicy:
       Never (instead of IfNotPresent) in every deployment yaml.
    3. So set in both samples/canary/stable.deployment.yml:20 and samples/canary/canary.deployment.yml:20
       `spec.template.spec.containers[0].imagePullPolicy=Never`
5. Now run `docker-compose build` to build the images that will be used for Canary testing
6. Create the Kubernetes Service, Stable Deployment, and Canary Deployment by running the following command:

   `kubectl apply -f ./`

   Note: You'll get an error about `docker-compose.yml` but can ignore it (it's not a valid Kubernetes file of course).
7. run `minikube service --url stable-service` to get the url to use in the host environment (browser and curl-loop.sh)
8. change the curl -s "http://localhost:8080" | grep "<title>.*</title>" statement according to the returned url.
9. check the privileges of the sh file and make it executable with chmod if necessary
10. Run the following command based on your OS:

    **Windows**

    Open a PowerShell window:

    `./curl-loop.ps1`

    **Mac**

    `sh curl-loop.sh`

    **Linux Bash terminal**

    `./curl-loop.sh`

11. Because the Stable Deployment has 4 replicas and the Canary Deployment only has 1, the output should show Stable app
    output most of the time. If you don't see Canary app show up at all run the command again.

Also pulling Docker images from remote with Minikube appears to be problematic, so our option with the local
docker-compose build is easiest. See also:
https://stackoverflow.com/questions/42564058/how-to-use-local-docker-images-with-minikube
https://stackoverflow.com/questions/48818237/cannot-pull-image-from-minikube-docker
Set the docker env to the minikube docker via minikube docker-env | Invoke-Expression imagePullPolicy if not mentioned
should have defaulted to Never instead of Always. I see IfNotPresent in stable.deployment.yml, which already should be
good enough.
https://github.com/kubernetes/minikube/issues/9580
https://stackoverflow.com/questions/57281700/trying-to-pull-run-docker-images-from-docker-hub-on-minikube-fails?rq=1