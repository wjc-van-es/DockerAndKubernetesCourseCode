## Rolling Update Deployment Instructions

1. Deploy the Deployment and Service by running the following command:

    `kubectl create -f ./ --save-config --record`

2. Run `kubectl get all` and notice that 4 Pods, 1 Deployment, and 1 ReplicaSet have successfully been deployed.
3. When you run minikube instead of Docker Desktop, 
   1. run `minikube service --url nginx-service` to get the url from where the host can access the service (this may be very different from anything described in the yaml)
   2. check the url with a browser or a curl -s "{the-returned-url}" command.
   3. modify the curl-loop scripts accordingly
4. On Linux make sure you have rights to execute the curl-loop.sh script or change privilege with `chmod -R 755 .`
5. Open a separate command window and run one of the following scripts based on your OS to call into the nginx Pods:

    **Windows (open a PowerShell window):**

    `./curl-loop.ps1`

    **Mac or Linux**

    `sh curl-loop.sh`

6. Change the image version in `nginx.deployment.yml` to the one shown in the comment right next to it. Save the file.
7. Run the following command to apply the new Deployment:

    `kubectl apply -f nginx.deployment.yml --record`

8. Go back and check the curl commands being made by the script and you should see no interuption in the service. This demonstrates a Rolling Deployment in action.
9. Check the Deployment status by running the following:

    `kubectl rollout status deployment my-nginx`



