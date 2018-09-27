var UserSQL = {
  insert: "INSERT INTO User(uid,userName,schoolName) VALUES(0,?,?)",
  queryAll: "SELECT * FROM User",
  getUserById: "SELECT * FROM User WHERE uid = ? "
};
module.exports = UserSQL;
