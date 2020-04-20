# docker-ansible-apache2-http2
Provision docker with ansible (apache2 with http2 example)

# Introduction
Example of provisioning a docker image with ansible. In this example, it's provisioned with apache2 configured to use http2.

# How to proof
- Create image:
```
docker build -t apache-http2 .
```

- Run container:
```
docker run -d --name=apachehttp2 -p 443:443 apache-http2
```

- Go to browser:
```
https://localhost
```
