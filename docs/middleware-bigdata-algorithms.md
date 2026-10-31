# 后端中间件与大数据开源代码仓库常用算法清单（前置数学版）

> 面向读者：具备增删改查（CRUD）能力、接触过 Redis/MySQL/Kafka 等中间件的编码人员。
> 配套文档：
> - 数学笔记（按**本科→硕博**课程体系组织，含术语中英对照）：本仓库 `third_party/math/中间件与大数据算法数学基础.md`（子模块，来源 <https://github.com/edidada/math>，运行 `scripts/init-submodules.sh` 拉取）。
> - 硬核三算法（反向传播/路径追踪/FFT）：见 `docs/three-typical-algorithms-math.md`。
> 体例：算法/数据结构给出**中英对照**；论文尽量给出 **DOI**（确无 DOI 的注明 arXiv 或"无 DOI"）；书籍给出 **ISBN**。

---

## 0. 总览：中间件/大数据项目 × 算法 × 数学

| 算法 / 数据结构（中英对照） | 代表开源项目 | 它解决的问题 | 核心前置数学 | 级别 |
| --- | --- | --- | --- | --- |
| B⁺ 树（B⁺-Tree） | MySQL InnoDB、PostgreSQL、ClickHouse 主键索引 | 有序索引、范围查询 | 对数、树的扇出、磁盘 I/O 模型 | 本科 |
| 日志结构合并树（Log-Structured Merge-Tree, LSM-Tree） | LevelDB、RocksDB、Cassandra、HBase、ClickHouse MergeTree | 顺序写 + 多级合并 | 多路归并排序、几何级数（层放大比） | 本科 |
| 跳表（Skip List） | Redis SortedSet、LevelDB/RocksDB MemTable、etcd | 概率化替代平衡树 | 几何分布、期望与概率分析 | 本科 |
| 布隆过滤器（Bloom Filter） | HBase、Cassandra、Elasticsearch、LevelDB | 空间高效"可能存在"判定 | 哈希、伯努利/泊松近似、错判率公式 | 本科 |
| 默克尔树（Merkle Tree） | Cassandra 反熵、BitTorrent、Dynamo | 分块一致性校验 | 哈希嵌套、二叉树 | 本科 |
| 倒排索引 + BM25（Inverted Index） | Elasticsearch / Lucene | 全文检索排序 | 条件概率、TF-IDF 对数加权、概率检索模型 | 本科 |
| 一致性哈希（Consistent Hashing） | Cassandra、Dynamo、Redis Cluster | 节点增删最小迁移 | 随机映射的均匀性、期望值、虚拟结点 | 本科 |
| 仲裁读写字 W > N−R（Quorum） | Cassandra、Dynamo | 副本读写下限 | 鸽笼原理、整数不等式 | 本科 |
| 传染病算法 / Gossip（Epidemic Algorithms） | Cassandra、Redis Cluster、Consul | 最终一致的消息传播 | 随机图、SIR 传染病模型、对数收敛 | 本科~硕博 |
| Paxos / ZAB / 木桶协议族 | ZooKeeper（ZAB）、etcd-早期实现 | 分布式共识（全序广播） | 状态机、数学归纳、多数派鸽笼 | 硕博 |
| Raft（Leader 选举 + 日志复制） | etcd、Consul、TiKV、ClickHouse Keeper | 更易懂的共识 | 随机化超时（均匀分布）、归纳法 | 硕博 |
| 向量时钟（Vector Clock） | Dynamo、Riak | 事件因果偏序追踪 | 离散偏序关系 | 本科 |
| CRDT（无冲突复制数据类型） | Riak、Redis Enterprise | 免并发控制的收敛副本 | 半格（Join-Semilattice）、单调函数、交换律 | 硕博 |
| 令牌桶 / 漏桶（Token Bucket / Leaky Bucket） | Nginx、Guava、Envoy、redis-cell | 平滑限流 | 线性递推、变化率（导数直觉） | 本科 |
| 指数加权移动平均（EWMA）/ 随机早期检测（RED） | Linux 内核拥塞队列、Nginx 缓存淘汰 | 自适应反馈 | 几何级数求和、按概率丢弃 | 本科 |
| Little 定律（排队论） | 数据库连接池、线程池容量估算 | 并发 Queuing 容量 | 稳态流守恒 L = λW | 本科~硕博 |
| 外部排序 Shuffle（External Merge Sort） | Spark、Hadoop MapReduce、Flink | 分区 + 排序归并 | 归并排序、哈希取模、磁盘 I/O 成本 | 本科 |
| 基于代价的查询优化（Cost-Based Optimizer, CBO） | Spark Catalyst、PostgreSQL、Presto | Join 顺序/访问路径 | 动态规划、选择性估计（直方图、假设检验） | 本科~硕博 |
| HyperLogLog（HLL 基数估计） | Redis `PFADD`、ClickHouse、Presto `approx_distinct` | 常数内存去重计数 | 几何分布、调和级数、泊松化渐近分析 | 本科~硕博 |
| Count-Min Sketch（CMS 草图） | Flink、Presto、ClickHouse | 流数据长尾计数 | 马尔可夫不等式、全概率 | 硕博 |
| t-digest（分位数草图） | Prometheus、Pinot、ES 分位近似 | 高精度 P99 分位 | 密度插值、迭代缩放 | 本科~硕博 |
| 蓄水池抽样（Reservoir Sampling） | Spark `sample`、大数据流采样 | 无限流等概率取样 | 数学归纳、均匀分布 | 本科 |
| MinHash + 局部敏感哈希（MinHash-LSH） | Spark MinHashLSH、ES 近重复去重 | 文档相似度 | 等概率最小值、Jaccard 指数、几何分布 | 本科 |
| 纠删码（Reed–Solomon Erasure Coding） | HDFS EC、MinIO、Azure LRC | 存储冗余优于 3 副本 | 有限域 GF(2⁸)、范德蒙/柯西矩阵、高斯消元 | 本科~硕博 |
| CRC 循环冗余校验 | Kafka、HDFS、ZFS | 数据完整性 | GF(2) 多项式环 | 本科 |
| PageRank 幂迭代 | Spark GraphX、图计算生态 | 图链路权重 | 马尔可夫链平稳分布、幂法收敛 | 硕博 |
| Huffman 编码（Huffman Coding）、DEFLATE | zlib、Kafka 压缩 | 无损压缩 | 熵（信息论）、贪心+前缀二叉树 | 本科 |
| LZ77/LZSS 字典滑动窗口（Lempel–Ziv） | Snappy、LZ4、Zstd、Kafka | 无损压缩 | 熵率、自适应编码定理 | 本科~硕博 |
| 哈希函数（Murmur/FNV） | 各类中间件 | 桶映射、数据分布 | 整数同余（mod 素数/2⁶⁴）、雪崩性 | 本科 |
| 游程编码/字典编码/位打包 | Parquet、Arrow、RoaringBitmap（ClickHouse）| 列式压缩 | 二进制编码优化、组合 | 本科 |

