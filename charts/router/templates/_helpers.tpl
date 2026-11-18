{{- define "router.labels" -}}
app.kubernetes.io/part-of: ai-gateway
app.kubernetes.io/instance: {{ .Release.Name }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}

{{- define "router.upstreamUrl" -}}
{{- if .Values.gateway.upstream.baseUrl -}}
{{ .Values.gateway.upstream.baseUrl }}
{{- else if .Values.mockLlm.enabled -}}
http://{{ .Release.Name }}-mock-llm/v1
{{- else -}}
{{ fail "set gateway.upstream.baseUrl or enable mockLlm" }}
{{- end -}}
{{- end }}
