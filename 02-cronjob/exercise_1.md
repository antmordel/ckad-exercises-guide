# Section CronJob: Exercise 1

1. Create a CronJob named `current-date` that runs every minute and executes the shell command `echo "Current date: $(date)"`
2. Watch the jobs as they are being scheduled
3. Identify one of the Pods that ran the CronJob and render the logs.
4. Determine the number of successful executions the CronJob will keep in its history
5. Delete the CronJob

<details>
  <summary><strong>Solution</strong></summary>

```bash
k create cronjob current-date --image=busybox --schedule="* * * * *" -- /bin/sh -c "echo Current date: $(date)"
k get cronjob --watch
k get po
k logs <pod>
k describe cronjob current-date | grep Successful
k delete cronjob current-date
</details>