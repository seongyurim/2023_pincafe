<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Content</title>
</head>
<body>
    <h1>UPDATE</h1>
    <hr>

    <p><input type="text" id="txtTitle" value="${vo.title}"><span id="txtId"> ${vo.userId}</span></p>
    <p><textarea id="txtContent" cols="30" rows="10">${vo.content}</textarea></p>    
    <button type="button" id="btnList">목록으로</button>
    <button type="button" id="btnUpdate">수정하기</button>

    <script src="/JS/jquery-3.7.0.min.js"></script>

    <script>
    (()=>{

        let myContent = false;

        const txtTitle   = document.querySelector('#txtTitle');
        const txtContent = document.querySelector('#txtContent');
        const btnList    = document.querySelector('#btnList');
        const btnUpdate  = document.querySelector('#btnUpdate');



        ////// 함수부 //////////////////////////////////////////////////////////////////

        // 현재 사용자와 게시글 작성자가 동일한지 확인한다.
        const checkMyContent = function() {
            if ('${session.userId}' === '${vo.userId}') {
                myContent = true;
            }
            else {
                // 로그인하지 않은 사용자인 경우(session.userId = '')
                // 로그인한 회원이지만 게시글 작성자와 다른 경우
                myContent = false;
            }
            console.log(myContent);
        }

        //
        const setUiObject = function() {
            // 내 컨텐츠가 아니라면 읽기만 가능하다.
            if (myContent == false) {
                // 타이틀과 컨텐츠를 Read Only + 수정버튼을 diabled
                txtTitle.setAttribute('readonly', 'readonly');
                txtContent.setAttribute('readonly', 'readonly');
                btnUpdate.setAttribute('disabled', 'disabled');
            }
            // 내 컨텐츠가 맞다면 읽기/쓰기가 모두 가능하다.
            else {
                // 수정이 가능하도록 readonly 속성 삭제
                txtTitle.removeAttribute('readonly');
                txtContent.removeAttribute('readonly');
            }
        }



        ////// 이벤트 핸들러 ///////////////////////////////////////////////////////////

        // 목록으로 버튼
        btnList.addEventListener('click', ()=>{
            history.back();
        });

        // 수정하기 버튼
        btnUpdate.addEventListener('click', ()=>{
            // DB로 전송할 데이터: id, seq, title, content
            let requestData = {
                userId : '${vo.userId}',
                seq : '${vo.seq}',
                title : txtTitle.value,
                content : txtContent.value
            };
            console.log(requestData);

            $.ajax({
                url : '/bbs/content',
                type : 'POST',
                data : requestData,
                success : function(data) {
                    if (data == "OK") {
                        alert('게시물이 성공적으로 수정되었어요.');
                        location.href = "/index";
                    }
                    else {
                        alert('게시물 수정에 실패했어요.');
                    }
                }
            });
        });



        ////// 호출부 //////////////////////////////////////////////////////////////////

        checkMyContent(); // 내 컨텐츠가 맞다면 myContent => true
        setUiObject(); // 내 컨텐츠인 경우에만 수정 가능하게
        
    })();
    </script>
</body>
</html>