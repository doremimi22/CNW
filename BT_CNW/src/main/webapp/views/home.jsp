<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Mimiu Studio - Trang Chủ</title>

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            margin: 0;
            font-family: "Poppins", sans-serif;
            background-color: #0b0b0b;
            color: white;
            overflow-x: hidden;
        }

        /* ================= HEADER ================= */
        .header {
            position: fixed;
            top: 0; left: 0;
            width: 100%;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(0,0,0,0.45);
            backdrop-filter: blur(12px);
            z-index: 1000;
        }

        .header .logo {
            font-size: 26px;
            font-weight: bold;
        }

        .header nav a {
            margin-left: 35px;
            color: white;
            text-decoration: none;
            opacity: 0.9;
            font-size: 15px;
        }

        .header nav a:hover { opacity: 1; }
        .header-spacer { height: 100px; }

        /* ================= GLOBAL WRAPPER ================= */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* ================= HERO SLIDER ================= */
        .hero-music-slider {
            position: relative;
            width: 100%;
            height: 470px;
            border-radius: 14px;
            overflow: hidden;
            margin-bottom: 40px;
            background: #111;
        }

        .music-slide {
            position: absolute;
            width: 100%;
            height: 100%;
            display: flex;
            opacity: 0;
            transition: opacity 0.6s ease;
        }

        .music-slide.active { opacity: 1; }

        /* LEFT INFO */
        .slide-left {
            width: 50%;
            padding: 60px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .slide-title {
            font-size: 42px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .slide-sub {
            font-size: 18px;
            opacity: 0.8;
            margin-bottom: 12px;
        }

        .slide-desc {
            font-size: 17px;
            opacity: 0.85;
            line-height: 1.6;
            max-width: 480px;
        }

        /* RIGHT IMAGE */
        .slide-right {
            width: 50%;
        }

        .slide-right img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            filter: brightness(0.85);
        }

        /* THUMBNAILS */
        .thumbnail-list {
            position: absolute;
            bottom: 15px;
            right: 15px;
            display: flex;
            gap: 10px;
            z-index: 50;
        }

        .thumb {
            width: 70px;
            height: 40px;
            border-radius: 6px;
            object-fit: cover;
            opacity: 0.7;
            cursor: pointer;
            border: 2px solid transparent;
            transition: 0.2s;
        }

        .thumb:hover {
            opacity: 1;
            border-color: #fff;
        }

        /* BUTTONS */
        .slider-btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: rgba(255,255,255,0.2);
            padding: 8px 15px;
            font-size: 26px;
            color: white;
            border-radius: 8px;
            cursor: pointer;
            z-index: 20;
        }

        .slider-btn:hover {
            background: rgba(255,255,255,0.4);
        }

        .slider-btn.left { left: 10px; }
        .slider-btn.right { right: 10px; }

        /* ================= SECTIONS ================= */
        .section-title {
            font-size: 22px;
            font-weight: bold;
            margin: 40px 0 20px 0;
        }

        .card-row {
            display: flex;
            gap: 25px;
            overflow-x: auto;
            padding-bottom: 20px;
        }

        .card-row::-webkit-scrollbar { display: none; }

        .card {
            width: 170px;
            background: #1b1b1b;
            border-radius: 12px;
            padding: 12px;
            cursor: pointer;
            transition: 0.3s;
        }

        .card:hover { transform: scale(1.05); }

        .card img {
            width: 100%;
            height: 170px;
            border-radius: 10px;
            object-fit: cover;
        }

        .song-name { margin-top: 10px; font-size: 15px; }
        .artist { opacity: 0.7; font-size: 13px; }
        /* FULL BACKGROUND SLIDE */
.music-slide {
    position: absolute;
    width: 100%;
    height: 100%;
    background-size: cover;
    background-position: center right;
    filter: brightness(0.9);
    opacity: 0;
    transition: opacity 0.6s ease;
}

.music-slide.active {
    opacity: 1;
}

/* LEFT CONTENT */
.slide-left {
    position: absolute;
    left: 40px;
    bottom: 50px;
    max-width: 500px;
    z-index: 10;
}

/* GRADIENT BLUR EFFECT */
.slide-gradient {
    position: absolute;
    width: 100%;
    height: 100%;
    background: linear-gradient(
            to right,
            rgba(0, 0, 0, 0.85) 0%,   /* bên trái tối */
            rgba(0, 0, 0, 0.50) 35%,  /* mờ dần */
            rgba(0, 0, 0, 0.15) 65%,  /* rất mờ */
            rgba(0, 0, 0, 0.0) 100%   /* hoàn toàn trong suốt */
    );
    backdrop-filter: blur(3px);
    z-index: 5;
}

