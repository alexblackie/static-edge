# static-edge

This is a small Docker container that reverse-proxies to a given URL, intended
to be used to integrate "simple" hosting methods into a Kubernetes-first
infrastructure paradigm.

For example, if you have a static site, deploying the site to object storage is
likely much easier than setting up your own nginx container and Kubernetes
deploy pipeline. But, if you need to hook that site into standard monitoring,
load balancers, etc. it can be tricky or annoying. This container aims to solve
that.

## Usage

There is only one variable to be set, `BACKEND_URL`, which should be a
full URL to the backend service you wish to proxy to.

For example:

```
$ docker run --rm \
	-e BACKEND_URL="https://example.z9.web.core.windows.net" \
	docker.pkg.github.com/alexblackie/static-edge:1
```
