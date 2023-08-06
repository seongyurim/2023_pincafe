<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FIND PW</title>

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
        margin-top: 15px;
        align-items: center;
        padding: 15px 158px; /* 버튼의 여백 조정 */
        text-align: center;
    }

    /* 버튼 박스 */
    .btnBox {
        display: flex;
        align-items: flex-start;
        text-align: center;
        margin-top: 20px;
    }

    .mybtn {
        padding: 10px 60px; /* 버튼의 여백 조정 */
        margin: 0 5px;
    }
</style>

</head>
<body>
    <div class="container-md master-container">
        <!-- 타이틀 영역 : 로고 & 아이디 찾기  -->
        <div class="title-nav">
            <a href="/index"><img src="/images/logo3.png" alt="PinCafe Logo"></a>
            <hr class="border border-primary border-1 opacity-35">
            <h2 class="title">비밀번호 찾기</h2>
        </div>

    <!-- 아이디, 이메일 인풋 및 확인 영역 -->
    <div class="default-box">
        <div class="form-floating mb-3">
            <input type="text" class="inputForms form-control" id="userId" placeholder="id">
            <label for="userId">id</label>
        </div>
        <div class="form-floating">
            <input type="email" class="inputForms form-control" id="txtEmail" placeholder="user@email.com">
            <label for="txtEmail">Email</label>
        </div>
        <button type="button" id="btnSubmit" class="btnSubmit btn btn-secondary">확인</button>    
    
    <!-- etc 버튼영역 -->
    <p class="btnBox">
        <button type="button" id="btnLogin" class="mybtn btn btn-light">로그인</button>
        <button type="button" id="btnIndex" class="mybtn btn btn-light">첫화면</button>
    </p>
    
    </div> <!-- default-box -->
    </div> <!-- container-md -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <script src="/JS/jquery-3.7.0.min.js"></script>


    <script>
    (()=>{
        
        const txtUserId  = document.querySelector('#txtUserId');
        const txtEmail   = document.querySelector('#txtEmail');
        const btnSubmit  = document.querySelector('#btnSubmit');
        const btnLogin   = document.querySelector('#btnLogin');
        const btnIndex   = document.querySelector('#btnIndex');

        btnSubmit.addEventListener('click', ()=>{

            // 값을 전부 입력하지 않고 버튼을 클릭하는 경우
            if ((txtUserId.value.length === 0) || (txtEmail.value.length === 0)) {
                alert('아이디와 이메일을 입력해주세요.');
                txtUserId.focus();
                return;
            }

            // DB로 전송할 데이터
            let requestData = {
                userId : txtUserId.value,
                email : txtEmail.value
            }
            console.log(requestData);

            // DB와 통신하기
            $.ajax({
                url : '/pwinquiry',
                type : 'POST',
                data : requestData,             // 아이디를 보냈으니
                success : function(data) {      // 비밀번호를 주겠지
                    if (data === "$FAIL") {
                        alert('등록된 아이디가 아닙니다.');
                    }
                    else { // "$OK"
                        alert('비밀번호를 메일로 전송하였습니다.');                    
                    }
                }
            });

        });

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