---

## 1. 存储与索引算法群

### 1.1 术语中英对照

| 中文 | 英文 |
| --- | --- |
| 有序索引 | Ordered Index |
| 页/磁盘块 | Page / Block |
| 扇出 | Fan-out |
| 写放大 / 读放大 / 空间放大 | Write Amplification / Read Amplification / Space Amplification |
| 层级/层 | Level |
| 倒排表 | Posting List |
| 词频/逆文档频率 | Term Frequency / Inverse Document Frequency |
| 冻结表 | MemTable / Immutable MemTable |

### 1.2 前置数学知识点

| 数学知识点 | 用在哪 | 关键公式 / 结论 |
| --- | --- | --- |
| 对数增长规则 | B⁺ 树高度估算 | 高度 ≈ $\lceil\log_{f} N\rceil$，$f$ 为扇出；10 亿数据 3~4 层即可（含根） |
| 磁盘排序成本模型 | 外部排序、LSM 合并 | $O(N/B \log_{B}(N/B))$ 次 I/O（$B$ = 每页元素数） |
| 几何级数求和 | LSM 每层容量比 | 容量比 $T^{L}$，写放大 $O(\log_T N)$；$T$（扇形系数）通常取 4~10 |
| 几何分布期望 | 跳表每层命中 | $\mathbb{E}[\text{level}] = 1/p$，全跳表高度期望 $O(\log_{1/p} n)$ |
| 伯努利/泊松近似 | 布隆过滤器 | 错判率 $P \approx \left(1 - e^{-kn/m}\right)^k$，最优 $k = (m/n)\ln 2$ |
| 条件概率与 TF-IDF | BM25 打分 | $Score \propto \sum_i IDF(q_i)\cdot \dfrac{tf\cdot(k_1+1)}{tf+k_1(1-b+b\,dl/avgdl)}$ |
| 二叉哈希树 | Merkle Tree | 沿树二分比较，定位不一致分块 $O(\log N)$ |

