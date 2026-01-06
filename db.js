const oracledb = require("oracledb"); //외부에서 당겨옴
//조회된 데이터 => 객체방식
oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;

const dbConfig = {
  user: "scott",
  password: "tiger",
  connectString: "192.168.0.23:1521/xe",
};

//db접속하기 위한 session을 얻어 오는 함수
async function getConnection() {
  try {
    const connection = await oracledb.getConnection(dbConfig);
    return connection; //연결(session)을 반환
  } catch (err) {
    return err; //에러를 반환
  }
}

//비동기 처리 -> 동기방식 처리
async function execute() {
  //session 획득
  const qry = `insert into board(board_no,title,content,writer)
              values(5,'db입력','연습중입니다.','user01')`;
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
// end of execute().

//execute();

//외부 js 파일에서 사용할 수 있도록 익스포트
module.exports = { getConnection, execute };
