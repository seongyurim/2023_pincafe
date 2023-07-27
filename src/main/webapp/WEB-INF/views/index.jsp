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

    <script>
    (()=>{

        const welcomMsg = document.querySelector('#welcomMsg');
        const btnLogin  = document.querySelector('#btnLogin');
        const btnJoin   = document.querySelector('#btnJoin');

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

        // 메인 화면의 웰컴 메세지를 설정한다.
        const setWelcomeMsg = function() {
            if (sessionState === true) {
                spnWelcome.textContent = '${vo.name}님 반갑습니다.';
            }
            else {
                spnWelcome.textContent = '로그인이 필요한 서비스입니다.';
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