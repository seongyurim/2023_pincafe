<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Introduction</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Template Vendor CSS Files -->
<link href="assets/vendor/aos/aos.css" rel="stylesheet">
<link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

<!-- Template Main CSS File -->
<link rel="stylesheet" href="/assets/css/style.css">

<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" href="/css/index.css">
</head>
<body>
    <!-- 내비게이션 영역 -->
    <%@ include file="navigation.jsp" %>

    <script>
    (()=>{
        let sessionState = false;

        const profileImg    = document.querySelector('#profileImg');
        const welcomeMsg    = document.querySelector('#welcomeMsg');
        const btnIntro      = document.querySelector('#btnIntro');
        const btnBBS        = document.querySelector('#btnBBS');
        const btnLogin      = document.querySelector('#btnLogin');
        const btnJoin       = document.querySelector('#btnJoin');
        const btnInfoUpdate = document.querySelector('#btnInfoUpdate');
        const mydivider     = document.querySelector('#mydivider');
        

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
                welcomeMsg.textContent = '어서오세요! Pincafe입니다.';
                btnLogin.textContent = 'Sign In';
                btnInfoUpdate.style.display = 'none';
                profileImg.style.display = 'none';
                mydivider.style.display = 'none';
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

        // 정보수정 버튼
        btnInfoUpdate.addEventListener('click', ()=> {
            location.href = "/infoupdate";
        });

        // 게시판 버튼
        btnBBS.addEventListener('click', ()=>{
            btnBBS.setAttribute('href', '/bbsmain');
        });

        // 페이지소개 버튼
        btnIntro.addEventListener('click', ()=>{
            btnIntro.setAttribute('href', '/introduction');
        });
        

        ////// 호출부 ////////////////////////////////////////////////////////////////////////

        setSessionState(); // 세션이 있는지 없는지 상태값을 저장한다.
        setSessionInfo();
        
    })();
    </script>
</body>
</html>