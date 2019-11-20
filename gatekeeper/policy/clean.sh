#!/bin/bash

set -ux
cd $(cd $(dirname $0) && pwd)

kubectl -n default delete -f ingress.yaml

kubectl delete -f constraints/
kubectl delete -f templates/
kubectl delete -f sync.yaml
