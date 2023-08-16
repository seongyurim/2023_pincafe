<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- 지도 첨부 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ue7v6d1q9l&submodules=geocoder"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<!-- 지도 첨부 -->

<title>New Content</title>

<!-- 지도 첨부 -->
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ue7v6d1q9l"></script>
<!-- 지도 첨부 -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" href="/css/createContent.css">
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
            
            <!-- 지도 첨부 팝업띄우는 버튼 -->
            <div id="btnWrap">
                <button type="button" id="popupBtn" class="btn btn-success">지도 첨부</button>
            </div>

            <div class="btn-container">
                <button type="button" id="btnList" class="btn btn-dark">목록</button>
                <button type="button" id="btnInsert" class="btn btn-dark">등록</button>
            </div> <!-- btn-container -->


        </div>  <!-- upload-block -->
 <!-- //모달 팝업창 -->
 <div id="modalWrap">
    <div id="modalContent">
        <div id="modalBody">
            <div id="topContainer">
                <p class="modalText">주소를 검색해서 지도를 첨부하세요.</p>
                <button type="button" class="btn-close" aria-label="Close"></button><!-- 닫기 버튼 --->
            </div>
                <!-- 주소 검색창 -->
                <div class="search">
                    <div class="searchbox">
                        <div class="form-floating mb-3">
                            <input type="text" class="myform form-control" id="address" placeholder="검색할 주소">
                            <label for="address">주소</label>
                        </div>
                        <button type="button" id="submit" class="search-btn btn btn-secondary">검색</button>
                    </div>
                    <!-- 첫 번째 지도 (검색x) 뿌려놓은 div -->
                    <div id="map"></div>

                    <!-- 주소, 위도, 경도 받아온 테이블 -->
                    <div>
                        <table>
                            <thead>
                                <!-- mapValue tr은 invisible로 만들기 -->
                                <tr id="mapValue">
                                    <th>주소</th>
                                    <th>위도</th>
                                    <th>경도</th>
                                </tr>	
                            </thead>
                            <!-- mapList tbody도 invisible로 만들기 -->
                            <tbody id="mapList"></tbody>
                        </table>
                    </div>
                </div>
                <div class="inputMap">
                    <button type="button" class="inputBtn btn btn-success">등록</button>
                </div>
        </div>
    </div>
