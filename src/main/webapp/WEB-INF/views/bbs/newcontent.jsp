<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New Content</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

<style>
    /* title영역 */
    .title-nav {
        text-align: center;
    }

    /* ========================================================================*/
    /* 업로드 영역 전체 스타일 */
    .upload-block {
        display: flex;
        align-items: center;
        flex-direction: column;
        justify-content: space-between;
        max-width: 1200px;
        height: 100%;
        margin: 0 auto;
    }

    /* ========================================================================*/
    /* 이미지 업로드 영역 */
    .img-upload {
        /* position: absolute; */
        display: flex;
        align-items: center;
        flex-direction: column;  /* 수직 정렬 */
        margin: auto 100px;
        width: 100%;
    }
    
    /* 이미지 컨테이너 */
    .image-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        align-content: space-around;
        margin: auto 20px;
        width: 100%;
        height: 100%;
    }

    /* 이미지가 들어갈 박스 (상위 클래스) */       
    .image-box {
    width: 200px;
    height: 200px;
    margin: 10px;
    box-sizing: border-box;
    border: 1px solid gray;
    border-radius: 15%;

    /* 이미지 꽉 차고 중앙정렬하고 기본 백그라운드컬러 설정 */
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center;
    background-color: #f0f0f0;
    }


    /* 이미지가 들어갈 박스 */  
    /*
    .previewBox 
    {
        flex: 0 0 calc(50% - 30px); */ /* 이미지 박스들이 한 줄에 2개씩 정렬되도록 너비 설정 */
        /*
        width: 100px; 
        height: 150px;
        margin: 10px;
        box-sizing: border-box;
        border: 1px solid gray;
        border-radius: 15%;
        

        /* 이미지 꽉 차고 중앙정렬하고 기본 백그라운드컬러 설정 */
        /*
        background-size: contain;
        background-repeat: no-repeat;
        background-position: center;
        background-color: #f0f0f0;
    } */

    /* 이미지가 들어갈 박스 */       
    .previewBox 
    {
        width: 200px;
        height: 200px;
        margin: 10px;
        box-sizing: border-box;
        border: 1px solid gray;
        border-radius: 15px;

        /* 이미지 꽉 차고 중앙정렬하고 기본 백그라운드컬러 설정 */
        background-size: contain;
        background-repeat: no-repeat;
        background-position: center;
        background-color: #f0f0f0;
    }


    /* 이미지 업로드 버튼 */
    .custom-file-button {
        display: inline-block;
        text-align: center;
        padding: 12px 15px; /* 버튼의 여백 조정 */
        width: 200px; 
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
    }

    .custom-file-button:hover {
        background-color: #45a049;
    }

    /* ========================================================================*/
    /* 글 업로드 영역 */
    .atc-upload {
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 100%;

        /* display: flex;
        align-items: center; 
        flex-direction: column;
        width: 100%;
        max-width: 800px;
        height: 100%; */
    }

    /* 글 작성 영역 (제목, 글) */
    .atc-write {
        position: relative;
        display: flex;
        flex-direction: column;  
        align-items: center;
    }

    /* 제목 */
    #txtTitle {
        width: 100%; /* 100% 너비를 사용하여 수평으로 늘어나도록 함 */
        margin-top: 20px;
        margin-bottom: 5px; /* 제목과 내용 사이 간격 설정 */
        border: 1px solid gray;
        font-size: 16px; /* 글자 크기 조정 */
        border-radius: 5px;
    }

    /* 본문 영역 */
    #txtContent {
        width: 100%; 
        height: 300px;
        margin-bottom: 10px; /* 본문과 버튼 사이 간격 설정 */
        padding: 8px; /* 입력창 내부 여백 조정 */
        font-size: 14px; /* 글자 크기 조정 */
        border: 1px solid gray;
        border-radius: 8px;
        resize: none;
    }

    /* 글 영역 버튼 컨테이너 */
    .btn-container {
        margin-top: 20px;
        margin-left: 30px;
        display: flex;
    }

    /* 글작성 버튼 스타일 */
    .btnAtc {
        padding: 15px 12px; /* 버튼의 여백 조정 */
        width: 80px; 
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 8px;
        margin-bottom: 10px; /* 버튼 간 수직 간격 조정 */
    }

    .btnAtc:hover {
        background-color: #45a049;
    }