### 1.3 关键论文（含 DOI）

| 论文 | 出处 | DOI |
| --- | --- | --- |
| Bayer & McCreight, *Organization and Maintenance of Large Ordered Indices*（B 树） | Acta Informatica 1972 | `10.1007/BF00288683` |
| O'Neil et al., *The Log-Structured Merge-Tree* | Acta Informatica 1996 | `10.1007/s002360050048` |
| Pugh, *Skip Lists: A Probabilistic Alternative to Balanced Trees* | CACM 1990 | `10.1145/78973.78977` |
| Bloom, *Space/Time Trade-offs in Hash Coding with Allowable Errors* | CACM 1970 | `10.1145/362686.362692` |
| Robertson & Zaragoza, *The Probabilistic Relevance Framework: BM25 and Beyond* | FnTIR 2009 | `10.1561/1500000019` |
| Merkle, *A Digital Signature Based on a Conventional Encryption Function* | CRYPTO '87 | `10.1007/3-540-48184-2_32` |

---

## 2. 分布式共识与复制算法群

### 2.1 术语中英对照

| 中文 | 英文 |
| --- | --- |
| 共识 | Consensus |
| 全序广播 | Total Order Broadcast |
| Leader 选举 | Leader Election |
| 任期 | Term |
| 反熵 | Anti-Entropy |
| 因果顺序 | Causal Order |
| 偏序集 / 半格 | Poset / Semilattice |
| 仲裁 | Quorum |

### 2.2 前置数学知识点

| 数学知识点 | 用在哪 | 关键公式 / 结论 |
| --- | --- | --- |
| 鸽笼原理 | Raft/Paxos 多数派安全性 | $Q_R + Q_W > N \Rightarrow$ 每次读必然看到最新写 |
| 整数不等式 | Quorum 组合 | $N=3$ 时 $W=R=2$ 可用性与一致性折中 |
| 数学归纳法 | Raft/Paxos 不变量证明 | "日志前缀一致"按任期归纳 |
| 均匀随机分布 | Raft 选举随机超时 | 避免瓜分选票（split vote），期望 $O(\log n)$ 轮收敛 |
| 随机图与传染病模型 | Gossip 收敛速度 | $O(\log n)$ 轮传播全部节点；$p<1$ 时 $O(\log n / \log(1/p))$ |
| 偏序关系（自反/反对称/传递） | 向量时钟、CRDT | $vc_1 \prec vc_2 \Leftrightarrow vc_1 \leq vc_2, vc_1 \neq vc_2$ |
| 半格（Join-Semilattice）与交换律 | CRDT（G-Counter, LWW-Set） | $s \triangleright s \vee t$ 单调；`merge` 结合+交换+幂等 ⇒ 收敛 |
| 网络分区的组合特性 | CRDT 可复现冲突 | "顺序保证 → 副本收敛"的偏序映射 |

### 2.3 关键论文（含 DOI）

