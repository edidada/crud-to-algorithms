@echo off
REM 学习资料 submodule 初始化脚本（Windows）
REM 2026-10-31：notes/ 全部笔记 submodule 迁移至 third_party/（sha 与迁移前保持一致）
REM 若需镜像加速，取消下面一行注释：
REM set GITCFG=-c url."https://gitclone.com/github.com/".insteadOf="https://github.com/"

git %GITCFG% submodule add https://github.com/edidada/math third_party/math
git %GITCFG% submodule add https://github.com/Sullivan07043/AlgoStudy third_party/algorithm-design
git %GITCFG% submodule add https://github.com/adijo/programming-pearls third_party/programming-pearls
git %GITCFG% submodule add https://github.com/QuantamHD/TAOCP-Solutions third_party/taocp
git %GITCFG% submodule add https://github.com/nitely/algo-design-manual-notes third_party/algorithm-design-manual
git %GITCFG% submodule add https://github.com/bryceustc/CodingInterviews third_party/coding-interviews
git %GITCFG% submodule add https://github.com/doocs/coding-interview third_party/coding-interview
git %GITCFG% submodule add https://github.com/gzc/CLRS third_party/clrs
git %GITCFG% submodule add https://github.com/doocs/leetcode third_party/platforms/leetcode
git %GITCFG% submodule add https://github.com/icecold009/codeforces-grind third_party/platforms/codeforces
git %GITCFG% submodule add https://github.com/kenkoooo/AtCoderProblems third_party/platforms/atcoder
git %GITCFG% submodule add https://github.com/YingzhuWei/PAT third_party/platforms/pat
git %GITCFG% submodule add https://github.com/we1005/CCF-CSP-and-PAT-solution third_party/platforms/ccf-csp
git %GITCFG% submodule add https://github.com/ArraryChen/Codeup_Coding third_party/platforms/codeup

git submodule update --init --recursive
