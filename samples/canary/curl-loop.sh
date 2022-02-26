for ((i=1;i<=20;i++)); 
do
    # minikube service --url stable-service
    # curl -s "http://localhost:8080" | grep "<title>.*</title>"
    curl -s "http://192.168.49.2:31270/" | grep "<title>.*</title>"
    sleep .5s
done