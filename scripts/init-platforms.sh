#!/usr/bin/env bash
set -e
# 平台笔记 submodule 初始化（默认 https，需能访问 github.com）
# 若本机无法直接访问 github，可设置镜像：
#   export GITCFG='-c url."https://gitclone.com/github.com/".insteadOf="https://github.com/"'
#   export GITCFG='url.git@github.com:.insteadOf=https://github.com/'   # 或走 SSH
GITCFG="${GITCFG:-}"
add() {
  local path="$1" url="$2"
  if git config --file .gitmodules --get submodule."$path".url >/dev/null 2>&1; then
    echo "skip (already configured): $path"; else
    echo "=== add $path ==="; git $GITCFG submodule add "$url" "$path"; fi
}
add notes/platforms/leetcode         https://github.com/doocs/leetcode
add notes/platforms/codeforces       https://github.com/icecold009/codeforces-grind
add notes/platforms/atcoder          https://github.com/kenkoooo/AtCoderProblems
add notes/platforms/pat              https://github.com/YingzhuWei/PAT
add notes/platforms/ccf-csp          https://github.com/we1005/CCF-CSP-and-PAT-solution
add notes/platforms/codeup           https://github.com/ArraryChen/Codeup_Coding
git submodule update --init --recursive