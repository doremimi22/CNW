<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo bài hát – Mimiu Studio</title>

    <style>
        body {
            background: #0b0b0b;
            font-family: "Poppins", sans-serif;
            color: white;
            padding-top: 110px;
        }

        .container {
            max-width: 850px;
            margin: 0 auto;
            padding: 20px;
        }

        h1 { margin-bottom: 20px; }

        .form-box {
            background: #1b1b1b;
            padding: 25px;
            border-radius: 14px;
            border: 1px solid #333;
        }

        label { display:block; margin-top:15px; font-size:15px; }

        input, textarea, select {
            width: 100%;
            padding: 12px;
            background: #121212;
            border: 1px solid #333;
            border-radius: 10px;
            color: white;
            margin-top: 6px;
        }

        .submit-btn {
            width: 100%;
            margin-top: 25px;
            padding: 12px;
            background: #6a4dfc;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            color: white;
            cursor: pointer;
        }

        .submit-btn:hover { background:#7c61ff; }

        /* IMAGE PREVIEW */
        #preview {
            width: 180px;
            height: 180px;
            object-fit: cover;
            border-radius: 12px;
            margin-top: 15px;
            display:none;
        }
    </style>
</head>

<body>

<!-- HEADER GIỐNG HOME -->
<div class="container">
    <h1>Tạo bài hát mới</h1>

    <div class="form-box">

        <c:if test="${not empty error}">
            <div style="color:#ff8080; margin-bottom:10px">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/song/create"
              method="post" enctype="multipart/form-data">

            <label>Tiêu đề bài hát</label>
            <input type="text" name="title" required>

            <label>Năm phát hành</label>
            <input type="number" name="year" min="1900" max="2100">

            <label>Thể loại</label>
            <input type="text" name="genre">

            <label>Link YouTube / Spotify</label>
            <input type="text" name="link">

            <label>Mô tả</label>
            <textarea name="description" rows="4"></textarea>

            <label>Chọn nghệ sĩ</label>
            <select name="artist_id" required>
                <option value="">-- Chọn nghệ sĩ --</option>
                <c:forEach var="a" items="${artists}">
                    <option value="${a.artistId}">
                        ${a.name}
                    </option>
                </c:forEach>
            </select>

            <label>Ảnh thumbnail</label>
            <input type="file" name="thumbnail" accept="image/*" onchange="showPreview(event)" required>

            <img id="preview">

            <button class="submit-btn">Tạo bài hát</button>

        </form>

    </div>
</div>

<script>
function showPreview(e) {
    const file = e.target.files[0];
    if (!file) return;
    const img = document.getElementById("preview");
    img.src = URL.createObjectURL(file);
    img.style.display = "block";
}
</script>

</body>
</html>
