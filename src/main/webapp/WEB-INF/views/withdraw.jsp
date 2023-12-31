<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Withdraw</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" href="/css/login.css">
</head>
<body>
    <div class="container-md master_container">
        <a href="/index"><img src="/images/logo3.png" alt="PinCafe Logo" id="logo"></a>
        <div class="title">회원탈퇴</div>
        
        
        <div class="inner_container">
            <div>
                <div><img src="/imgs/member/thumbnail/${vo.fileCode}.jpg" id="profileImg"></div>
                <div id="withdrawMsg">${vo.name}님, 탈퇴하시려면 비밀번호를 확인해주세요.</div>
            </div>
            <div class="form-floating mb-3 myanchor"> <!-- 아이디 -->
                <input type="password" class="inputForms form-control" id="inputPw" placeholder="Password">
                <label for="txtUserId">Password</label>
                <button type="button" id="btnPwCheck" class="btn btn-light btnAdded">비밀번호 확인</button>
            </div>
            <div class="btnBox">
                <button type="button" id="btnRealWithdraw" class="mybtn btn btn-info">회원탈퇴</button>
            </div>
        </div>
    </div>

<!-- ------------------------------------------------------------------------------------------------------- -->

    <!-- <div class="container-md master-container">
        <div class="title-nav">
            <a href="/index"><img src="/images/logo3.png" alt="PinCafe Logo"></a>
            <hr class="border border-primary border-1 opacity-35">
            <h2 class="title">회원 탈퇴</h2>
        </div>
        
        <div class="confirmProcess">
            <p class="alert">
                <div><img alt="profileImg" src='/imgs/member/thumbnail/${vo.fileCode}.jpg' id="profileImg"></div>
                <div>${vo.name}님, 탈퇴하시려면 비밀번호를 확인해주세요.</div>
            </p>
    
            <form class="main-container row g-3">
                <div class="myset1 col-auto">
                    <label for="getPw" class="visually-hidden">비밀번호 확인</label>
                    <input type="text" readonly class="form-control-plaintext" id="getPw" value="비밀번호 확인">
                </div>
                <div class="myset2 col-auto">
                    <label for="inputPw" class="visually-hidden">Password</label>
                    <input type="password" class="form-control" id="inputPw" placeholder="Password">
                </div>
                <div class="myset3 col-auto">
                    <button type="submit" id="btnPwCheck" class="btnCheck btn btn-dark mb-3">확인</button>
                </div>
                <div class="btn-container">
                    <button type="button" id="btnRealWithdraw" class="btnWD btn btn-danger">탈퇴</button>
                </div>
            </form>
        </div>
    </div>  -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

    <script>
    (()=>{
        // 전역 변수 설정
        // let pwconfirmed = false;
        // ============================================================================================
        // 버튼 DOM 가져오기 
        const btnPwCheck = document.getElementById('btnPwCheck');
        const btnRealWithdraw = document.getElementById('btnRealWithdraw');

        // ============================================================================================
        // 함수 구현
        const checkPwConfirmed = function() {
            pwconfirmed = true;
        }

        // ============================================================================================
        // 이벤트 리스너 
        btnPwCheck.addEventListener('click', ()=>
        {
            // pwconfirmed 초기화
            pwconfirmed = false;
            const inputPw = document.getElementById('inputPw').value; // 사용자가 입력한 비밀번호 가져오기
            
            const xhr = new XMLHttpRequest();
            // POST 요청으로 '/checkPassword' URL에 비밀번호 전송
            xhr.open('POST', '/checkPassword', true);
            xhr.setRequestHeader('Content-Type', 'application/json'); // JSON 형식으로 데이터 전송

            // 서버로 데이터 전송
            xhr.send(inputPw);

            // 서버 응답 처리
            xhr.onreadystatechange = function () {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        const response = xhr.responseText;
                        if (response === 'COMPLETE') {
                            alert('비밀번호가 확인되었습니다.');
                            // sessionStorage 에 pwconfirmed를 true로 세팅해서 저장
                            sessionStorage.setItem('pwconfirmed', 'true');
                        } else if (response === 'FAIL') {
                            alert('비밀번호가 일치하지 않습니다.');
                        } else if (response === 'NOT_LOGGED_IN') {
                            alert('로그인되지 않았습니다.');
                        }
                    } else {
                        alert('비밀번호를 입력하세요.');
                    }
                }
            };
        });

        btnRealWithdraw.addEventListener('click', ()=>
        {
            // sessionStorage 에서 저장된 key값이 true 일 때만 pwconfirmed를 가지고 오는 것
            const pwconfirmed = sessionStorage.getItem('pwconfirmed') === 'true';
            console.log(pwconfirmed);
            if (pwconfirmed == true)
            {
                if (confirm('정말 탈퇴하시겠습니까?')) {

                // Ajax 요청을 보내기 위해 XMLHttpRequest 객체 생성
                const xhr = new XMLHttpRequest();

                // POST 요청으로 '/withdraw' URL에 탈퇴 요청
                // 여기서 true는 비동기적 요청 여부(boolean)에 대한 값 (즉, true이므로 비동기요청)
                xhr.open('POST', '/withdraw', true);
                // setRequestHeader(a,b) => a = 헤더 이름, b = 헤더의 값
                xhr.setRequestHeader('Content-Type', 'application/json'); // JSON 형식으로 데이터 전송

                // 서버로 보낼 데이터는 따로 필요하지 않을 수도 있음
                // 딱히 데이터가 없이 빈 객체로 가게 되면 그냥 요청을 보내는 용도로만 사용됨
                const data = JSON.stringify({});

                // 서버로 데이터(요청) 전송
                xhr.send(data);

                // 서버 응답 처리
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            const response = xhr.responseText;
                            if (response === 'OK') {
                                alert('회원 탈퇴가 완료되었습니다.');
                                location.href = "/index";
                            } else {
                                alert('회원 탈퇴에 실패했습니다. 다시 시도해주세요.');
                            }
                        } else {
                            alert('오류가 발생했습니다.');
                        }
                    }
                };
            }
            }
            else
            {
                alert ("비밀번호 확인을 완료해주세요.")
            }
        });
    })();
    </script>
</body>
</html>