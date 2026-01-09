const oracledb = require("oracledb");
oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;

const dbConfig = {
  user: "scott",
  password: "tiger",
  connectString: "192.168.0.23:1521/xe",
};

async function getConnection() {
  try {
    const connection = await oracledb.getConnection(dbConfig);
    return connection; //연결(session)을 반환
  } catch (err) {
    return err; //에러를 반환
  }
}

async function execute() {
  //session 획득
  const qry = `insert into goods(num,name,Category,price,barcode,stock)
              values('상품번호','상품명','카테고리',10000,999888777666,10')`;
  try {
    const connection = await oracledb.getConnection(dbConfig);
    const result = await connection.execute(qry);
    connection.commit(); //커밋
    console.log("db 등록 성공");
    console.log(result);
  } catch (err) {
    console.log(`예외발생 => ${err}`);
  }
}

module.exports = { getConnection, execute };
