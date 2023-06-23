# Replicated Helm Charts

Helm charts maintained by the Replicated team

## Releasing

This repo uses [chart-releaser](https://github.com/helm/chart-releaser) to release all charts in the charts folder. Chart releaser will look for changes in the charts folder, and release charts that have changed on merge to main. The release is made available on github using the version that the charts `Chart.yaml` lists. The repository will also be automatically tagged for the release making it easy to identify where in the source history any given chart version was created from.

While chart-releaser will release multiple charts at once, pull requests should only modify a single chart at a time. If any chart fails to release chart-releaser will stop processing charts. By only modifying a single chart with any given pull request, not only is version history clear for each chart but a failure to release one chart does not impact the release of an alternate chart.

The Github action will list any reason for failure to release. A common mistake is not updating the Chart.lock file to match the Chart.yaml file. If a lock file is included in a chart, chart-release will verify that it matches the Chart.yaml version to avoid unexpected dependency versions. A failure to release only needs to be fixed in a new PR and merged again to trigger chart-releaser to try again.

At no point should a version ever be re-released. Once released a version is immutable. If a chart needs to be updated, a new version should be created. This is to ensure that the version history of a chart is clear and unambiguous.

## Tests

There are tests in place, that are executed as GitHub Actions + can also be executed locally.


For local use, first install `go-task` (if you don't have it already) and the test suite tools. On MacOS:

```
brew install go-task
task macos_install_deps
```

Then:

```
VALUES=values-nginx-basic task test
```

Or if you want to use a chart other than `test-replicated-library` (that exists as a directory in `test-charts`):

```
CHART=somechart VALUES=values-nginx-basic task test
```
