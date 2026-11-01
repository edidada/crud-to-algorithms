#!/usr/bin/env bash
set -e
# 学习资料 submodule 初始化脚本
# 2026-10-31：notes/ 全部笔记 submodule 迁移至 third_party/（sha 与迁移前保持一致）
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

# 数学笔记（自维护）
add third_party/math                       https://github.com/edidada/math

# 算法书读书笔记
add third_party/algorithm-design           https://github.com/Sullivan07043/AlgoStudy
add third_party/programming-pearls         https://github.com/adijo/programming-pearls
add third_party/taocp                      https://github.com/QuantamHD/TAOCP-Solutions
add third_party/algorithm-design-manual    https://github.com/nitely/algo-design-manual-notes
add third_party/coding-interviews          https://github.com/bryceustc/CodingInterviews
add third_party/coding-interview           https://github.com/doocs/coding-interview
add third_party/clrs                       https://github.com/gzc/CLRS

# 平台笔记（PAT 仓库含 Windows 非法文件名，已在 .gitmodules 设 update=none 跳过 checkout）
add third_party/platforms/leetcode         https://github.com/doocs/leetcode
add third_party/platforms/codeforces       https://github.com/icecold009/codeforces-grind
add third_party/platforms/atcoder          https://github.com/kenkoooo/AtCoderProblems
add third_party/platforms/pat              https://github.com/YingzhuWei/PAT
add third_party/platforms/ccf-csp          https://github.com/we1005/CCF-CSP-and-PAT-solution
add third_party/platforms/codeup           https://github.com/ArraryChen/Codeup_Coding

git submodule update --init --recursive
