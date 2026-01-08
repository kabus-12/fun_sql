//express 서버모듈.
const express = require("express"); //모듈 임포트
const db = require("./db");
const app = express(); //인스턴스 생성

app.use(express.static("public"));
app.use(express.json());

// URL주소 - 실행함수 => 라우팅
// "/"
app.get("/", (req, res) => {
  res.send("/ 안형주 홈에 오신걸 환영합니다.");
});
//댓글 삭제
//요청방식(get)- '/remove_board/:borad_no'
//반환되는 결과({retCode:'ok' or 'NG' })
app.get("/remove_boards/:borad_no", async (req, res) => {
  const borad_no = req.params.borad_no;
  const qry = `delete from board where board_no = ${borad_no}`;
  try {
    const connection = await db.getConnection();
    const result = await connection.execute(qry);
    connection.commit();
    console.log(result);
    res.json({ retCode: "OK", retMsg: "ok" });
  } catch (err) {
    console.log(err);
    res.json({ retCode: "NG", retMsg: "DB에러" });
  }
});

//댓글 전체 목록을 반환
app.get("/boards", async (req, res) => {
  const qry = "select * from board order by 1";
  try {
    const connection = await db.getConnection();
    const result = await connection.execute(qry);
    console.log(result);
    res.send(result.rows);
  } catch (err) {
    console.log(err);
    res.send("실패"); //웹브라우저에 결과 전송
  }
});

// 요청방식 get vs post
// get : 단순조회.
//post : 많은 양의 전달
app.post("/add_board", async (req, res) => {
  console.log(req.body);
  //{board_no:10,title:'test',content:'sample',writer:'user01'}
  const { board_no, title, content, writer } = req.body;

  const qry = `insert into board(board_no,title,content,writer)
               values(:board_no, :title, :content,:writer)`;
  try {
    const connection = await db.getConnection();
    const result = await connection.execute(qry, [
      board_no,
      title,
      content,
      writer,
    ]);
    console.log(result);
    connection.commit();
    //res.send("처리완료"); //서버 ->클라이언트
    res.json({ board_no, title, content, writer });
  } catch (err) {
    console.log(err);
    //res.send("에러");
    res.json({ retCode: "NG", retMsg: "DB에러" });
  }
});

// "/customer"
/*
app.get("/customer", (req, res) => {
  res.send("/customer 경로가 호출됨.");
});

app.get("/product", (req, res) => {
  res.send("/product 경로가 호출됨.");
});
*/
// "/student" -> 화면에 출력
app.get("/student/:studno", async (req, res) => {
  console.log(req.params.studno);
  const studno = req.params.studno;
  const qry = "select * from student where studno =" + studno;
  const connection = await db.getConnection();
  const result = await connection.execute(qry);
  res.send(result.rows); // 반환되는 결과값에서 rows 속성의 결과값만 출력;
});

// '/'employee' -> 사원목록을 출력하는 라우팅
app.get("/employee/:empno", async (req, res) => {
  console.log(req.params.empno);
  const empno = req.params.empno;
  const qry = "select * from emp where empno = " + empno;
  const connection = await db.getConnection();
  const result = await connection.execute(qry);
  res.send(result.rows);
});

//서버 실행
app.listen(3000, () => {
  console.log("server 실행. http://localhost:3000");
});

//집가서 node.js를 윈도우버전으로 다운로드
//d:dev:fun_sql폴더로 cmd를 통해 들어가 npm install을 하면 오늘 배울때 install받은 파일들을 다운받을수 있다.
