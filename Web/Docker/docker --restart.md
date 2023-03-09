To specify a restart policy for a service in a Docker Compose file, you can use the `restart` key under the service definition. The `restart` key can take one of the following values:

-   `no`: Do not automatically restart the service if it stops or exits.
-   `always`: Always restart the service if it stops or exits.
-   `on-failure`: Restart the service if it stops or exits with a non-zero exit code.
-   `unless-stopped`: Always restart the service unless it is explicitly stopped.