* 証跡
```
$ ./deploy.sh
+++ dirname ./deploy.sh
++ cd .
++ pwd
+ cd /Users/kitazawa/Working/demo-opa-kube-mgmt/mydemo
+ kubectl -n opa get configmap ingress-gip-checker
+ kubectl -n opa create configmap ingress-gip-checker --from-file=./policies/ingress-gip-checker.rego
configmap/ingress-gip-checker created
+ kubectl -n opa label configmaps ingress-gip-checker openpolicyagent.org/policy=rego
configmap/ingress-gip-checker labeled
+ sleep 5
+ set +e
+ kubectl -n default apply -f ingress.yaml
service/demo-svc unchanged
Error from server (hoge, ingress.annotations['kubernetes.io/ingress.global-static-ip-name'] is immutable field): error when applying patch:
{"metadata":{"annotations":{"kubectl.kubernetes.io/last-applied-configuration":"{\"apiVersion\":\"extensions/v1beta1\",\"kind\":\"Ingress\",\"metadata\":{\"annotations\":{\"kubernetes.io/ingress.global-static-ip-name\":\"hoge\"},\"name\":\"demo-ingress\",\"namespace\":\"default\"},\"spec\":{\"backend\":{\"serviceName\":\"demo-svc\",\"servicePort\":80},\"rules\":[{\"host\":\"demo.local\",\"http\":{\"paths\":[{\"backend\":{\"serviceName\":\"demo-svc\",\"servicePort\":80}}]}}]}}\n","kubernetes.io/ingress.global-static-ip-name":"hoge"}}}
to:
Resource: "extensions/v1beta1, Resource=ingresses", GroupVersionKind: "extensions/v1beta1, Kind=Ingress"
Name: "demo-ingress", Namespace: "default"
Object: &{map["apiVersion":"extensions/v1beta1" "kind":"Ingress" "metadata":map["annotations":map["kubectl.kubernetes.io/last-applied-configuration":"{\"apiVersion\":\"extensions/v1beta1\",\"kind\":\"Ingress\",\"metadata\":{\"annotations\":{\"kubernetes.io/ingress.global-static-ip-name\":\"demo-gip-01\"},\"name\":\"demo-ingress\",\"namespace\":\"default\"},\"spec\":{\"backend\":{\"serviceName\":\"demo-svc\",\"servicePort\":80},\"rules\":[{\"host\":\"demo.local\",\"http\":{\"paths\":[{\"backend\":{\"serviceName\":\"demo-svc\",\"servicePort\":80}}]}}]}}\n" "kubernetes.io/ingress.global-static-ip-name":"demo-gip-01"] "creationTimestamp":"2019-11-19T10:49:01Z" "generation":'\x01' "name":"demo-ingress" "namespace":"default" "resourceVersion":"2202986" "selfLink":"/apis/extensions/v1beta1/namespaces/default/ingresses/demo-ingress" "uid":"327f0b39-0aba-11ea-93ad-42010a920094"] "spec":map["backend":map["serviceName":"demo-svc" "servicePort":'P'] "rules":[map["host":"demo.local" "http":map["paths":[map["backend":map["serviceName":"demo-svc" "servicePort":'P']]]]]]] "status":map["loadBalancer":map[]]]}
for: "ingress.yaml": admission webhook "validating-webhook.openpolicyagent.org" denied the request: hoge, ingress.annotations['kubernetes.io/ingress.global-static-ip-name'] is immutable field
+ kubectl -n default apply -f /dev/fd/63
++ cat ingress.yaml
++ perl -p -e 's|hoge|demo-gip-01|g'
ingress.extensions/demo-ingress unchanged
service/demo-svc unchanged
+ kubectl -n default apply -f /dev/fd/63
++ cat ingress.yaml
++ perl -p -e 's|hoge|demo-gip-02|g'
service/demo-svc unchanged
Error from server (ingress.annotations['kubernetes.io/ingress.global-static-ip-name'] is immutable field): error when applying patch:
{"metadata":{"annotations":{"kubectl.kubernetes.io/last-applied-configuration":"{\"apiVersion\":\"extensions/v1beta1\",\"kind\":\"Ingress\",\"metadata\":{\"annotations\":{\"kubernetes.io/ingress.global-static-ip-name\":\"demo-gip-02\"},\"name\":\"demo-ingress\",\"namespace\":\"default\"},\"spec\":{\"backend\":{\"serviceName\":\"demo-svc\",\"servicePort\":80},\"rules\":[{\"host\":\"demo.local\",\"http\":{\"paths\":[{\"backend\":{\"serviceName\":\"demo-svc\",\"servicePort\":80}}]}}]}}\n","kubernetes.io/ingress.global-static-ip-name":"demo-gip-02"}}}
to:
Resource: "extensions/v1beta1, Resource=ingresses", GroupVersionKind: "extensions/v1beta1, Kind=Ingress"
Name: "demo-ingress", Namespace: "default"
Object: &{map["apiVersion":"extensions/v1beta1" "kind":"Ingress" "metadata":map["annotations":map["kubectl.kubernetes.io/last-applied-configuration":"{\"apiVersion\":\"extensions/v1beta1\",\"kind\":\"Ingress\",\"metadata\":{\"annotations\":{\"kubernetes.io/ingress.global-static-ip-name\":\"demo-gip-01\"},\"name\":\"demo-ingress\",\"namespace\":\"default\"},\"spec\":{\"backend\":{\"serviceName\":\"demo-svc\",\"servicePort\":80},\"rules\":[{\"host\":\"demo.local\",\"http\":{\"paths\":[{\"backend\":{\"serviceName\":\"demo-svc\",\"servicePort\":80}}]}}]}}\n" "kubernetes.io/ingress.global-static-ip-name":"demo-gip-01"] "creationTimestamp":"2019-11-19T10:49:01Z" "generation":'\x01' "name":"demo-ingress" "namespace":"default" "resourceVersion":"2202986" "selfLink":"/apis/extensions/v1beta1/namespaces/default/ingresses/demo-ingress" "uid":"327f0b39-0aba-11ea-93ad-42010a920094"] "spec":map["backend":map["serviceName":"demo-svc" "servicePort":'P'] "rules":[map["host":"demo.local" "http":map["paths":[map["backend":map["serviceName":"demo-svc" "servicePort":'P']]]]]]] "status":map["loadBalancer":map[]]]}
for: "/dev/fd/63": admission webhook "validating-webhook.openpolicyagent.org" denied the request: ingress.annotations['kubernetes.io/ingress.global-static-ip-name'] is immutable field
```
