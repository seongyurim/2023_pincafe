<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pincafe</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" href="/css/index.css">
</head>
<body>
    <nav class="navbar sticky-top navbar-expand-sm bg-body-tertiary" id="mynavi">
        <div class="container-fluid">
          <a class="navbar-brand" href="/index"><img src="/images/logo3.png" alt="PinCafe Logo"></a>
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse d-flex justify-content-between align-items-center" id="navbarSupportedContent">
            <ul class="navbar-nav">
              <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="#">ABOUT US</a>
              </li>
              <li class="nav-item">
                <a class="nav-link active" href="#">COMMUNITY</a>
              </li>
            </ul>
            <div class="d-flex align-items-center">
              <div id="welcomeMsg" class="me-3">Welcome, User!</div>
              <ul class="navbar-nav ms-auto">
                <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle active" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <img alt="Profile Image" id="profileImg">
                  </a>
                  <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" id="btnLogin">Sign In</a></li>
                    <li><a class="dropdown-item" id="btnJoin">Sign Up</a></li>
                    <li><hr class="dropdown-divider" id="mydivider"></li>
                    <li><a class="dropdown-item" id="btnInfoUpdate">Edit Profile</a></li>
                  </ul>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </nav>
    
    <div id="searchSet">
        <form action="/search" method="GET">
            <input type="text" name="keyword" class="container-md"  id="searchName" placeholder="카페 이름을 검색해보세요.">
            <button type="submit" id="btnSearch">검색</button>
        </form>
    </div>

    <table id="tblBBS" class="table container-sm table-hover">
        <thead>
            <th id="col1" style="width: 15%;">글번호</th>
            <th id="col2" style="width: 10%;">지역</th>
            <th id="col3" style="width: 40%">제목</th>
            <th id="col4" style="width: 10%;">닉네임</th>
            <th id="col5" style="width: 25%">등록일</th>
        </thead>
        <tbody>            
        </tbody>
    </table>

    <div id="btnSet">
        <button type="button" id="btnPrev" class="myBtn btn btn-outline-dark">이전</button>
        <button type="button" id="btn1" class="btns myBtn btn btn-outline-dark">1</button>
        <button type="button" id="btn2" class="btns myBtn btn btn-outline-dark">2</button>
        <button type="button" id="btn3" class="btns myBtn btn btn-outline-dark">3</button>
        <button type="button" id="btn4" class="btns myBtn btn btn-outline-dark">4</button>
        <button type="button" id="btn5" class="btns myBtn btn btn-outline-dark">5</button>
        <button type="button" id="btnNext" class="myBtn btn btn-outline-dark">다음</button>
        <button type="button" id="btnWrite" class="myBtn btn btn-outline-dark">글쓰기</button>
    </div>

    <div id="instaFeed" class="container-sm">
    </div>

    <script src="/JS/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
    (()=>{
        let sessionState = false;

        // row..
        let rowCount = 0;        // 전체 건수

        // page..
        let rowsPerPage = 10;     // 페이지 당 건수(테이블에서 보여지는 최대 건수)
        let curPage = 0;         // 현재 페이지 위치

        // section..
        let curSection = 0;      // 현재 섹션
        let pagesPerSection = 5; // 섹션당 페이지 수(버튼 수와 동일)

        const profileImg    = document.querySelector('#profileImg');
        const welcomeMsg    = document.querySelector('#welcomeMsg');
        const btnLogin      = document.querySelector('#btnLogin');
        const btnJoin       = document.querySelector('#btnJoin');
        const btnInfoUpdate = document.querySelector('#btnInfoUpdate');
        const mydivider     = document.querySelector('#mydivider');

        const btnPrev    = document.querySelector('#btnPrev');
        const btnNext    = document.querySelector('#btnNext');
        const btnWrite   = document.querySelector('#btnWrite');

        const btn1 = document.querySelector('#btn1');
        const btn2 = document.querySelector('#btn2');
        const btn3 = document.querySelector('#btn3');
        const btn4 = document.querySelector('#btn4');
        const btn5 = document.querySelector('#btn5');
        

        ////// 함수부 ////////////////////////////////////////////////////////////////////////

        // 현재 세션이 있는지 없는지 설정해준다.
        const setSessionState = function() {
            if ('${vo.userId}' == '') {
                sessionState = false;
            }
            else {
                sessionState = true;
            }
        }
        
        // 로그인 인포 설정
        const setSessionInfo = function() {
            if (sessionState === true) {
                welcomeMsg.textContent = '${vo.name}님 반갑습니다.';
                btnLogin.textContent = 'Sign Out';
                btnJoin.style.display = 'none';
                profileImg.setAttribute('src', '/imgs/member/thumbnail/${vo.fileCode}.jpg');
            }
            else {
                btnLogin.textContent = 'Sign In';
                btnInfoUpdate.style.display = 'none';
                profileImg.style.display = 'none';
                mydivider.style.display = 'none';
            }
        }
        

        // 게시판을 세팅한다.
        const setBBS = function(page) {
            // BBS 세팅을 위한 데이터를 오브젝트에 담기
            let requestData = {
                page : page,
                rowsPerPage : rowsPerPage // 현재 전역변수에 5로 설정되어 있음
            };

            // 오브젝트를 DB로 전달하기
            $.ajax({
                url : 'bbs/list',
                type : 'POST',
                data : requestData,
                success : function(data) { // 여기서 받는 데이터: rowCount, bbsList
                    
                    let bstr = '';
                    const tblBody = document.querySelector('#tblBBS > tbody')

                    // 전체 카운트를 저장한다.
                    rowCount = data.rowCount;

                    // 테이블 body를 채워준다.
                    tblBody.innerHTML = '';

                    for (let i = 0; i < data.bbsList.length; i++) {
                        bstr = '';
                        bstr += '<tr>';
                            bstr += '<td>' + data.bbsList[i].rowNum + '</td>';
                            bstr += '<td>' + data.bbsList[i].divi + '</td>';
                            
                            bstr += '<td><a href=\"/bbs/content?userId=' + data.bbsList[i].userId
                                          + '&seq=' + data.bbsList[i].seq
                                          + '\">' + data.bbsList[i].title
                                          + '</a></td>';

                            bstr += '<td>' + data.bbsList[i].userId + '</td>';
                            bstr += '<td>' + data.bbsList[i].regdate + '</td>';
                        bstr += '</tr>';

                    tblBody.innerHTML += bstr;
                    }
                }
            });
            console.log(requestData);
        }


        // 실제 적용해야 할 페이지를 구한다.
        const getRealPage = function(pageOffset) {
            return (curSection * pagesPerSection) + pageOffset;
        }

        // 게시판 버튼 숫자를 업데이트하고 남는 버튼은 삭제한다.
        const updateBtns = function() {
            let startPage = curSection * pagesPerSection + 1;
            for (let i = 0; i < pagesPerSection; i++) {
                const btn = document.querySelector('#btn' + (i+1));
                if (startPage <= Math.ceil(rowCount / rowsPerPage)) {
                    btn.textContent = startPage++;
                    btn.style.display = 'inline';
                }
                else {
                    btn.style.display = 'none';
                }
            }
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

        
        // 이전 목록 버튼
        btnPrev.addEventListener('click', ()=> {
            
            if (curSection <= 0) {
                alert("첫 페이지입니다.");
                return;
            }

            curSection--;
            updateBtns();
            let realPage = getRealPage(0); // 이전 페이지의 0번으로 설정
            setBBS(realPage);
        });
        

        // 다음 목록 버튼
        btnNext.addEventListener('click', ()=> {
            
            let rowsPerSection = rowsPerPage * pagesPerSection; // 25개            
            let nextRowCount = rowCount - rowsPerSection * (curSection + 1);
            
            if (nextRowCount <= 0) {
                alert("마지막 페이지입니다.");
                return;
            }

            curSection++;
            updateBtns();
            let realPage = getRealPage(0); // 다음 페이지의 0번으로 설정
            setBBS(realPage);
            console.log("curSection = " + curSection);            
        });

        btn1.addEventListener('click', ()=> {
            // 1번 버튼을 눌렀을 때
            const offset = 0; // 0번 버튼을 누른 것이므로
            const realPage = getRealPage(offset); // offset, curSection 값을 이용해서
            setBBS(realPage);
            console.log("realPage = " + realPage);
        });

        btn2.addEventListener('click', ()=> {
            // 2번 버튼을 눌렀을 때
            const offset = 1; // 1번 버튼을 누른 것이므로
            const realPage = getRealPage(offset);
            setBBS(realPage);
            console.log("realPage = " + realPage);
        });

        btn3.addEventListener('click', ()=> {
            // 3번 버튼을 눌렀을 때
            const offset = 2; // 2번 버튼을 누른 것이므로
            const realPage = getRealPage(offset);
            setBBS(realPage);
            console.log("realPage = " + realPage);
        });

        btn4.addEventListener('click', ()=> {
            // 4번 버튼을 눌렀을 때
            const offset = 3; // 3번 버튼을 누른 것이므로
            const realPage = getRealPage(offset);
            setBBS(realPage);
            console.log("realPage = " + realPage);
        });

        btn5.addEventListener('click', ()=> {
            // 5번 버튼을 눌렀을 때
            const offset = 4; // 4번 버튼을 누른 것이므로
            const realPage = getRealPage(offset);
            setBBS(realPage);
            console.log("realPage = " + realPage);
        });


        // 글쓰기 버튼
        btnWrite.addEventListener('click', ()=>{

            // 비로그인 상태
            if (sessionState === false) {
                if (confirm("로그인 후 이용할 수 있습니다. 로그인하시겠어요?")) {
                    location.href = '/login';
                }
                else {
                    return;
                }
            }
            // 로그인 상태
            else {
                location.href = "/bbs/newcontent";
            }
        });

        // 정보수정 버튼
        btnInfoUpdate.addEventListener('click', ()=> {
            location.href = "/infoupdate";
        });
        

        ////// 호출부 ////////////////////////////////////////////////////////////////////////

        setSessionState(); // 세션이 있는지 없는지 상태값을 저장한다.
        setSessionInfo();
        setBBS(0);
        
    })();
    </script>
</body>
</html>