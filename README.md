1. Создать namespace командой:

kubectl create namespace m

2. Поднять сервис командой:

kubectl apply -f ./kube/

3. Проверить работоспособность командой: 

curl http://arch.homework/health
