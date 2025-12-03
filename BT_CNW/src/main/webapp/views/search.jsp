<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            background: #0b0b0b;
            color: white;
            overflow-x: hidden;
        }

     
        /* ================= SEARCH PAGE CONTENT ================= */
        .container {
            width: 90%;
            margin: auto;
        }

        .search-title {
            font-size: 35px;
            font-weight: bold;
            margin-bottom: 25px;
        }

        .search-box {
            width: 100%;
            padding: 18px;
            border-radius: 12px;
            border: 2px solid #333;
            background: #1a1a1a;
            color: white;
            font-size: 18px;
            outline: none;
        }
        .search-box:focus { border-color: #777; }

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
    </style>
</head>

<body>

<!-- ================= REUSE HEADER ================= -->
<jsp:include page="/views/header.jsp"></jsp:include>
<!-- ================= CONTENT ================= -->
<div class="container">

    <div class="search-title">Bạn muốn nghe gì?</div>

    <form action="${pageContext.request.contextPath}/search" method="get">
        <input type="text" class="search-box" name="q" placeholder="Tìm bài hát, nghệ sĩ, album..."
               value="${param.q}">
    </form>

    <!-- SONGS -->
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

    <!-- ARTISTS -->
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

    <!-- ALBUMS -->
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

    <!-- NO RESULT -->
    <c:if test="${empty songs and empty artists and empty albums and not empty param.q}">
        <div class="section-title">Không tìm thấy kết quả cho "<b>${param.q}</b>"</div>
    </c:if>

</div>

</body>
</html>
