<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
    <h1>Login</h1>

    <form action="/login" method="POST" id="frmLogin">
        <table>
            <tr>
                <td><label for="txtUserId">아이디</label></td>
                <td><input type="text" name="userId" id="txtUserId"></td>
            </tr>
    
            <tr>
                <td><label for="txtUserPw">패스워드</label></td>
                <td><input type="password" name="userPw" id="txtUserPw"></td>
            </tr>
        </table>
    </form>
    
    <div>
        <button type="button" id="btnLogin">로그인</button>
        <button type="button" id="btnIndex">메인으로</button>    
    </div>
    <hr>    
    <div>
        <button type="button" id="btnJoin">회원가입</button>
        <button type="button" id="btnFindId">아이디찾기</button>
        <button type="button" id="btnFindPw">비밀번호 찾기</button>
    </div>

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