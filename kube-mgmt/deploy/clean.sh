#!/bin/bash

set -eux -o pipefail
cd $(cd $(dirname $0) && pwd)

kubectl delete -f admission-controller.yaml
kubectl delete -f webhook-configuration.yaml

kubectl delete ns opa

kubectl label ns kube-system openpolicyagent.org/webhook-
