<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Article</title>
</head>
<body>
    <h1>Article</h1>

    <input type="text" id="txtTitle" value="${vo.title}"><span id="txtId">${vo.userId}</span>
    <br><br>
    <textarea name="" id="txtContent" cols="30" rows="10">${vo.content}</textarea>
    <br>
    <button type="button" id="btnList">목록</button>
    <button type="button" id="btnUpdate">수정</button>

    <script src="/JS/jquery-3.7.0.min.js"></script>


    <script>
    (()=>{
            // 변수 설정
            let myContent = false;
            let modify = false;
            
            const title = document.querySelector('#txtTitle');
            const content = document.querySelector('#txtContent');
            const btnUpdate = document.querySelector('#btnUpdate');
            const btnList = document.querySelector('#btnList');

            // =================================================================
            // 함수
            const checkMyContent = function()
            {
                // 현재 로그인한 userId와 해당 글 vo의 userId가 같으면
                if ('${session.userId}' === '${vo.userId}')
                {
                    myContent = true;
                    // alert ("내 글 맞음");
                }
                else 
                {
                    myContent = false;
                    // alert ("내 글 아님");
                }
            }

            //// 내글 여부에 따라 UI 바꾸는 함수
            const setUiObject = function()
            {
                // 내 글이 아니면 read only
                if (myContent === false)
                {
                    // 타이틀과 컨텐츠를 read only로
                    title.setAttribute('readonly', true);
                    // = title.setAttribute('readonly', 'readonly');
                    content.setAttribute('readonly', true);

                    // 수정 버튼은 disable로
                    btnUpdate.setAttribute('disabled', true);
                }
            }

        // ===================================================================
        // 이벤트 핸들러

        // 목록 버튼 이벤트리스너
        btnList.addEventListener('click', ()=>{
            // history.back();
            location.href='/index';
        });

        btnUpdate.addEventListener('click', ()=>{
            // updateData = 서버에 던질 데이터
            // 던질 데이터를 마련한다. (id, seq, title, content)
            // 내용만 던지면 서버가 어디에 맞춰 저장하라는 건지 모르므로
            // userId와 seq를 내용과 꼭 함께 던져줘야 함 (즉, key를 던져줘야 함)
            let updateData = {
                userId : '${vo.userId}',
                title : title.value,
                content : content.value
            };
            // console.log(updateData);

            if (confirm('수정하시겠습니까?'))
            {
                $.ajax
                ({
                    url : '/bbs/content', 
                    type : 'POST',
                    data : updateData,
                    success : function(data)
                    {
                        // controller 로 data 보냄 (postmapping)으로 받도록
                        // console.log(data);
                        if (data === "OK")
                        {
                            alert ("수정되었습니다.");
                        }
                        else
                        {
                            alert ("수정에 실패하였습니다.")
                        }
                    }
                });
            }
        });

        // =================================================================
        // 호출부
        // checkMyContent();
        // setUiObject();

    })();
    </script>
</body>
</html>