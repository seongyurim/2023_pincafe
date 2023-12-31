<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
      content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>Content</title>
    <script type="text/javascript"
      src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ue7v6d1q9l&submodules=geocoder"></script>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ue7v6d1q9l"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Vendor CSS Files -->
    <link href="../assets/vendor/aos/aos.css" rel="stylesheet">
    <link href="../assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="../assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link rel="stylesheet" href="../assets/css/style.css">

    <link rel="stylesheet" href="../css/reset.css">
    <link rel="stylesheet" href="../css/index.css">
    <link rel="stylesheet" href="../css/readContent.css">
  </head>

  <body>

    <!-- 내비게이션 -->
    <%@ include file="../navigation.jsp" %>

      <!-- 다음글/이전글 -->
      <div id="prevNextSet" class="container-sm">
        <div class="nextArea">
          <a href="/bbs/readContent?userId=${nextContent.userId}&seq=${nextContent.seq}" class="links nextLink">
            <span class="contentDetail">다음글</span>
            <span class="nextContentArea">${nextContent.title}</span>
          </a>
        </div>
        <div class="prevArea">
          <a href="/bbs/readContent?userId=${prevContent.userId}&seq=${prevContent.seq}" class="links prevLink">
            <span class="contentDetail">이전글</span>
            <span class="prevContentArea">${prevContent.title}</span>
          </a>
        </div>
      </div>

      <div class="container-sm master_container">
        <div class="mb-3 titleArea">
          <div id="divi">[${vo.divi}]</div>
          <h1 id="txtTitle" name="title">${vo.title}</h1>
          <div class="writerInfo">
            <div class="ImgArea">
              <img class="profileImg" src="/imgs/member/thumbnail/${authorProfileImg}.jpg">
            </div>
            <div class="profileArea">
              <div class="profileAreaUpper">
                <span class="nickname">${authorNickname}</span>
              </div>
              <div class="profileAreaLower">
                <span class="regDate">${vo.regdate}</span>
                <span class="countTxt">조회</span>
                <span class="viewCount">${vo.viewCount}</span>
              </div>
            </div>
            <div class="btnArea">
              <button type="button" id="btnList" class="mybtn btn btn-light btn-sm">목록으로</button>
              <button type="button" id="btnUpdate" class="mybtn btn btn-light btn-sm">수정</button>
              <button type="button" id="btnDelete" class="mybtn btn btn-light btn-sm">삭제</button>
            </div>
          </div>
        </div>

        <div class="mb-3"><img id="postImage" src="/imgs/member/thumbnail/${vo.fileCode}.jpg" alt="Posted Image"></div>
        <div class="mb-3">
          <div class="txtContent" rows="3" name="content" readonly>${vo.content}</div>

          <div class="mapSet">
            <div id="cafeAddress">
              <span><img id="pinImg" src="/images/location.png"></span>
              <span>${vo.address}</span>
            </div>

            <div class="map-container">
              <div id="map"></div>
            </div>
          </div>
        </div>
      </div>

      <div id="comment">
      </div>

      <div id="comment_container" class="container-sm">
        <div class="writeCM">
          <input type="text" id="cmWrite" class="form-control">
          <button type="button" class="mybtn btn btn-light btn-sm" id="btnCM">등록</button>
        </div>

        <div class="comment_wrap">
        </div>
      </div>


      <!-- Template Vendor JS Files -->
      <script src="../assets/vendor/aos/aos.js"></script>
      <script src="../assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
      <script src="../assets/vendor/swiper/swiper-bundle.min.js"></script>
      <script src="../assets/vendor/php-email-form/validate.js"></script>

      <!-- Template Main JS File -->
      <script src="../assets/js/main.js"></script>

      <script src="/JS/jquery-3.7.0.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

      <script>

        // 위도, 경도 변수 설정
        let lat = 0;
        let lng = 0;

        let myComment = false;

        let rowCount = 0; // 전체 댓글 건수
        let commentPage = 500; // 댓글페이지

        const profileImg = document.querySelector('#profileImg');
        const welcomeMsg = document.querySelector('#welcomeMsg');
        const btnIntro = document.querySelector('#btnIntro');
        const btnBBS = document.querySelector('#btnBBS');
        const btnLogin = document.querySelector('#btnLogin');
        const btnJoin = document.querySelector('#btnJoin');
        const btnInfoUpdate = document.querySelector('#btnInfoUpdate');
        const mydivider = document.querySelector('#mydivider');

        const txtTitle = document.querySelector('#txtTitle');
        const txtContent = document.querySelector('#txtContent');
        const btnList = document.querySelector('#btnList');
        const btnUpdate = document.querySelector('#btnUpdate');
        const btnDelete = document.querySelector('#btnDelete');
        const mapSet = document.querySelector('.mapSet');
        const cafeAddress = document.querySelector('#cafeAddress');

        const postImage = document.querySelector('#postImage');
        const imageContainer = document.querySelector('#imageContainer');

        const prevLink = document.querySelector('.prevLink');
        const nextLink = document.querySelector('.nextLink');
        const prevContentArea = document.querySelector('.prevContentArea');
        const nextContentArea = document.querySelector('.nextContentArea');

        const btnCM = document.querySelector('#btnCM');
        const cmWrite = document.querySelector('#cmWrite');
        // const editButtons = document.querySelectorAll('.editBtn');
        const cmDeleteButtons = document.querySelectorAll('.cmDeleteBtn');

        ////// 함수부 //////////////////////////////////////////////////////////////////

        // 현재 세션이 있는지 없는지 설정해준다.
        const setSessionState = function () {
          if ('${session.userId}' == '') {
            sessionState = false;
          }
          else {
            sessionState = true;
          }
        }

        // 로그인 인포 설정
        const setSessionInfo = function () {
          if (sessionState === true) {
            welcomeMsg.textContent = '${session.name}님 반갑습니다.';
            btnLogin.textContent = 'Sign Out';
            btnJoin.style.display = 'none';
            profileImg.setAttribute('src', '/imgs/member/thumbnail/${session.fileCode}.jpg');
          }
          else {
            welcomeMsg.textContent = '어서오세요! Pincafe입니다.';
            btnLogin.textContent = 'Sign In';
            btnInfoUpdate.style.display = 'none';
            profileImg.style.display = 'none';
            mydivider.style.display = 'none';
          }
        }

        const setNextPrevContent = function () {
          if ('${prevContent.title}' === '') {
            prevContentArea.textContent = '이전글이 없습니다.';
            prevLink.removeAttribute('href');
          }

          if ('${nextContent.title}' === '') {
            nextContentArea.textContent = '다음글이 없습니다.';
            nextLink.removeAttribute('href');
          }
        }

          // 댓글리스트 가져오기
          const setCMbbs = function (page) {
            let requestData = {
              page: page,
              commentPage: commentPage,
              bbsUserId: '${vo.userId}',
              bbsSeq: '${vo.seq}'
            }


            console.log("댓글 데이터 가져오는지 : " + requestData.page);
            console.log("댓글 데이터 가져오는지 : " + requestData.commentPage);

            $.ajax({
              url: '/cm/list',
              type: 'POST',
              // url: '/bbs/readContent',
              // type: 'GET',
              data: requestData,
              success: function (data) {
                rowCount = data.rowCount;
                const commentContainer = document.querySelector('#comment_container .comment_wrap');
                commentContainer.innerHTML = '';

                for (let i = 0; i < data.cmList.length; i++) {
                  // console.log(cmAuthorNicknames);
                  const commentEntry = document.createElement('div');
                  commentEntry.classList.add('comment_entry');

                  commentEntry.innerHTML = `
                    <div class="writerInfo">
                      <div class="ImgArea">
                        <img class="profileImg cmProfileImg" src="/imgs/member/thumbnail/0000.jpg">
                      </div>
                      <div class="profileArea">
                        <div class="profileAreaUpper">
                          <span class="nickname">\${data.cmList[i].cmUserId}</span>
                        </div>
                        <div class="profileAreaLower">
                          <span class="regDate">\${data.cmList[i].cmRegdate}</span>
                        </div>
                      </div>
                      <div class="btnArea">
                        <button type="button" class="mybtn btn btn-light btn-sm" data-cm-id="${data.cmList[i].cmUserId}">수정</button>
                        <button type="button" id="cmDeleteBtn" class="cmDeleteBtn mybtn btn btn-light btn-sm" data-cm-seq="\${data.cmList[i].cmSeq}" data-cm-id="\${data.cmList[i].cmUserId}">삭제</button>
                      </div>
                    </div>
                    <div class="comment_content">\${data.cmList[i].cmContent}</div>
                  `;

                  commentContainer.appendChild(commentEntry);
                }
              }
            });
          };

        // UI Setting
        window.addEventListener('DOMContentLoaded', () => {

          // 이미지를 첨부하지 않았다면 안보이게
          if (!postImage.naturalWidth) {
            postImage.style.display = 'none';
          }

          // 지도를 첨부하지 않았다면 안보이게
          lat = parseFloat('${vo.lat}');
          lng = parseFloat('${vo.lng}');

          if ((lat === 0.0) && (lng === 0.0)) {
            mapSet.style.display = 'none';
          }
          else {
            selectMapList(lat, lng);
          }

          // 댓글 리스트
          setCMbbs(0);
          // setCmUiObject(); // 내 댓글일 경우에만 수정 가능하게
          // checkMyComment(); // 내 댓글이면 myComment => true

          console.log("check")

          // const cmDeleteButtons = document.querySelectorAll('.cmDeleteBtn');
          
          // cmDeleteButtons.forEach(button => {
          //   const cmUserId = button.getAttribute('data-cm-id');
            
          //   if (checkMyComment(cmUserId)) {
          //     button.style.display = 'inline-block'; // 작성자와 세션 일치 시 버튼 표시
          //   } else {
          //     button.style.display = 'none'; // 작성자와 세션 불일치 시 버튼 숨김
          //   }
          // });

          // setCmUiObject(); // 내 댓글일 경우에만 수정 가능하게
        });

        // 지도를 그려주는 함수
        function selectMapList() {
          lat = '${vo.lat}';
          lng = '${vo.lng}';

          let map = new naver.maps.Map('map', {
            center: new naver.maps.LatLng(lat, lng),
            zoom: 16
          });

          let marker = new naver.maps.Marker({
            position: new naver.maps.LatLng(lat, lng),
            map: map
          });

          console.log(lat, lng);
        }

        // 현재 사용자와 게시글 작성자가 동일한지 확인한다.
        const checkMyContent = function () {
          if ('${session.userId}' === '${vo.userId}') {
            myContent = true;
          }
          else {
            // 로그인하지 않은 사용자인 경우(session.userId = '')
            // 로그인한 회원이지만 게시글 작성자와 다른 경우
            myContent = false;
          }
          console.log(myContent);
        }

        // 글 수정 및 삭제버튼 나타내기 여부
        const setUiObject = function () {
          if (myContent == false) {
            btnUpdate.style.display = 'none';
            btnDelete.style.display = 'none';
          }
        }

        // 현재 사용자와 댓글 작성자가 동일한지 확인한다.
        // const checkMyComment = function (userId) {
        //   console.log("checkMyComment실행");
        //    // 현재 사용자와 댓글 작성자가 동일한 경우에만 true
        //    return '${session.userId}' === userId;
        // }

        // cmDeleteButtons.forEach(button => {
        //   // 각 버튼 요소에 대한 처리
        //   const cmUserId = button.getAttribute('data-cm-id');
        //   // 이하 버튼에 대한 처리
        // });

        // // 현재 사용자와 댓글 작성자가 동일한지 확인하는 함수
        // const checkMyComment = function (userId) {
        //   return '${session.userId}' === userId;
        // }

        // // 댓글 수정 및 삭제 버튼 나타내기 여부
        // const setCmUiObject = function () {
        //   const cmDeleteButtons = document.querySelectorAll('.cmDeleteBtn');
        //   console.log("cmDeleteButtons : " + cmDeleteButtons[0]);
          
        //   cmDeleteButtons.forEach(button => {
        //     const cmUserId = button.getAttribute('data-cm-id');
            
        //     if (checkMyComment(cmUserId)) {
        //       button.style.display = 'inline-block'; // 작성자와 세션 일치 시 버튼 표시
        //     } else {
        //       button.style.display = 'none'; // 작성자와 세션 불일치 시 버튼 숨김
        //     }
        //   });
        // };

        // // 댓글 수정 및 삭제버튼 나타내기 여부
        // const setCmUiObject = function () {
        //   console.log("setCmUiObject실행");
        //   const cmDeleteButtons = document.querySelectorAll('.cmDeleteBtn');
        //   console.log("cmDeleteButtons 배열 내용:");
        //   // cmDeleteButtons.forEach(button => {
        //   //   console.log(button);
        //   // });

        //   cmDeleteButtons.forEach(button => {
        //     const cmUserId = button.getAttribute('data-cm-id');
        //     console.log(cmUserId);
        //   });
        //   // console.log("현재 버튼 : ", cmDeleteButtons[0].data-cm-id);
        //   // for (let i = 0; i < cmDeleteButtons.length; i++)
        //   // {
        //   //   if (checkMyComment(cmUserId) === true)
        //   //   {
        //   //     cmDeleteButtons[i].style.display = 'inline-block';
        //   //   }
        //   //   else (checkMyComment(cmUserId) === false)
        //   //   {
        //   //     cmDeleteButtons[i].style.display = 'none';
        //   //   }
        //   // }
        //   // cmDeleteButtons.forEach(()) => {
        //   //   if (comment.cmUserId === '${session.userId}') {
        //   //     // 댓글 작성자와 세션 아이디 일치하는 경우
        //   //     // 수정 및 삭제 버튼을 보이게 처리
        //   //     comment.editButton.style.display = 'inline-block';
        //   //   } else {
        //   //     console.log("댓글 작성자 불일치");
        //   //     // 댓글 작성자와 세션 아이디 불일치하는 경우
        //   //     // 수정 및 삭제 버튼을 숨기게 처리
        //   //     comment.editButton.style.display = 'none';
        //   //   }
        //   };

        // if (checkMyComment(cmUserId) === false) {
        //       console.log("댓글 작성자 불일치");
        //       // 수정 및 삭제 버튼을 숨기는 처리
        //       const editButtons = event.target.closest('.btnArea').querySelectorAll('.mybtn');
        //             editButtons.forEach(button => {
        //               button.style.display = 'none';
        //             });
        //     }

        ////// 이벤트 핸들러 ///////////////////////////////////////////////////////////

        // 로그인 버튼
        btnLogin.addEventListener('click', () => {
          // alert(3);
          if (sessionState === true) { // 로그인한 상태라면
            if (!confirm("정말 로그아웃 하시겠어요?")) {
              return;
            }
            else {
              alert('정상적으로 로그아웃 되었어요.');
              location.href = '/logout';
            }
          }
          else { // 로그인한 상태가 아니라면
            location.href = '/login';
          }
        });

        // 회원가입 버튼
        btnJoin.addEventListener('click', () => {
          location.href = '/join';
        });

        // 정보수정 버튼
        btnInfoUpdate.addEventListener('click', () => {
          location.href = "/infoupdate";
        });

        // 게시판 버튼
        btnBBS.addEventListener('click', () => {
          btnBBS.setAttribute('href', '/bbsmain');
        });

        // 페이지소개 버튼
        btnIntro.addEventListener('click', () => {
          btnIntro.setAttribute('href', '/introduction');
        });

        // 목록으로 버튼
        btnList.addEventListener('click', () => {
          location.href = "/bbsmain";
        });

        // 수정하기 버튼
        btnUpdate.addEventListener('click', () => {
          location.href = "/bbs/updateContent?userId=${vo.userId}&seq=${vo.seq}";
        });

        // 게시글 삭제 버튼
        btnDelete.addEventListener('click', () => {
          let requestData = {
            userId: '${vo.userId}',
            seq: '${vo.seq}',
          };

          if (confirm('삭제된 글은 복구할 수 없습니다.\n정말 삭제하시겠습니까?')) {
            $.ajax({
              url: '/bbs/deleteContent',
              type: 'POST',
              data: requestData,
              success: function (data) {
                if (data == "OK") {
                  alert('게시글이 삭제되었습니다.');
                  location.href = "/bbsmain";
                }
                else {
                  alert('게시글 삭제에 실패했습니다. 다시 시도해주세요.');
                }
              }
            });
          }
        });


        // 댓글달기
        btnCM.addEventListener('click', () => {
          if (sessionState === false)
          {
            if (confirm('로그인 후 이용할 수 있습니다. 로그인하시겠어요?')) 
            {
              location.href = "/login";
            }
          }
          else if (sessionState === true)
          {
            if (cmWrite.value === '') {
              alert("댓글 내용을 작성해주세요.");
            }
  
            console.log("댓글 추가");
  
            let requestData = {
              cmUserId: '${session.userId}',
              cmContent: cmWrite.value,
              bbsSeq: '${vo.seq}',
              bbsUserId: '${vo.userId}',
              // name : '${session.name}'
            }
  
            console.log(requestData);
            $.ajax({
              url: '/cm/comment',
              type: 'POST',
              data: requestData,
              success: function (data) {
                console.log("data : " + data);
                if (data === "OK") {
                  alert('댓글 작성 성공!');
                  setCMbbs(0);
                  cmWrite.value = "";
                }
                else {
                  alert('댓글 작성 실패!');
                }
              }
            });
          }
        });

        // 댓글 삭제
        const commentContainer = document.querySelector('.comment_wrap');
        commentContainer.addEventListener('click', (event) => {
          console.log(event.target);
          console.log("삭제 버튼 클릭");
          const cmSeq = event.target.getAttribute('data-cm-seq');
          const cmUserId = event.target.getAttribute('data-cm-id');
          if (event.target.classList.contains('cmDeleteBtn')) {
            if(cmUserId === '${session.userId}')
            {

            
            console.log(cmSeq);
            console.log(cmUserId);
            let requestData = {
              cmSeq: cmSeq,
              cmUserId: cmUserId,
            };

            if (confirm('정말 이 댓글을 삭제하시겠습니까?')) {
              $.ajax({
                url: '/cm/deleteComment',
                type: 'POST',
                data: requestData,
                success: function (response) {
                  if (response === 'success') {
                    console.log(response);
                    alert('댓글이 성공적으로 삭제되었습니다.');
                    setCMbbs(0);
                  }
                  else if (response === 'fail')
                  {
                    console.log(response);
                    alert('댓글 삭제에 실패했습니다.');
                  }
                },
                error: function () {
                  alert('댓글 삭제 중 오류가 발생했습니다.');
                }
              })
            };
          }
          else 
          {
            alert("댓글을 삭제할 수 없습니다.");
          }
          }
        });

        // document.querySelector('.btnArea').addEventListener('click', (event) => {
        // if (event.target.classList.contains('cmDeleteBtn')) 

        // 댓글 삭제 
        // console.log('del buttons : ', cmDeleteButtons);


        // cmDeleteButtons.forEach((button) => {
        // button.addEventListener('click', (event) => 
        // {
        //         console.log(event.target);
        //         console.log("삭제 버튼 클릭");
        //         const cmSeq = event.target.getAttribute('data-cm-seq');
        //         const cmUserId = event.target.getAttribute('data-cm-id');
        //         console.log(cmSeq);
        //         console.log(cmUserId);
        //         let requestData = {
        //           cmSeq : cmSeq,
        //           cmUserId : cmUserId,
        //         };

        //         if (confirm('정말 이 댓글을 삭제하시겠습니까?')) {
        //             $.ajax({
        //               url: '/cm/deleteComment', 
        //               type: 'POST',
        //               data: requestData,
        //               success: function (response) {
        //                   if (response === 'success') 
        //                   {
        //                       alert('댓글이 성공적으로 삭제되었습니다.');

        //                   } 
        //                   else (response === 'fail')
        //                   {
        //                       alert('댓글 삭제에 실패했습니다.');
        //                   }
        //               },
        //               error: function () {
        //                   alert('댓글 삭제 중 오류가 발생했습니다.');
        //               }
        //         })
        //       };
        //     })});





        ////// 호출부 //////////////////////////////////////////////////////////////////

        setSessionState();
        setSessionInfo();
        checkMyContent(); // 내 컨텐츠가 맞다면 myContent => true
        // checkMyComment(); // 내 댓글이면 myComment => true
        setUiObject(); // 내 컨텐츠인 경우에만 수정 가능하게
        // setCmUiObject(); // 내 댓글일 경우에만 수정 가능하게
        setNextPrevContent();


      </script>
  </body>

  </html>