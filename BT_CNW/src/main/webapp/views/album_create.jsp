<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    String defaultAlbumName = "Album mới";
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo Album – Mimiu Studio</title>

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: "Poppins", sans-serif;
            background: #0b0b0b;
            color: white;
            overflow-x: hidden;
            padding-top: 105px;
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
            background: rgba(0,0,0,0.45);
            backdrop-filter: blur(12px);
            z-index: 1000;
        }

        .logo { font-size: 26px; font-weight: bold; }

        nav a {
            margin-left: 35px;
            color: white;
            opacity: .9;
            text-decoration: none;
        }

        nav a:hover { opacity: 1; }

        .dropdown {
            position: relative;
            display: inline-block;
            margin-left: 35px;
        }

        .dropdown-content {
            display:none;
            position:absolute;
            top:30px; left:0;
            width:160px;
            padding:8px 0;
            border-radius:10px;
            background:rgba(30,30,30,0.95);
        }

        .dropdown:hover .dropdown-content { display:block; }

        .dropdown-content a {
            display:block;
            padding:10px 14px;
            color:white;
        }

        .dropdown-content a:hover {
            background:#555;
        }

        .header-spacer { height: 95px; }

        /* CONTENT */
        .container {
            max-width:1100px;
            margin:0 auto;
            padding:0 25px;
        }

        .album-header {
            display:flex;
            gap:30px;
            align-items:center;
            margin-bottom:25px;
        }

        #coverBox {
            width:180px; height:180px;
            border:2px dashed #6a4dfc;
            border-radius:12px;
            background:#222;
            display:flex;
            align-items:center;
            justify-content:center;
            color:#a693ff;
            cursor:pointer;
            overflow:hidden;
        }

        #coverPreview { width:100%; height:100%; object-fit:cover; display:none; }

        .album-info input {
            font-size:32px;
            font-weight:bold;
            background:none;
            border:none;
            color:white;
            width:100%;
        }

        .search-box {
            width:100%;
            padding:14px 15px;
            border-radius:10px;
            background:#111;
            border:1px solid #333;
            margin-bottom:18px;
            color:white;
        }

        .song-card {
            background:#141414;
            padding:14px 18px;
            border-radius:12px;
            border:1px solid #222;
            margin-bottom:12px;
            display:flex;
            align-items:center;
        }

        .song-left {
            display:flex;
            gap:15px;
            align-items:center;
        }

        .song-left img {
            width:55px;
            height:55px;
            object-fit:cover;
            border-radius:8px;
        }

        .selected-box {
            background:#111;
            padding:15px;
            border-radius:12px;
            margin-bottom:20px;
        }

    </style>
</head>

<body>

<!-- HEADER -->
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

        <a class="user-icon">👤</a>
        <a href="${pageContext.request.contextPath}/logout" style="color:#ff7f7f;">Đăng xuất</a>
    </nav>
</div>

<div class="header-spacer"></div>

<!-- CONTENT -->
<div class="container">

    <div class="album-header">
        <div id="coverBox" onclick="document.getElementById('coverInput').click()">
            <img id="coverPreview">
            <span id="coverText">Ảnh bìa album</span>
        </div>

        <div class="album-info">
            <input type="text" id="albumName" value="<%= defaultAlbumName %>">
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/album/create"
          method="post" enctype="multipart/form-data">

        <!-- Hidden values -->
        <input type="file" id="coverInput" name="cover" hidden accept="image/*">
        <input type="hidden" name="title" id="titleHidden">

        <label>Năm phát hành</label>
        <input type="number" name="year" class="search-box">

        <label>Mô tả</label>
        <textarea name="description" rows="4" class="search-box"></textarea>

        <!-- SONG SELECTED PREVIEW -->
      <!-- SEARCH SONG -->
        <h2 style="margin-top:30px;">Danh sách bài hát</h2>
        <input type="text" id="songSearch" class="search-box" placeholder="Tìm bài hát...">

        <!-- SONG LIST -->
        <div id="songList">
            <c:forEach var="s" items="${songs}">
                <label class="song-card">

                    <div class="song-left">
                        <input type="checkbox" class="song-check"
                               value="${s.songId}"
                               data-title="${s.title}"
                               data-year="${s.year}"
                               style="width:20px; height:20px;">

                        <img src="${pageContext.request.contextPath}/${s.thumbnail}">
                        <div>
                            <div class="song-name">${s.title}</div>
                        </div>
                    </div>

                </label>
            </c:forEach>
        </div>

        <input type="hidden" name="song_ids" id="songIds">

        <button style="width:100%; padding:15px; border:none; border-radius:12px;
                       background:#6a4dfc; color:white; font-size:17px; margin-top:20px;">
            Tạo Album
        </button>

    </form>
</div>

<script>
window.onload = function() {

    /* SYNC TITLE */
    const titleHidden = document.getElementById("titleHidden");
    const albumName = document.getElementById("albumName");
    titleHidden.value = albumName.value;

    albumName.addEventListener("input", function () {
        titleHidden.value = this.value;
    });

    /* COVER PREVIEW */
    document.getElementById("coverInput").addEventListener("change", e => {
        const f = e.target.files[0];
        if (!f) return;
        coverPreview.src = URL.createObjectURL(f);
        coverPreview.style.display = "block";
        coverText.style.display = "none";
    });

    /* SEARCH SONG */
    document.getElementById("songSearch").addEventListener("input", function(){
        const key = this.value.toLowerCase();
        document.querySelectorAll(".song-card").forEach(card => {
            card.style.display = card.innerText.toLowerCase().includes(key) ? "flex" : "none";
        });
    });

    /* CHỈ CẬP NHẬT SONG_IDS */
    function updateSelected(){
        let ids = [];

        document.querySelectorAll(".song-check:checked").forEach(box => {
            ids.push(box.value);
        });

        document.getElementById("songIds").value = ids.join(",");
    }

    document.querySelectorAll(".song-check").forEach(box =>
        box.addEventListener("change", updateSelected)
    );
};

</script>

</body>
</html>