| 论文 | 出处 | DOI |
| --- | --- | --- |
| Lamport, *The Part-Time Parliament*（Paxos） | ACM TOCS 1998 | `10.1145/279227.279229` |
| Lamport, *Paxos Made Simple* | SIGACT News 2001 | 无 DOI（开放获取） |
| Ongaro & Ousterhout, *In Search of an Understandable Consensus Algorithm*（Raft） | USENIX ATC 2014 | 无 DOI（USENIX 开放获取） |
| Demers et al., *Epidemic Algorithms for Replicated Database Maintenance* | PODC 1987 | `10.1145/41840.41841` |
| Lamport, *Time, Clocks, and the Ordering of Events in a Distributed System* | CACM 1978 | `10.1145/359545.359563` |
| Letia/Preguiça/Shapiro, *CRDTs: Consistency without Concurrency Control* | ACM SIGOPS OSR 2010 | `10.1145/1773912.1773921`（另有 arXiv:0907.0929） |
| Karger et al., *Consistent Hashing and Random Trees* | STOC 1997 | `10.1145/258533.258596` |
| DeCandia et al., *Dynamo: Amazon's Highly Available Key-value Store* | SOSP 2007 | `10.1145/1323293.1294281` |

---

## 3. 流量治理与调度算法群

### 3.1 术语中英对照

| 中文 | 英文 |
| --- | --- |
| 限流 | Rate Limiting |
| 令牌桶 | Token Bucket |
| 漏桶 | Leaky Bucket |
| 平滑加权轮询 | Smooth Weighted Round-Robin |
| 连接池 | Connection Pool |
| 到达率 / 服务率 | Arrival Rate / Service Rate |

### 3.2 前置数学知识点

| 数学知识点 | 用在哪 | 关键公式 / 结论 |
| --- | --- | --- |
| 线性递推 | 令牌桶 | $tokens(t+\Delta) = \min(C,\ tokens(t) + r\Delta)$ |
| 变化率直觉（微积分） | 突发与平均速率 | 平均速率 = 补充速率 $r$，突发上限 = 桶容量 $C$ |
| 几何级数求和 | EWMA | $M_t = \alpha x_t + (1-\alpha) M_{t-1} \Rightarrow$ 等价于几何加权平均 |
| GCD（欧几里得算法） | 加权轮询 | Nginx 平滑权重常用 $\gcd$ 归一化轮次 |
| 排队论稳态 | 连接池/队列容量 | **Little 定律** $L = \lambda W$（吞吐 × 时延 = 并发） |

### 3.3 关键论文（含 DOI）

| 论文 | 出处 | DOI |
| --- | --- | --- |
| Little, *A Proof for the Queuing Formula $L = \lambda W$* | Operations Research 1961 | `10.1287/opre.9.3.383` |

---

## 4. 大数据计算引擎算法群

### 4.1 术语中英对照

| 中文 | 英文 |
| --- | --- |
| 血缘/DAG 血统 | Lineage |
| 选择性 | Selectivity |
| 值选择性估计 | Cardinality Estimation |
| 任务调度 | Task Scheduling |
| 蓄水池 | Reservoir |
| 水位线（乱序等待） | Watermark |

### 4.2 前置数学知识点

| 数学知识点 | 用在哪 | 关键公式 / 结论 |
| --- | --- | --- |
| 归并排序 & 哈希取模 | Spark/Hadoop Shuffle | 分区数 $P$，桶 = $hash(key) \bmod P$；排序 $O(N\log N)$ |
| 动态规划 | Join 顺序优化（Selinger 1979 起） | 子集 DP：对关系集合 $S$ 取最优拆分 $\min_{S = S_1 \sqcup S_2}\{cost(S_1)+cost(S_2)+cost(S_1 \bowtie S_2)\}$ |
| 直方图与统计推断 | CBO 选择性估计 | 等宽/等深直方图、样本估计选择性（列统计） |
| 几何分布与随机最小值 | MinHash | $P[\text{最小值首个相同}] = J(A,B)$（Jaccard 相似度估计） |
| 数学归纳 + 均匀分布 | 蓄水池抽样 | $i$ 元素被留概率 $\frac{k}{i}$ 严格相等 |
| 马尔可夫不等式 / 切比雪夫 | Count-Min Sketch 误差界 | $\Pr[\hat{x}_i > x_i + \varepsilon\|x\|_1] \leq \delta$，深度 $d = O(\log(1/\delta))$、宽度 $w = O(1/\varepsilon)$ |
| 调和级数近似 | HyperLogLog 简化推导 | 零游程的几何分布；估计标准误 $\frac{1.04}{\sqrt{m}}$ |
| 幂法收敛 & 随机游走 | PageRank（Spark GraphX） | 迭代 $PR = (1-d)\,\tfrac{\mathbf{1}}{n} + d\,M^\top PR$，谱半径 $<1$ 保证收敛 |
| 有限域 GF(2⁸) 矩阵 | HDFS/MinIO EC | RS($k,m$)：$m$ 个校验块可恢复任意 $m$ 失效（MDS 性质） |

