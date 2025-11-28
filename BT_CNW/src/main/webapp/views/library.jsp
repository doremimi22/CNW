<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thư viện – Mimiu Studio</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Poppins", sans-serif;
            background-color: #0b0b0b;
            color: white;
            padding-top: 100px;
            overflow-x: hidden;
        }

        /* ---------------- HEADER ---------------- */
        .header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(0,0,0,0.4);
            backdrop-filter: blur(10px);
            z-index: 1000;
        }

        .header .logo {
            font-size: 26px;
            font-weight: bold;
        }

        .header nav a {
            margin-left: 35px;
            text-decoration: none;
            color: white;
            opacity: 0.85;
            font-size: 15px;
        }

        .header nav a:hover {
            opacity: 1;
        }

        /* ---------------- CONTENT WRAPPER ---------------- */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 25px;
        }

        /* ---------------- TAG FILTER BUTTONS ---------------- */
        .filter-tags {
            display: flex;
            gap: 15px;
            margin-bottom: 35px;
        }

        .tag-btn {
            padding: 10px 25px;
            border-radius: 25px;
            font-size: 16px;
            border: 2px solid #6a4dfc;
            color: #d6c9ff;
            cursor: pointer;
            background: transparent;
            transition: 0.25s;
            user-select: none;
        }

        .tag-btn:hover {
            background: #6a4dfc30;
        }

        /* Khi được chọn */
        .tag-btn.active {
            background: #6a4dfc;
            color: white;
            border-color: #7d5bff;
        }

        /* ---------------- SECTION TITLE ---------------- */
        .section-title {
            font-size: 22px;
            font-weight: bold;
            margin: 25px 0 15px 0;
        }

        /* ---------------- PLAYLIST CARDS (SQUARE) ---------------- */
        .playlist-row {
            display: flex;
            gap: 25px;
            flex-wrap: wrap;
        }

        .playlist-card {
            width: 180px;
            background: #1b1b1b;
            border-radius: 12px;
            padding: 15px;
            transition: 0.25s;
            cursor: pointer;
        }

        .playlist-card:hover {
            transform: scale(1.05);
        }

        .playlist-card img {
            width: 100%;
            height: 170px;
            border-radius: 10px;
            object-fit: cover;
        }

        .playlist-name {
            margin-top: 12px;
            font-size: 16px;
            font-weight: bold;
        }

        .playlist-desc {
            opacity: 0.7;
            font-size: 13px;
        }

        /* ---------------- ARTIST CARDS (CIRCLE) ---------------- */
        .artist-row {
            display: flex;
            gap: 35px;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .artist-card {
            width: 150px;
            text-align: center;
            cursor: pointer;
            transition: 0.25s;
        }

        .artist-card:hover {
            transform: scale(1.05);
        }

        .artist-card img {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            object-fit: cover;
        }

        .artist-name {
            margin-top: 12px;
            font-size: 16px;
            font-weight: bold;
        }

        .artist-label {
            opacity: 0.7;
            font-size: 13px;
        }

    </style>
</head>

<body>

<!-- ---------------- HEADER ---------------- -->
<div class="header">
    <div class="logo">Mimiu Studio</div>

    <nav>
        <a href="home.jsp">Trang chủ</a>
        <a href="search.jsp">Tìm kiếm</a>
        <a href="library.jsp">Thư viện</a>
        <a href="create.jsp">Tạo Playlist</a>
    </nav>
</div>


<!-- ---------------- CONTENT ---------------- -->
<div class="container">

    <!-- FILTER TAGS -->
    <div class="filter-tags">
        <div id="tagPlaylist" class="tag-btn">Danh sách phát</div>
        <div id="tagArtist" class="tag-btn">Nghệ sĩ</div>
    </div>

    <!-- PLAYLIST SECTION -->
    <div id="playlistSection">

        <div class="section-title">Danh sách phát</div>

        <div class="playlist-row">

            <div class="playlist-card">
                <img src="https://i.scdn.co/image/ab67616d0000b27300c1ff717a8ba4a8988e85b2">
                <div class="playlist-name">Summer Mood</div>
                <div class="playlist-desc">24 bài hát</div>
            </div>

            <div class="playlist-card">
                <img src="https://i.scdn.co/image/ab67616d0000b273b369e3a27c287fa42ccf7bbc">
                <div class="playlist-name">Deep Focus</div>
                <div class="playlist-desc">18 bài hát</div>
            </div>

        </div>

    </div>

    <!-- ARTIST SECTION -->
    <div id="artistSection">

        <div class="section-title" style="margin-top:40px;">Nghệ sĩ</div>

        <div class="artist-row">

            <div class="artist-card">
                <img src="https://i.scdn.co/image/ab6761610000e5ebe7182795e983c2ba8b4cfec1">
                <div class="artist-name">Nova</div>
                <div class="artist-label">Nghệ sĩ</div>
            </div>

            <div class="artist-card">
                <img src="https://i.scdn.co/image/ab6761610000e5eb989b71b3170f547fe36f1bfc">
                <div class="artist-name">Kira</div>
                <div class="artist-label">Nghệ sĩ</div>
            </div>

        </div>

    </div>

</div> <!-- END container -->


<!-- ---------------- FILTER LOGIC ---------------- -->
<script>
    const tagPlaylist = document.getElementById("tagPlaylist");
    const tagArtist = document.getElementById("tagArtist");

    const playlistSection = document.getElementById("playlistSection");
    const artistSection   = document.getElementById("artistSection");

    function resetAll() {
        tagPlaylist.classList.remove("active");
        tagArtist.classList.remove("active");
        playlistSection.style.display = "block";
        artistSection.style.display = "block";
    }

    tagPlaylist.onclick = function () {
        // nếu đang active → bỏ chọn, hiển thị cả 2
        if (tagPlaylist.classList.contains("active")) {
            resetAll();
            return;
        }

        // chọn Playlist
        tagPlaylist.classList.add("active");
        tagArtist.classList.remove("active");

        playlistSection.style.display = "block";
        artistSection.style.display = "none";
    };

    tagArtist.onclick = function () {
        // nếu đang active → bỏ chọn, hiển thị cả 2
        if (tagArtist.classList.contains("active")) {
            resetAll();
            return;
        }

        // chọn Nghệ sĩ
        tagArtist.classList.add("active");
        tagPlaylist.classList.remove("active");

        playlistSection.style.display = "none";
        artistSection.style.display = "block";
    };
</script>

</body>
</html>
