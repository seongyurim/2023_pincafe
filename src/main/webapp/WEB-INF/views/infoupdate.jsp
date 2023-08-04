<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>InfoUpdate</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" href="/css/infoupdate.css">
</head>
<body>
    <h1>InfoUpdate</h1>
    <hr>
    <!-- <ul><b>세션정보 가져오기</b></ul>
    <ul>${vo.userId}</ul>
    <ul>${vo.userPw}</ul>
    <ul>${vo.name}</ul>
    <ul>${vo.email}</ul>
    <ul>${vo.address}</ul>
    <ul>${vo.fileCode}</ul>
    <ul>${vo.thumbnail}</ul> -->

    <div id="photoContainer">
        <div><img src="/imgs/member/thumbnail/${vo.fileCode}.jpg" alt="Profile Image" id="imgPreview"></div>
        <div><input type="file" name="file_code" id="thumbnail" style="display: none;"/></div>
        <div id="btnsImg">
            <label for="thumbnail" id="btnImgChange" class="btn btn-outline-dark">변경</label>
            <button type="button" id="btnImgDelete" class="btn btn-outline-dark">삭제</button>
        </div>        
    </div>

    <table>
        <tr>
            <td>아이디</td>
            <td><span>${vo.userId}</span></td>
        </tr>
        <tr>
            <td>닉네임</td>
            <td><input type="text" id="txtName" name="name" placeholder="Nickname" value="${vo.name}">
                <button type="button" id="btnCheckNick">닉네임 중복확인</button></td>
        </tr>
        <tr>
            <td>비밀번호</td>
            <td><input type="password" id="txtUserPw" name="userPw" placeholder="Password"></td>
        </tr>
        <tr>
            <td>비밀번호 확인</td>
            <td><input type="password" id="txtCheckPw" placeholder="Password Check"></td>
        </tr>
        <tr>
            <td>이메일</td>
            <td><input type="email" id="txtEmail" name="email" placeholder="Email"></td>
        </tr>

        <tr>
            <td><label for="kakaoZip">주소</label></td>
            <td>
                <input type="text" id="kakaoZip" placeholder="Zipcode">
                <button type="button" id="kakaoFindZipBtn">우편번호 찾기</button>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><input type="text" id="kakaoAddress" name="address" placeholder="Address"></td>
        </tr>
        <tr>
            <td></td>
            <td><input type="text" id="kakaoDetailAddress" placeholder="Detail Address"></td>
        </tr>
        <tr>
            <td></td>
            <td><input type="text" id="kakaoExtraAddress" placeholder="Extra Address"></td>
        </tr>
    </table>

    <p>
        <button type="button" id="btnInfoUpdate" class="btns">정보수정</button>
        <button type="button" id="btnIndex" class="btns">메인으로</button>
        <button type="button" id="btnWithdraw" class="btns">회원탈퇴</button>
    </p>

      <script src="/JS/jquery-3.7.0.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
      <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <script>
    (()=>{

        const vo = {
            userId : "${vo.userId}",
            userPw : "${vo.userPw}",
            name : "${vo.name}",
            email : "${vo.email}",
            address : "${vo.address}",
            fileCode : "${vo.fileCode}",
            thumbnail : "${vo.thumbnail}"
        };

        const txtName        = document.querySelector('#txtName');
        const txtUserPw      = document.querySelector('#txtUserPw');
        const txtCheckPw     = document.querySelector('#txtCheckPw');
        const txtEmail       = document.querySelector('#txtEmail');
        const btnInfoUpdate  = document.querySelector('#btnInfoUpdate');
        const btnIndex       = document.querySelector('#btnIndex');
        const btnWithdraw    = document.querySelector('#btnWithdraw');

        // 프로필사진 관련
        const thumbnail      = document.querySelector('#thumbnail');
        const imgPreview     = document.querySelector('#imgPreview');
        const btnUpdatePhoto = document.querySelector('#btnUpdatePhoto');

        // 카카오 주소 API 관련
        const kakaoZip           = document.querySelector('#kakaoZip');           // 우편번호
        const kakaoAddress       = document.querySelector('#kakaoAddress');       // 주소
        const kakaoDetailAddress = document.querySelector('#kakaoDetailAddress'); // 상세주소
        const kakaoExtraAddress  = document.querySelector('#kakaoExtraAddress');  // 참고항목
        const kakaoFindZipBtn    = document.querySelector('#kakaoFindZipBtn');    // 우편번호 찾기 버튼
        let finalAddress = ''; // 카카오에서 가져온 주소 문자열을 한 필드에 최종저장

        let nickChecking = false; // 중복확인을 통과하면 true로 변경된다.
        let checkedNick  = '';    // 중복확인이 통과된 닉네임이 저장된다.


        ////// 함수부 ////////////////////////////////////////////////////////////////////////////////////////////////

        const checkUpdateData = function() {

            // 1. 아무 양식도 작성하지 않은 경우
            if ((txtName.value.length === 0) &&
                (txtUserPw.value.length === 0) &&
                (txtCheckPw.value.length === 0) &&
                (txtEmail.value.length === 0) &&
                (finalAddress.length === 0)) {
                    alert('정보수정 양식을 작성해주세요.')
                    return false;
                }

            // // 2. 닉네임 중복여부 확인
            // if ((nickChecking == false) || (checkedNick != txtName.value)) { 
            //     alert('닉네임 중복확인이 필요합니다.');
            //     txtName.value = '';
            //     txtName.focus();
            //     return false;
            // }

            // 3. 비밀번호 검증(정규표현식을 사용하는 것이 더 좋음)
            if (txtUserPw.value.length === 0) {
                alert('비밀번호를 입력해주세요.');
                txtUserPw.value = '';
                txtCheckPw.value = '';
                txtUserPw.focus();
                return false;
            }

            // 4. 비밀번호와 비밀번호 확인 값이 서로 같은지 확인
            if (txtUserPw.value != txtCheckPw.value) {
                alert('입력된 비밀번호가 서로 다릅니다.');
                txtCheckPw.value = '';
                txtCheckPw.focus();
                return false;
            }

            // //5. 이메일의 정규표현식 검증 // 테스트 후 주석 해제할 것 +++++++++++++++++++++++++++++++++++++++++++++++++++++
            // let regex = new RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/);
            // let testResult = regex.test(txtEmail.value);
            // if (testResult === false) {
            //     // console.log("REGEX FOR EMAIL = " + testResult);
            //     alert('올바른 이메일 형태를 입력해주세요.');
            //     txtEmail.focus();
            //     return false;
            // }

            // 6. 위의 검사를 모두 통과했으면 true
            return true;
            }


        // 비밀번호의 글자수와 일치여부 확인
        const checkPw = function() {
            // 비밀번호 글자수 확인
            if (txtUserPw.value != '') {
                if ((txtUserPw.value.length < 6) || (txtUserPw.value.length > 16)) {
                    isPwCorrect.innerHTML = '비밀번호는 6~16자만 가능합니다.';
                    isPwCorrect.style.color = 'red';
                }
                else {
                    isPwCorrect.innerHTML = '사용 가능한 비밀번호입니다.';
                    isPwCorrect.style.color = 'green';
            
                    // 비밀번호 일치여부 확인
                    if ((txtUserPw.value != '') && (txtCheckPw.value != '')) {
                        isPwCorrect.innerHTML = '';
                        if (txtUserPw.value == txtCheckPw.value) {        
                            isPwSame.innerHTML = '비밀번호가 일치합니다.';
                            isPwSame.style.color = 'green';
                        }
                        else {
                            isPwSame.innerHTML = '비밀번호가 일치하지 않습니다.';
                            isPwSame.style.color = 'red';
                        }
                    }
                }
            }
            else {
                isPwCorrect.innerHTML = '';
            }
        }


        // 카카오 주소 API
        const getFinalAddress = function() {
            new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을 때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                let addr = ''; // 주소 변수
                let extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R') {
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // (추가) 조합된 참고항목을 해당 필드에 넣는다.
                    kakaoExtraAddress.value = extraAddr;                
                } else {
                    kakaoExtraAddress.value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                kakaoZip.value = data.zonecode;
                kakaoAddress.value = addr;

                // (custom) 모든 주소를 한 필드에 넣는다.
                finalAddress = kakaoZip.value + " " + kakaoAddress.value + " " + kakaoDetailAddress.value;

                // 커서를 상세주소 필드로 이동한다.
                kakaoDetailAddress.focus();
                }
            }).open();
        }
        
        
               
        ////// 이벤트 리스너 /////////////////////////////////////////////////////////////////////////////////////////
        
        thumbnail.addEventListener('change', ()=>{
            const files = thumbnail.files;
            if (files[0])
            {
                const reader = new FileReader();
                reader.onload = ({target})=>
                {
                    imgPreview.src = target.result;
                };
                reader.readAsDataURL(files[0]);
            }
        });


        // 닉네임 검증: 빈 값, 범위 외의 값, 중복 값
        btnCheckNick.addEventListener('click', ()=>{

            // 1. 값이 범위를 넘는 경우
            if ((txtName.value.length < 2) || (txtName.value.length > 10)) {
                alert('아이디 길이는 2~10자만 가능합니다.');
                nickChecking = false;
                txtName.focus();
                return;
            }

            // 2. 허용되지 않은 값이 있는 경우: 한글 초성, 모음
            let regex = new RegExp(/^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,10}$/);
            let testResult = regex.test(txtName.value);
            if (testResult == false) {
                alert('닉네임은 2~10자의 한글, 영문, 숫자로만 사용할 수 있습니다.');
                nickChecking = false;
                txtName.value = '';
                txtName.focus();
                return;
            }

            // 4. 서버로 데이터를 전송한다.
            let requestData = {
                name : txtName.value
            }
            console.log(requestData);

            let xhr = new XMLHttpRequest(); // 서버와 통신을 수행하는 객체
            xhr.open('POST', '/checkNick', true);
            xhr.setRequestHeader('Content-Type', 'application/json'); // 컨텐트타입을 json으로 설정

            xhr.onreadystatechange = function() {
                // 서버와 통신하는 객체의 상태가 변하였다. (즉 서버에서 새로운 데이터가 왔다는 의미)
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        let data = xhr.responseText;
                        if (data == 'FAIL') {
                            alert('이미 존재하는 닉네임입니다.');
                            nickChecking = false;
                        }
                        else {
                            alert('사용 가능한 닉네임입니다.');
                            nickChecking = true;
                            checkedNick = txtName.value;
                        }
                    }
                    else {
                        console.error('Request failed with status: ', xhr.status);
                    }
                }
            };

            let dat = JSON.stringify(requestData);
            console.log(dat);
            xhr.send(dat);   
            });


        // 정보수정 버튼
        btnInfoUpdate.addEventListener('click', ()=>{
            
            if (txtName.value.length === 0) {
                txtName.value = vo.name;
            }

            if (txtUserPw.value.length === 0) {
                txtUserPw.value = vo.userPw;
            }

            if (txtEmail.value.length === 0) {
                txtEmail.value = vo.email;
            }

            if ((kakaoZip.value.length === 0) &&
            (kakaoAddress.value.length === 0 ) &&
            (kakaoDetailAddress.value.length === 0) &&
            (kakaoExtraAddress.value.length === 0)) {
                finalAddress = vo.address;
            }
            
            // // 데이터를 검사한다.
            // if (false === checkUpdateData()) {
            //     // alert('error');
            //     return;
            // }
            
            // 정보전송
            let formData = new FormData();
            formData.append('userId', vo.userId);
            formData.append('name', txtName.value);
            formData.append('userPw', txtUserPw.value);
            formData.append('email', txtEmail.value);
            formData.append('address', finalAddress);

            // 사용자가 프로필 사진을 첨부하였다면
            if (thumbnail.files[0] !== undefined) {
                formData.append('thumbnail', thumbnail.files[0]); // 파일이 선택되어 있지 않다면 undefined
            }

            console.log("----------- Added data in FormData: -----------");
            formData.forEach((value, key) => {
                    console.log(key + ' : ' + value);
            });

            let xhr = new XMLHttpRequest();
            xhr.open("POST", "/infoupdate", true);

            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) 
                {
                    if (xhr.status === 200) 
                    {
                        console.log('회원정보 수정 성공');
                        console.log(xhr.responseText);
                        alert('회원정보가 정상적으로 수정되었어요!');
                        location.href = "/index";
                    } 
                    else 
                    {
                        console.error("회원정보 수정 실패: ", xhr.status);
                        console.log(xhr.responseText);
                        alert('정보수정에 실패했어요.');
                        // resetPage();
                    }
                }
            };
            xhr.send(formData);
        });

        // 비밀번호의 유효성을 클라이언트가 직접 확인할 수 있도록 메세징
        txtUserPw.addEventListener('input', checkPw);
        txtCheckPw.addEventListener('input', checkPw);

        // 카카오 우편번호 찾기 버튼
        kakaoFindZipBtn.addEventListener('click', ()=>{
            getFinalAddress();
        });

        // 메인으로 버
        btnIndex.addEventListener('click', ()=>{
            location.href = "/index";
        });

        // 회원탈퇴 버튼
        btnWithdraw.addEventListener('click',()=>{
            location.href = "/withdraw";
        })
        
    })();
    </script>
</body>
</html>