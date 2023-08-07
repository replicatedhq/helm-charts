RUN?=""
BUILDPATHS = ./test/...
TESTFLAGS ?= -v -coverprofile cover.out

.PHONY: test

test:
	if [ -n $(RUN) ]; then \
		go test ${BUILDPATHS} ${TESTFLAGS} -run $(RUN); \
	else \
		go test ${BUILDPATHS} ${TESTFLAGS}; \
	fi
