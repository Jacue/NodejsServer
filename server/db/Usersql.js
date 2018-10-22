var UserSQL = {
  insert: "INSERT INTO User(uid,userName,schoolName,createTime,sortIndex) VALUES(0,?,?,?,?)",
  queryAll: "SELECT * FROM User ORDER BY sortIndex ASC",
  queryOne: "SELECT * FROM User WHERE uid = ?",
  delete: "DELETE FROM User WHERE uid = ?",
  exchange: "UPDATE User SET sortIndex = ? where uid = ?",
};
module.exports = UserSQL;
   