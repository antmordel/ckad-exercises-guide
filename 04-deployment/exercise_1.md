# Section Deployment: Exercise 1

1. Create a Deployment named `deploy` with 3 replicas. The Pods should use the `nginx` image and the name `nginx`. The Deployment uses the label `tier=backend`. The Pods should use the label `app=v1`
2. List the Deployment and ensure that the correct number of replicas is running.
3. Update the image to `nginx:latest`
4. Verify that the change has been rolled out to all replicas
5. Scale the Deployment to 5 replicas
6. Have a look at the Deployment rollout history
7. Revert the Deployment to revision 1
8. Ensure that the Pods use the image `nginx`
9. (Optional) Discuss: Can you foresee potential issues with a rolling deployment? How do you configure a update process that first kills all existing containers with the current version before it starts containers with the new version?

<details>
  <summary><strong>Solution</strong></summary>

```bash
k create deploy deploy --image=nginx --replicas=3 -o yaml --dry-run=client > deploy.yaml
```

And then we modify the `deploy.yaml` file to look like this:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    tier: backend
  name: deploy
spec:
  replicas: 3
  selector:
    matchLabels:
      app: v1
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: v1
    spec:
      containers:
      - image: nginx
        name: nginx
        resources: {}
status: {}
```

```bash
k apply -f deploy.yaml
k get deploy

k set image deployment/deploy nginx=nginx:latest

k rollout history deploy
k rollout history deploy --revision=2

k scale deployment deploy --replicas=5
k get po

k rollout undo deployment/deploy --to-revision=1

k delete deploy deploy
```


**Optional question**. A rolling deployment ensures zero downtime which has the side effect of having two different versions of a container running at the same time. This can become an issue if you introduce backward-incompatible changes to your public API. A client might hit either the old or new service API. You can configure the deployment use the `Recreate` strategy. This strategy first kills all existing containers for the deployment running the current version before starting containers running the new version.
</details>