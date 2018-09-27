var UserSQL = {
  insert: "INSERT INTO User(uid,userName,schoolName,createTime) VALUES(0,?,?,?)",
  queryAll: "SELECT * FROM User ORDER BY createTime DESC",
  delete: "DELETE FROM User WHERE uid = ?"
};
module.exports = UserSQL;