### 4.3 关键论文（含 DOI）

| 论文 | 出处 | DOI |
| --- | --- | --- |
| Selinger et al., *Access Path Selection in a Relational DATABASE Management System* | SIGMOD 1979 | `10.1145/582095.582099` |
| Dean & Ghemawat, *MapReduce: Simplified Data Processing on Large Clusters* | CACM 2008 | `10.1145/1327452.1327492` |
| Ghemawat et al., *The Google File System* | SOSP 2003 | `10.1145/1165389.945450` |
| Chang et al., *Bigtable: A Distributed Storage System for Structured Data* | ACM TOCS 2008 | `10.1145/1365815.1365816` |
| Corbett et al., *Spanner: Google's Globally-Distributed Database* | ACM TOCS 2013 | `10.1145/2491245` |
| Cormode & Muthukrishnan, *An Improved Data Stream Summary: The Count-Min Sketch and its Applications* | J. Algorithms 2005 | `10.1016/j.jalgor.2003.12.001` |
| Flajolet et al., *HyperLogLog: The Analysis of a Near-Optimal Cardinality Estimation Algorithm* | DMTCS 2007 | `10.46298/dmtcs.3545` |
| Vitter, *Random Sampling with a Reservoir* | ACM TOMS 1985 | `10.1145/3147.3165` |
| Brin & Page, *The Anatomy of a Large-Scale Hypertextual Web Search Engine* | Computer Networks 1998 | `10.1016/S0169-7552(98)00110-X` |
| Reed & Solomon, *Polynomial Codes over Certain Finite Fields* | SIAM 1960 | `10.1137/0708018` |

> 补充：Heule et al., *HyperLogLog in Practice*（EDBT 2013，Google HLL++，Spark/ES 用的改进版）无正式 DOI，见 arXiv:1302.0240。

---

## 5. 编码与压缩算法群

### 5.1 术语中英对照

| 中文 | 英文 |
| --- | --- |
| 熵 / 熵率 | Entropy / Entropy Rate |
| 前缀码 | Prefix Code |
| 自适应编码 | Adaptive Coding |
| 游程编码 | Run-Length Encoding (RLE) |
| 位打包 | Bit-Packing |
| 雪崩性 | Avalanche Property |

### 5.2 前置数学知识点

| 数学知识点 | 用在哪 | 关键公式 / 结论 |
| --- | --- | --- |
| 信息论熵 | 压缩极限 | $H(X) = -\sum p_i \log_2 p_i$，任何前缀码平均码长 $\geq H(X)$ |
| 贪心 + 二叉树 | Huffman 最优前缀码 | 频率两两合并的最小堆策略 |
| 熵率 | LZ77/LZSS | 长文档自适应逼近信源熵率 |
| 整数同余 | Murmur/FNV 哈希 | 乘以素数再 mod $2^{64}$；素数取模 vs 位掩码 |
| 组合计数 | Parquet/RLE | 序列编码空间下界估计 |

### 5.3 关键论文（含 DOI）

| 论文 | 出处 | DOI |
| --- | --- | --- |
| Shannon, *A Mathematical Theory of Communication* | Bell Syst. Tech. J. 1948 | 无 DOI（BSTJ 时期，经典开放获取） |
| Huffman, *A Method for the Construction of Minimum-Redundancy Codes* | IRE 1952 | `10.1109/JRPROC.1952.273898` |
| Ziv & Lempel, *A Universal Algorithm for Sequential Data Compression* | IEEE Trans. Inf. Theory 1977 | `10.1109/TIT.1977.1055714` |
| Ziv & Lempel（1978 变体） | IEEE Trans. Inf. Theory 1978 | `10.1109/TIT.1978.1055946` |

---

## 6. 书单（含 ISBN）

> 国外原版优先：英文原版社区勘误/配套资源最全，推荐为主；中文版作为对照。

