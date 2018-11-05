var express = require("express");
var router = express.Router();

// 导入MySQL模块
var mysql = require("mysql");
var dbConfig = require("../db/DBConfig");
var usersSQL = require("../db/Usersql");
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
  sqlOperation(usersSQL.queryAll, null, function(result, err) {
    responseJSON(res, result);
  });
});

// 添加用户
router.post("/addRecord", function(req, res, next) {
  var param = req.body;
  var moment = require("moment");
  var nowDate = moment().format("YYYY-MM-DD HH:mm:ss");
  sqlOperation(
    usersSQL.insert,
    [param.userName, param.schoolName, nowDate],
    function(result, err) {
      responseJSON(res, result);
    }
  );
});

router.delete("/deleteRecord", function(req, res, next) {
  var param = req.query;
  sqlOperation(usersSQL.delete, [param.uid], function(result, err) {
    responseJSON(res, result);
  });
});

router.post("/register", function(req, res, next) {
  var param = req.query;
  sqlOperation(usersSQL.queryOne, [param.userName], function(result) {
    if (result.data.length > 0){
      result = {
        code: 200,
        msg: "帐号已存在，请直接登录",
        data: null
      };
      responseJSON(res, result);
    } else {
      var moment = require("moment");
      var nowDate = moment().format("YYYY-MM-DD HH:mm:ss");
      sqlOperation(
        usersSQL.insert,
        [param.userName, param.password, nowDate],
        function(result, err) {
          if (!err) {  
            sqlOperation(usersSQL.queryOne, [param.userName], function(result) {
              if (result.data.length > 0) {
                var retUser = result.data[0];
                result = {
                  code: 200,
                  msg: "注册成功",
                  data: retUser
                };
                responseJSON(res, result);  
              }
            });
          }
        }
      );
    }
  });
});

router.post("/login", function(req, res, next) {
  var param = req.query;
  sqlOperation(usersSQL.checkLogin, [param.userName, param.password], function(result) {
    if (result.data.length === 0){
      result = {
        code: 200,
        msg: "帐号不存在，请先注册",
        data: null
      };
      responseJSON(res, result);
    } else {
      if (result.data.length > 0) {
        var retUser = result.data[0];
        result = {
          code: 200,
          msg: "登录成功",
          data: retUser
        };
        responseJSON(res, result);  
      }
    }
  });
});

module.exports = router;
