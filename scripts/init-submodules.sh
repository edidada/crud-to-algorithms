#!/usr/bin/env bash
set -e
# 算法书单读书笔记 submodule 初始化脚本
# 默认直接 git submodule add（需能访问 github.com）
# 如需镜像加速（本仓库初始提交即通过 gitclone.com 添加），先执行：
#   export GITCFG='-c url."https://gitclone.com/github.com/".insteadOf="https://github.com/"'
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

add notes/algorithm-design         https://github.com/Sullivan07043/AlgoStudy
add notes/programming-pearls       https://github.com/adijo/programming-pearls
add notes/taocp                    https://github.com/QuantamHD/TAOCP-Solutions
add notes/algorithm-design-manual  https://github.com/nitely/algo-design-manual-notes
add notes/coding-interviews        https://github.com/bryceustc/CodingInterviews
add notes/coding-interview         https://github.com/doocs/coding-interview
add notes/clrs                     https://github.com/gzc/CLRS

git submodule update --init --recursive