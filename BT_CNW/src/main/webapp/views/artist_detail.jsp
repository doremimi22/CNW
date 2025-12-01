<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${artist.name} – Nghệ Sĩ</title>

    <style>
        * { margin:0; padding:0; box-sizing:border-box; }

        body {
            font-family:"Poppins",sans-serif;
            background:#0b0b0b;
            color:white;
            overflow-x:hidden;
            padding-top:110px;
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

        .logo { font-size:26px; font-weight:bold; }

        nav { display:flex; align-items:center; }
        nav a {
            margin-left:35px;
            color:white; opacity:.9; text-decoration:none;
        }
        nav a:hover { opacity:1; }

        .dropdown { position:relative; margin-left:35px; }
        .drop-btn { cursor:pointer; opacity:.9; }
        .dropdown-content {
            display:none; position:absolute; top:30px; left:0;
            width:160px;
            background:rgba(30,30,30,0.95);
            border-radius:10px;
            padding:8px 0;
        }
        .dropdown:hover .dropdown-content { display:block; }

        .dropdown-content a {
            display:block; padding:10px 14px;
            text-decoration:none; color:white; opacity:.85;
        }
        .dropdown-content a:hover { background:#555; }

        .user-icon {
            margin-left:25px;
            font-size:20px;
            opacity:.85;
        }

        .header-spacer { height:95px; }

        /* ============== ARTIST PROFILE ============== */
        .container { max-width:1100px; margin:0 auto; padding:0 25px; }

        .artist-header {
            display:flex; gap:30px; align-items:center;
            margin-bottom:40px;
        }

        .artist-avatar {
            width:180px; height:180px;
            border-radius:50%;
            object-fit:cover;
            border:3px solid #6a4dfc;
        }

        .artist-info h1 {
            font-size:38px; margin-bottom:8px;
        }

        .artist-info .birthday {
            font-size:15px; opacity:.7; margin-bottom:15px;
        }

        .biography {
            background:#111;
            padding:18px 20px;
            border-radius:12px;
            line-height:1.5;
            border:1px solid #222;
            margin-bottom:35px;
        }

        .section-title {
            font-size:22px;
            font-weight:bold;
            margin:25px 0 12px;
        }

        .song-list, .album-list {
            background:#111;
            padding:18px 20px;
            border:1px solid #222;
            border-radius:12px;
        }

        .song-item, .album-item {
            padding:10px 0;
            border-bottom:1px solid #222;
        }
        .song-item:last-child, .album-item:last-child {
            border-bottom:none;
        }
.song-list, .album-list {
    background:#111;
    padding:18px 20px;
    border:1px solid #222;
    border-radius:12px;
}

.song-row, .album-row {
    display:flex;
    align-items:center;
    gap:18px;
    padding:12px 0;
    border-bottom:1px solid #222;
    cursor:pointer;
    transition:.2s;
}

.song-row:hover, .album-row:hover {
    background:#1a1a1a;
}

.song-row:last-child, .album-row:last-child {
    border-bottom:none;
}

.cover {
    width:60px; height:60px;
    border-radius:8px;
    object-fit:cover;
}

.item-title {
    font-size:16px;
    font-weight:600;
}

.item-sub {
    font-size:13px;
    opacity:.7;
}

        .year { opacity:.6; font-size:14px; }
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

        <div class="user-icon">👤</div>
        <a href="${pageContext.request.contextPath}/logout" style="color:#ff7f7f;">Đăng xuất</a>
    </nav>
</div>

<div class="header-spacer"></div>

<!-- ================= CONTENT ================= -->
<div class="container">

    <!-- ===== PROFILE ===== -->
    <div class="artist-header">
        <img class="artist-avatar"
             src="${pageContext.request.contextPath}/${artist.avatar}"
             alt="Avatar nghệ sĩ">

        <div class="artist-info">
            <h1>${artist.name}</h1>
            <div class="birthday">🎂 Sinh nhật: ${artist.birthday}</div>
        </div>
    </div>

    <!-- ===== BIOGRAPHY ===== -->
    <div class="biography">
        ${artist.biography}
    </div>

    <!-- ===== SONGS ===== -->
 <div class="section-title">Bài hát của nghệ sĩ</div>
<div class="song-list">

    <c:forEach var="s" items="${songs}">
        <a href="${pageContext.request.contextPath}/song?action=detail&id=${s.songId}"
           style="text-decoration:none; color:white;">
            
            <div class="song-row">
                <img class="cover" src="${pageContext.request.contextPath}/${s.thumbnail}">
                
                <div>
                    <div class="item-title">${s.title}</div>
                    <div class="item-sub">Năm phát hành: ${s.year}</div>
                </div>
            </div>

        </a>
    </c:forEach>

    <c:if test="${empty songs}">
        <div style="opacity:.7;">Chưa có bài hát nào.</div>
    </c:if>

</div>


  <div class="section-title">Album có bài hát của nghệ sĩ</div>

<div class="album-list">

    <c:forEach var="al" items="${albums}">
        <a href="${pageContext.request.contextPath}/album?action=detail&id=${al.albumId}"
           style="text-decoration:none; color:white;">

            <div class="album-row">
                <img class="cover" src="${pageContext.request.contextPath}/${al.cover}">

                <div>
                    <div class="item-title">${al.title}</div>
                    <div class="item-sub">Năm: ${al.releaseYear}</div>
                </div>
            </div>

        </a>
    </c:forEach>

    <c:if test="${empty albums}">
        <div style="opacity:.7;">Chưa có album nào.</div>
    </c:if>

</div>


</div>

</body>
</html>
