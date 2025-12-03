<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo Nghệ Sĩ – Mimiu Studio</title>

    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body {
            font-family:"Poppins",sans-serif;
            background:#0b0b0b;
            color:white;
            padding-top:110px;
        }

 
        /* FORM */
        .container { max-width:700px; margin:0 auto; padding:0 20px; }
        .box {
            background:#111; padding:25px 30px;
            border-radius:12px; border:1px solid #333;
        }

        input, textarea {
            width:100%; padding:12px;
            background:#1b1b1b; border:1px solid #333;
            border-radius:10px; color:white; margin-top:6px;
        }

        button {
            width:100%; padding:14px;
            margin-top:25px;
            background:#6a4dfc;
            border:none; border-radius:12px;
            font-size:17px; color:white;
        }

        label { display:block; margin-top:18px; }

        #avatarBox {
            width:140px; height:140px;
            background:#222; border:2px dashed #6a4dfc;
            border-radius:12px; display:flex;
            align-items:center; justify-content:center;
            color:#a997ff; cursor:pointer;
            overflow:hidden;
        }

        #previewAvatar {
            width:100%; height:100%;
            object-fit:cover; display:none;
        }
    </style>
</head>

<body>
<!-- ================= REUSE HEADER ================= -->
<jsp:include page="/views/header.jsp"></jsp:include>


<div class="container">
    <h1 style="margin-bottom:20px;">Tạo Nghệ Sĩ</h1>

    <div class="box">

        <form action="${pageContext.request.contextPath}/artist/create"
              method="post" enctype="multipart/form-data">

            <label>Ảnh đại diện</label>
            <div id="avatarBox" onclick="document.getElementById('avatarInput').click()">
                <img id="previewAvatar">
                <span id="avatarText">Chọn ảnh</span>
            </div>
            <input type="file" id="avatarInput" name="avatar" accept="image/*" style="display:none">

            <label>Tên nghệ sĩ</label>
            <input type="text" name="name" required>

            <label>Sinh nhật</label>
            <input type="date" name="birthday" required>

            <label>Tiểu sử</label>
            <textarea name="biography" rows="5"></textarea>

            <button>Tạo Nghệ Sĩ</button>
        </form>
    </div>
</div>

<script>
// ẢNH PREVIEW
document.getElementById("avatarInput").addEventListener("change", e => {
    const file = e.target.files[0];
    if (!file) return;

    previewAvatar.src = URL.createObjectURL(file);
    previewAvatar.style.display = "block";
    avatarText.style.display = "none";
});
</script>

</body>
</html>