/* TITLES */
.slide-title {
    font-size: 42px;
    font-weight: bold;
}

.slide-sub {
    font-size: 18px;
    opacity: 0.85;
    margin-top: 8px;
}

.slide-desc {
    opacity: 0.85;
    margin-top: 14px;
    font-size: 17px;
    line-height: 1.5;
}
        
    </style>
</head>

<body>

<!-- ================= HEADER ================= -->
<div class="header">
    <div class="logo">Mimiu Studio</div>
    <nav>
        <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
        <a href="#">Tìm kiếm</a>
        <a href="#">Thư viện</a>
        <a href="#">Tạo Playlist</a>
    </nav>
</div>
<div class="header-spacer"></div>

<!-- ================= PAGE MAIN WRAPPER ================= -->
<div class="container">
<!-- ================= HERO MUSIC SLIDER ================= -->
<div class="hero-music-slider">

    <!-- SLIDE 0 -->
    <div class="music-slide active"
         style="background-image: url('${pageContext.request.contextPath}/images/banner.jpg');">

        <div class="slide-gradient"></div>

        <div class="slide-left">
            <h1 class="slide-title">Mimiu Studio – Music For Your Soul</h1>
            <div class="slide-sub">Da Nang · Viet Nam</div>
            <p class="slide-desc">
                Thưởng thức những giai điệu được tuyển chọn dành riêng cho bạn.
                Một không gian âm nhạc giúp bạn thư giãn và sáng tạo mỗi ngày.
            </p>
        </div>
    </div>

    <!-- SLIDE 1..n -->
    <c:forEach var="s" items="${songs}">
        <div class="music-slide"
             style="background-image: url('${s.thumbnail}');">

            <div class="slide-gradient"></div>

            <div class="slide-left">
                <h1 class="slide-title">${s.title}</h1>
                <div class="slide-sub">
                    <c:forEach var="ar" items="${s.artists}">
                        ${ar.name}
                    </c:forEach>
                    · ${s.year}
                </div>
                <p class="slide-desc">${s.description}</p>
            </div>
        </div>
    </c:forEach>

    <div class="slider-btn left" onclick="prevSlide()">❮</div>
    <div class="slider-btn right" onclick="nextSlide()">❯</div>
</div>

    <!-- ================= SECTION: SONGS ================= -->
    <div class="section-title">Bài hát gợi ý</div>
    <div class="card-row">
        <c:forEach var="s" items="${songs}">
            <div class="card"
                 onclick="location.href='${pageContext.request.contextPath}/song?action=detail&id=${s.songId}'">
                <img src="${s.thumbnail}">
                <div class="song-name">${s.title}</div>
                <div class="artist">${s.year}</div>
            </div>
        </c:forEach>
    </div>

    <!-- ================= SECTION: ALBUMS ================= -->
    <div class="section-title">Album nổi bật</div>
    <div class="card-row">
        <c:forEach var="al" items="${albums}">
            <div class="card"
                 onclick="location.href='${pageContext.request.contextPath}/album?action=detail&id=${al.albumId}'">
                <img src="${al.cover}">
                <div class="song-name">${al.title}</div>
                <div class="artist">${al.releaseYear}</div>
            </div>
        </c:forEach>
    </div>

    <!-- ================= SECTION: ARTISTS ================= -->
    <div class="section-title">Nghệ sĩ được yêu thích</div>
    <div class="card-row">
        <c:forEach var="ar" items="${artists}">
            <div class="card"
                 onclick="location.href='${pageContext.request.contextPath}/artist?action=detail&id=${ar.artistId}'">
                <img src="${ar.avatar}">
                <div class="song-name">${ar.name}</div>
                <div class="artist">${ar.biography}</div>
            </div>
        </c:forEach>
    </div>

</div> <!-- END CONTAINER -->

<!-- ================= SLIDER SCRIPT ================= -->
<script>
let slideIndex = 0;

function showSlide(n) {
    const slides = document.querySelectorAll(".music-slide");

    slides.forEach(s => s.classList.remove("active"));

    if (n >= slides.length) slideIndex = 0;
    if (n < 0) slideIndex = slides.length - 1;

    slides[slideIndex].classList.add("active");
}

function nextSlide() {
    slideIndex++;
    showSlide(slideIndex);
}

function prevSlide() {
    slideIndex--;
    showSlide(slideIndex);
}

function goToSlide(n) {
    slideIndex = n;
    showSlide(slideIndex);
}

setInterval(() => {
    nextSlide();
}, 5500);
</script>

</body>
</html>
