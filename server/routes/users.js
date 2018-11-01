
var express = require("express");
var router = express.Router();

// 导入MySQL模块
var mysql = require("mysql");
var dbConfig = require("../db/DBConfig");
var userSQL = require("../db/Usersql");
// 使用DBConfig.js的配置信息创建一个MySQL连接池
var pool = mysql.createPool(dbConfig.mysql);
// 响应一个JSON数据
var responseJSON = function(res, ret) {
  if (typeof ret === "undefined") {
    res.json({
      code: "-200",
      msg: "操作失败"
    });
  } else {
    res.json(ret);
  }
};

var sqlOperation = function(queryString, paramArr, finishBlock) {
  // 从连接池获取连接
  pool.getConnection(function(err, connection) {
    // 建立连接 增加一个用户信息
    connection.query(queryString, paramArr, function(err, result) {
      if (result) {
        result = {
          code: 200,
          msg: "操作成功",
          data: result
        };
      }
      // 以json形式，把操作结果返回给前台页面
      if (finishBlock != null && finishBlock != undefined) {
        finishBlock(result, err);
      }
      // 释放连接
      connection.release();
    });
  });
};

// 获取所有用户信息
router.get("/allRecords", function(req, res, next) {
  sqlOperation(userSQL.queryAll, null, function(result, err){
    // 以json形式，把操作结果返回给前台页面
    responseJSON(res, result);
  })
});

// 添加用户
router.post("/addRecord", function(req, res, next) {

  sqlOperation(userSQL.queryAll, null, function(result){
    // 以json形式，把操作结果返回给前台页面
    var param = req.body;
    var moment = require('moment');
    var nowDate = moment().format('YYYY-MM-DD HH:mm:ss');
    sqlOperation(userSQL.insert, [param.userName, param.schoolName, nowDate], function(result, err){
      // 以json形式，把操作结果返回给前台页面
      responseJSON(res, result);
    })
  })

});

router.delete("/deleteRecord", function(req, res, next) {
  var param = req.query;
  sqlOperation(userSQL.delete, [param.uid], function(result, err){
    // 以json形式，把操作结果返回给前台页面
    responseJSON(res, result);
  })
});

module.exports = router;
