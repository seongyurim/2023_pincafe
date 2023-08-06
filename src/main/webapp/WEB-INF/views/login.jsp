<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<!-- 폰트 링크 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<!-- 부트스트랩 링크 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

<style>
    .master-container {
        margin: 30px auto;
    }

    /* title영역 */
    .title-nav {
        text-align: center;
    }
    
    .title {
        font-weight: bold;
        font-family: 'Noto Sans KR', sans-serif;
    }

    
    /* 상위 박스 */
    .default-box {
        font-family: 'Noto Sans KR', sans-serif;
        display: flex;
        align-items: center;
        flex-direction: column;
        justify-content: space-between;
        max-width: 1000px;
        height: 100%;
        margin: 50px auto;
    }

    /* 인풋폼 */
    .inputForms {
        width: 350px;
    }

    .btnSubmit {
        display: flex;
        margin-top: 30px;
        align-items: center;
        padding: 15px 60px; /* 버튼의 여백 조정 */
        text-align: center;
    }

    /* 버튼 박스 */
    .btnBox {
        max-width: 100%;
        display: flex;
        align-items: flex-start;
        text-align: center;
        margin-top: 15px;
    }

    .mybtn1 {
        padding: 12px 65px; /* 버튼의 여백 조정 */
        margin: 0 5px;
    }

    .mybtn2 {
        padding: 12px 15px; /* 버튼의 여백 조정 */
        margin: 0 3px;
    }

</style>

</head>
<body>
    <div class="container-md master-container">
        <!-- 타이틀 영역 : 로고 & 아이디 찾기  -->
        <div class="title-nav">
            <a href="/index"><img src="/images/logo3.png" alt="PinCafe Logo"></a>
            <hr class="border border-primary border-1 opacity-35">
            <h1 class="title">로그인</h1>
        </div>

        
    <!-- 아이디, 이메일 인풋 및 확인 영역 -->
    <form action="/login" method="POST" id="frmLogin">
    <div class="default-box">
        <div class="form-floating mb-3">
            <input type="text" class="inputForms form-control" name="userId" id="txtUserId" placeholder="id">
            <label for="txtUserId">id</label>
        </div>
        <div class="form-floating">
            <input type="password" class="inputForms form-control" name="userPw" id="txtUserPw" placeholder="password">
            <label for="txtUserPw">password</label>
        </div>
    </form>
    <!-- 메인 버튼영역 -->
    <p class="btnBox">
        <button type="button" id="btnLogin" class="mybtn1 btn btn-secondary">로그인</button>    
        <button type="button" id="btnIndex" class="mybtn1 btn btn-secondary">메인</button>    
    </p>
        <!-- etc 버튼영역 -->
    <p class="btnBox">
        <button type="button" id="btnJoin" class="mybtn2 btn btn-light">회원가입</button>
        <button type="button" id="btnFindId" class="mybtn2 btn btn-light">아이디 찾기</button>
        <button type="button" id="btnFindPw" class="mybtn2 btn btn-light">비밀번호 찾기</button>
    </p>
    
    </div> <!-- default-box -->
    </div> <!-- master-container -->    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <script src="/JS/jquery-3.7.0.min.js"></script>

<script>
(()=>{   
    
    const btnLogin  = document.querySelector('#btnLogin');
    const btnIndex  = document.querySelector('#btnIndex');
    const btnJoin   = document.querySelector('#btnJoin');
    const btnFindId = document.querySelector('#btnFindId');
    const btnFindPw = document.querySelector('#btnFindPw');


    //////////////////////////////////////////////////////////////////////////
    // 이벤트 핸들러
    btnLogin.addEventListener('click', () => {
        const frmLogin = document.querySelector('#frmLogin');
        frmLogin.submit();

        const txtUserId = document.querySelector('#txtUserId').value;
        const txtUserPw = document.querySelector('#txtUserPw').value;

        // 아이디와 패스워드를 입력하지 않았을 경우 경고 메시지
        if (!txtUserId || !txtUserPw) {
            alert('아이디와 패스워드를 입력해주세요!');
            return;
        }    
    });


    /////////////////////////////////////////////////////////////////////
    btnIndex.addEventListener('click', ()=>{
        location.href = '/index';
    });

    btnJoin.addEventListener('click', ()=>{
        location.href = '/join';
    });

    btnFindId.addEventListener('click', ()=>{
        location.href = '/idinquiry';
    });

    btnFindPw.addEventListener('click', ()=>{
        location.href = '/pwinquiry';
    });

})(); 
</script>
        
</body>