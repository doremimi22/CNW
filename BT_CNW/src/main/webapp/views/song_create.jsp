<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // tên bài hát mặc định (sau này có thể tự sinh hoặc để trống)
    String defaultTitle = "Bài hát mới";
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo bài hát – Mimiu Studio</title>

    <style>
        * {margin:0; padding:0; box-sizing:border-box;}

        body {
            font-family: "Poppins", sans-serif;
            background: #0b0b0b;
            color: white;
            padding-top: 100px;
            overflow-x: hidden;
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

.logo {
    font-size: 26px;
    font-weight: bold;
}

nav a {
    margin-left: 35px;
    font-size: 15px;
    color: white;
    opacity: .9;
    text-decoration: none;
}

nav a:hover { opacity: 1; }

/* DROPDOWN */
.dropdown {
    position: relative;
    display: inline-block;
    margin-left: 35px;
}

.drop-btn {
    color: white;
    opacity: .9;
    cursor: pointer;
    font-size: 15px;
    padding: 6px 0;
}

.dropdown-content {
    display: none;
    position: absolute;
    top: 30px;
    left: 0;
    background: rgba(30, 30, 30, 0.95);
    backdrop-filter: blur(6px);
    border-radius: 10px;
    width: 160px;
    padding: 8px 0;
    box-shadow: 0 4px 10px rgba(0,0,0,0.4);
    z-index: 9999;
}

.dropdown:hover .dropdown-content {
    display: block;
}

.dropdown-content a {
    display: block;
    padding: 10px 14px;
    font-size: 14px;
    text-decoration: none;
    color: white;
    opacity: .85;
}

.dropdown-content a:hover {
    background: #555;
    opacity: 1;
}

.user-icon {
    display: inline-block;
    margin-left: 25px;
    font-size: 20px;
    cursor: default;
    opacity: .85;
}

.user-icon:hover {
    opacity: 1;
    transform: scale(1.07);
}

.header-spacer { height: 100px; }


        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 25px;
        }

        /* Song Header (giống Playlist Header) */
        .song-header {
            display: flex;
            gap: 30px;
            margin-bottom: 40px;
            align-items: center;
        }

        /* COVER chọn ảnh */
        #coverBox {
            width: 180px;
            height: 180px;
            border-radius: 12px;
            background: #222;
            border: 2px dashed #6a4dfc;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #c7baff;
            font-size: 14px;
            cursor: pointer;
            overflow: hidden;
        }

        #coverPreview {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: none;
        }

        /* Name editable */
        .song-info h1 input {
            font-size: 32px;
            font-weight: bold;
            background: none;
            border: none;
            color: white;
            width: 100%;
            outline: none;
        }

        /* search artist */
        .search-artist {
            width: 100%;
            padding: 14px 18px;
            background: #1c1c1c;
            border-radius: 12px;
            border: 2px solid #333;
            color: white;
            font-size: 16px;
            margin-bottom: 10px;
        }

        .artist-list {
            margin-top: 5px;
            background: #141414;
            border-radius: 12px;
            border: 1px solid #222;
            max-height: 180px;
            overflow-y: auto;
            display: none;
        }

        .artist-item {
            padding: 10px 15px;
            cursor: pointer;
            border-bottom: 1px solid #222;
        }

        .artist-item:hover {
            background: #1c1c1c;
        }

        /* FORM BELOW */
        .form-box input, .form-box textarea {
            width: 100%;
            padding: 14px;
            background: #121212;
            border-radius: 10px;
            border: 1px solid #333;
            color: white;
            margin-top: 8px;
        }

        label {
            margin-top: 18px;
            display: block;
            font-size: 15px;
        }

        .submit-btn {
            width: 100%;
            padding: 15px;
            margin-top: 25px;
            border: none;
            border-radius: 12px;
            background: #6a4dfc;
            color: white;
            cursor: pointer;
            font-size: 17px;
        }

        .submit-btn:hover {
            background: #7c61ff;
        }
    </style>
</head>