| 书名 | ISBN | 用在哪 |
| --- | --- | --- |
| 《算法导论（原书第 3 版）》 CLRS | 9787111407010 | 总纲：树/哈希/排序/复杂度 |
| Cormen et al., *Introduction to Algorithms* 4th ed（英文最新版） | 9780262046305 | 同上，国外原版最新 |
| Erickson, *Algorithms*（免费在线 jeffe.cs.illinois.edu） | 9780999282922 | 数据结构与复杂度的现代开源教材 |
| Dasgupta, Papadimitriou & Vazirani, *Algorithms* | 9780073523408 | 算法思想（随机化/草图思维）的国外经典 |
| *Designing Data-Intensive Applications*（DDIA）英文 1 版 | 9781449373320 | 全景串联本文档所有算法 |
| Kleppmann & Riccomini, *DDIA* 2nd ed（2025 英文新版） | 9781098119058 | 最新版补充流处理/共识新范式 |
| 《数据密集型应用系统设计》DDIA 简中 | 9787519821968 | 同上，中文版（电力出版社） |
| *Database Internals*（Petrov） | 9781492040347 | B 树/LSM/共识实现细节 |
| *Mining of Massive Datasets* 3rd（Leskovec 等） | 9781108476348 | 大数据算法（SimHash/LSH/流摘要/Spark） |
| *Probability and Computing* 2nd（Mitzenmacher & Upfal） | 9781107027863 | 布隆/HLL/CMS 的随机分析正规化 |
| *Randomized Algorithms*（Motwani & Raghavan） | 9780521474658 | 随机化算法进阶 |
| 《概率论与数理统计（第五版）》盛骤等 | 9787040516609 | 本科概率统一基础 |
| *The Art of Computer Programming* Vol. 2（Knuth） | 9780201896842 | 随机数/哈希 |
| *The Art of Computer Programming* Vol. 3 | 9780201896855 | 排序与检索 |
| *Elements of Information Theory* 2nd（Cover & Thomas） | 9780471241959 | 熵/熵率/LZ 编码定理 |
| *Convex Optimization*（Boyd & Vandenberghe） | 9780521833783 | 调度/优化的硕博延伸 |
| *Kafka: The Definitive Guide* | 9781491936160 | Kafka 架构速览 |
| *Learning Spark* 2nd（Damji 等，Databricks） | 9781492050049 | Spark Shuffle/CBO 实战 |
| *Streaming Systems*（Akidau 等，Beam/Flink 语义） | 9781491983874 | Watermark/窗口/精确一次 |
| *Redis in Action*（Carlson, Manning） | 9781617290855 | SortedSet 跳表/HLL 的实现语境 |
| *Understanding Compression*（Collet & Sison-Liu） | 9781449362423 | LZ4/Zstd 生态的压缩原理 |
| *Systems Performance* 2nd（Gregg, Addison-Wesley） | 9780136820154 | 磁盘/内存 I/O 成本与系统观测 |

---

## 7. 三个最重要的"数学升级点"与最短学习闭环

**如果只能补三块数学，选这三块**（覆盖率最高）：

1. **概率论 + 随机分析**（本科→硕博）：跳表、布隆、HLL、CMS、Gossip、Raft 随机化全靠它。
2. **组合与离散数学**：B⁺ 树、一致性哈希、Quorum、CRDT 格论、Merkle 树。
3. **线性代数与有限域**：纠删码、CRC、哈希设计。

**最短学习闭环（4 周）**：

- Week 1：概率论基础 → 手写跳表与布隆过滤器，复现错判率/期望公式。
- Week 2：读 Raft 论文 + etcd 源码，画出"多数派→鸽笼→安全性"的数学链。
- Week 3：有限域 GF(2⁸) → 自己在 Python 里实现 RS(10,4) 编码与修复。
- Week 4：HyperLogLog 推导（均值/含偏置修正）→ 对比 Redis `PFCOUNT` 实测误差。
- 全程对照 `third_party/math/中间件与大数据算法数学基础.md`（含硕博级课程索引与自测题）。

> 记住：中间件的"数学难"不在深，而在**随手要用**——把"复杂度、概率、域代数"变成肌肉记忆，读任何开源代码都能一眼看穿它的性能假设。
