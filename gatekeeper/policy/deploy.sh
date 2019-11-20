#!/bin/bash

set -eux -o pipefail
cd $(cd $(dirname $0) && pwd)

kubectl apply -f sync.yaml
kubectl apply -f templates/
sleep 5
kubectl apply -f constraints/

sleep 5

set +e
kubectl -n default apply -f ingress.yaml  # NG
kubectl -n default apply -f <(cat ingress.yaml | perl -p -e 's|hoge|demo-gip-01|g')  # OK
kubectl -n default apply -f <(cat ingress.yaml | perl -p -e 's|hoge|demo-gip-02|g')  # NG

