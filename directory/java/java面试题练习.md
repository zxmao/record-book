#### 1 有一个List<Person>，Person有id/name/age/city等属性
     
    现在需要按照年龄的从小到大排序，请问应该如何处理

     答:personList.stream.sorted(Comparator.comparing(Person::getAge))

     请描述下outputstream和writer的区别

     答:区别在于outputstream为字符输出流,直接操作byte[],Writer为字节输出流,在操作字节流的时候回进行encoding和decode,可能会出现编码问题.

     请描述下equals和hashcode的作用.什么情况下我们需要实现这两个接口

     答: equals 主要用于对象之间的比较,hashcode所返回的是一个指向系统内存存储位置的整数,在hashSet和hashMap实现中,他们都是通过key的hash值进行唯一判断,进行操作.
         编写继承Object类的时候,需要实现这两个方法.

     请描述下java中有哪些集合对象。

     答:Collection,Array,List,Set,Map

     static这个关键字是用在什么地方?作用是什么？

     答:static用在类,变量,方法上,作用是在类加载的时候执行一次,以后将不再执行.

     JDK中有哪些常用的接口？他们的作用是什么？

     答:Iterable迭代器接口,提供了集合的遍历方法.
        Runnable多线程接口,提供了多线程运行方法run().

     请提供下你熟悉、使用过的第三方jar包（spring除外）

     org.apache.commons.commons-lang
     org.apache.commons.commons-lang3
     com.google.guava.guava
     org.projectlombok.lombok
     org.mapstruct.mapstruct

     请实现一个单例
     答:
         public class Singleton{
             private Singleton(){};
             private static Singleton instance;
             public synchronized static newInstance(){
             if(instance == null){
                return new Singleton();
            }}}


     # spring
     有个对象，需要系统启动后初始化一些数据，可以怎么实现？

     @Bean
     public void init() {
        //初始数据...
     }

     spring中有哪些常用的annotation？作用是什么？

     答:
        @Autowrite
        @Inject
        @Resource 自动注入

        @Component
        @RestController
        @Controller
        @Service
        @Repository 自动扫描

        @RequestMapping
        @RequestBody
        @ResponseBody
        @Param
        @PathValite

     spring中annotation是如何实现的？机制是什么?

       答: 基于context:annotation-config启动,机制是基于 java 反射技术.

     除了spring-framework，你还使用过其他的spring框架？

        spring Web
        spring mvc
        spring Data Jpa
        spring Boot

     说明下spring boot的机制

       答: spring boot 扩展了jar协议,抽象了Archive概念,实现了约定优于配置,上层应用无感知的开发体验.

     # 数据映射
     如果数据库中amount字段，保存了0.0000001数据，请问对应的java对象需要使用什么？
        Double

     乐观锁和悲观锁有什么区别？分别如何实现？

        悲观锁:数据库中的表锁,行锁,读锁,写锁.都是基于乐观锁实现.
        乐观锁:在做数据更新的时候进行数据判断,使用版本号机制实现.

     enum保存到数据库对应的是什么数据类型？
        enum数据类型

     # 数据库
     有一个表Person，有id/name/age/city
     现在需要查询每个city人数，请提供相关的sql

        SELECT count(id),city
        FROM person
        GROUP BY city

     需要按照age从小到大，查询排名100-200的用户
        select *
        from person
        order by age asc
        limit 99,100;

     请问左连接、右链接有什么区别

     数据库中有哪些常用的字段，请说明下
        int 整数类型
        double

     # linux
     请提供常用的linux命令
     
     ls 文件目录
     ll 文件目录
     cd 进入文件夹
     mkdir 创建文件夹
     touch 创建文件
     rm 删除
     mv 移动
     cp copy
     find 查找文件
     pwd 当前路径
      
     请说明linux中管道的概念并举例
     
     将一个命令的标准输出作为另一个命令的标准输入。也就是把几个命令组合起来使用，后一个命令除以前一个命令的结果。
     例：grep -r "close" /home/* | more       在home目录下所有文件中查找，包括close的文件，并分页输出。
     
     现在需要查看1.log的最后100行，请问如何操作
     
     tail -100 1.log
     
     linux中744是什么意思
     
     权限分为三种：读（r=4），写（w=2），执行（x=1）。综合起来还有可读可执行（rx=5=4+1）、可读可写（rw=6=4+2）、可读可写可执行(rwx=7=4+2+1)。
     
     1.文件所有者可读可写可执行
     2.与文件所有者同属一个用户组的其他用户可读
     3.其它用户组可读
     
     如何从一台linux将文件复制到另外一个linux
     
     scp local_file remote_username@remote_ip:remote_folder  

     # 其他
     请描述下war的目录结构
     请描述下你的日常工作的流水（早上上班到下午下班）
     你们的代码管理用的是什么？发布流程是怎么样的？
     如何写单元测试的？
     有哪些jar包比较熟悉
