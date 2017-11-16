all:
    # note: this tag must match the nginx image tag in `dockerfile`

    TAG    = 1.13.6
    PREFIX = celestia/nginx-reloady

container:
	docker build --pull -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)
