RUN?=""
BUILDPATHS = ./test/...
TESTFLAGS ?= -v -coverprofile cover.out

.PHONY: test

.PHONY: fmt
fmt:
	go fmt ${BUILDPATHS}

.PHONY: vet
vet:
	go vet ${BUILDFLAGS} ${BUILDPATHS}

helm-dep-update:
	helm dependency update ./test/test-chart

.PHONY: test
test: fmt vet helm-dep-update
	if [ -n $(RUN) ]; then \
		go test ${BUILDPATHS} ${TESTFLAGS} -run $(RUN); \
	else \
		go test ${BUILDPATHS} ${TESTFLAGS}; \
	fi
