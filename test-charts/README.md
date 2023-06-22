*test-charts*

# Summary

This directory contains tests for the charts located in `../charts/`, specifically examples of "downstream" consumer charts that consume the "upstream" library charts.

These can then be rendered with Helm (eg. `helm template`) using one or more of the values files located in the `tests` subdirectories of each "downstream" chart here.
