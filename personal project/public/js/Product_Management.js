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
                  <button onclick="deleteRow(this)" class="btn btn-danger">삭제</button>
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
    alert("값을 입력해주세요");
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
                  <button onclick="deleteRow(this)" class="btn btn-danger">삭제</button>
                </div>
              </td>
            </tr>`;
      const subject = document.querySelector("tbody");
      subject.insertAdjacentHTML("beforeend", insertHtml);
      alert("등록이 완료되었습니다");
      document.querySelector("#num").value = "";
      document.querySelector("#name").value = "";
      document.querySelector("#price").value = "";
      document.querySelector("#barcode").value = "";
      document.querySelector("#stock").value = "";
    })
    .catch((err) => {
      console.log(err);
    });
});
//상품 수정
document.addEventListener("DOMContentLoaded", () => {
  const tbody = document.querySelector("tbody");
  const modal = document.querySelector(".modal2");
  const overlay = document.querySelector(".modal-overlay2");

  // 테이블 버튼 클릭 (Event Delegation)
  tbody.addEventListener("click", (e) => {
    if (!e.target.classList.contains("btn-secondary")) return;

    const row = e.target.closest("tr");

    // row 데이터 가져오기
    const num = parseInt(row.cells[0].textContent);
    const name = row.cells[1].textContent;
    const category = row.cells[2].textContent;
    const price = parseFloat(row.cells[3].textContent);
    const barcode = row.cells[4].textContent;
    const stock = parseInt(row.cells[5].textContent);

    // 모달 열기
    modal.style.display = "block";
    overlay.style.display = "block";

    // 모달 input 채우기
    modal.querySelector("#num2").value = num;
    modal.querySelector("#name2").value = name;
    modal.querySelector("#category2").value = category;
    modal.querySelector("#price2").value = price;
    modal.querySelector("#barcode2").value = barcode;
    modal.querySelector("#stock2").value = stock;
  });
});

document.querySelector("form.retouch").addEventListener("submit", (e) => {
  e.preventDefault();

  const modal = document.querySelector(".modal2");
  const overlay = document.querySelector(".modal-overlay2");

  const num = document.querySelector("#num2").value;
  const name = document.querySelector("#name2").value;
  const category = document.querySelector("#category2").value;
  const price = document.querySelector("#price2").value;
  const barcode = document.querySelector("#barcode2").value;
  const stock = document.querySelector("#stock2").value;
  console.log(num, name, category, price, barcode, stock);
  //입력값 체크
  // if (!num || !name || !category || !price || !barcode || !stock) {
  //   alert("필수값 입력");
  //   return;
  // }
  const data = { num, name, category, price, barcode, stock };
  // post요청
  // 1. url
  // 2. option object
  fetch("./retouch_goods", {
    method: "post",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  })
    .then((data) => {
      return data.json();
    }) //fetch() 실행이 성공하면...
    .then((result) => {
      console.log(result);
      if (result.success) {
        modal.style.display = "none";
        overlay.style.display = "none";
        alert("수정이 완료되었습니다.");
        location.reload();
        console.log(result);
      }
    })
    .catch((err) => {
      console.log(err);
    }); //fetch() 실행이 에러이면...
});

//상품 검색
const search = document.getElementById("search");
const tablebody = document.getElementById("aaa");
const searchbutton = document.getElementById("searchbtn");

searchbutton.addEventListener("click", (e) => {
  const keyword = search.value.trim().toLowerCase();
  const rows = tablebody.querySelectorAll("tr"); // tbody 안 tr이면 더 안전

  rows.forEach((row) => {
    // td가 2개 이상 있는지 확인
    if (row.cells.length > 1) {
      const productName = row.cells[1].textContent.toLowerCase();
      row.style.display = productName.includes(keyword) ? "" : "none";
    }
  });
});
//상품 삭제
function deleteRow(button) {
  const row = button.closest("tr");
  const num = row.children[0].textContent;
  console.log(`삭제 = ${num}`);

  fetch("/delete_goods", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ num }),
  })
    .then((res) => res.json())
    .then((result) => {
      alert("삭제가 완료되었습니다.");
      location.reload();
    });
}

//드롭다운
const filter = document.getElementById("ctgr");
const table = document.getElementById("table");
const tbody = table.querySelector("tbody");

filter.addEventListener("change", () => {
  const select = event.target.value.trim();

  for (let row of tbody.rows) {
    const category = row.cells[2].textContent.trim();
    console.log(select);
    if (select == "전체" || category === select) {
      row.style.display = "";
    } else {
      row.style.display = "none";
    }
  }
});
