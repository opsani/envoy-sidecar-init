#Sidecar proxy init container 
Supports the following environment variables:

ENVOY_PORT: mandatory, specifies what port Envoy proxy is listening to
EXCLUDE_PORTS: optional, a space-delimited list of ports that are not routed through Envoy
PROXY_PORTS: optional, a space-delimited list of ports that are routed through Envoy

If PROXY_PORTS is not defined then all incoming tcp traffic, excluding ports listed in EXCLUDE_PORTS, would be routed through Envoy.
