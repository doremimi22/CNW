<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${playlist.name} – Playlist</title>

    <style>
        /* RESET CHO TOÀN TRANG – CHỐNG TRÀN VIỀN / LỆCH HEADER */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html, body {
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            font-family: "Poppins", sans-serif;
            background: #0b0b0b;
            color: white;
        }

        .header-spacer {
            height: 100px;
        }

        .container {
            width: 90%;
            margin: auto;
        }

        /* PLAYLIST HEADER */
        .pl-header {
            display: flex;
            align-items: center;
            gap: 25px;
            margin-bottom: 40px;
        }

        .pl-cover {
            width: 200px;
            height: 200px;
            border-radius: 10px;
            background: #222;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 60px;
            opacity: .7;
        }

        .pl-info h1 {
            font-size: 48px;
            font-weight: 900;
        }

        .pl-info .creator {
            margin-top: 6px;
            opacity: .8;
        }

        /* SONG LIST */
        .song-item {
            background: #1b1b1b;
            padding: 16px;
            border-radius: 10px;
            margin-bottom: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: .2s;
        }

        .song-item:hover {
            background: #292929;
        }

        .song-info {
            cursor: pointer;
            width: 100%;
        }

        .btn-remove {
            background: #ff6f6f;
            padding: 6px 12px;
            border-radius: 6px;
            text-decoration: none;
            color: white;
        }

        /* SEARCH BOX */
        .search-box {
            margin-top: 40px;
            background: #1b1b1b;
            padding: 18px;
            border-radius: 12px;
        }

        #searchInput {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: none;
            background: #333;
            color: white;
        }

        /* SEARCH RESULT */
        .search-result-item {
            background: #222;
            padding: 14px;
            border-radius: 10px;
            margin-top: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .add-btn {
            background: #4a95ff;
            padding: 6px 14px;
            border-radius: 8px;
            cursor: pointer;
        }

        .add-btn:hover {
            background: #6aa7ff;
        }
    </style>
</head>

<body>

<!-- HEADER CHUNG -->
<jsp:include page="/views/header.jsp" />

<!-- ĐẨY NỘI DUNG XUỐNG DƯỚI HEADER FIXED -->
<div class="header-spacer"></div>

<div class="container">

    <!-- HEADER PLAYLIST -->
    <div class="pl-header">
        <div class="pl-cover">🎵</div>

        <div class="pl-info">
            <h1>${playlist.name}</h1>
            <div class="creator">
                Danh sách công khai – Người tạo:
                <b>${sessionScope.fullname}</b>
            </div>
        </div>
    </div>

    <!-- SONGS IN PLAYLIST -->
    <h2>Bài hát trong playlist</h2>

    <c:forEach var="s" items="${songs}">
        <div class="song-item">
            <div class="song-info"
                 onclick="location.href='${pageContext.request.contextPath}/song?action=detail&id=${s.song.songId}'">
                <b>${s.song.title}</b><br>
                <span style="opacity:.7">${s.song.year}</span>
            </div>

            <a class="btn-remove"
               onclick="event.stopPropagation()"
               href="${pageContext.request.contextPath}/playlist?action=removeSong&playlistSongId=${s.playlistSongId}&playlistId=${playlist.playlistId}">
                Xóa
            </a>
        </div>
    </c:forEach>

    <c:if test="${empty songs}">
        <p>Playlist chưa có bài hát.</p>
    </c:if>

    <!-- SEARCH AREA -->
    <div class="search-box">
        <h3>Hãy cùng tìm nội dung cho danh sách phát của bạn</h3>

        <input type="text" id="searchInput"
               placeholder="Tìm bài hát"
               onkeyup="searchSong()">

        <div id="searchResult">
            <!-- RENDER SẴN TẤT CẢ BÀI HÁT, JS CHỈ ẨN/HIỆN -->
            <c:forEach var="s" items="${allSongs}">
                <div class="search-result-item"
                     data-title="${fn:toLowerCase(s.title)}">
                    <div style="cursor:pointer"
                         onclick="location.href='${pageContext.request.contextPath}/song?action=detail&id=${s.songId}'">
                        <b>${s.title}</b><br>
                        <span style="opacity:.7">${s.year}</span>
                    </div>
                    <button class="add-btn" onclick="addSong(${s.songId})">+</button>
                </div>
            </c:forEach>
        </div>
    </div>

</div>

<!-- SCRIPT -->
<script>
    // playlistId từ server (số)
    const playlistId = ${playlist.playlistId};

    // Lọc theo từ khóa: ẩn/hiện các dòng đã render
    function searchSong() {
        const keyword = document.getElementById("searchInput").value.toLowerCase().trim();
        const items = document.querySelectorAll("#searchResult .search-result-item");

        items.forEach(item => {
            const title = item.getAttribute("data-title"); // đã là lowercase
            if (!keyword || title.includes(keyword)) {
                item.style.display = "flex";
            } else {
                item.style.display = "none";
            }
        });
    }

    // Gửi request thêm bài hát
    function addSong(songId) {
        console.log("ADD SONG", "playlistId =", playlistId, "songId =", songId);

        if (songId == null || isNaN(songId)) {
            alert("Không xác định được bài hát để thêm!");
            return;
        }

        fetch("${pageContext.request.contextPath}/playlist", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "action=addSong&playlistId=" + playlistId + "&songId=" + songId
        }).then(res => {
            if (res.ok) {
                location.reload();
            } else {
                alert("Lỗi khi thêm bài hát!");
            }
        }).catch(err => {
            console.error("Fetch error:", err);
            alert("Không gửi được yêu cầu tới server!");
        });
    }
</script>

</body>
</html>
