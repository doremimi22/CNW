<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${song.title} – Mimiu Studio</title>

    <style>
        body {
            font-family: "Poppins", sans-serif;
            background: #0b0b0b;
            color: white;
            padding: 40px;
        }

        .song-detail {
            display: flex;
            gap: 40px;
            margin-top: 40px;
        }

        .thumb {
            width: 320px;
            height: 320px;
            border-radius: 15px;
            object-fit: cover;
        }

        .info-title {
            font-size: 40px;
            font-weight: bold;
        }

        .info-artist {
            margin-top: 10px;
            font-size: 18px;
            opacity: 0.8;
        }

        .desc {
            margin-top: 20px;
            opacity: 0.9;
            line-height: 1.6;
        }

        .back {
            text-decoration: none;
            color: #ccc;
            font-size: 14px;
        }
        .back:hover { color: white; }
    </style>
</head>

<body>

<a class="back" href="${pageContext.request.contextPath}/home">← Quay lại trang chủ</a>

<div class="song-detail">

    <img src="${song.thumbnail}" class="thumb">

    <div class="info">
        <div class="info-title">${song.title}</div>

        <div class="info-artist">
            <c:forEach var="a" items="${song.artists}">
                ${a.name}
            </c:forEach>
            · ${song.year}
        </div>

        <div class="desc">${song.description}</div>

        <div style="margin-top:20px;">
            <a href="${song.link}" target="_blank"
               style="color:#1db954; font-size:18px; text-decoration:none;">
                ► Mở bài hát
            </a>
        </div>
    </div>

</div>

</body>
</html>
