package com.Spark_DW

import com.Constants.Constan
import com.SparkUtils.JDBCUtils
import com.config.ConfigManager
import org.apache.spark.sql.SaveMode
import org.apache.spark.sql.hive.HiveContext
import org.apache.spark.{SparkConf, SparkContext}
import parquet.org.slf4j.LoggerFactory

object DWD_USER_VISIT {
  def main(args: Array[String]): Unit = {
    val conf = new SparkConf().setAppName(Constan.SPARK_APP_NAME_USER).setMaster(Constan.SPARK_LOCAL)
    val sc  = new SparkContext(conf)
    val hiveContext = new HiveContext(sc)

    // 加载相应的语句
    val sql = ConfigManager.getProper(args(0))
    if (sql == null) {
      LoggerFactory.getLogger("SparkLogger").debug("你提交的表名参数有问题，请重新设置！")
    }else {
//      // 处理sql内部的占位符
//      val finalSql = sql.replace("?",args(1))
      // 运行sql
      val df = hiveContext.sql(sql)
      // 处理配置参数
      val mysqlTableName = args(0).split("\\.")(1)
      val hiveTableName = args(0)
      val jdbcProp = JDBCUtils.getJDBCProp()._1
      val jdbcUrl = JDBCUtils.getJDBCProp()._2
      // 将数据出入mysql中
//      df.write.mode("overwrite").jdbc(jdbcUrl,mysqlTableName,jdbcProp)
      // 将数据存入hive中
      df.write.mode(SaveMode.Overwrite).insertInto(hiveTableName)
    }
  }
}
