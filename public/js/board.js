//fetch를 통해서 게시글 데이터 가져오기
fetch("boards")
  .then((response) => {
    return response.json();
  })
  .then((result) => {
    //반복처리
    result.forEach((elem) => {
      //console.log(result);
      // tbody subject
      const insertHtml = `<tr>
      <td>${elem.BOARD_NO}</td>
      <td class="title">${elem.TITLE}</td>
      <td>${elem.WRITER}</td>
      <td>${new Date(elem.WRITE_DATE).toLocaleString()}</td>
      <td><button onclick='deleteRow(${
        elem.BOARD_NO
      })' class="delete">삭제</button>
      </tr>`;
      const subject = document.querySelector("tbody");
      subject.insertAdjacentHTML("beforeend", insertHtml);
    }); //end of forEach.
  })
  .catch((err) => {
    console.log(err);
  });

//form에다가 submit 이벤트 등록
document.querySelector("form").addEventListener("submit", (e) => {
  e.preventDefault();
  const board_no = document.querySelector("#postNo").value;
  const title = document.querySelector("#title").value;
  const content = document.querySelector("#content").value;
  const writer = document.querySelector("#writer").value;
  //입력값 체크
  if (!board_no || !title || !content || !writer) {
    alert("필수값 입력");
    return;
  }
  const data = { board_no, title, content, writer };
  // post요청
  // 1. url
  // 2. option object
  fetch("./add_board", {
    method: "post",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  })
    .then((data) => {
      return data.json();
    }) //fetch() 실행이 성공하면...
    .then((result) => {
      console.log(result);
      const insertHtml = `<tr>
        <td>${result.board_no}</td>
        <td class="title">${result.title}</td>
        <td>${result.writer}</td>
        <td>${new Date().toLocaleString()}</td>
        <td><button onclick='deleteRow(${
          result.board_no
        })' class="delete">삭제</button>
        </tr>`;
      const subject = document.querySelector("tbody");
      subject.insertAdjacentHTML("beforeend", insertHtml);

      // if (result == "처리완료") {
      //   alert("성공");
      // } else if (result == "에러") {
      //   alert("실패");
      // }
    })
    .catch((err) => {
      console.log(err);
    }); //fetch() 실행이 에러이면...
});

//글 삭제
function deleteRow(bno) {
  fetch("remove_board/" + bno).then((bno) => {
    console.log(bno);
  });
}

function clean() {
  document.querySelector("button.submit").addEventListener("click", (e) => {
    document.querySelector("#postNo").value = "";
    document.querySelector("#title").value = "";
    document.querySelector("#content").value = "";
    document.querySelector("#writer").value = "";
  });
}
