#!/usr/bin/env bash

set -euo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [[ -z "${repo_root}" ]]; then
  echo "Erro: este diretório não pertence a um repositório Git."
  exit 1
fi

cd "${repo_root}"

git add .

if git diff --cached --quiet; then
  echo "Sem alterações para commit."
  exit 0
fi

build_auto_subject() {
  local changed_files
  local file_count
  local sample

  changed_files="$(git diff --cached --name-only)"
  file_count="$(printf '%s\n' "${changed_files}" | sed '/^$/d' | wc -l | tr -d ' ')"
  sample="$(printf '%s\n' "${changed_files}" | sed '/^$/d' | head -n 3 | paste -sd ', ' -)"

  if [[ "${file_count}" -eq 1 ]]; then
    printf 'Atualiza %s' "${sample}"
    return
  fi

  if [[ "${file_count}" -le 3 ]]; then
    printf 'Atualiza %s' "${sample}"
    return
  fi

  printf 'Atualiza %s e mais %s ficheiros' "${sample}" "$((file_count - 3))"
}

if [[ $# -ge 1 ]]; then
  commit_subject="$1"
else
  commit_subject="$(build_auto_subject)"
fi

summary="$(git diff --cached --stat)"

git commit -m "${commit_subject}" -m "Resumo automático das alterações:

${summary}"

git push

echo "Sincronização concluída."
