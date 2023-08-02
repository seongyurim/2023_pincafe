<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pincafe</title>
</head>
<body>
    <h1>Welcome!</h1>
    <p>
        <span id="welcomMsg"></span>
    </p>
    <p>
        <button type="button" id="btnLogin">로그인</button>
        <button type="button" id="btnJoin">회원가입</button>
    </p>
    <p>
        <form action="/search" method="GET">
            <input type="text" name="keyword" placeholder="카페 이름을 검색해보세요.">
            <button type="submit">검색</button>
        </form>
    </p>
    <p>
        <img src="/imgs/member/thumbnail/${vo.fileCode}.jpg" alt="Profile Image" class="profileImg">
    </p>

    <ul id="feedBBS" class="feed-BBS">

    </ul>






    <script>
    (()=>{
        let sessionState = false;

        // row..
        let rowCount = 0;        // 전체 건수

        // page..
        let rowsPerPage = 5;     // 페이지 당 건수(테이블에서 보여지는 최대 건수)
        let curPage = 0;         // 현재 페이지 위치

        // section..
        let curSection = 0;      // 현재 섹션
        let pagesPerSection = 5; // 섹션당 페이지 수(버튼 수와 동일)

        const welcomMsg = document.querySelector('#welcomMsg');
        const btnLogin  = document.querySelector('#btnLogin');
        const btnJoin   = document.querySelector('#btnJoin');

        ////// 함수부 ////////////////////////////////////////////////////////////////////////

        // 현재 세션이 있는지 없는지 설정해준다.
        const setSessionState = function() {
            if ('${vo.id}' == '') {
                sessionState = false;
            }
            else {
                sessionState = true;
            }
        }

        // 메인 화면의 웰컴 메세지를 설정한다.
        const setWelcomeMsg = function() {
            if (sessionState === true) {
                welcomMsg.textContent = '${vo.nickname}님 반갑습니다.';
            }
            else {
                welcomMsg.textContent = '로그인이 필요한 서비스입니다.';
            }
        }

        // 로그인 여부에 따라 버튼을 다르게 설정한다.
        const setLoginButton = function() {
            if (sessionState === true) {
                btnLogin.textContent = '로그아웃';
            }
            else {
                btnLogin.textContent = '로그인';
            }
        }

        const setJoinButton = function() {
            if (sessionState === true) {
                btnJoin.style.display = 'none';
            }
        }

        // 피드형 게시판 생성
        const setBBS = function(page) {
            // BBS 세팅을 위한 데이터를 오브젝트에 담기
            let requestData = {
                // divi : 'C',
                page: page,
                rowsPerPage: rowsPerPage // 현재 전역변수에 5로 설정되어 있음
            };

            // 오브젝트를 DB로 전달하기
            $.ajax({
                url: 'bbs/list',
                type: 'POST',
                data: requestData,
                success: function(data) {
                    // 여기서 받는 데이터: rowCount, bbsList
                    const feedBBS = document.querySelector('#feedBBS');

                    // 전체 카운트를 저장한다.
                    rowCount = data.rowCount;

                    // 피드형 게시판을 채워준다.
                    feedBBS.innerHTML = '';

                    for (let i = 0; i < data.bbsList.length; i++) {
                        const feedItem = document.createElement('li');
                        feedItem.classList.add('feed-item');

                        const imageLink = document.createElement('a');
                        imageLink.href = '/bbs/content?userId=' + data.bbsList[i].userId + '&seq=' + data.bbsList[i].seq;

                        const image = document.createElement('img');
                        image.src = data.bbsList[i].imageUrl;
                        image.alt = '피드 이미지';

                        const titleLink = document.createElement('a');
                        titleLink.href = '/bbs/content?userId=' + data.bbsList[i].userId + '&seq=' + data.bbsList[i].seq;
                        titleLink.textContent = data.bbsList[i].title;

                        const userId = document.createElement('p');
                        userId.textContent = data.bbsList[i].userId;

                        const regdate = document.createElement('p');
                        regdate.textContent = data.bbsList[i].regdate;

                        // 피드 항목에 요소들을 추가합니다.
                        imageLink.appendChild(image);
                        feedItem.appendChild(imageLink);
                        feedItem.appendChild(titleLink);
                        feedItem.appendChild(userId);
                        feedItem.appendChild(regdate);

                        // 피드 항목을 피드 게시판에 추가합니다.
                        feedBBS.appendChild(feedItem);
                    }
                }
            });
            // console.log(requestData);
        }


        ////// 이벤트 핸들러 /////////////////////////////////////////////////////////////////

        // 로그인 버튼
        btnLogin.addEventListener('click', ()=>{
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
        btnJoin.addEventListener('click', ()=>{
            location.href = '/join';
        });



        ////// 호출부 ////////////////////////////////////////////////////////////////////////

        setSessionState(); // 세션이 있는지 없는지 상태값을 저장한다.
        setWelcomeMsg();   // 로그인한 사용자에게 웰컴 메세지를 설정한다.
        setLoginButton();  // 로그인 여부에 따라 버튼을 로그인/로그오프로 설정한다.
        setJoinButton();   // 로그인이 되었다면 회원가입 버튼을 숨긴다.

        
    })();
    </script>
</body>
</html>