<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>Cafe Binder</title>
<style>
    * {box-sizing: border-box}
    body {font-family: Verdana, sans-serif; margin:0}
    .mySlides {display: none}
    img {vertical-align: middle;}

    /* 슬라이드 쇼 컨테이너 */
    .slideshow-container {
      max-width: 1000px;
      position: relative;
      margin: auto;
    }

    /* 다음및 이전버튼*/
    .prev, .next {
      cursor: pointer;
      position: absolute;
      top: 50%;
      width: auto;
      padding: 16px;
      margin-top: -22px;
      color: white;
      font-weight: bold;
      font-size: 18px;
      transition: 0.6s ease;
      border-radius: 0 3px 3px 0;
      user-select: none;
    }

    /* 버튼 배치 */
    .next {
      right: 0;
      border-radius: 3px 0 0 3px;
    }

    /* 버튼위에 마우스를 올릴시 색상 바뀜 */
    .prev:hover, .next:hover {
      background-color: rgba(0,0,0,0.8);
    }

    /* 점글머리 기호표시 */
    .dot {
      cursor: pointer;
      height: 15px;
      width: 15px;
      margin: 0 2px;
      background-color: #bbb;
      border-radius: 50%;
      display: inline-block;
      transition: background-color 0.6s ease;
    }

    .active, .dot:hover {
      background-color: #717171;
    }

    /* 페이딩 애니메이션 */
    .fade {
      animation-name: fade;
      animation-duration: 1.5s;
    }

    @keyframes fade {
      from {opacity: .4} 
      to {opacity: 1}
    }
   
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
      font-size: 30px;
      
    }
  

    #Cafe_name {
      flex: 1;
      text-align: center;
    }
    #likeCount {
    margin-left: 5px; /* 좋아요 아이콘과 좋아요 갯수 사이의 간격 조정 */
    }

    #jb-main{
      font-size: 40px;
    }
    #jb-content {
      max-width: 900px;   /* 가로 폭의 최대 상한 설정 */
      min-width: 900px;  /* 가로 폭의 최소 상한 설정 */
      margin-bottom: 20px;
      float: left;
    }
    #jb-sidebar-left {
      width: 200px;
      padding: 20px;
      margin-right: 20px;
      margin-bottom: 20px;
      float: left;
      border: 1px solid #bcbcbc;
    }
    #jb-sidebar-right {
      width: 200px;
      padding: 20px;
      margin-bottom: 20px;
      float: right;
      border: 1px solid #bcbcbc;
    }
    #jb-footer {
      clear: both;
      padding: 20px;
      border: 1px solid #bcbcbc;
        width: 100%; /* 가로 폭 100%로 설정 */
        box-sizing: border-box; /* 테두리를 기준으로 크기 설정 */
    }
</style>