<body>
<!-- ================= HEADER ================= -->
<div class="header">

    <!-- LOGO + ADMIN BADGE -->
    <div class="logo">
        <c:choose>
            <c:when test="${sessionScope.user.role == 'admin'}">
                Mimiu Studio <span style="color:#ffcc00;">★ Admin</span>
            </c:when>
            <c:otherwise>
                Mimiu Studio
            </c:otherwise>
        </c:choose>
    </div>

    <nav>
        <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
        <a href="${pageContext.request.contextPath}/search">Tìm kiếm</a>
        <a href="${pageContext.request.contextPath}/library">Thư viện</a>

        <!-- ADMIN ONLY -->
        <c:if test="${sessionScope.user.role == 'admin'}">
            <div class="dropdown">
                <span class="drop-btn">Tạo mới ▼</span>
                <div class="dropdown-content">
                    <a href="${pageContext.request.contextPath}/song/create">Tạo bài hát</a>
                    <a href="${pageContext.request.contextPath}/album/create">Tạo album</a>
                </div>
            </div>
        </c:if>

        <!-- USER ICON + LOGOUT -->
        <c:if test="${not empty sessionScope.user}">
            <div class="user-icon" title="${sessionScope.user.username}">👤</div>
            <a href="${pageContext.request.contextPath}/logout" style="color:#ff7f7f;">Đăng xuất</a>
        </c:if>

        <!-- CHƯA LOGIN -->
        <c:if test="${empty sessionScope.user}">
            <a href="${pageContext.request.contextPath}/login" style="color:#8fb4ff;">Đăng nhập</a>
        </c:if>
    </nav>
</div>

<div class="header-spacer"></div>


<!-- CONTENT -->
<div class="container">

    <!-- Tiêu đề + ảnh bìa -->
    <div class="song-header">

        <!-- COVER -->
        <div id="coverBox" onclick="document.getElementById('coverInput').click()">
            <img id="coverPreview">
            <span id="coverText">Ảnh bìa</span>
        </div>

        <!-- Tên bài hát -->
        <div class="song-info">
            <h1>
                <input type="text" id="songTitle" name="title" placeholder="Tên bài hát..." value="<%= defaultTitle %>">
            </h1>
        </div>
    </div>


    <!-- FORM -->
    <form action="${pageContext.request.contextPath}/song/create" 
          method="post" enctype="multipart/form-data">

        <!-- Hidden real file input -->
        <input type="file" id="coverInput" name="thumbnail" accept="image/*" style="display:none" required>

        <input type="hidden" name="title" id="titleHidden">
        
        <!-- ARTIST SEARCH -->
        <label>Chọn nghệ sĩ</label>
        <input type="text" class="search-artist" id="artistSearch" placeholder="Tìm nghệ sĩ...">

        <div class="artist-list" id="artistList">
            <c:forEach var="a" items="${artists}">
                <div class="artist-item" data-id="${a.artistId}">
                    ${a.name}
                </div>
            </c:forEach>
        </div>

        <!-- Save artist -->
        <input type="hidden" name="artist_id" id="artistId">


        <!-- FORM INFO -->
        <div class="form-box">

            <label>Thể loại</label>
            <input type="text" name="genre">

            <label>Năm phát hành</label>
            <input type="number" name="year" min="1900" max="2100">

            <label>Link YouTube / Spotify</label>
            <input type="text" name="link">

            <label>Mô tả</label>
            <textarea name="description" rows="4"></textarea>

        </div>

        <button class="submit-btn">Tạo bài hát</button>
    </form>

</div> <!-- END CONTENT -->


<script>
// Cover preview
document.getElementById("coverInput").addEventListener("change", function(e) {
    const file = e.target.files[0];
    if (!file) return;

    const img = document.getElementById("coverPreview");
    img.src = URL.createObjectURL(file);
    img.style.display = "block";

    document.getElementById("coverText").style.display = "none";
});

// Sync title from editable input
document.getElementById("songTitle").addEventListener("input", function() {
    document.getElementById("titleHidden").value = this.value;
});

// Artist search
const searchInput = document.getElementById("artistSearch");
const artistList = document.getElementById("artistList");

searchInput.addEventListener("input", function() {
    const key = this.value.toLowerCase();
    let hasResult = false;

    document.querySelectorAll(".artist-item").forEach(item => {
        const name = item.textContent.toLowerCase();
        if (name.includes(key)) {
            item.style.display = "block";
            hasResult = true;
        } else item.style.display = "none";
    });

    artistList.style.display = hasResult ? "block" : "none";
});

// chọn nghệ sĩ
document.querySelectorAll(".artist-item").forEach(item => {
    item.addEventListener("click", function() {
        document.getElementById("artistSearch").value = this.textContent;
        document.getElementById("artistId").value = this.dataset.id;
        artistList.style.display = "none";
    });
});
</script>

</body>
</html>
