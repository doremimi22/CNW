<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập – Mimiu Studio</title>

    <style>
        * { margin:0; padding:0; box-sizing:border-box; }

        body {
            font-family: "Poppins", sans-serif;
            height: 100vh;
            background: linear-gradient(160deg, #5b2bff, #120025 50%, #0a0a0a);
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            position: relative;
        }

        /* PLANET CHUNG */
        .planet {
            position: absolute;
            border-radius: 50%;
            background: radial-gradient(circle, #ad82ff, #5f3ae6, #3b1a80);
            opacity: 0.45;
            filter: blur(3px);
            animation: float 6s ease-in-out infinite alternate;
        }

        @keyframes float {
            0%   { transform: translateY(0px) scale(1); }
            100% { transform: translateY(-25px) scale(1.05); }
        }

        .p1 { width:180px; height:180px; top:10%; left:5%; animation-duration: 7s; }
        .p2 { width:120px; height:120px; bottom:12%; right:10%; animation-duration: 5.5s; }
        .p3 { width:260px; height:260px; bottom:-5%; left:-6%; opacity:0.35; animation-duration: 9s; }
        .p4 { width:90px; height:90px; top:20%; right:22%; animation-duration: 8s; }
        .p5 { width:140px; height:140px; bottom:25%; left:30%; animation-duration: 6.5s; }
        .p6 { width:70px; height:70px; top:60%; left:75%; animation-duration: 5s; }
        .p7 { width:200px; height:200px; top:-4%; right:-4%; opacity:0.3; animation-duration: 10s; }

        /* LOGIN BOX */
        .login-box {
            width: 380px;
            padding: 35px 30px;
            background: rgba(17, 5, 40, 0.6);
            backdrop-filter: blur(20px);
            border-radius: 22px;
            box-shadow: 0 0 25px rgba(140, 80, 255, 0.3);
            z-index: 10;
            text-align: center;
        }

        .title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 25px;
        }

        .input-field {
            width: 100%;
            padding: 14px;
            margin-bottom: 18px;
            background: #1c1c1c;
            border: 2px solid #333;
            border-radius: 14px;
            color: white;
            font-size: 15px;
            outline: none;
            transition: .25s;
        }

        .input-field:focus {
            border-color: #815dff;
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            background: #6a4dfc;
            border: none;
            border-radius: 14px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: .25s;
        }

        .btn-login:hover {
            background: #7d5bff;
        }

        .error-msg {
            background: rgba(255, 80, 80, 0.25);
            border: 1px solid #ff6b6b;
            padding: 10px;
            border-radius: 10px;
            margin-bottom: 15px;
            font-size: 14px;
            color: #ffb3b3;
        }

        .success-msg {
            background: rgba(80,255,80,0.25);
            border: 1px solid #7dff7d;
            padding: 10px;
            border-radius: 10px;
            margin-bottom: 15px;
            font-size: 14px;
            color: #caffca;
        }

        .register-link {
            margin-top: 15px;
            font-size: 14px;
            opacity: 0.8;
            text-align: center;
        }

        .register-link a {
            color: #a98cff;
            text-decoration: none;
        }
    </style>
</head>

<body>

<!-- PLANETS -->
<div class="planet p1"></div>
<div class="planet p2"></div>
<div class="planet p3"></div>
<div class="planet p4"></div>
<div class="planet p5"></div>
<div class="planet p6"></div>
<div class="planet p7"></div>

<div class="login-box">

    <div class="title">Đăng nhập</div>

    <!-- SUCCESS FROM SIGNUP -->
    <c:if test="${not empty sessionScope.success}">
        <div class="success-msg">${sessionScope.success}</div>
    </c:if>

    <% session.removeAttribute("success"); %>

    <!-- ERROR LOGIN -->
    <c:if test="${not empty sessionScope.error}">
        <div class="error-msg">${sessionScope.error}</div>
    </c:if>

    <% session.removeAttribute("error"); %>

    <form action="${pageContext.request.contextPath}/login" method="post">

        <input type="text" name="username" class="input-field"
               placeholder="Tên đăng nhập" autocomplete="off" required>

        <input type="password" name="password" class="input-field"
               placeholder="Mật khẩu" required>

        <button type="submit" class="btn-login">Đăng nhập</button>
    </form>

    <div class="register-link">
        Chưa có tài khoản?
        <a href="${pageContext.request.contextPath}/views/signup.jsp">Đăng ký</a>
    </div>

</div>

</body>
</html>
