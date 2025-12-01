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
            padding-top: 105px;
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

        .logo { font-size: 26px; font-weight: bold; }

        nav a {
            margin-left: 35px;
            font-size: 15px;
            text-decoration: none;
            color: white;
            opacity: .9;
        }
        nav a:hover { opacity: 1; }

        .dropdown { position: relative; display: inline-block; margin-left: 35px; }
        .drop-btn { cursor: pointer; opacity:.9; }

        .dropdown-content {
            display:none;
            position:absolute;
            top:30px; left:0;
            width:160px;
            background:rgba(30,30,30,0.95);
            border-radius:10px;
            padding:8px 0;
        }

        .dropdown:hover .dropdown-content { display:block; }

        .dropdown-content a {
            display:block;
            padding:10px 14px;
            font-size:14px;
            text-decoration:none;
            color:white;
            opacity:.85;
        }
        .dropdown-content a:hover { background:#555; }

        .user-icon {
            margin-left:25px;
            font-size:20px;
            opacity:.85;
        }
        .user-icon:hover { opacity:1; }

        .header-spacer { height: 95px; }

        /* ================= CONTENT ================= */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 25px;
        }

        .search-title {
            font-size: 35px;
            font-weight: bold;
            margin-bottom: 20px;
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

        .search-box:focus { border-color:#777; }

        .section-title {
            font-size: 22px;
            font-weight: bold;
            margin: 40px 0 15px 0;
        }

        .card-row {
            display: flex;
            gap: 25px;
            overflow-x: auto;
            padding-bottom: 20px;
        }
        .card-row::-webkit-scrollbar { display:none; }

        .card {
            width: 160px;
            background: #1b1b1b;
            padding: 12px;
            border-radius: 12px;
            cursor: pointer;
            transition:.3s;
        }
        .card:hover { transform: scale(1.06); }

        .card img {
            width: 100%;
            height: 160px;
            border-radius:10px;
            object-fit:cover;
        }

        .song-name { margin-top: 10px; font-size: 15px; }
        .artist { font-size: 13px; opacity:.7; }
    </style>
</head>

<body>

<!-- ================= HEADER ================= -->
<div class="header">
    <div class="logo">
        <c:choose>
            <c:when test="${sessionScope.user.role == 'admin'}">
                Mimiu Studio <span style="color:#ffcc00;">★ Admin</span>
            </c:when>
            <c:otherwise>Mimiu Studio</c:otherwise>
        </c:choose>
    </div>

    <nav>
        <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
        <a href="${pageContext.request.contextPath}/search">Tìm kiếm</a>
        <a href="${pageContext.request.contextPath}/library">Thư viện</a>

        <!-- ADMIN MENU -->
        <c:if test="${sessionScope.user.role == 'admin'}">
            <div class="dropdown">
                <span class="drop-btn">Tạo mới ▼</span>
                <div class="dropdown-content">
                    <a href="${pageContext.request.contextPath}/song/create">Tạo bài hát</a>
                    <a href="${pageContext.request.contextPath}/album/create">Tạo album</a>
                    <a href="${pageContext.request.contextPath}/artist/create">Tạo nghệ sĩ</a>
                </div>
            </div>
        </c:if>

        <!-- USER STATUS -->
        <c:if test="${not empty sessionScope.user}">
            <div class="user-icon" title="${sessionScope.user.username}">👤</div>
            <a href="${pageContext.request.contextPath}/logout" style="color:#ff6f6f;">Đăng xuất</a>
        </c:if>

        <c:if test="${empty sessionScope.user}">
            <a href="${pageContext.request.contextPath}/login" style="color:#8fb4ff;">Đăng nhập</a>
        </c:if>
    </nav>
</div>

<div class="header-spacer"></div>

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
