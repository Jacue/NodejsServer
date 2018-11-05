var UsersSQL = {
  insert: "INSERT INTO Users(userName,password,createTime) VALUES(?,?,?)",
  queryAll: "SELECT * FROM Users ORDER BY createTime ASC",
  queryOne: "SELECT * FROM Users WHERE userName = ?",
  checkLogin: "SELECT * FROM Users WHERE userName = ? AND password = ?",
  delete: "DELETE FROM Users WHERE uid = ?",
};
module.exports = UsersSQL;
   