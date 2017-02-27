    * 适用于 ToOne 关系
    * 在对集合使用时需要注意一般数据库 Select 会比 Join 更快
  * SELECT
    * 集合的默认获取方式,避免笛卡尔乘积
    * 需要注意 N+1 问题, 每个集合元素都获取一次
  * BATCH - @Fetch(FetchMode.SELECT) @BatchSize(size = 10)
    * 在访问一个元素时即加载多个元素
    * 批量加载数量可配置
    * 批量加载数量有多种算法来判断
  * SUBSELLECT
    * 当访问集合中的某个元素时加载整个集合
    * 性能取决于数据库
  * PROFILE
    * 可通过指定多个配置在实际使用时使用不同的策略

### 一级缓存 vs 二级缓存
* 一级缓存
  * Session 级别缓存
  * 在同一个事务中
  * 事务之间不会共享缓存数据
  * 事务结束时缓存即被清理
* 二级缓存
  * SessionFactory 级别缓存即 JVM 级别缓存
  * 所有的会话都会共享缓存
  * 事务完成后缓存依然存在

### 2LC - 二级缓存
* 默认不启用
  * 可打开全局的二级缓存,sharedMode ALL
  * 可针对单个实体和集合进行缓存
  * 可在会话级别控制缓存模式
* 可缓存所有属性(默认)或非懒加载属性

__二级缓存的并发策略__

CacheConcurrencyStrategy | 说明
----|----
NONE | 不使用任何并发策略
READ_ONLY | 最简单和最优的
NONSTRICT_READ_WRITE| 如果更新较少且不易碰撞,事务隔离不强
READ_WRITE | 支持更新,在使用串行事务级别时不应该使用
TRANSACTIONAL| 需要支持事务的缓存,需要 JTA



* [Hibernate ORM: Tips, Tricks, and Performance Techniques](http://www.slideshare.net/brmeyer/hibernate-orm-performance-31550150)
* [数据获取和缓存优化](http://what-when-how.com/hibernate/optimizing-fetching-and-caching-hibernate/)


## Hibernate 更新操作

PreUpdate 只有在修改实体时才会触发,如果使用 Hibernate 的 EXTRA LAZY, 往 Collection 中插入时时不会触发原实体的,因此 PreUpdate 在修改部分 Collection 的时候不会被触发.

Version 字段只有在自己所持有熟悉和自己所持有的关系被修改时才会更新 Version, 更新 Version 时也会触发 PreUpdate 修改.

在 Hibernate 中可强制使用 `OptimisticLock` 使得在更新集合时也触发 Version 的修改,因此也可以强制触发 PreUpdate 事件.
