<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${album.title} – Mimiu Studio</title>

    <style>
        body {
            background: #0b0b0b;
            font-family: "Poppins", sans-serif;
            color: white;
            padding: 40px;
        }

        .album-detail {
            display: flex;
            gap: 40px;
            margin-top: 30px;
        }

        .cover {
            width: 300px;
            height: 300px;
            border-radius: 12px;
            object-fit: cover;
        }

        .album-title {
            font-size: 38px;
            font-weight: bold;
        }

        .album-desc {
            margin-top: 15px;
            opacity: 0.85;
        }

        .song-list {
            margin-top: 35px;
        }

        .song-item {
            padding: 12px 0;
            border-bottom: 1px solid #333;
            cursor: pointer;
        }
        .song-item:hover {
            color: #1db954;
        }
    </style>
</head>

<body>

<a href="${pageContext.request.contextPath}/home" style="color:#ccc;">← Quay lại</a>

<div class="album-detail">

    <img src="${album.cover}" class="cover">

    <div>
        <div class="album-title">${album.title}</div>
        <div style="opacity:0.8; margin-top:5px;">${album.releaseYear}</div>

        <div class="album-desc">${album.description}</div>
    </div>
</div>

<!-- List Songs -->
<div class="song-list">
    <h2>Các bài hát trong album</h2>

    <c:forEach var="s" items="${songs}">
        <div class="song-item"
             onclick="location.href='${pageContext.request.contextPath}/song?action=detail&id=${s.songId}'">
            ${s.title}
        </div>
    </c:forEach>
</div>

</body>
</html>
