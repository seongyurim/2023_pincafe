<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New Content</title>
</head>
<body>
    <h1>New Content</h1>
    <hr>

    <p>
        <input type="text" id="txtTitle" maxlength="150">
        <select name="divi" id="divi" value="${divi}">
            <option value="C">일반(Common)</option>
            <option value="R">필독(Required)</option>
            <option value="N">공지(Notice)</option>
        </select>
    </p>
    <p><textarea id="txtContent" cols="40" rows="10" maxlength="1000"></textarea></p>    
    <button type="button" id="btnList">목록으로</button>
    <button type="button" id="btnInsert">등록하기</button>

    <script src="/JS/jquery-3.7.0.min.js"></script>

    <script>
    (()=>{

        let myContent = false;

        const txtTitle   = document.querySelector('#txtTitle');
        const divi       = document.querySelector('#divi');
        const txtContent = document.querySelector('#txtContent');
        const btnList    = document.querySelector('#btnList');
        const btnInsert  = document.querySelector('#btnInsert');


        ////// 함수부 //////////////////////////////////////////////////////////////////

        // const checkValues = function() {
        //     if ((txtTitle.value.length == 0) ||
        //         (txtContent.value.length == 0)) {
        //             return false;
        //         }
        // }




        ////// 이벤트 핸들러 ///////////////////////////////////////////////////////////

        // 목록으로 버튼
        btnList.addEventListener('click', ()=>{
            history.back();
        });

        // 글쓰기 버튼
        btnInsert.addEventListener('click', ()=>{
            if (txtTitle.value == "") {
                alert('제목을 입력해주세요.');
                return;
            }
            else if (txtContent.value == "") {
                alert('본문을 입력해주세요.');
            }
            else {
                // DB로 전송할 데이터
                let requestData = {
                    userId : '${session.userId}',
                    title : txtTitle.value,
                    content : txtContent.value,
                    divi : divi.options[divi.selectedIndex].value
                };
                console.log(requestData);
    
                $.ajax({
                    url : '/bbs/newcontent',
                    type : 'POST',
                    data : requestData,
                    success : function(data) {
                        if (data == "OK") {
                            alert('게시물이 성공적으로 등록되었어요.');
                            location.href = "/index";
                        }
                        else {
                            alert('게시물 등록에 실패했어요.');
                        }
                    }
                });
            }
            
        });     
    })();
    </script>
</body>
</html>