*test-charts*

# Summary

This directory contains tests for the charts located in `../charts/`, specifically examples of "downstream" consumer charts that consume the "upstream" library charts.

These can then be rendered with Helm (eg. `helm template`) using one or more of the values files located in the `tests` subdirectories of each "downstream" chart here.

# Directory Structure

- chartname (eg. `test-replicated-library`)
  - tests (contains multiple Helm values yaml files)
  - policies/* (conftest - contains subdirectories matching the name of a Helm values yaml file, without the .yaml extension)
