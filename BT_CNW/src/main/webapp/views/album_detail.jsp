<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${album.title} – Mimiu Studio</title>

    <style>
        * { margin:0; padding:0; box-sizing:border-box; }

        body {
            background:#0b0b0b;
            font-family:"Poppins", sans-serif;
            color:white;
            overflow-x:hidden;
            padding-top:110px;
        }

    
        /* CONTENT */
        .container { max-width:1100px; margin:0 auto; padding:0 25px; }

        .album-header { display:flex; gap:40px; align-items:center; }
        .cover {
            width:300px; height:300px;
            border-radius:12px; object-fit:cover;
        }

        .album-title { font-size:40px; font-weight:600; }
        .album-year { opacity:.75; margin-top:5px; }
        .album-desc { margin-top:15px; opacity:.85; line-height:1.5; }

        /* ARTISTS */
        .artist-section { margin-top:40px; }
        .artist-row {
            display:flex; gap:15px; align-items:center;
            margin-bottom:15px; text-decoration:none; color:white;
        }
        .artist-avatar {
            width:60px; height:60px; border-radius:50%;
            object-fit:cover; border:2px solid #6a4dfc;
        }

        /* SONGS */
        .song-section { margin-top:40px; }
        .song-row {
            display:flex; align-items:center;
            gap:18px; padding:14px 0;
            border-bottom:1px solid #222;
            cursor:pointer; transition:.2s;
        }
        .song-row:hover { background:#1a1a1a; }

        .song-thumb {
            width:60px; height:60px;
            border-radius:8px; object-fit:cover;
        }

        .song-title { font-size:17px; font-weight:500; }
        .song-artist { font-size:14px; opacity:.7; }
    </style>
</head>

<body>
<!-- ================= REUSE HEADER ================= -->
<jsp:include page="/views/components/header.jsp"></jsp:include>
<!-- CONTENT -->
<div class="container">

    <!-- ALBUM HEADER -->
    <div class="album-header">
        <img src="${pageContext.request.contextPath}/${album.cover}" class="cover">

        <div>
            <div class="album-title">${album.title}</div>
            <div class="album-year">${album.releaseYear}</div>
            <div class="album-desc">${album.description}</div>
        </div>
    </div>

    <!-- ARTISTS -->
    <div class="artist-section">
        <h2>Nghệ sĩ trong album</h2>

        <c:forEach var="ar" items="${artists}">
            <a class="artist-row"
               href="${pageContext.request.contextPath}/artist?action=detail&id=${ar.artistId}">
                <img src="${pageContext.request.contextPath}/${ar.avatar}" class="artist-avatar">
                <div>
                    <div style="font-size:17px; font-weight:600;">${ar.name}</div>
                    <div style="opacity:.7; font-size:13px;">${ar.birthday}</div>
                </div>
            </a>
        </c:forEach>

        <c:if test="${empty artists}">
            <div style="opacity:.7; margin-top:10px;">Không có nghệ sĩ.</div>
        </c:if>
    </div>

    <!-- SONG LIST -->
    <div class="song-section">
        <h2>Các bài hát trong album</h2>

        <c:forEach var="s" items="${songs}">
            <div class="song-row"
                 onclick="location.href='${pageContext.request.contextPath}/song?action=detail&id=${s.songId}'">

                <img class="song-thumb" src="${pageContext.request.contextPath}/${s.thumbnail}">

                <div>
                    <div class="song-title">${s.title}</div>

                    <div class="song-artist">
                        <c:forEach var="a" items="${s.artists}">
                            ${a.name}
                        </c:forEach>
                    </div>
                </div>

            </div>
        </c:forEach>

        <c:if test="${empty songs}">
            <div style="opacity:.7;">Không có bài hát.</div>
        </c:if>

    </div>

</div>

</body>
</html>
