<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" href="/css/login.css">
</head>
<body>
    <div class="container-md master_container">
        <a href="/index"><img src="/images/logo3.png" alt="PinCafe Logo" id="logo"></a>
        <div class="title">로그인</div>
        
        <div class="inner_container">
            <form action="/login" method="POST" id="frmLogin">
                <div class="form-floating mb-3">
                    <input type="text" class="inputForms form-control" name="userId" id="txtUserId" placeholder="ID">
                    <label for="txtUserId">ID</label>
                </div>
                <div class="form-floating">
                    <input type="password" class="inputForms form-control" name="userPw" id="txtUserPw" placeholder="Password">
                    <label for="txtUserPw">Password</label>
                </div>
            </form>            
            <div class="btnBox">
                <button type="button" id="btnLogin" class="mybtn btn btn-info">로그인</button>
            </div>
        </div>

        <ul class="etc_wrap">
            <li id="btnFindPw"><a href="/pwinquiry">비밀번호 찾기</a></li>
            <li id="btnFindId"><a href="/idinquiry">아이디 찾기</a></li>
            <li id="btnJoin"><a href="/join">회원가입</a></li>
        </ul>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <script src="/JS/jquery-3.7.0.min.js"></script>

    <script>
    (()=>{   
        
        const btnLogin  = document.querySelector('#btnLogin');
        const btnJoin   = document.querySelector('#btnJoin');
        const btnFindId = document.querySelector('#btnFindId');
        const btnFindPw = document.querySelector('#btnFindPw');

        btnLogin.addEventListener('click', () => {
            const frmLogin = document.querySelector('#frmLogin');
            frmLogin.submit();

            const txtUserId = document.querySelector('#txtUserId').value;
            const txtUserPw = document.querySelector('#txtUserPw').value;

            // 아이디와 패스워드를 입력하지 않았을 경우 경고 메시지
            if (!txtUserId || !txtUserPw) {
                alert('아이디와 패스워드를 입력해주세요.');
                return;
            }
        });

    })(); 
    </script>
        
</body>