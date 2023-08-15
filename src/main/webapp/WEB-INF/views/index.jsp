<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pincafe</title>
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
</head>
<body>
    <!-- 내비게이션 영역 -->
    <%@ include file="navigation.jsp" %>
    
    <!-- 검색창 -->
    <div id="searchSet" class="shadow">
        <form action="/search" method="GET">
            <img src="/images/pinicon.png" id="pinicon">
            <div id="searchContainer">
                <input type="text" name="keyword" class="container-md" id="searchName" placeholder="카페 이름을 검색해보세요.">
                <button type="submit" id="btnSearch"><img src="/images/searchicon.png" id="searchicon"></button>
            </div>
        </form>
    </div>

    <!-- 신규오픈카페 안내 -->
    <section class="section site-portfolio">
        <div class="container">
        <div class="row mb-5 align-items-center">
            <div class="col-md-12 col-lg-6 mb-4 mb-lg-0" data-aos="fade-up">
            <h2>New Cafes In This Month</h2>
            <p class="mb-0">이번달 서울에 오픈한 새로운 카페를 만나보세요!</p>
            </div>
            <div class="col-md-12 col-lg-6 text-start text-lg-end" data-aos="fade-up" data-aos-delay="100">
            <div id="filters" class="filters">
                <a href="#" data-filter="*" class="active">All</a>
                <a href="#" data-filter=".east">East</a>
                <a href="#" data-filter=".west">West</a>
                <a href="#" data-filter=".south">South</a>
                <a href="#" data-filter=".north">North</a>
                <a href="#" data-filter=".central">Central</a>
            </div>
            </div>
        </div>

        <div id="portfolio-grid" class="row no-gutter" data-aos="fade-up" data-aos-delay="200">
            <!-- Image 01 동부 -->
            <div class="item east col-sm-6 col-md-4 col-lg-4 mb-4">
                <a href="work-single.html" class="item-wrap fancybox">
                    <div class="work-info">
                    <h3>피오디디</h3>
                    <span>동대문구 광장동</span>
                    </div>
                    <img class="img-fluid" src="assets/img/east_07_01.jpg">
                </a>
            </div>

            <!-- Image 02 남부 -->
            <div class="item south col-sm-6 col-md-4 col-lg-4 mb-4">
                <a href="work-single.html" class="item-wrap fancybox">
                    <div class="work-info">
                    <h3>제르베</h3>
                    <span>강남구 논현동</span>
                    </div>
                    <img class="img-fluid" src="assets/img/south_jerbe.jpg">
                </a>
            </div>

            <!-- Image 03 동부 -->
            <div class="item east col-sm-6 col-md-4 col-lg-4 mb-4">
                <a href="work-single.html" class="item-wrap fancybox">
                    <div class="work-info">
                    <h3>신보</h3>
                    <span>동대문구 이문동</span>
                    </div>
                    <img class="img-fluid" src="assets/img/east_03_01.jpg">
                </a>
            </div>

            <!-- Image 04 북부 -->
            <div class="item north col-sm-6 col-md-4 col-lg-4 mb-4">
                <a href="work-single.html" class="item-wrap fancybox">
                    <div class="work-info">
                    <h3>쏘리에스프레소바</h3>
                    <span>종로구 적선동</span>
                    </div>
                    <img class="img-fluid" src="assets/img/north_sorry.png">
                </a>
            </div>

            <!-- Image 05 중부 -->
            <div class="item central col-sm-6 col-md-4 col-lg-4 mb-4">
                <a href="work-single.html" class="item-wrap fancybox">
                    <div class="work-info">
                    <h3>D커피</h3>
                    <span>중구 신당동</span>
                    </div>
                    <img class="img-fluid" src="assets/img/central_dCoffee.jpg">
                </a>
            </div>

            <!-- Image 06 동부 -->
            <div class="item east col-sm-6 col-md-4 col-lg-4 mb-4">
                <a href="work-single.html" class="item-wrap fancybox">
                    <div class="work-info">
                    <h3>열매제과점</h3>
                    <span>광진구 화양동</span>
                    </div>
                    <img class="img-fluid" src="assets/img/east_06_03.jpg">
                </a>
            </div>

            <!-- Image 07 동부 -->
            <div class="item east col-sm-6 col-md-4 col-lg-4 mb-4">
                <a href="work-single.html" class="item-wrap fancybox">
                    <div class="work-info">
                    <h3>브렛서울</h3>
                    <span>광진구 화양동</span>
                    </div>
                    <img class="img-fluid" src="assets/img/east_04_01.jpg">
                </a>
            </div>

            <!-- Image 08 중부 -->
            <div class="item central col-sm-6 col-md-4 col-lg-4 mb-4">
                <a href="work-single.html" class="item-wrap fancybox">
                    <div class="work-info">
                    <h3>재인</h3>
                    <span>용산구 한남동</span>
                    </div>
                    <img class="img-fluid" src="assets/img/central_jaein.jpg">
                </a>
            </div>

            <!-- Image 09 서부 -->
            <div class="item west col-sm-6 col-md-4 col-lg-4 mb-4">
                <a href="work-single.html" class="item-wrap fancybox">
                    <div class="work-info">
                    <h3>퍼머넌트 해비탯</h3>
                    <span>마포구 대흥동</span>
                    </div>
                    <img class="img-fluid" src="assets/img/west_permanent.jpg">
                </a>
            </div>
        </div>
        </div>
    </section>



    
    <!-- Template Vendor JS Files -->
    <script src="assets/vendor/aos/aos.js"></script>
    <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
    <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
    <script src="assets/vendor/php-email-form/validate.js"></script>
    
    <!-- Template Main JS File -->
    <script src="assets/js/main.js"></script>    
    
    <script src="/JS/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
    (()=>{
        let sessionState = false;

        const profileImg    = document.querySelector('#profileImg');
        const welcomeMsg    = document.querySelector('#welcomeMsg');
        const btnBBS        = document.querySelector('#btnBBS');
        const btnLogin      = document.querySelector('#btnLogin');
        const btnJoin       = document.querySelector('#btnJoin');
        const btnInfoUpdate = document.querySelector('#btnInfoUpdate');
        const mydivider     = document.querySelector('#mydivider');
        

        ////// 함수부 ////////////////////////////////////////////////////////////////////////

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
                welcomeMsg.textContent = '${vo.name}님 반갑습니다.';
                btnLogin.textContent = 'Sign Out';
                btnJoin.style.display = 'none';
                profileImg.setAttribute('src', '/imgs/member/thumbnail/${vo.fileCode}.jpg');
            }
            else {
                welcomeMsg.textContent = '어서오세요! Pincafe입니다.';
                btnLogin.textContent = 'Sign In';
                btnInfoUpdate.style.display = 'none';
                profileImg.style.display = 'none';
                mydivider.style.display = 'none';
            }
        }



        ////// 이벤트 핸들러 /////////////////////////////////////////////////////////////////

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

        btnBBS.addEventListener('click', ()=>{
            btnBBS.setAttribute('href', '/bbsmain');
        });
        

        ////// 호출부 ////////////////////////////////////////////////////////////////////////

        setSessionState(); // 세션이 있는지 없는지 상태값을 저장한다.
        setSessionInfo();
        
    })();
    </script>
</body>
</html>