<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New Content</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" href="/css/newcontent.css">
</head>
<body>
    <div class="title-nav">
        <a href="/index"><img src="/images/logo3.png" alt="PinCafe Logo"></a>
    </div>
    <hr>

    <div class="container-sm">  <!-- 부트스트랩 컨테이너 -->
        <div class="upload-block">
            <div class="atc-upload">
                <select name="divi" id="divi" class="form-select" value="${divi}" aria-label="Default select example">
                    <option selected>카페의 위치를 선택해주세요</option>
                    <option value="East">동부</option>
                    <option value="West">서부</option>
                    <option value="South">남부</option>
                    <option value="North">북부</option>
                    <option value="Central">중부</option>
                </select>
                <div class="mb-3">
                    <!-- <label for="txtTitle" class="form-label">Email address</label> -->
                    <input type="text" class="form-control" id="txtTitle" placeholder="title">
                </div>
                <p>
                    <div class="mb-3">
                        <textarea class="form-control" id="txtContent" cols="40" rows="10" placeholder="contents"></textarea>
                    </div>
                </p>    
            </div> <!-- atc-upload -->
            <div class="img-upload">
                <div class="image-container">
                    <img class="image-box previewBox" id="previewBox">                   
                </div>  <!-- image-container -->
                <form id="uploadForm">
                    <label for="fileInput" class="custom-file-button">사진 첨부</label>
                    <input type="file" id="fileInput" accept="image/*" style="display:none;" multiple='multiple'>                 
                </form>
            </div>  <!-- img-upload -->
            
            <div class="btn-container">
                <button type="button" id="btnList" class="btn btn-dark">목록</button>
                <button type="button" id="btnInsert" class="btn btn-dark">등록</button>
            </div> <!-- btn-container -->

        </div>  <!-- upload-block -->
    </div>  <!-- 부트스트랩 컨테이너 -->
    <br><br><br>


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