</head>
<body>

    <div id="jb_header">
        <a href="/index">
          <span id="jb_main">Cafe Binder</span>
        </a>
        <span id="Cafe_name">임시 카페이름</span>
        <div class="h_container">
            <i id="heart" class="far fa-heart" onclick="likeCafe()"></i><span id="likeCount">0</span>
        </div>
    </div>


    <div id="jb-container">
        <div id="jb-sidebar-left">
          <ul>
            <li><a href="https://www.youtube.com/hashtag/%ED%85%8C%EB%A7%88%EC%B9%B4%ED%8E%98">#테마카페</a></li>
            <li><a href="https://www.youtube.com/hashtag/%ED%94%84%EB%A0%8C%EC%B0%A8%EC%9D%B4%EC%A6%88%EC%B9%B4%ED%8E%98">#프렌차이즈카페</a></li>
            <li><a href="https://www.youtube.com/hashtag/%EC%B9%B4%ED%8E%98">#소규모카페</a></li>
          </ul>
        </div>

        <div id="jb-content">
            <div class="slideshow-container">            
                <div class="mySlides fade">
                  <img src="https://digitaltransformation.co.kr/wp-content/uploads/2019/04/starbucks.png" style="width:100%">
                </div>

                <div class="mySlides fade">
                  <img src="https://digitaltransformation.co.kr/wp-content/uploads/2019/04/starbucks.png" style="width:100%">
                </div>

                <div class="mySlides fade">
                  <img src="https://digitaltransformation.co.kr/wp-content/uploads/2019/04/starbucks.png" style="width:100%">
                </div>

                <a class="prev" role="button" onclick="plusSlides(-1)">❮</a>
                <a class="next" role="button" onclick="plusSlides(1)">❯</a>
            </div>

            <div style="text-align:center">
                <span class="dot" role="button" onclick="currentSlide(1)"></span> 
                <span class="dot" role="button" onclick="currentSlide(2)"></span> 
                <span class="dot" role="button" onclick="currentSlide(3)"></span> 
              </div>
              
        </div>

        <div id="jb-sidebar-right">
            <ul>
                <li><button type="button" id="btnReview">후기작성</button></li>
                <li><button type="button" id="btnMap">지도</button></li>
                <li><button type="button" id="btmMain">목록</button></li>
            </ul>
        </div>

        <div id="jb-footer">
            <div>
                <ul id="commentList"></ul>
                <ul>1</ul>
              </div>
            
              <div>
                <ul id="postList"></ul>
                <ul>2</ul>
                <ul>3</ul>
              </div>
        </div>
        
        



    <script src="/JS/jquery-3.7.0.min.js"></script>
    <!-- 좋아요 하트 외부에서 가져오기 -->
    <script src="https://kit.fontawesome.com/3929e16ef5.js" crossorigin="anonymous"></script>  





    <script>

        const jb_header = document.getElementById('jb_header');
        const jb_main = document.getElementById('jb_main');
        const Cafe_name = document.getElementById('Cafe_name');

        const prev = document.getElementById('prev');
        const next = document.getElementById('next');


        //오른쪽 메뉴 버튼  
        const btnReview = document.getElementById('btnReview');
        const btnMap = document.getElementById('btnMap');
        const btmMain = document.getElementById('btmMain');
        


    //////////////////////////////////////////////////////////////
    ///이미지 슬라이더 구현부


     // 이미지 슬라이더 초기화 및 첫 번째 이미지 표시
    let slideIndex = 1;
    showSlides(slideIndex);
        
    // 이전/다음 슬라이드를 보여주는 함수
    function plusSlides(n) {
      showSlides(slideIndex += n);
    }

    // 특정 슬라이드를 보여주는 함수
    function currentSlide(n) {
      showSlides(slideIndex = n);
    }

    // 슬라이드를 보여주는 메인 함수
    function showSlides(n) {

    // 이미지 슬라이더의 이미지들과 도트들을 가져옴
    const slides = document.getElementsByClassName("mySlides");
    const dots = document.getElementsByClassName("dot");
    // 슬라이드 인덱스가 이미지 슬라이더의 길이보다 크면 첫 번째 슬라이드로 설정
    if (n > slides.length) {
      slideIndex = 1;
    }

    // 슬라이드 인덱스가 1보다 작으면 마지막 슬라이드로 설정
    if (n < 1) {
      slideIndex = slides.length;
    }

    // 모든 이미지 슬라이더 숨김
    for (let i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";
    }

    // 모든 도트 클래스에서 'active' 클래스 제거
    for (let i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
    }

    // 현재 슬라이드의 이미지를 표시하고 해당 도트에 'active' 클래스 추가하여 활성화 표시
    slides[slideIndex - 1].style.display = "block";
    dots[slideIndex - 1].className += " active";

    }

    //////////////////////////////////////////////////////////////////
    //좋아요 관련 구현부

    let isLiked = false; // 좋아요 상태를 저장하는 변수
    let likeCount = 0; // 현재 좋아요 수를 저장하는 변수


    
        
    ///////////////////////////////////////////////////////////////////////////////
    //이벤트 리스너

    btnReview.addEventListener('click', ()=>{
        console.log("카페의 리뷰");
    });

    btnMap.addEventListener('click', ()=>{
        console.log("해당카페의 지도");
    });

    btmMain.addEventListener('click', ()=>{
        console.log("메인으로(카페선택 페이지)");
    });

  
    ///////////////////////////////////////////////////////////////////////
    //호출부
    

    </script>
</body>
</html>