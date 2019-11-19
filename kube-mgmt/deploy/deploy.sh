#!/bin/bash

set -eux -o pipefail
cd $(cd $(dirname $0) && pwd)

kubectl create ns opa

kubectl -n opa create secret tls opa-server --cert=./cert/server.crt --key=./cert/server.key

kubectl -n opa apply -f admission-controller.yaml
kubectl -n opa apply -f webhook-configuration.yaml

kubectl label ns kube-system openpolicyagent.org/webhook=ignore
kubectl label ns opa openpolicyagent.org/webhook=ignore
