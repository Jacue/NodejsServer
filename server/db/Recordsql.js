var RecordSQL = {
    insert: "INSERT INTO Record(rid,userName,schoolName,createTime) VALUES(0,?,?,?)",
    queryAll: "SELECT * FROM Record ORDER BY createTime ASC",
    queryOne: "SELECT * FROM Record WHERE rid = ?",
    delete: "DELETE FROM Record WHERE rid = ?",
  };
  module.exports = RecordSQL;
     