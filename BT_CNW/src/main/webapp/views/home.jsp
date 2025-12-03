<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Mimiu Studio - Trang Chủ</title>

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: "Poppins", sans-serif;
            background: #0b0b0b;
            color: white;
            overflow-x: hidden;
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
            background-size: cover;
            background-position: center right;
            opacity: 0;
            transition: opacity .6s ease;
        }

        .music-slide.active { opacity: 1; }

        .slide-left {
            position: absolute;
            left: 40px;
            bottom: 50px;
            max-width: 480px;
            z-index: 10;
        }

        .slide-gradient {
            position: absolute;
            width: 100%; height: 100%;
            background: linear-gradient(
                to right,
                rgba(0,0,0,.85) 0%,
                rgba(0,0,0,.45) 40%,
                rgba(0,0,0,.12) 70%,
                rgba(0,0,0,0) 100%
            );
            backdrop-filter: blur(3px);
            z-index: 5;
        }

        .slide-title { font-size: 42px; font-weight: bold; }
        .slide-sub { font-size: 18px; opacity: .85; margin-top: 8px; }
        .slide-desc { opacity: .85; margin-top: 12px; line-height: 1.5; }

        /* BUTTONS */
        .slider-btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            padding: 8px 15px;
            font-size: 26px;
            color: white;
            background: rgba(255,255,255,0.2);
            border-radius: 8px;
            cursor: pointer;
            z-index: 20;
        }
        .slider-btn:hover { background: rgba(255,255,255,0.4); }
        .slider-btn.left { left: 10px; }
        .slider-btn.right { right: 10px; }

        /* LIST SECTIONS */
        .section-title {
            margin: 40px 0 15px 0;
            font-size: 22px;
            font-weight: bold;
        }

        .card-row {
            display: flex;
            gap: 25px;
            overflow-x: auto;
            padding-bottom: 20px;
        }
        .card-row::-webkit-scrollbar { display:none; }

        .card {
            width: 170px;
            background: #1b1b1b;
            border-radius: 12px;
            padding: 12px;
            cursor: pointer;
            transition: .25s;
        }
        .card:hover { transform: scale(1.06); }

        .card img {
            width: 100%; height: 170px;
            border-radius: 10px;
            object-fit: cover;
        }

        .song-name { margin-top: 10px; }
        .artist { font-size: 13px; opacity:.7; }

        .container { width: 90%; margin: auto; }
    </style>
</head>

<body>

<!-- ================= REUSE HEADER ================= -->
<jsp:include page="/views/header.jsp"></jsp:include>

<!-- ================= MAIN WRAPPER ================= -->
<div class="container">

<!-- ================= HERO SLIDER ================= -->
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
                Một không gian âm nhạc giúp bạn thư giãn và sáng tạo.
            </p>
        </div>
    </div>

    <!-- SLIDE TỪ DATABASE -->
    <c:forEach var="s" items="${songs}">
        <div class="music-slide" style="background-image: url('${s.thumbnail}');">
            <div class="slide-gradient"></div>
            <div class="slide-left">
                <h1 class="slide-title">${s.title}</h1>
                <div class="slide-sub">
                    <c:forEach var="ar" items="${s.artists}">${ar.name} </c:forEach>
                    · ${s.year}
                </div>
                <p class="slide-desc">${s.description}</p>
            </div>
        </div>
    </c:forEach>

    <div class="slider-btn left" onclick="prevSlide()">❮</div>
    <div class="slider-btn right" onclick="nextSlide()">❯</div>
</div>

<!-- ================= SONGS ================= -->
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

<!-- ================= ALBUMS ================= -->
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

<!-- ================= ARTISTS ================= -->
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
function nextSlide() { slideIndex++; showSlide(slideIndex); }
function prevSlide() { slideIndex--; showSlide(slideIndex); }
setInterval(nextSlide, 5500);
</script>

</body>
</html>
