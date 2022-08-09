# Pods: Exercise 1

**Questions**: Create a pod with a container with the `nginx` image using a YAML specification.

**Solution**
Open an editor (`vim` in my case): `vim nginx.yaml`.
Create a specification like:

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
```

Run `k apply -f nginx.yaml` to create the pod.