<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>Content</title>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ue7v6d1q9l&submodules=geocoder"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
<link rel="stylesheet" href="/css/readContent.css">
</head>
<body>

  <!-- 내비게이션 -->
  <%@ include file="../navigation.jsp" %>

  <div class="container-sm master_container">
    <div class="mb-3 titleArea">
      <div id="divi">[${vo.divi}]</div>
      <h1 id="txtTitle" name="title">${vo.title}</h1>
      <div class="writerInfo">
        <div class="ImgArea">
          <img class="profileImg" src="/imgs/member/thumbnail/${authorProfileImg}.jpg">
        </div>
        <div class="profileArea">
          <div class="profileAreaUpper">
            <span class="nickname">${authorNickname}</span>
          </div>
          <div class="profileAreaLower">
            <span class="regDate">${vo.regdate}</span>
            <span class="countTxt">조회</span>
            <span class="viewCount">${vo.viewCount}</span>
          </div>
        </div>
        <div class="btnArea">
          <button type="button" id="btnList" class="mybtn btn btn-light btn-sm">목록으로</button>
          <button type="button" id="btnUpdate" class="mybtn btn btn-light btn-sm">수정</button>
          <button type="button" id="btnDelete" class="mybtn btn btn-light btn-sm">삭제</button>
        </div>
      </div>
    </div>
    <div class="mb-3"><img id="postImage" src="" alt="Posted Image"></div>
    <div class="mb-3"><div class="txtContent" rows="3" name="content" readonly>${vo.content}</div>

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

    <!-- <div id="jb_header">
      <div id="jp_header_title">
        <a href="/index"><img src="/images/logo3.png" alt="PinCafe Logo"></a>
        <div id="titleDiv"><h1 class="title" id="txtTitle" name="title">${vo.title}</h1></div>
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
          <img src="/upload/member/thumbnail/${vo.fileCode}.jpeg" id="postImage" class="d-block w-100" alt="...">
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
        <div id="imageAndContentContainer">
          <img id="postImage" src="" alt="게시물 이미지">
          <div id="bulletinContent">
            <p><textarea id="txtContent" name="content" cols="90" rows="15" readonly>${vo.content}</textarea></p>
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

        const txtTitle    = document.querySelector('#txtTitle');
        const txtContent  = document.querySelector('#txtContent');
        const btnList     = document.querySelector('#btnList');
        const btnUpdate   = document.querySelector('#btnUpdate');
        const btnDelete   = document.querySelector('#btnDelete');
        const mapSet      = document.querySelector('.mapSet');
        const cafeAddress = document.querySelector('#cafeAddress');

        const postImage      = document.querySelector('#postImage');
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

        // UI Setting
        window.addEventListener('load', () => {

          // 이미지를 첨부하지 않았다면 안보이게
          if (!postImage.naturalWidth) {
            postImage.style.display = 'none';
          }

          // 지도를 첨부하지 않았다면 안보이게
          lat = parseFloat('${vo.lat}');
          lng = parseFloat('${vo.lng}');

          if ((lat === 0.0) && (lng === 0.0)) {
            mapSet.style.display = 'none';
          }
          else {
            selectMapList(lat, lng);
          }
        });

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

        // 수정 및 삭제버튼 나타내기 여부
        const setUiObject = function() {
            if (myContent == false) {
                btnUpdate.style.display = 'none';
                btnDelete.style.display = 'none';
            }
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

        // 목록으로 버튼
        btnList.addEventListener('click', ()=>{
            history.back();
        });

        // 수정하기 버튼
        btnUpdate.addEventListener('click', ()=>{
            location.href = "/bbs/updateContent?userId=${vo.userId}&seq=${vo.seq}";
        });

      // 게시글 삭제 버튼
      btnDelete.addEventListener('click', ()=>{

        let requestData = {
          userId : '${vo.userId}',
          seq : '${vo.seq}',
        };
        
        if (confirm ('삭제된 글은 복구할 수 없습니다.\n정말 삭제하시겠습니까?')) 
        {
          $.ajax({
              url : '/bbs/deleteContent',
              type : 'POST',
              data : requestData,
              success : function(data) {
                  if (data == "OK") {
                      alert('게시글이 삭제되었습니다.');
                        location.href = "/index";
                  }
                  else {
                      alert('게시글 삭제에 실패했습니다. 다시 시도해주세요.');
                  }
              }
          });
        }
    });

    ////// 호출부 //////////////////////////////////////////////////////////////////

    setSessionState();
    setSessionInfo();
    checkMyContent(); // 내 컨텐츠가 맞다면 myContent => true
    setUiObject(); // 내 컨텐츠인 경우에만 수정 가능하게

    //////////////////////////////////////////////////////////////////
    //좋아요 관련 구현부

    document.addEventListener('DOMContentLoaded', function () {
      const likeButton = document.getElementById('heart');
      let isLiked = false;
      let likeCount = 0;

    // 좋아요 수를 업데이트하는 함수입니다
    function updateLikeCount() {
      const likeCountElement = document.getElementById('likeCount');
      likeCountElement.textContent = likeCount.toString();
    }

    // 좋아요 버튼 클릭을 처리하는 함수입니다
    function likeCafe() {
      isLiked = !isLiked;
      if (isLiked) {
        likeCount++;
      } else {
        likeCount--;
      }
      updateLikeCount();

      // 백엔드 API의 엔드포인트 URL을 적절하게 변경해주세요
    const endpoint = 'http://localhost:9090/bbs/readContent';

        $.ajax({
          url: endpoint,
          type: 'POST',
          contentType: 'application/json',
          data: JSON.stringify({
            user_id: 'red123', // 사용자 아이디를 문자열로 변경
            cafe_no: '6', // 카페 아이디를 문자열로 변경
            cafe_like: isLiked ? 1 : 0, // 좋아요 상태를 1 또는 0으로 전송
          }),
          success: function (data) {
            // 서버에서 성공적인 응답을 받은 경우 (옵션)
            // 필요에 따라 서버 응답을 처리할 수 있습니다.
          },
          error: function () {
            // 에러 처리 (옵션)
            console.error('서버 응답 실패');
          },
        });
      }
    // 좋아요 버튼에 클릭 이벤트를 추가합니다
    likeButton.addEventListener('click', likeCafe);
    });

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