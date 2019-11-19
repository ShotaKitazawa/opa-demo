package kubernetes.admission

import data.kubernetes.namespaces


# forbit to create ingress.annotations['kubernetes.io/ingress.global-static-ip-name'] = hoge
deny[msg] {
  operations = {"CREATE", "UPDATE"}
	input.request.kind.kind == "Ingress"
	operations[input.request.operation]
  gipName := getGIP(input.request.object)
	gipName == "hoge"
	msg := gipName
}

# forbit to update ingress.annotations['kubernetes.io/ingress.global-static-ip-name']
deny[msg] {
  operations = {"UPDATE"}
	input.request.kind.kind == "Ingress"
	operations[input.request.operation]
  gipName := getGIP(input.request.object)
  oldGipName := getGIP(input.request.oldObject)
	not gipName == oldGipName
	msg := "ingress.annotations['kubernetes.io/ingress.global-static-ip-name'] is immutable field"
}

getGIP(object) = gip {
  gip = object.metadata.annotations["kubernetes.io/ingress.global-static-ip-name"]
}
