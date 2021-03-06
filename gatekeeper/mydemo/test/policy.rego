package ingress_gip_validation

# admin ユーザであるかどうか
admin_user {
  username := input.review.userInfo.username
  endswith(username, "admin")
}

# ingress.annotations['kubernetes.io/ingress.global-static-ip-name'] に hoge を指定した CREATE, UPDATE を禁止する
violation[{"msg": msg}] {
  gip_is_hoge
  msg := "ingress.annotations['kubernetes.io/ingress.global-static-ip-name'] must not be hoge"
}
gip_is_hoge {
  not admin_user

  operation := input.review.operation
  operations := {"CREATE", "UPDATE"}
  operations[operation]

  object := input.review.object
  gipName := object.metadata.annotations["kubernetes.io/ingress.global-static-ip-name"]
  gipName == "hoge"
}

# ingress.annotations['kubernetes.io/ingress.global-static-ip-name'] の更新を禁止する
violation[{"msg": msg, "details": {"currentGIP": current, "provideGIP": provide}}] {
  gip_is_updated
  msg := "ingress.annotations['kubernetes.io/ingress.global-static-ip-name'] must be immutable field"
  current := input.review.oldObject.metadata.annotations["kubernetes.io/ingress.global-static-ip-name"]
  provide := input.review.object.metadata.annotations["kubernetes.io/ingress.global-static-ip-name"]
}
gip_is_updated {
  not admin_user

  operation := input.review.operation
  operations := {"UPDATE"}
  operations[operation]

  current := input.review.oldObject.metadata.annotations["kubernetes.io/ingress.global-static-ip-name"]
  provide := input.review.object.metadata.annotations["kubernetes.io/ingress.global-static-ip-name"]
  not current == provide
}
