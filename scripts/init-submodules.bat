@echo off
REM 算法书单读书笔记 submodule 初始化脚本（Windows）
REM 若需镜像加速，取消下面一行注释：
REM set GITCFG=-c url."https://gitclone.com/github.com/".insteadOf="https://github.com/"

git %GITCFG% submodule add https://github.com/Sullivan07043/AlgoStudy notes/algorithm-design
git %GITCFG% submodule add https://github.com/adijo/programming-pearls notes/programming-pearls
git %GITCFG% submodule add https://github.com/QuantamHD/TAOCP-Solutions notes/taocp
git %GITCFG% submodule add https://github.com/nitely/algo-design-manual-notes notes/algorithm-design-manual
git %GITCFG% submodule add https://github.com/bryceustc/CodingInterviews notes/coding-interviews
git %GITCFG% submodule add https://github.com/doocs/coding-interview notes/coding-interview
git %GITCFG% submodule add https://github.com/gzc/CLRS notes/clrs

git submodule update --init --recursive