{{- define "gw.labels" -}}
app.kubernetes.io/part-of: ai-gateway
app.kubernetes.io/instance: {{ .Release.Name }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}
