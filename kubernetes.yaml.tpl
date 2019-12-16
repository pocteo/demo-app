apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-app-deploy
spec:
  replicas: 1
  selector:
    matchLabels:
      app: demo-app-pod
  template:
    metadata:
      labels:
        app: demo-app-pod
    spec:
      containers:
      - name: demo-app-container
        image: pocteo/demo-app:COMMIT_SHA
        ports:
        - containerPort: 3000
---
kind: Service
apiVersion: v1
metadata:
  name: demo-app-svc
spec:
  selector:
    app: demo-app-pod
  ports:
  - protocol: TCP
    nodePort: 30000
    port: 80
    targetPort: 3000
  type: NodePort
