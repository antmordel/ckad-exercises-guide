# Pods

A pod, defined in YAMl, has the following top level fields. They are called *top level* or *root level* properties.

```yaml
apiVersion:
kind:
metadata:

spec:
```

## Top level fields

Normally, `apiVersion` will be set to `v1`.
The `kind` is the type of object that we will create. In this case, we will create a `Pod` object.

For the `metadata`, we will have the following properties:
  
```yaml
metadata:
  name: myapp-pod
  labels:
    app: myapp
    type: front-end
```

Under `labels`, we can put as many key-value pars as we wish.

## Spec field

The `spec` field contains the definition of the pod. Specifically we will focus on the `containers` field.

```yaml
spec:
  containers:
    - name: nginx-controller
      image: nginx:1.7.9
```

## Creating a pod

Once we have the definition of the pod in YAML, we can create the pod by running `kubectl create -f <pod.yaml>`.

After creating the pod, we can check the status of the pod by running `kubectl get pods`.
