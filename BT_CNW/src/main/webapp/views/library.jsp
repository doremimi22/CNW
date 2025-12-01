<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Playlist – Mimiu Studio</title>

    <style>
        body { font-family: "Poppins", sans-serif; background: #0b0b0b; color: white; }

        .header-spacer { height: 100px; }

        .container {
            width: 90%;
            margin: auto;
            margin-top: 20px;
        }

        .section-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 18px;
        }

        .playlist-row {
            display: flex;
            gap: 25px;
            flex-wrap: wrap;
        }

        .playlist-card {
            width: 220px;
            background: #1b1b1b;
            border-radius: 12px;
            padding: 14px;
            cursor: pointer;
            transition: .25s;
        }
        .playlist-card:hover { transform: scale(1.06); }

        .playlist-img {
            width: 100%;
            height: 180px;
            border-radius: 10px;
            object-fit: cover;
            background: #333;
        }

        .playlist-name {
            margin-top: 12px;
            font-size: 17px;
            font-weight: 500;
        }

        .add-btn {
            margin: 20px 0;
            display: inline-block;
            padding: 10px 18px;
            background: #4a95ff;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            color: white;
            font-weight: 500;
        }
        .add-btn:hover { background: #6aa7ff; }
    </style>
</head>

<body>

<jsp:include page="/views/header.jsp"/>

<div class="header-spacer"></div>

<div class="container">

    <div class="section-title">Playlist của bạn</div>

    <!-- NÚT TẠO PLAYLIST -->
    <a href="${pageContext.request.contextPath}/playlist?action=create" class="add-btn">
        + Tạo Playlist
    </a>

    <!-- LIST PLAYLIST -->
    <div class="playlist-row">
        <c:forEach var="pl" items="${playlists}">
            <div class="playlist-card"
                 onclick="location.href='${pageContext.request.contextPath}/playlist?action=detail&id=${pl.playlistId}'">

                <img class="playlist-img" 
     src="${pageContext.request.contextPath}/images/playlist_default.jpg">

                <div class="playlist-name">${pl.name}</div>
            </div>
        </c:forEach>

        <c:if test="${empty playlists}">
            <p>Bạn chưa có playlist nào. Hãy tạo mới!</p>
        </c:if>
    </div>

</div>
</body>
</html>
