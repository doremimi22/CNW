<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
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
        width: 160px;
        padding: 8px 0;
        background: rgba(30, 30, 30, 0.95);
        backdrop-filter: blur(6px);
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.4);
        z-index: 9999;
        padding-top: 6px;
    }

    .dropdown:hover .dropdown-content { display: block; }

    .dropdown-content a {
        display: block;
        padding: 10px 14px;
        font-size: 14px;
        color: white;
        opacity: .85;
        text-decoration: none;
    }

    .dropdown-content a:hover {
        background: #555;
        opacity: 1;
    }

    .user-name {
        display: inline-block;
        margin-left: 25px;
        font-size: 15px;
        cursor: default;
        opacity: .85;
    }

    .header-spacer { height: 100px; }
</style>


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
        <a href="${pageContext.request.contextPath}/playlist">Playlist</a>

        <!-- ADMIN: dropdown -->
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

        <!-- USER -->
        <c:if test="${not empty sessionScope.user}">
            <div class="user-name">👤Hello ${sessionScope.fullname}</div>
            <a href="${pageContext.request.contextPath}/logout" style="color:#ff7f7f;">Đăng xuất</a>
        </c:if>

        <!-- GUEST -->
        <c:if test="${empty sessionScope.user}">
            <a href="${pageContext.request.contextPath}/login" style="color:#8fb4ff;">Đăng nhập</a>
        </c:if>
    </nav>
</div>

<div class="header-spacer"></div>
