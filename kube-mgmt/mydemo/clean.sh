#!/bin/bash

set -ux
cd $(cd $(dirname $0) && pwd)

kubectl -n opa delete configmap ingress-gip-checker
kubectl -n default delete -f ingress.yaml
