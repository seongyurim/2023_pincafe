<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ue7v6d1q9l&submodules=geocoder"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<title>Content</title>

<!-- 폰트 링크 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ue7v6d1q9l"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" href="/css/updateContent.css">

</head>
<body>
    <div id="jb_header">
      <div id="jp_header_title">
        <a href="/index"><img src="/images/logo3.png" alt="PinCafe Logo"></a>
        <div id="titleDiv"><input type="text" id="txtTitle" value="${vo.title}"></div>
        <div id="hcDiv">
          <div class="h_container">
            <i id="heart" class="far fa-heart" onclick="likeCafe()"></i><span id="likeCount">&nbsp;0</span>           
          </div>
        </div>
      </div> 
    </div>

    <!-- 이미지 캐러셀 -->
    <div id="carouselDiv">
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
    </div>
    <!-- 이미지 캐러셀 -->
    <div id="jb-content">
      <div id="bbsDetail">
        <div id="imageAndContentContainer">
          <!-- <img id="postImage" src="" alt="게시물 이미지"> -->
          <div id="bulletinContent">
            <p><textarea id="txtContent" cols="90" rows="15">${vo.content}</textarea></p>
          </div>
        </div>
      </div>
    </div>

    <!-- 지도 div -->
    <p id="cafeAd">
      <img id="pinImg" src="/images/location.png" alt="핀이미지">
      ${vo.address}</p>
    <div class="map-container">
      <div id="map"></div>
    </div>

    <div id="jb-footer">  
        <button type="button" id="btnList" class="mybtn btn btn-secondary">목록</button>
        <button type="button" id="btnUpdate" class="mybtn btn btn-secondary">수정</button>
        <button type="button" id="btnDelete" class="mybtn btn btn-secondary">삭제</button>
    </div>
    
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

        const txtTitle   = document.querySelector('#txtTitle');
        const txtContent = document.querySelector('#txtContent');
        const btnList    = document.querySelector('#btnList');
        const btnUpdate  = document.querySelector('#btnUpdate');
        const btnDelete  = document.querySelector('#btnDelete');
        const cafeAd     = document.querySelector('#cafeAd');


        const imageContainer  = document.querySelector('#imageContainer');


        
        

        ////// 함수부 //////////////////////////////////////////////////////////////////

        //지도를 그려주는 함수
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

        //
        const setUiObject = function() {
            // 내 컨텐츠가 아니라면 읽기만 가능하다.
            if (myContent == false) {
                // 타이틀과 컨텐츠를 Read Only + 수정,삭제 버튼을 disabled
                txtTitle.setAttribute('readonly', 'readonly');
                txtContent.setAttribute('readonly', 'readonly');
                btnUpdate.style.display = 'none';
                btnDelete.style.display = 'none';
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

      // 게시글 삭제 버튼
      btnDelete.addEventListener('click', ()=>{

            // DB로 전송할 데이터: id, seq
            let requestData = {
                            userId : '${vo.userId}',
                            seq : '${vo.seq}',
                        };
            
            if (confirm ('삭제된 글은 복구할 수 없습니다. \n정말 삭제하시겠습니까?')) 
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

    checkMyContent(); // 내 컨텐츠가 맞다면 myContent => true
    setUiObject(); // 내 컨텐츠인 경우에만 수정 가능하게
    // 지도 그려주는 함수 실행
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