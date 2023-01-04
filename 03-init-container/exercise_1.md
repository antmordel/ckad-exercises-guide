# Section InitContainer: Exercise 1

Kubernetes runs an init container before the main container. In this lab, the init container retrieves configuration files from a remote location and makes it available to the application running in the main container. The configuration files are shared through a volume mounted by both containers. The running application consumes the configuration files and can render its values.

1. Create a new Pod in a YAML file named `business-app.yaml`. The Pod should define two containers, one init container and one main application container. Name the init container `configurer` and the main container `web`. The init container uses the image `busybox`, the main container uses the image `bmuschko/nodejs-read-config:1.0.0`. Expose the main container on port 8080.
2. Edit the YAML file by adding a new volume of type `emptyDir` that is mounted at `/usr/shared/app` for both containers.
3. Edit the YAML file by providing the command for the init container. The init container should run a `wget` command for downloading the file `https://raw.githubusercontent.com/bmuschko/ckad-crash-course/master/exercises/03-init-container/app/config/config.json` into the directory `/usr/shared/app`.
4. Start the Pod and ensure that it is up and running.
5. Run the command `curl localhost:8080` from the main application container. The response should render a database URL derived off the information in the configuration file.
6. (Optional) Discuss: How would you approach a debugging a failing command inside of the init container?
<details>
  <summary><strong>Solution</strong></summary>

```bash
k run business-app --image=bmuschko/nodejs-read-config:1.0.0 --port=8080 -o yaml --dry-run=client > business-app.yaml
```

We will end up with the following YAML file:

```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: business-app
  name: business-app
spec:
  containers:
  - image: bmuschko/nodejs-read-config:1.0.0
    name: business-app
    ports:
    - containerPort: 8080
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

Modify the YAML file by adding the init container and the volume:

```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: business-app
  name: business-app
spec:
  initContainers:
  - image: busybox
    name: configurer
    volumeMounts:
    - name: configdir
      mountPath: "/usr/shared/app"
  containers:
  - image: bmuschko/nodejs-read-config:1.0.0
    name: web
    ports:
    - containerPort: 8080
    resources: {}
    volumeMounts:
    - name: configdir
      mountPath: "/usr/shared/app"
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  volumes:
  - name: configdir
    emptyDir: {}
status: {}
```

After adding the command to the init container, the YAML file should look like this:

```yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: business-app
  name: business-app
spec:
  initContainers:
  - name: configurer
    image: busybox
    command:
    - wget
    - "-O"
    - "/usr/shared/app/config.json"
    - https://raw.githubusercontent.com/bmuschko/ckad-crash-course/master/exercises/03-init-container/app/config/config.json
    volumeMounts:
    - name: configdir
      mountPath: "/usr/shared/app"
  containers:
  - image: bmuschko/nodejs-read-config:1.0.0
    name: web
    ports:
    - containerPort: 8080
    volumeMounts:
    - name: configdir
      mountPath: "/usr/shared/app"
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Never
  volumes:
  - name: configdir
    emptyDir: {}
status: {}
```

Then apply the YAML file:

```bash
k apply -f business-app.yaml
k get po --watch
```

Finally:
```bash
k exec business-app -it -- /bin/sh
curl localhost:8080
```

**Optional part**: Adding a temporary sleep command to the init container help with reserving time for debugging the data available on the mounted volume. You simply kubectl exec into the container and inspect the contents.
</details>