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
<!-- ================= REUSE HEADER ================= -->
<jsp:include page="/views/components/header.jsp"></jsp:include>
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
