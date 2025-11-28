<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm – Mimiu Studio</title>

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: "Poppins", sans-serif;
            background-color: #0b0b0b;
            color: white;
            padding-top: 100px;
            overflow-x: hidden;
        }

        /* HEADER */
        .header {
            position: fixed;
            top: 0; left: 0;
            width: 100%;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(0,0,0,0.4);
            backdrop-filter: blur(10px);
            z-index: 1000;
        }
        .header .logo { font-size: 26px; font-weight: bold; }
        .header nav a {
            margin-left: 35px;
            text-decoration: none;
            color: white;
            opacity: 0.85;
        }
        .header nav a:hover { opacity: 1; }

        /* WRAP */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 25px;
        }

        /* SEARCH INPUT */
        .search-title { font-size: 35px; font-weight: bold; margin-bottom: 20px; }

        .search-box {
            width: 100%;
            background: #1c1c1c;
            padding: 18px 20px;
            border-radius: 14px;
            border: 2px solid #333;
            font-size: 18px;
            color: white;
            outline: none;
        }
        .search-box:focus { border-color: #666; }

        /* SECTION TITLE */
        .section-title {
            margin-top: 40px;
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        /* CARDS */
        .card-row {
            display: flex;
            gap: 25px;
            overflow-x: auto;
            padding-bottom: 20px;
            margin-top: 10px;
        }
        .card-row::-webkit-scrollbar { display: none; }

        .card {
            background: #1b1b1b;
            border-radius: 12px;
            width: 150px;
            padding: 12px;
            transition: 0.3s;
            cursor: pointer;
        }
        .card:hover { transform: scale(1.05); }

        .card img {
            width: 100%;
            height: 150px;
            border-radius: 10px;
            object-fit: cover;
        }

        .song-name { margin-top: 10px; font-size: 15px; }
        .artist { opacity: 0.7; font-size: 13px; }

        /* TAGS */
        .tag-row { display: flex; flex-wrap: wrap; gap: 15px; }

        .tag {
            padding: 10px 18px;
            background: #1b1b1b;
            border-radius: 30px;
            border: 1px solid #333;
            color: white;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            transition: 0.2s;
        }
        .tag:hover { background: #333; transform: scale(1.05); }

    </style>
</head>

<body>

<!-- HEADER -->
<div class="header">
    <div class="logo">Mimiu Studio</div>
    <nav>
        <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
        <a href="${pageContext.request.contextPath}/search">Tìm kiếm</a>
        <a href="#">Thư viện</a>
        <a href="#">Tạo Playlist</a>
    </nav>
</div>

<div class="container">

    <!-- TITLE -->
    <div class="search-title">Bạn muốn nghe gì?</div>

    <!-- SEARCH FORM -->
    <form action="${pageContext.request.contextPath}/search" method="get">
        <input name="q" type="text" class="search-box"
               placeholder="Tìm bài hát, nghệ sĩ hoặc album..."
               value="${param.q}">
    </form>

    <!-- TAG SUGGEST -->
    <div class="section-title">Khám phá nội dung mới mẻ</div>

    <div class="tag-row">
        <a href="search?q=indie" class="tag">#indie</a>
        <a href="search?q=vpop" class="tag">#v-pop</a>
        <a href="search?q=lofi" class="tag">#lofi</a>
        <a href="search?q=chill" class="tag">#chill</a>
        <a href="search?q=ballad" class="tag">#ballad</a>
        <a href="search?q=kpop" class="tag">#k-pop</a>
        <a href="search?q=rap" class="tag">#rap</a>
    </div>


    <!-- ================== SONG RESULTS ================== -->
    <c:if test="${not empty songs}">
        <div class="section-title">Bài hát</div>
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
    </c:if>


    <!-- ================== ARTIST RESULTS ================== -->
    <c:if test="${not empty artists}">
        <div class="section-title">Nghệ sĩ</div>
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
    </c:if>


    <!-- ================== ALBUM RESULTS ================== -->
    <c:if test="${not empty albums}">
        <div class="section-title">Album</div>
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
    </c:if>


    <!-- ================== NO RESULT ================== -->
    <c:if test="${empty songs and empty artists and empty albums and not empty param.q}">
        <div class="section-title">Không tìm thấy kết quả cho từ khóa "<b>${param.q}</b>"</div>
    </c:if>

</div>

</body>
</html>
