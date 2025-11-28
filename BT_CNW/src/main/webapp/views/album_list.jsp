<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Mimiu Studio - Trang Chủ</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: "Poppins", sans-serif;
            background-color: #0b0b0b;
            color: white;
            overflow-x: hidden;
        }

        /* HEADER */
        .header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(0, 0, 0, 0.4);
            backdrop-filter: blur(10px);
            z-index: 1000;
        }
        .header .logo {
            font-size: 26px;
            font-weight: bold;
        }
        .header nav a {
            margin-left: 35px;
            text-decoration: none;
            color: white;
            opacity: 0.85;
            font-size: 15px;
        }
        .header nav a:hover { opacity: 1; }
        .header-spacer { height: 100px; }

        /* WRAPPER */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* HERO */
        .hero {
            width: 100%;
            height: 450px;
            background: url('https://i.pinimg.com/originals/b7/75/9a/b7759afe53659f9669325a91a80263cb.jpg') no-repeat center/cover;
            position: relative;
            border-radius: 12px;
            overflow: hidden;
        }
        .hero-overlay {
            position: absolute;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.45);
        }
        .hero-content {
            position: absolute;
            bottom: 40px;
            left: 40px;
            max-width: 600px;
        }
        .hero-title {
            font-size: 40px;
            font-weight: bold;
        }
        .hero-desc {
            opacity: 0.9;
            margin-top: 15px;
            font-size: 17px;
            line-height: 1.5;
        }

        /* SECTION TITLE */
        .section-title {
            font-size: 22px;
            font-weight: bold;
            margin: 40px 0 20px 0;
        }

        /* CARDS */
        .card-row {
            display: flex;
            gap: 25px;
            overflow-x: auto;
            padding-bottom: 20px;
        }
        .card-row::-webkit-scrollbar { display: none; }
        .card {
            background: #1b1b1b;
            border-radius: 12px;
            width: 170px;
            padding: 12px;
            transition: 0.3s;
            cursor: pointer;
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
    </style>
</head>

<body>

<!-- HEADER -->
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

<!-- CONTENT -->
<div class="container">

    <!-- HERO -->
    <div class="hero">
        <div class="hero-overlay"></div>
        <div class="hero-content">
            <div class="hero-title">Mimiu Studio – Music For Your Soul</div>
            <div class="hero-desc">
                Thưởng thức những giai điệu được tuyển chọn dành riêng cho bạn.
                Một không gian âm nhạc giúp bạn thư giãn và sáng tạo mỗi ngày.
            </div>
        </div>
    </div>

    <!-- SECTION: BÀI HÁT -->
    <div class="section-title">Bài hát gợi ý</div>
    <div class="card-row">

        <c:forEach var="s" items="${songs}">
            <div class="card"
                 onclick="location.href='${pageContext.request.contextPath}/song?action=detail&id=${s.songId}'">
                <img src="${s.thumbnail}">
                <div class="song-name">${s.title}</div>
                <div class="artist">Năm: ${s.year}</div>
            </div>
        </c:forEach>

    </div>

    <!-- SECTION: ALBUMS -->
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

    <!-- SECTION: NGHỆ SĨ -->
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

</div>
</body>
</html>
