package ingress_gip_validation

# GIP名に hoge を指定して CREATE したときに失敗することのテスト
test_violation_gip_is_hoge {
  mock := {"object": {"metadata": {"annotations": {"kubernetes.io/ingress.global-static-ip-name": "hoge"}}}, "operation": "CREATE"}

  gip_is_hoge with input.review as mock
}

# admin ユーザならば GIP名に hoge を指定して CREATE しても成功することのテスト
test_acception_gip_is_hoge_admin {
  mock := {"object": {"metadata": {"annotations": {"kubernetes.io/ingress.global-static-ip-name": "hoge"}}}, "operation": "CREATE", "userInfo": {"username": "admin"}}

  not gip_is_hoge with input.review as mock
}

# GIP名に fuga を指定して CREATE したときに成功することのテスト
test_acception_gip_is_fuga {
  mock := {"object": {"metadata": {"annotations": {"kubernetes.io/ingress.global-static-ip-name": "fuga"}}}, "operation": "CREATE"}

  not gip_is_hoge with input.review as mock
}

# GIP名を変更 ("hoge" -> "fuga") して UPDATE したときに失敗することのテスト
test_violation_gip_updated{
  mock := {"object": {"metadata": {"annotations": {"kubernetes.io/ingress.global-static-ip-name": "hoge"}}}, "oldObject": {"metadata": {"annotations": {"kubernetes.io/ingress.global-static-ip-name": "fuga"}}}, "operation": "UPDATE"}

  gip_is_updated with input.review as mock
}

# GIP名を変更しないで UPDATE したときに成功することのテスト
test_acception_gip_not_updated {
  mock := {"object": {"metadata": {"annotations": {"kubernetes.io/ingress.global-static-ip-name": "hoge"}}}, "oldObject": {"metadata": {"annotations": {"kubernetes.io/ingress.global-static-ip-name": "hoge"}}}, "operation": "UPDATE"}

  not gip_is_updated with input.review as mock
}
