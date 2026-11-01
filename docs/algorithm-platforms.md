# 算法刷题 / 竞赛平台（难度高于 LeetCode + 面向硕博的机试/比赛）

> 难度梯度：LeetCode（求职基准） < Codeforces / AtCoder / TopCoder（算法竞赛）。
> 另有面向考研 / 申硕 / 保研的机试平台 **PAT**、**CCF CSP**，以及考研机试 OJ **Codeup**。
> 各平台公开题解 / 笔记的 git submodule 原挂载于 `notes/platforms/`，**现已整体迁移至 `third_party/platforms/`**（commit sha 与迁移前一致）。

## 平台一览

| 平台 | 定位 | 官网 | 本地子模块 |
| --- | --- | --- | --- |
| LeetCode | 求职 / 面试基准，含周赛、双周赛 | https://leetcode.com · https://leetcode.cn | third_party/platforms/leetcode |
| Codeforces | 全球算法竞赛天花板，难度远高于 LeetCode（Div.2 → Div.1 → Div.1+） | https://codeforces.com | third_party/platforms/codeforces |
| AtCoder | 日本高质量竞赛（ABC / ARC / AGC） | https://atcoder.jp | third_party/platforms/atcoder |
| TopCoder | 老牌算法 / 编程竞赛 | https://www.topcoder.com | （暂无单独 submodule） |
| PAT（浙大计算机程序设计能力考试） | 面向考研 / 保研 / 申硕机试（甲级 / 顶级） | https://www.patest.cn | third_party/platforms/pat |
| CCF CSP（软件能力认证） | 用于研究生招生、申硕、就业 | https://www.cspro.org | third_party/platforms/ccf-csp |
| Codeup | 《算法笔记》配套 OJ，考研机试 / PAT 备考 | http://codeup.cn | third_party/platforms/codeup |
| 牛客网 Nowcoder | 求职 / 考研机试题库与真题 | https://www.nowcoder.com | （暂无单独 submodule） |
| Google Code Jam / Kick Start、Facebook Hacker Cup、ICPC | 国际算法赛事 | — | （暂无单独 submodule） |

## 说明

- 表中"本地子模块"列为空者，表示尚未挂载对应公开笔记仓库（多为平台型站点，无单一权威题解仓库）。
- 拉取笔记：`git submodule update --init --recursive`（或运行 `scripts/init-submodules.sh` / `.bat`）。
- PAT 仓库（`third_party/platforms/pat`）含一个 Windows 无法创建的文件名（`1067. Sort with Swap(0,*) (25) .cpp`，文件名带 `*`），已在 `.gitmodules` 中配置 `update=none` 跳过其 checkout；本机拉取后其余文件正常可用，仅该文件缺失。
- 算法书读书笔记子模块同批迁移：见 `docs/algorithm-books.md` 与 `third_party/` 对应目录。
