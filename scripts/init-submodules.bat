@echo off
REM 学习资料 submodule 初始化脚本（Windows）
REM 说明：notes/ 读书/平台笔记子模块已于 2026-10-31 移除，当前仅保留数学笔记。
REM 若需镜像加速，取消下面一行注释：
REM set GITCFG=-c url."https://gitclone.com/github.com/".insteadOf="https://github.com/"

if exist .gitmodules (
  git submodule update --init --recursive
) else (
  git %GITCFG% submodule add https://github.com/edidada/math third_party/math
  git %GITCFG% submodule update --init --recursive
)
