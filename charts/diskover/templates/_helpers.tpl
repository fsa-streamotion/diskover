{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Renders merged additional labels from .Values.global.additionalLabels and
.Values.additionalLabels. Chart-level additionalLabels take precedence over
global.additionalLabels when the same key appears in both maps.

Usage:
  {{- with include "diskover.additionalLabels" . }}
  {{ . | indent <N> }}
  {{- end }}
*/}}
{{- define "diskover.additionalLabels" -}}
{{- $additionalLabels := merge (deepCopy (default dict .Values.additionalLabels)) (default dict .Values.global.additionalLabels) -}}
{{- if $additionalLabels -}}
{{ toYaml $additionalLabels | trim }}
{{- end -}}
{{- end -}}

{{/*
Renders the chart label and any merged additional labels for use in resource
metadata. Always produces at least the chart label, so no with-guard is needed
at the call site.

Usage:
  labels:
  {{ include "diskover.chartLabels" . | indent 4 }}
*/}}
{{- define "diskover.chartLabels" -}}
chart: "{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}"
{{- with include "diskover.additionalLabels" . }}
{{ . }}
{{- end }}
{{- end -}}
