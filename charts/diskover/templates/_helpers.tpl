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
  {{- if include "diskover.additionalLabels" . }}
  {{ include "diskover.additionalLabels" . | indent <N> }}
  {{- end }}
*/}}
{{- define "diskover.additionalLabels" -}}
{{- $global := dict -}}
{{- if and .Values.global .Values.global.additionalLabels -}}
{{- $global = .Values.global.additionalLabels -}}
{{- end -}}
{{- $merged := merge (deepCopy (default dict .Values.additionalLabels)) $global -}}
{{- if $merged -}}
{{ toYaml $merged | trim }}
{{- end -}}
{{- end -}}
