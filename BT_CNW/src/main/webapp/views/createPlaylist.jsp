<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo Playlist – Mimiu Studio</title>

    <style>
        /* RESET LỖI HEADER LỆCH */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Poppins", sans-serif;
            background:#0b0b0b;
            color:white;
            overflow-x: hidden;
        }

        .header-spacer {
            height: 100px;
        }

        .box {
            width: 420px;
            margin: 50px auto;
            padding: 28px;
            background: #1b1b1b;
            border-radius: 14px;
        }

        .box h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        input[type=text] {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 8px;
            outline: none;
            background: #333;
            color: white;
            margin-bottom: 15px;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #4a95ff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            color: white;
            font-size: 16px;
        }

        button:hover {
            background: #6aa7ff;
        }
    </style>
</head>

<body>

<!-- INCLUDE HEADER -->
<jsp:include page="/views/header.jsp"/>

<!-- SPACER (CHỈ 1 CÁI, KHÔNG NÊN BỎ) -->
<div class="header-spacer"></div>

<div class="box">
    <h2>Tạo playlist mới</h2>

    <form action="${pageContext.request.contextPath}/playlist" method="post">
        <input type="hidden" name="action" value="new">

        <label>Tên Playlist</label>
        <input type="text" name="name" placeholder="Nhập tên playlist..." required>

        <button type="submit">Tạo playlist</button>
    </form>
</div>

</body>
</html>
