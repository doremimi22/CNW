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

nav {
    display: flex;
    align-items: center;
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
}

.dropdown-content {
    display: none;
    position: absolute;
    top: 30px;
    left: 0;
    width: 160px;
    background: rgba(30,30,30,0.95);
    border-radius: 10px;
    padding: 8px 0;
    box-shadow: 0 4px 10px rgba(0,0,0,0.4);
    z-index: 9999;
}

.dropdown-content a {
    display: block;
    padding: 10px 14px;
    color: white;
    opacity: .85;
    text-decoration: none;
}

.dropdown-content a:hover {
    background: #555;
    opacity: 1;
}

.dropdown:hover .dropdown-content { display: block; }
.drop-btn:hover { opacity: 1; }

/* USER ICON */
.user-icon {
    margin-left: 25px;
    font-size: 20px;
    opacity: .85;
    cursor: default;
    transition: .2s;
}

.user-icon:hover {
    opacity: 1;
    transform: scale(1.07);
}

.header-spacer {
    height: 95px;
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

<<div class="header">

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
