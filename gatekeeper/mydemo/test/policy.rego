package ingress_gip_validation

### Violation Rules

# forbit to create ingress.annotations['kubernetes.io/ingress.global-static-ip-name'] = hoge
violation[{"msg": msg}] {
  gip_is_hoge
  msg := "ingress.annotations['kubernetes.io/ingress.global-static-ip-name'] must not be hoge"
}

# forbit to update ingress.annotations['kubernetes.io/ingress.global-static-ip-name']
violation[{"msg": msg, "details": {"currentGIP": current, "provideGIP": provide}}] {
  gip_is_updated
  msg := "ingress.annotations['kubernetes.io/ingress.global-static-ip-name'] must be immutable field"
  current := input.review.oldObject.metadata.annotations["kubernetes.io/ingress.global-static-ip-name"]
  provide := input.review.object.metadata.annotations["kubernetes.io/ingress.global-static-ip-name"]
}

### Functions

gip_is_hoge {
  operation := input.review.operation
  operations := {"CREATE", "UPDATE"}
  operations[operation]

  object := input.review.object
  gipName := object.metadata.annotations["kubernetes.io/ingress.global-static-ip-name"]
  gipName == "hoge"
}

gip_is_updated {
  operation := input.review.operation
  operations := {"UPDATE"}
  operations[operation]

  current := input.review.oldObject.metadata.annotations["kubernetes.io/ingress.global-static-ip-name"]
  provide := input.review.object.metadata.annotations["kubernetes.io/ingress.global-static-ip-name"]
  not current == provide
}
