for ((i=1;i<=200;i++));
do
    # with minikube we had to obtain the exact external url for the service by issueing the command:
    # minikube service --url nginx-service
    # curl -s "http://localhost:8080" | grep "<title>.*</title>"
    curl -s "http://192.168.49.2:30530/" | grep "<title>.*</title>"
    sleep 2s
done