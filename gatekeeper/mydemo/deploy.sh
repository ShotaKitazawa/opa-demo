#!/bin/bash

set -eux -o pipefail
cd $(cd $(dirname $0) && pwd)

kubectl apply -f sync.yaml
kubectl apply -f templates/
sleep 5
kubectl apply -f constraints/

sleep 5

set +e
kubectl -n default apply -f ./manifests/ingress-demo-hoge.yaml # NG
kubectl -n default apply -f ./manifests/ingress-demo-01.yaml   # OK
kubectl -n default apply -f ./manifests/ingress-demo-02.yaml   # NG

