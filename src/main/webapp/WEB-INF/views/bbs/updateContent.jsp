<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Content</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

<style>
   
   
    /* 좋아요 아이콘 */
    .h_container {
    background-color: #cac7c7;
    border-radius: 20px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, .1);
    display: flex; /* 플렉스 박스로 변경 */
    align-items: center; /* 세로 중앙 정렬 */
    width: fit-content; /* 내용에 맞게 너비 설정 */
    padding: 5px 10px; /* 여백 조정 */ 
    }
    
    /* 좋아요 아이콘이 토글되면 빨간색으로 만들기 */
    .h_container:hover {
        color: red;
    }

    #heart.is-liked {
      color: red;
    }


    #jb-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    }
    
    #jb_header {
    padding: 20px;
    display: flex;
    align-items: center;
    border: 1px solid #bcbcbc;
    font-size: 20px;
    justify-content: flex-start; /* 요소들을 왼쪽으로 정렬 */
    } 

    #jb_main {
    margin: 20px auto;
    display: flex;
    justify-content: space-between;
    }

    #jp_header_title {
      display: flex;
      align-items: center;
      justify-content: center; /* 요소들을 가운데로 정렬 */
      flex: 1; /* 남은 가로 공간을 차지하여 너비를 조절 */
    }

    #Cafe_name {
      font-size: 24px;
    }

    #jb-content {
  text-align: center; /* 내용을 가운데 정렬 */
}

#bbsDetail {
  display: inline-block; /* 이미지와 내용을 가로로 나열 */
  margin-top: 20px; /* 이미지와 내용 사이에 간격 추가 */
}

#imageAndContentContainer {
  display: flex; /* 이미지와 내용을 가로로 나열 */
  flex-direction: column; /* 요소들을 수직으로 정렬 (이미지 위, 내용 아래로 배치) */
  align-items: center; /* 가로 축으로 가운데 정렬 */
}

#postImage {
  max-width: 100%; /* 이미지의 최대 가로 폭 설정 */
  max-height: 500px; /* 이미지의 최대 높이 설정 */
}

#bulletinContent {
  padding-top: 20px; /* 이미지와 내용 사이에 간격 추가 */
}

#jb-footer {
  display: flex;
  justify-content: center; /* 가로 축으로 가운데 정렬 */
  border: 1px solid #bcbcbc;
  box-sizing: border-box; /* 테두리를 기준으로 크기 설정 */
  padding: 20px; /* 버튼과 테두리 사이에 간격 추가 */
}
#txtDivi {
  width: 100px;
}


   
</style>


</head>
<body>
  <div id="jb_header">
    <a href="/index"><img src="/images/logo3.png" alt="PinCafe Logo"></a>
    <div id="jp_header_title">
        <select id="txtDivi" class="form-select" aria-label="Default select example">
            <option value="<%= session.getAttribute('divi') %>"> <%= session.getAttribute('divi') %></option>
            <option value="동부">동부</option>
            <option value="서부">서부</option>
            <option value="남부">남부</option>
            <option value="북부">북부</option>
            <option value="중부">중부</option>
        </select>
        <p><input type="text" id="txtTitle" value="<%= session.getAttribute('title') %>"></p>
        <div class="h_container">
            <i id="heart" class="far fa-heart" onclick="likeCafe()"></i><span id="likeCount">0</span>
        </div>
    </div>
</div>

<div id="jb-content">
    <div id="bbsDetail">
        <div id="imageAndContentContainer">
            <img id="postImage" src="" alt="게시물 이미지">
            <div id="bulletinContent">
                <p><textarea id="txtContent" cols="90" rows="15"><%= session.getAttribute("content") %></textarea></p>
            </div>
        </div>
    </div>
</div>

<div id="jb-footer">
    <button type="button" id="btnList">목록으로</button>
    <button type="button" id="btnUpdate">수정하기</button>
</div>
    
    <script src="/JS/jquery-3.7.0.min.js"></script>
    <!-- 좋아요 하트 외부에서 가져오기 -->
    <script src="https://kit.fontawesome.com/3929e16ef5.js" crossorigin="anonymous"></script>  
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

    <script>
    (()=>{

      console.log("수정하기 페이지입니다.");

        let myContent = false;

        const txtTitle   = document.querySelector('#txtTitle');
        const txtContent = document.querySelector('#txtContent');
        const btnList    = document.querySelector('#btnList');
        const btnUpdate  = document.querySelector('#btnUpdate');
      ////////////////////////////////////////////////////////////////////
      
      
      

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
                btnUpdate.style.display = 'none';
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
            // DB로 전송할 데이터: id, seq, title, content,divi
            let requestData = {
                userId : '${vo.userId}',
                seq : '${vo.seq}',
                title : txtTitle.value,
                content : txtContent.value,
                divi : txtDivi.value
            };
            console.log(requestData);

            $.ajax({
                url : '/bbs/updateContent',
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


  ///////////////////////////////////////////////////////////////////////////
  //이미지 표시함수

    
     // 이미지를 표시하는 함수
    function displayImage(imageUrl, divi) {
        const postImage = document.getElementById('postImage');
        if (imageUrl && divi) {
            // 이미지 URL이 유효하고 divi 값이 있는 경우 이미지를 표시
            postImage.src = imageUrl;
            postImage.style.display = "block"; // 이미지 보이기
        } else {
            // 이미지 URL이 없거나 divi 값이 없는 경우 이미지 영역을 숨김
            postImage.style.display = "none";
        }
    }

    // 페이지 로드 후 실행
    document.addEventListener("DOMContentLoaded", function () {
        // 세션에서 이미지 URL 가져오기
        const sessionImageUrl = "${vo.fileCode}" === "null" ? null : "/imgs/member/thumbnail/${vo.fileCode}.jpg";
        
        // 세션에서 divi 값 가져오기
        const divi = "${vo.fileCode}" === "(null)" ? null : "${vo.fileCode}";

        // 이미지를 표시
        displayImage(sessionImageUrl, divi);
    });


    })();

    
   

   

    </script>
</body>
</html>