const express = require("express");
const db = require("./db");
const app = express();
const path = require("path");

app.use(express.static("public"));
app.use(express.json());

app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "Product_management.html"));
});

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

//수정
app.post("/retouch_goods", async (req, res) => {
  const { num, name, category, price, barcode, stock } = req.body;
  console.log(num, name, category, price, barcode, stock);
  const qry = `
    UPDATE goods 
    SET name=:name, category=:category, price=:price, barcode=:barcode, stock=:stock
    WHERE num=:num
  `;

  try {
    const connection = await db.getConnection();
    const result = await connection.execute(qry, {
      num,
      name,
      category,
      price,
      barcode,
      stock,
    });
    await connection.commit();

    res.json({ success: true });
  } catch (err) {
    console.log(err);
    res.json({ success: false, error: err.message });
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
//상품 삭제
app.post("/delete_goods", async (req, res) => {
  const { num } = req.body;

  const qry = `delete from goods
              where num = :num`;
  try {
    const connection = await db.getConnection();
    const result = await connection.execute(qry, [num]);
    console.log(result);
    connection.commit();
    res.json({ num });
  } catch (err) {
    console.log(err);
    res.json({ retCode: "NG", retMsg: "에러" });
  }
});

app.listen(3000, () => {
  console.log("server 실행. http://localhost:3000");
});
