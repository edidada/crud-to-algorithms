#!/usr/bin/env bash
set -e
# 学习资料 submodule 初始化脚本
# 说明：notes/ 读书/平台笔记子模块已于 2026-10-31 移除，当前仅保留数学笔记。
# 如需镜像加速（可选）：export GITCFG='-c url."https://gitclone.com/github.com/".insteadOf="https://github.com/"'
GITCFG="${GITCFG:-}"

add() {
  local path="$1" url="$2"
  if git config --file .gitmodules --get submodule."$path".url >/dev/null 2>&1; then
    echo "skip (already configured): $path"
  else
    echo "=== add $path ==="
    git $GITCFG submodule add "$url" "$path"
  fi
}

add third_party/math               https://github.com/edidada/math

git submodule update --init --recursive
