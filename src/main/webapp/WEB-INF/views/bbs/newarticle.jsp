<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>New Article</title>
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
                justify-content: space-between;
                max-width: 1000px;
                height: 100%;
                margin: 0 auto;
            }

            /* ========================================================================*/
            /* 이미지 업로드 영역 */
            .img-upload {
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
                flex: 0 0 calc(50% - 30px); /* 이미지 박스들이 한 줄에 2개씩 정렬되도록 너비 설정 */
                width: 100px;
                height: 150px;
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
            .previewBox 
            {
                flex: 0 0 calc(50% - 30px); /* 이미지 박스들이 한 줄에 2개씩 정렬되도록 너비 설정 */
                width: 100px;
                height: 150px;
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

            /* 이미지 업로드 버튼 */
            .custom-file-button {
                display: inline-block;
                text-align: center;
                padding: 12px 15px; /* 버튼의 여백 조정 */
                width: 250px; 
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
                align-items: flex-start; 
                margin: auto 5px;
                width: 100%;
                height: 100%;
                padding-right: 30px; /* 버튼들과 간격 조정 */
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
                border-radius: 5px;
            }

            /* 본문 영역 */
            #txtContent {
                resize: vertical; /* 텍스트 영역 크기 조정 가능 */
                width: 100%; 
                height: 100%;
                border: 1px solid gray;
                border-radius: 8px;
                resize: none;
            }

            /* 글 영역 버튼 컨테이너 */
            .btn-container {
                margin-top: 20px;
                margin-left: 30px;
                display: flex;
                flex-direction: column; /* 버튼들을 수직으로 정렬 */
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

        <div class="container-md">
            <div class="upload-block">
                <div class="img-upload">
                    <div class="image-container">
                        <img class="image-box previewBox" id="previewBox1">                   
                        <img class="image-box previewBox" id="previewBox2">
                        <img class="image-box previewBox" id="previewBox3">
                        <img class="image-box previewBox" id="previewBox4">
                    </div>
                    <form id="uploadForm">
                    <label for="fileInput" class="custom-file-button">사진 업로드</label>
                    <input type="file" id="fileInput" accept="image/*" style="display:none;" multiple='multiple'>                 
                    </form>
                </div>
                <div class="atc-upload">
                    <div class="atc-write">
                        <input type="text" id="txtTitle" placeholder="제목" style="width:300px;height:30px;font-size:16px;">
                        <p><textarea id="txtContent" cols="80" rows="20" maxlength="1000"></textarea></p>    
                    </div>
                    <div class="btn-container">
                        <button type="button" class="btnAtc" id="btnInsert">등록</button>
                        <button type="button" class="btnAtc" id="btnUndo">취소</button>
                    </div>
                </div>
            </div>
        </div>
    <script>
    (()=>{
        // DOM 객체
        const $btnInsert = document.getElementById('btnInsert');
        const $btnUndo = document.getElementById('btnUndo');
        const $fileInput = document.getElementById('fileInput');
        const $imageContainers = document.querySelector('.image-box');
        const $previewBoxes = document.querySelectorAll('.previewBox');
        const $uploadForm = document.getElementById('uploadForm');

        // 이벤트 핸들러
        $btnInsert.addEventListener ('click', ()=>
        {
            console.log("등록");
            // location.href = "";
        });

        $btnUndo.addEventListener ('click', ()=>
        {
            console.log("취소");
            location.href = "/index";
        });

        // 이미지 파일 선택 시 미리보기
        $fileInput.addEventListener ('change', ()=>
        {
            // clearPreviewBoxes();
            const files = $fileInput.files;
            for (let i = 0; i < 4; i++)
            if (files[i])
            {
                const reader = new FileReader();
                reader.onload = ({target})=>
                {
                    if ({target} == null)
                    {
                        $previewBoxes[i].style.display = 'none';
                    }
                    $previewBoxes[i].src = target.result;
                };
                reader.readAsDataURL($fileInput.files[i]);
            }
            // else 
            // {
            //     $previewBoxes[i].style.display = 'none';
            // }
        });

        function resetForm() 
        {
            $uploadForm.reset();
            clearPreviewBoxes();
        }

        function clearPreviewBoxes()
        {
            for (let i = 0; i < 4; i++)
            {
                $previewBoxes[i].style.display = 'none';
            }
        }
    })();
    </script>
</body>
</html>