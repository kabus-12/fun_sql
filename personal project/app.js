const express = require("express");
const db = require("./db");
const app = express();

app.use(express.static("public"));
app.use(express.json());

//화면 출력
app.get("/goods", async (req, res) => {
  const qry = "select * from goods order by 1";
  try {
    const connection = await db.getConnection();
    const result = await connection.execute(qry);
    console.log(result);
    res.send(result.rows);
  } catch (err) {
    console.log(err);
    res.send("실패");
  }
});

app.get("/retouch_goods", async (req, res) => {
  console.log(req.body);
  const { num, name, category, price, barcode, stock } = req.body;
  const qry =
    "update goods set num=:num,name=:name,category=:category,price=:price,barcode=:barcode,stock=:stock";
  try {
    const connection = await db.getConnection();
    const result = await connection.execute(qry, [
      num,
      name,
      category,
      price,
      barcode,
      stock,
    ]);
    console.log(result);
    res.send(result.rows);
  } catch (err) {
    console.log(err);
    res.send("실패");
  }
});

//입력시 테이블에 추가
app.post("/add_goods", async (req, res) => {
  console.log(req.body);
  const { num, name, category, price, barcode, stock } = req.body;

  const qry = `insert into goods
              values(:num,:name,:category,:price,:barcode,:stock)`;
  try {
    const connection = await db.getConnection();
    const result = await connection.execute(qry, [
      num,
      name,
      category,
      price,
      barcode,
      stock,
    ]);
    console.log(result);
    connection.commit();
    res.json({ num, name, category, price, barcode, stock });
  } catch (err) {
    console.log(err);
    res.json({ retCode: "NG", retMsg: "에러" });
  }
});

app.listen(4000, () => {
  console.log("server 실행. http://localhost:4000");
});
