<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">    
<title>Cafe Binder</title>
<style>
    /* 이미지 컨테이너 스타일링 */
    #slideshow-container {
        position: relative;
        overflow: hidden;
        display: flex;
        flex-direction: column;
        margin: 0 auto; /* 가운데 정렬 */
        max-width: 940px; /* 가로 최대 너비 지정 */
    }

    /* 이미지 슬라이드 스타일링 */
    #slideshow {
        display: flex;
        transition: transform 0.3s ease-in-out;
    }

    /* 버튼 스타일링 */
    .prevBtn, .nextBtn {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        padding: 10px;
        color: black;
        cursor: pointer;
    }

    .prevBtn {
        left: 10px;
    }

    .nextBtn {
        right: 10px;
    }

    /* 좋아요 아이콘 */
    .h_container {
        background-color: #cac7c7;
        border-radius: 20px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, .1);
        display: inline-block;
        width: 35px;
        height: 35px;
        text-align: center;
        line-height: 40px;
    }
    /* 좋아요 아이콘이 토글되면 빨간색으로 만들기 */
    .h_container:hover {
        color: red;
    }

    #jb-container {
    width: 940px;
    margin: 10px auto;
    padding: 20px;
    border: 1px solid #bcbcbc;
  }
  #jb-header {
    padding: 20px;
    margin-bottom: 20px;
    border: 1px solid #bcbcbc;
    font-size: 30px;
  }
  #jb-main{
    font-size: 40px;

  }
  #jb-content {
    max-width: 900px;   /* 가로 폭의 최대 상한 설정 */
    min-width: 900px;  /* 가로 폭의 최소 상한 설정 */
    width: 50%; /* 가로 폭을 100%로 설정 */
    padding: 20px;
    margin-bottom: 20px;
    float: left;
    border: 1px solid #bcbcbc;
  }
  #jb-sidebar-left {
    width: 160px;
    padding: 20px;
    margin-right: 20px;
    margin-bottom: 20px;
    float: left;
    border: 1px solid #bcbcbc;
  }
  #jb-sidebar-right {
    width: 160px;
    padding: 20px;
    margin-bottom: 20px;
    float: right;
    border: 1px solid #bcbcbc;
  }
  #jb-footer {
    clear: both;
    padding: 20px;
    border: 1px solid #bcbcbc;
  }



</style>
</head>
<body>

        <div id="jb-header">
                <a href="/index">
                <span id="jb-main">Cafe Binder</span></a>
                <span>임시 카페이름</span>
                <span><div class="h_container">
                    <i><id="heart" class="far fa-heart"></i></span>
            </div>
        </div>


        <div id="jb-sidebar-left">
            <ul>
                
                <li><a href="https://www.youtube.com/hashtag/%ED%85%8C%EB%A7%88%EC%B9%B4%ED%8E%98">#테마카페</a></li>
                <li><a href="https://www.youtube.com/hashtag/%ED%94%84%EB%A0%8C%EC%B0%A8%EC%9D%B4%EC%A6%88%EC%B9%B4%ED%8E%98">#프렌차이즈카페</a></li>
                <li><a href="https://www.youtube.com/hashtag/%EC%B9%B4%ED%8E%98">#소규모카페</a></li>
            </ul>
        </div>

        <div id="jb-content">
            <div id="slideshow-container">
                <div id="slideshow">
                    <img src="https://digitaltransformation.co.kr/wp-content/uploads/2019/04/starbucks.png" alt="이미지1">
                    <img src="https://digitaltransformation.co.kr/wp-content/uploads/2019/04/starbucks.png" alt="이미지2">
                    <img src="https://digitaltransformation.co.kr/wp-content/uploads/2019/04/starbucks.png" alt="이미지3">
                </div>
                    <div class="prevBtn" onclick="prevSlide()">&#10094;</div>
                    <div class="nextBtn" onclick="nextSlide()">&#10095;</div>
            </div>
        </div>

        <div id="jb-sidebar-right">
            <ul>
                <li><button type="button" id="">후기작성</button></li>
                <li><button type="button" id="">지도</button></li>
                <li><button type="button" id="">목록</button></li>
            </ul>
        </div>

        <div id="jb-footer">
            <div>
                <tr>
                    <td>해당카페의 댓글</td>
                    <td>해당카페의 댓글</td>
                </tr>
            </div>

            <div>
                <tr>
                    <td>해당카페의 게시물</td>
                    <td>해당카페의 게시물</td>
                </tr>
            </div>
        </div>
    </div>
    
    
    

    <script src="/JS/jquery-3.7.0.min.js"></script>
    <!-- 좋아요 하트 구현부 -->
    <script src="https://kit.fontawesome.com/3929e16ef5.js" crossorigin="anonymous"></script>  
    
    
       
        

    <script>
    (()=>{

        //////////////////////////////////////////////////////////////////////////////////////
        ///구현부


        //슬라이드 관련

        let currentIndex = 0; // 현재 보이는 이미지의 인덱스를 저장하는 변수

        // 슬라이드의 이미지들을 가져오고 컨테이너에 너비를 설정하는 함수
        function setupSlider() {
            const slideshowContainer = document.getElementById('slideshow-container');
            const slider = document.getElementById('slideshow');
            const slideLis = slider.getElementsByTagName('img');
            const liWidth = slideLis[0].clientWidth;
            const sliderWidth = liWidth * slideLis.length;
            slider.style.width = `${sliderWidth}px`;
            slideshowContainer.style.maxWidth = `${sliderWidth}px`; // 컨테이너 너비 설정
        }

        // 슬라이드 이동 함수
        function showSlide(index) {
            const slideWidth = document.getElementById('slideshow').querySelector('img').clientWidth;
            const slideshow = document.getElementById('slideshow');
            slideshow.style.transform = `translateX(${-slideWidth * index}px)`;
        }

        // 다음 슬라이드로 이동
        function nextSlide() {
            currentIndex = (currentIndex + 1) % document.getElementById('slideshow').getElementsByTagName('img').length;
            showSlide(currentIndex);
        }

        // 이전 슬라이드로 이동
        function prevSlide() {
            currentIndex = (currentIndex - 1 + document.getElementById('slideshow').getElementsByTagName('img').length) % document.getElementById('slideshow').getElementsByTagName('img').length;
            showSlide(currentIndex);
        }

        // 페이지 로드 시 슬라이드 설정
        window.onload = function() {
            setupSlider();
            showSlide(currentIndex);
        };


    })();
    </script>
</body>
</html>