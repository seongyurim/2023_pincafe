<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>Content</title>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ue7v6d1q9l&submodules=geocoder"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ue7v6d1q9l"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Template Vendor CSS Files -->
<link href="assets/vendor/aos/aos.css" rel="stylesheet">
<link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

<!-- Template Main CSS File -->
<link rel="stylesheet" href="/assets/css/style.css">

<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" href="/css/index.css">
<link rel="stylesheet" href="/css/updateContent.css">
</head>
<body>

    <!-- 내비게이션 -->
    <%@ include file="../navigation.jsp" %>

    <div class="container-sm master_container">
      <div class="titleSet">
        <select name="divi" id="divi" class="form-select myselect" value="${divi}">
          <option selected>카페 위치</option>
          <option value="East">동부</option>
          <option value="West">서부</option>
          <option value="South">남부</option>
          <option value="North">북부</option>
          <option value="Central">중부</option>
        </select>
        <div class="mb-3 titleArea">
          <input type="text" id="txtTitle" class=form-control name="title" value="${vo.title}">
        </div>
      </div>
      <div class="mb-3"><img id="postImage" src="" alt="Posted Image"></div>
      <textarea id="txtContent" class=form-control cols="90" rows="15">${vo.content}</textarea>
    
    <div class="mapSet">
      <div id="cafeAddress">
        <span><img id="pinImg" src="/images/location.png"></span>
        <span>${vo.address}</span>
      </div>
      
      <div class="map-container">
        <div id="map"></div>
      </div>
    </div>
  </div>
  
  <div class="btnSet">
    <button type="button" id="btnBack" class="btn btn-light">취소</button>
    <button type="button" id="btnUpdate" class="btn btn-info">수정</button>
  </div>


    <!-- <div id="jb_header">
      <div id="jp_header_title">
        <a href="/index"><img src="/images/logo3.png" alt="PinCafe Logo"></a>
        <div id="titleDiv"><input type="text" id="txtTitle" value="${vo.title}"></div>
        <div id="hcDiv">
          <div class="h_container">
            <i id="heart" class="far fa-heart" onclick="likeCafe()"></i><span id="likeCount">&nbsp;0</span>           
          </div>
        </div>
      </div> 
    </div> -->

    <!-- 이미지 캐러셀 -->
    <!-- <div id="carouselDiv">
    <div id="carouselExampleIndicators" class="carousel slide">
      <div class="carousel-indicators">
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
      </div>
      <div class="carousel-inner">
        <div class="mycarousel carousel-item active">
          <img src="" id="postImage" class="d-block w-100" alt="...">
        </div>
        <div class="mycarousel carousel-item">
          <img src="/images/cat.jpeg" id="postImage2" class="d-block w-100" alt="...">
        </div>
        <div class="mycarousel carousel-item">
          <img src="/images/jjanggu5.jpg" id="postImage3" class="d-block w-100" alt="...">
        </div>
      </div>
      <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div> 
    </div> -->

    <!-- 이미지 캐러셀 -->
    <!-- <div id="jb-content">
      <div id="bbsDetail">
        <div id="imageAndContentContainer"> -->
          <!-- <img id="postImage" src="" alt="게시물 이미지"> -->
          <!-- <div id="bulletinContent">
            <p><textarea id="txtContent" cols="90" rows="15">${vo.content}</textarea></p>
          </div>
        </div>
      </div>
    </div> -->

    <!-- Template Vendor JS Files -->
    <script src="assets/vendor/aos/aos.js"></script>
    <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
    <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
    <script src="assets/vendor/php-email-form/validate.js"></script>
    
    <!-- Template Main JS File -->
    <script src="assets/js/main.js"></script>
    
    <script src="/JS/jquery-3.7.0.min.js"></script>
    <!-- 좋아요 하트 외부에서 가져오기 -->
    <script src="https://kit.fontawesome.com/3929e16ef5.js" crossorigin="anonymous"></script>  
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

    <script>
    (()=>{
        console.log('${vo.title}');

        // 위도, 경도 변수 설정
        let lat = 0;
        let lng = 0;

        let myContent = false;

        const profileImg    = document.querySelector('#profileImg');
        const welcomeMsg    = document.querySelector('#welcomeMsg');
        const btnIntro      = document.querySelector('#btnIntro');
        const btnBBS        = document.querySelector('#btnBBS');
        const btnLogin      = document.querySelector('#btnLogin');
        const btnJoin       = document.querySelector('#btnJoin');
        const btnInfoUpdate = document.querySelector('#btnInfoUpdate');
        const mydivider     = document.querySelector('#mydivider');

        const txtTitle   = document.querySelector('#txtTitle');
        const txtContent = document.querySelector('#txtContent');
        const btnUpdate  = document.querySelector('#btnUpdate');
        const btnBack    = document.querySelector('#btnBack');
        const cafeAd     = document.querySelector('#cafeAd');
        const imageContainer = document.querySelector('#imageContainer');

        ////// 함수부 //////////////////////////////////////////////////////////////////

        // 현재 세션이 있는지 없는지 설정해준다.
        const setSessionState = function() {
            if ('${vo.userId}' == '') {
                sessionState = false;
            }
            else {
                sessionState = true;
            }
        }
        
        // 로그인 인포 설정
        const setSessionInfo = function() {
            if (sessionState === true) {
                welcomeMsg.textContent = '${session.name}님 반갑습니다.';
                btnLogin.textContent = 'Sign Out';
                btnJoin.style.display = 'none';
                profileImg.setAttribute('src', '/imgs/member/thumbnail/${session.fileCode}.jpg');
            }
            else {
                welcomeMsg.textContent = '어서오세요! Pincafe입니다.';
                btnLogin.textContent = 'Sign In';
                btnInfoUpdate.style.display = 'none';
                profileImg.style.display = 'none';
                mydivider.style.display = 'none';
            }
        }

        // 지도를 그려주는 함수
        function selectMapList() {

            lat = '${vo.lat}';
            lng = '${vo.lng}';
            
            let map = new naver.maps.Map('map', {
                center: new naver.maps.LatLng(lat, lng),
                zoom: 16
            });

            let marker = new naver.maps.Marker({
            position: new naver.maps.LatLng(lat, lng),
            map: map});

            console.log(lat, lng);
        }

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

        ////// 이벤트 핸들러 ///////////////////////////////////////////////////////////

        // 로그인 버튼
        btnLogin.addEventListener('click', ()=>{
          if (sessionState === true) { // 로그인한 상태라면
              if (!confirm("정말 로그아웃 하시겠어요?")) {
                  return;
              }
              else {
                  alert('정상적으로 로그아웃 되었어요.');
                  location.href = '/logout';
              }
          }
          else { // 로그인한 상태가 아니라면
              location.href = '/login';
          }
        });

        // 회원가입 버튼
        btnJoin.addEventListener('click', ()=>{
          location.href = '/join';
        });

        // 정보수정 버튼
        btnInfoUpdate.addEventListener('click', ()=> {
          location.href = "/infoupdate";
        });

        // 게시판 버튼
        btnBBS.addEventListener('click', ()=>{
          btnBBS.setAttribute('href', '/bbsmain');
        });

        // 페이지소개 버튼
        btnIntro.addEventListener('click', ()=>{
          btnIntro.setAttribute('href', '/introduction');
        });

        // 취소 버튼
        btnBack.addEventListener('click', ()=>{
          if (!confirm("변경사항이 저장되지 않을 수 있습니다.\n글 수정을 취소하시겠어요?")) {
            return;
          }
          else {
            history.back();
          }
        });

        // 수정 버튼
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
                url : '/bbs/updateContent',
                type : 'POST',
                data : requestData,
                success : function(data) {
                    if (data == "OK") {
                        alert('게시물이 성공적으로 수정되었어요.');
                        location.href = "/bbsmain";
                    }
                    else {
                        alert('게시물 수정에 실패했어요.');
                    }
                }
            });
        });

    ////// 호출부 //////////////////////////////////////////////////////////////////

    setSessionState();
    setSessionInfo();
    checkMyContent(); // 내 컨텐츠가 맞다면 myContent => true
    selectMapList();
    
    ///////////////////////////////////////////////////////////////////////////
    //이미지 표시함수

    // 이미지를 표시하는 함수
    function displayImage(imageUrl) {
      const postImage = document.getElementById('postImage');
      postImage.src = imageUrl;
    }

    // 페이지 로드 후 실행
    document.addEventListener("DOMContentLoaded", function () {
        // 이미지를 서버의 경로를 기반으로 표시
        const imageUrl = "/imgs/member/thumbnail/${vo.fileCode}.jpg";
        displayImage(imageUrl);
    });

    })();

    </script>
</body>
</html>