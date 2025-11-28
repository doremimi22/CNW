<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký – Mimiu Studio</title>

    <style>
        * {margin:0; padding:0; box-sizing:border-box;}

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

/* ANIMATION FLOAT */
@keyframes float {
    0%   { transform: translateY(0px) scale(1); }
    100% { transform: translateY(-25px) scale(1.05); }
}

/* NHIỀU PLANET – KHÁC SIZE + VỊ TRÍ + TỐC ĐỘ */
.p1 { width:180px; height:180px; top:10%; left:5%; animation-duration: 7s; }
.p2 { width:120px; height:120px; bottom:12%; right:10%; animation-duration: 5.5s; }
.p3 { width:260px; height:260px; bottom:-5%; left:-6%; opacity:0.35; animation-duration: 9s; }
.p4 { width:90px; height:90px; top:20%; right:22%; animation-duration: 8s; }
.p5 { width:140px; height:140px; bottom:25%; left:30%; animation-duration: 6.5s; }
.p6 { width:70px; height:70px; top:60%; left:75%; animation-duration: 5s; }
.p7 { width:200px; height:200px; top:-4%; right:-4%; opacity:0.3; animation-duration: 10s; }

        .signup-box {
            width: 420px;
            padding: 40px 30px;
            background: rgba(17, 5, 40, 0.6);
            backdrop-filter: blur(20px);
            border-radius: 22px;
            box-shadow: 0 0 25px rgba(140, 80, 255, 0.3);
            position: relative;
            z-index: 10;
        }

        .title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 25px;
            text-align: center;
        }

        .input-label {
            font-size: 14px;
            opacity: 0.8;
            margin-bottom: 5px;
            display: block;
        }

        .input-field {
            width: 100%;
            padding: 14px;
            background: #1c1c1c;
            border: 2px solid #333;
            border-radius: 14px;
            color: white;
            font-size: 15px;
            margin-bottom: 18px;
            outline: none;
            transition: .25s;
        }

        .input-field:focus {
            border-color: #815dff;
        }

        .btn-register {
            width: 100%;
            padding: 12px;
            background: #6a4dfc;
            border: none;
            border-radius: 14px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            margin-top: 5px;
            transition: .25s;
        }

        .btn-register:hover {
            background: #7d5bff;
        }

        .login-link {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
            opacity: 0.8;
        }

        .login-link a {
            color: #a98cff;
            text-decoration: none;
        }
    </style>
</head>

<body>
<div class="planet p1"></div>
<div class="planet p2"></div>
<div class="planet p3"></div>
<div class="planet p4"></div>
<div class="planet p5"></div>
<div class="planet p6"></div>
<div class="planet p7"></div>


<!-- SIGNUP BOX -->
<div class="signup-box">

    <div class="title">Đăng ký</div>

    <form action="SignupServlet" method="post">

        <label class="input-label">Tên đăng nhập</label>
        <input type="text" name="username" class="input-field" required />

        <label class="input-label">Mật khẩu</label>
        <input type="password" name="password" class="input-field" required />

        <label class="input-label">Xác nhận mật khẩu</label>
        <input type="password" name="confirm" class="input-field" required />

        <button type="submit" class="btn-register">Tạo tài khoản</button>

    </form>

    <div class="login-link">
        Đã có tài khoản? <a href="${pageContext.request.contextPath}/views/login.jsp">Đăng nhập</a>

    </div>

</div>

</body>
</html>
