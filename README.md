# Sidecar proxy init container 
Supports the following environment variables:

* ENVOY_PORT: mandatory, specifies what port Envoy proxy is listening to
* EXCLUDE_PORTS: optional, a space-delimited list of ports that are not routed through Envoy
* PROXY_PORTS: optional, a space-delimited list of ports that are routed through Envoy

If PROXY_PORTS is not defined then all incoming tcp traffic, excluding ports listed in EXCLUDE_PORTS, would be routed through Envoy.

This init container requires NET_ADMIN privilege. It should be added to deployment as:
```
apiVersion: apps/v1
kind: Deployment
spec:
  template:
    spec:
      containers:
...
      initContainers:
      - image: opsani/envoy-sidecar-init:latest
        imagePullPolicy: Always
        name: envoy-sidecar-init
        securityContext:
          capabilities:
            add:
            - NET_ADMIN
        env:
          - name: ENVOY_PORT
            value: "15001"
          - name: EXCLUDE_PORTS
            value: "22 9901"
          - name: PROXY_PORTS
            value: "80 90 12345"
```
