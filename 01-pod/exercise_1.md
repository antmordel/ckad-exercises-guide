# Section Pod: Exercise 1

1. Create the namespace `ckad-prep`
2. In the namespace `ckad-prep`, create a new Pod named `mypod` with the image `nginx:2.3.5`. Expose the port 80
3. Change the image of the Pod to `nginx:1.15.12`
4. List the Pod and ensure that the container is running
5. Log into the container and run the `ls` command. Write down the output. Log out of the container.
7. Retrieve the IP address of the Pod `mypod`
8. Run a temporary Pod in the namespace `ckad-prep` using the image `busybox`, shell into it and run a `wget` command against the `nginx` Pod using port 80
9. Render the logs of Pod `mypod`
10. Delete the Pod and the namespace

<details>
  <summary><strong>Solution</strong></summary>

```bash
k create ns ckad-prep
k run mypod --image=nginx:2.3.5 --port=80 --namespace=ckad-prep
k get po -n ckad-prep -o yaml > mypod.yaml
k apply -f mypod.yaml
k exec -ti mypod -- /bin/bash
k get po -o wide
k run temp --image=busybox -it --rm --restart=Never -- /bin/sh
wget -O- <ip>
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    type: nginx

spec:
  containers:
    - name: nginx-controller
      image: nginx
      ports:
        - containerPort: 80
```
</details>