</style>
</head>
<body>
    <h1 class="title-nav">PinCafe</h1>
    <hr>

    <div class="container-sm">  <!-- 부트스트랩 컨테이너 -->
        <div class="upload-block">
            <div class="atc-upload">
                    <input type="text" id="txtTitle" maxlength="150">
                    <select name="divi" id="divi" value="${divi}">
                        <option value="C">일반(Common)</option>
                        <option value="R">필독(Required)</option>
                        <option value="N">공지(Notice)</option>
                    </select>
                </p>
                <p><textarea id="txtContent" cols="40" rows="10" maxlength="1000"></textarea></p>    
            </div> <!-- atc-upload -->
            <div class="img-upload">
                <div class="image-container">
                    <img class="image-box previewBox" id="previewBox">                   
                </div>  <!-- image-container -->
                <form id="uploadForm">
                    <label for="fileInput" class="custom-file-button">사진 업로드</label>
                    <input type="file" id="fileInput" accept="image/*" style="display:none;" multiple='multiple'>                 
                </form>
            </div>  <!-- img-upload -->
            
            <div class="btn-container">
                <button type="button" id="btnList">목록으로</button>
                <button type="button" id="btnInsert">등록하기</button>
            </div> <!-- btn-container -->

        </div>  <!-- upload-block -->
    </div>  <!-- 부트스트랩 컨테이너 -->


    <script src="/JS/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

    <script>
    (()=>{
        // =========================================================================================
        // DOM 객체
        // 미리보기
        const $btnInsert = document.getElementById('btnInsert');
        const $btnUndo = document.getElementById('btnUndo');
        const $fileInput = document.getElementById('fileInput');
        const $imageContainers = document.querySelector('.image-box');
        const $previewBoxes = document.querySelectorAll('.previewBox');
        const $uploadForm = document.getElementById('uploadForm');

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
                let formData = new FormData();

                formData.append('userId', '${session.userId}');
                formData.append('title',txtTitle.value);
                formData.append('content',txtContent.value);
                formData.append('divi',divi.options[divi.selectedIndex].value);
            
            // 만약 파일이 존재한다면 append Data 시키기
            if ($fileInput.files[0] !== undefined)
            {
                formData.append('thumbnail', $fileInput.files[0]);
            }

            // 서버에 AJAX로 전송한다.
            let xhr = new XMLHttpRequest();
            xhr.open('POST', '/bbs/newcontent', true);
            xhr.onreadystatechange = function()
            {
                // 수신이 완료됐으면
                if (xhr.readyState === XMLHttpRequest.DONE)
                {
                    if (xhr.status === 200)
                    {
                        console.log("게시글 업로드 성공");
                        console.log('서버가 전송한 메세지 : ' + xhr.responseText);
                        alert ("게시글 작성 성공!");
                        location.href = "/index";
                    }
                    else
                    // 400이나 500이면
                    {
                        console.error("망함");
                        console.error("서버가 전송한 에러코드 : "  + xhr.status);
                    }
                }
            }
            xhr.send(formData);               

            }      
        });     

        // =======================================================================================

        // 이미지 파일 선택 시 미리보기 (1개 ver)
        $fileInput.addEventListener ('change', ()=>
        {
            // clearPreviewBoxes();
            const files = $fileInput.files;
            if (files[0])
            {
                const reader = new FileReader();
                reader.onload = ({target})=>
                {
                    if ({target} == null)
                    {
                        $previewBoxes[0].style.display = 'none';
                    }
                    $previewBoxes[0].src = target.result;
                };
                reader.readAsDataURL($fileInput.files[0]);
            }
        });

        // // 이미지 파일 선택 시 미리보기 (4개 ver)
        // $fileInput.addEventListener ('change', ()=>
        // {
        //     // clearPreviewBoxes();
        //     const files = $fileInput.files;
        //     for (let i = 0; i < 4; i++)
        //     if (files[i])
        //     {
        //         const reader = new FileReader();
        //         reader.onload = ({target})=>
        //         {
        //             if ({target} == null)
        //             {
        //                 $previewBoxes[i].style.display = 'none';
        //             }
        //             $previewBoxes[i].src = target.result;
        //         };
        //         reader.readAsDataURL($fileInput.files[i]);
        //     }
        // });
    })();
    </script>
</body>
</html>