</div>




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
        let ad = "";
        let lat = 0;
        let lng = 0;
        let mapInfo = [ad, lat, lng];

        const txtTitle   = document.querySelector('#txtTitle');
        const divi       = document.querySelector('#divi');
        const txtContent = document.querySelector('#txtContent');
        const btnList    = document.querySelector('#btnList');
        const btnInsert  = document.querySelector('#btnInsert');

        const btn = document.getElementById('popupBtn');
        const modal = document.getElementById('modalWrap');
        const closeBtn = document.querySelector('.btn-close');
        const inputBtn = document.querySelector('.inputBtn');
        const mapList = document.getElementById('mapList').getElementsByTagName("td");
        const searchbox = document.getElementById('address');
        ////// 함수부 //////////////////////////////////////////////////////////////////

        // const checkValues = function() {
        //     if ((txtTitle.value.length == 0) ||
        //         (txtContent.value.length == 0)) {
        //             return false;
        //         }
        // }




        ////// 이벤트 핸들러 ///////////////////////////////////////////////////////////

        // 모달창
        // 지도 첨부 버튼
        btn.onclick = function() {
            modal.style.display = 'block';
            searchbox.value = "";
            insertAddress("", 0, 0);
            const tdArray = Array.from(mapList);
            for (let i = 0; i < tdArray.length; i++)
            {
                tdArray[i].remove();
            }
        }

        // 모달창 닫기 버튼
        closeBtn.onclick = function() {
            insertAddress("", 0, 0);
            modal.style.display = 'none';
            searchbox.value = "";
            const tdArray = Array.from(mapList);
            for (let i = 0; i < tdArray.length; i++)
            {
                tdArray[i].remove();
            }
        }

        // 등록 버튼
        inputBtn.addEventListener ('click', ()=> 
        {
            ad = mapList.item(0).innerHTML;
            lat = mapList.item(1).innerHTML;
            lng = mapList.item(2).innerHTML;
            console.log("주소 : ", ad);
            console.log("위도 : ", lat);
            console.log("경도 : ", lng);
            modal.style.display = 'none';
        })

        // 목록으로 버튼
        btnList.addEventListener('click', ()=>{
            history.back();
        });

        // 글쓰기 버튼
        btnInsert.addEventListener('click', ()=>{
            console.log("주소 : ", ad);
            console.log("위도 : ", lat);
            console.log("경도 : ", lng);
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
                console.log(ad);
                console.log(lat);
                console.log(lng);

                formData.append('userId', '${session.userId}');
                formData.append('title',txtTitle.value);
                formData.append('content',txtContent.value);
                formData.append('divi',divi.options[divi.selectedIndex].value);
                formData.append('address',ad);
                formData.append('lat',lat);
                formData.append('lng',lng);
            
            // 만약 파일이 존재한다면 append Data 시키기
            if ($fileInput.files[0] !== undefined)
            {
                formData.append('thumbnail', $fileInput.files[0]);
            }

            // 서버에 AJAX로 전송한다.
            let xhr = new XMLHttpRequest();
            xhr.open('POST', '/bbs/createContent', true);
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

        // =============================================================================
        // 주소 검색
        // 검색한 주소의 정보를 insertAddress 함수로 넘겨준다.
        function searchAddressToCoordinate(address) {
            // Naver 지도 서비스의 geocode 함수를 호출하여 주소를 좌표로 변환
            naver.maps.Service.geocode({
                query: address
            }, function(status, response) {
                if (status === naver.maps.Service.Status.ERROR) {
                    return alert('Something Wrong!');
                }
                if (response.v2.meta.totalCount === 0) {
                    return alert('올바른 주소를 입력해주세요.');
                }
                // 변환된 주소 정보를 가져와서 처리
                var htmlAddresses = [],
                    item = response.v2.addresses[0],
                    point = new naver.maps.Point(item.x, item.y);
                // 도로명 주소가 있는 경우 배열에 추가
                if (item.roadAddress) {
                    htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
                }
                // 지번 주소가 있는 경우 배열에 추가
                if (item.jibunAddress) {
                    htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
                }
                // 영문명 주소가 있는 경우 배열에 추가
                if (item.englishAddress) {
                    htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
                }

                insertAddress(item.roadAddress, item.x, item.y);
                
            });
        }

        // 주소 검색 이벤트 핸들러
        // 주소 입력 필드(#address)에서 키보드의 키 다운 이벤트를 감지
        $('#address').on('keydown', function(e) {
            var keyCode = e.which;
            // e.which를 사용하여 눌린 키의 keyCode를 얻는다.
            if (keyCode === 13) { // Enter Key
                searchAddressToCoordinate($('#address').val());
                // 만약 눌린 키가 엔터 키(키 코드 13)라면, 
                // searchAddressToCoordinate 함수를 호출하여 주소를 좌표로 변환하고 지도에 표시
            }
        });
        // 제출 버튼(#submit)을 클릭하는 이벤트를 감지하는 이벤트 핸들러
        $('#submit').on('click', function(e) {
            e.preventDefault();
            // 기본 동작을 막기 위해 e.preventDefault();를 사용
            searchAddressToCoordinate($('#address').val());
            // searchAddressToCoordinate 함수를 호출하여 주소를 좌표로 변환하고 지도에 표시
        });
        naver.maps.Event.once(map, 'init_stylemap', initGeocoder);
        // 1. Naver 지도 객체(map)에서 'init_stylemap' 이벤트가 최초로 발생할 때에만 
        // initGeocoder 함수를 호출
        // 2. init_stylemap 이벤트는 지도 스타일이 초기화되는 시점을 나타냄
        // 3. initGeocoder 함수를 호출하여 지오코더(geocoder)를 초기화하고 
        // 주소를 좌표로 변환할 수 있는 환경을 설정

        //검색정보를 테이블로 작성해주고, 지도에 마커를 찍어준다.
        function insertAddress(address, latitude, longitude) {
            var mapList = "";
            mapList += "<tr>"
            mapList += "	<td>" + address + "</td>"
            mapList += "	<td>" + longitude + "</td>"
            mapList += "	<td>" + latitude + "</td>"
            mapList += "</tr>"

            $('#mapList').append(mapList);	

            var map = new naver.maps.Map('map', {
                center: new naver.maps.LatLng(longitude, latitude),
                zoom: 14
            });
            var marker = new naver.maps.Marker({
                map: map,
                position: new naver.maps.LatLng(longitude, latitude),
            });
        }

    })();
    </script>
</body>
</html>