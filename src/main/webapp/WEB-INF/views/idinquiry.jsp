<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FIND ID</title>
</head>
<body>
    <h1>아이디 찾기</h1>
    <hr>
    <p>
        <label for="txtNickname">닉네임</label>
        <input type="text" name="nickname" id="txtNickname"><br>
        <label for="txtEmail">이메일</label>
        <input type="email" name="email" id="txtEmail">
        <button type="button" id="btnSubmit">확인</button>        
    </p>
    <p>
        <button type="button" id="btnLogin">로그인</button>
        <button type="button" id="btnIndex">첫화면</button>
    </p>

    <script src="/JS/jquery-3.7.0.min.js"></script>

    <script>
    (()=>{
        
        const txtNickname  = document.querySelector('#txtNickname');
        const txtEmail  = document.querySelector('#txtEmail');
        const btnSubmit = document.querySelector('#btnSubmit');
        const btnLogin  = document.querySelector('#btnLogin');
        const btnIndex  = document.querySelector('#btnIndex');

        btnSubmit.addEventListener('click', ()=>{

            // 값을 입력하지 않고 버튼을 클릭하는 경우
            if ((txtNickname.value.length === 0) || (txtEmail.value.length === 0)) {
                alert('닉네임과 이메일을 입력해주세요.');
                txtEmail.focus();
                return;
            }

            // DB로 전송할 데이터
            let requestData = {
                email : txtEmail.value,
                nickname : txtNickname.value
            }
            console.log(requestData);

            // DB와 통신하기
            $.ajax({
                url : '/idinquiry',
                type : 'POST',
                data : requestData,             // 아이디를 보냈으니
                success : function(data) {      // 이메일을 주겠지
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