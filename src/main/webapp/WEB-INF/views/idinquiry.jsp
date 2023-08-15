<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FIND ID</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" href="/css/login.css">
</head>
<body>
    <div class="container-md master_container">
        <a href="/index"><img src="/images/logo3.png" alt="PinCafe Logo" id="logo"></a>
        <div class="title">아이디 찾기</div>
        
        <div class="inner_container">
            <div class="form-floating mb-3">
                <input type="text" class="inputForms form-control" id="txtName" placeholder="nickname">
                <label for="txtName">Nickname</label>
            </div>
            <div class="form-floating">
                <input type="email" class="inputForms form-control" id="txtEmail" placeholder="user@email.com">
                <label for="txtEmail">Email</label>
            </div>
            <div class="btnBox">
                <button type="button" id="btnSubmit" class="mybtn btn btn-info">아이디 찾기</button>
            </div>
        </div>

        <ul class="etc_wrap">
            <li id="btnFindPw"><a href="/login">로그인</a></li>
        </ul>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <script src="/JS/jquery-3.7.0.min.js"></script>

    <script>
    (()=>{
        
        const txtName   = document.querySelector('#txtName');
        const txtEmail  = document.querySelector('#txtEmail');
        const btnSubmit = document.querySelector('#btnSubmit');
        const btnLogin  = document.querySelector('#btnLogin');
        const btnIndex  = document.querySelector('#btnIndex');

        btnSubmit.addEventListener('click', ()=>{

            // 값을 입력하지 않고 버튼을 클릭하는 경우
            if ((txtName.value.length === 0) || (txtEmail.value.length === 0)) {
                alert('닉네임과 이메일을 입력해주세요.');
                txtEmail.focus();
                return;
            }

            // DB로 전송할 데이터
            let requestData = {
                name : txtName.value,
                email : txtEmail.value
            }
            console.log(requestData);

            // DB와 통신하기
            $.ajax({
                url : '/idinquiry',
                type : 'POST',
                data : requestData,             
                success : function(data) {      
                    if (data === "$FAIL") {
                        alert('등록된 이메일이 아닙니다.');
                        txtEmail.value = '';
                        txtEmail.focus();
                    }
                    else {
                        alert('회원님의 아이디는 [ ' + data + ' ] 입니다.');                    
                    }
                }
            });
        });

        // 로그인 버튼
        btnLogin.addEventListener('click', ()=>{
            location.href = '/login';
        });

        btnIndex.addEventListener('click', ()=>{
            location.href = '/index';
        });


    })();
    </script>
</body>
</html>