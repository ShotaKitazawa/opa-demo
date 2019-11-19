#!/bin/bash

set -eux -o pipefail
cd $(cd $(dirname $0) && pwd)

if kubectl -n opa get configmap ingress-gip-checker &>/dev/null; then
  kubectl -n opa delete configmap ingress-gip-checker
fi
kubectl -n opa create configmap ingress-gip-checker --from-file=./policies/ingress-gip-checker.rego
kubectl -n opa label configmaps ingress-gip-checker openpolicyagent.org/policy=rego

sleep 5

set +e
kubectl -n default apply -f ingress.yaml  # NG
kubectl -n default apply -f <(cat ingress.yaml | perl -p -e 's|hoge|demo-gip-01|g')  # OK
kubectl -n default apply -f <(cat ingress.yaml | perl -p -e 's|hoge|demo-gip-02|g')  # NG
