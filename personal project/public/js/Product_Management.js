//모달
function addition() {
  document.querySelector(".modal").style.display = "block";
  document.querySelector(".modal-overlay").style.display = "block";
}

function main() {
  document.querySelector(".modal").style.display = "none";
  document.querySelector(".modal-overlay").style.display = "none";
  location.reload(true);
}

function retouch() {
  document.querySelector(".modal2").style.display = "block";
  document.querySelector(".modal-overlay2").style.display = "block";
}

function close() {
  document.querySelector(".modal2").style.display = "none";
  document.querySelector(".modal-overlay2").style.display = "none";
  location.reload(true);
}
//화면에 테이블 출력
fetch("goods")
  .then((response) => {
    return response.json();
  })
  .then((result) => {
    console.log(result);
    result.forEach((elem) => {
      const insertHtml = `<tr>
              <td>${elem.NUM}</td>
              <td>${elem.NAME}</td>
              <td>${elem.CATEGORY}</td>
              <td>${elem.PRICE}</td>
              <td>${elem.BARCODE}</td>
              <td>${elem.STOCK}</td>
              <td>
                <div class="btn-group">
                  <button onclick="retouch()" class="btn btn-secondary">수정</button>
                  <button class="btn btn-danger">삭제</button>
                </div>
              </td>
            </tr>`;
      const subject = document.querySelector("tbody");
      subject.insertAdjacentHTML("beforeend", insertHtml);
    });
  })
  .catch((err) => {
    console.log(err);
  });

//상품 추가
document.querySelector("form.addition").addEventListener("submit", (e) => {
  e.preventDefault();
  const num = document.querySelector("#num").value;
  const name = document.querySelector("#name").value;
  const category = document.querySelector("#category").value;
  const price = document.querySelector("#price").value;
  const barcode = document.querySelector("#barcode").value;
  const stock = document.querySelector("#stock").value;

  if (!num || !name || !category || !price || !barcode || !stock) {
    alert("필수값 입력");
    return;
  }

  const data = { num, name, category, price, barcode, stock };

  fetch("./add_goods", {
    method: "post",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  })
    .then((data) => {
      return data.json();
    })
    .then((result) => {
      console.log(result);
      const insertHtml = `<tr>
              <td>${result.num}</td>
              <td>${result.name}</td>
              <td>${result.category}</td>
              <td>${result.price}</td>
              <td>${result.barcode}</td>
              <td>${result.stock}</td>
              <td>
                <div class="btn-group">
                  <button onclick="retouch()" class="btn btn-secondary">수정</button>
                  <button class="btn btn-danger">삭제</button>
                </div>
              </td>
            </tr>`;
      const subject = document.querySelector("tbody");
      subject.insertAdjacentHTML("beforeend", insertHtml);
    })
    .catch((err) => {
      console.log(err);
    });
});
//상품 수정
fetch("./retouch_goods")
  .then((response) => {
    return response.json();
  })
  .then((result) => {
    console.log(result);
    result.forEach((elem) => {
      const insertHtml = `<tr>
              <td>${elem.NUM}</td>
              <td>${elem.NAME}</td>
              <td>${elem.CATEGORY}</td>
              <td>${elem.PRICE}</td>
              <td>${elem.BARCODE}</td>
              <td>${elem.STOCK}</td>
              <td>
                <div class="btn-group">
                  <button onclick="retouch()" class="btn btn-secondary">수정</button>
                  <button class="btn btn-danger">삭제</button>
                </div>
              </td>
            </tr>`;
      const subject = document.querySelector("tbody");
      subject.insertAdjacentHTML("beforeend", insertHtml);
    });
  })
  .catch((err) => {
    console.log(err);
  });
