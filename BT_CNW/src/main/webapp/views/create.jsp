<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
    // Tự sinh tên playlist ví dụ: Playlist #3
    int totalPlaylists = 5; // sau này load từ DB
    String playlistName = "Playlist #" + (totalPlaylists + 1);

    // Tên người dùng (placeholder – sau này sẽ lấy từ session)
    String username = "Người dùng A";
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo Playlist – Mimiu Studio</title>

    <style>
        * {margin:0; padding:0; box-sizing:border-box;}

        body {
            font-family: "Poppins", sans-serif;
            background: #0b0b0b;
            color: white;
            padding-top: 100px;
            overflow-x: hidden;
        }

        /* Header */
        .header {
            position: fixed;
            top: 0; left: 0;
            width: 100%;
            padding: 20px 40px;
            display: flex; justify-content: space-between; align-items: center;
            background: rgba(0,0,0,0.4);
            backdrop-filter: blur(10px);
            z-index: 1000;
        }

        .header nav a {
            margin-left: 35px;
            text-decoration: none;
            color: white;
            opacity: .85;
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 25px;
        }

        /* Playlist Header Section */
        .playlist-header {
            display: flex;
            gap: 30px;
            margin-bottom: 40px;
            align-items: center;
        }

        .playlist-cover {
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
        }

        .playlist-info h1 {
            font-size: 32px;
            font-weight: bold;
        }

        .playlist-info .user {
            margin-top: 6px;
            opacity: 0.7;
        }

        /* Search */
        .search-box {
            width: 100%;
            padding: 14px 18px;
            background: #1c1c1c;
            border-radius: 12px;
            border: 2px solid #333;
            color: white;
            font-size: 16px;
            margin-bottom: 30px;
        }

        /* Song cards */
        .song-row {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .song-card {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #141414;
            padding: 14px 18px;
            border-radius: 12px;
            border: 1px solid #222;
            transition: 0.2s;
        }

        .song-card:hover {
            background: #1a1a1a;
        }

        .song-left {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .song-left img {
            width: 55px;
            height: 55px;
            border-radius: 8px;
            object-fit: cover;
        }

        .song-name {
            font-size: 16px;
            font-weight: 500;
        }

        .artist {
            font-size: 13px;
            opacity: 0.7;
        }

        /* Add button */
        .add-btn {
            font-size: 26px;
            color: #a78aff;
            cursor: pointer;
            transition: 0.25s;
        }

        .add-btn:hover {
            color: #cbb3ff;
        }

    </style>
</head>

<body>

<!-- HEADER -->
<div class="header">
    <div class="logo">Mimiu Studio</div>
    <nav>
        <a href="home.jsp">Trang chủ</a>
        <a href="search.jsp">Tìm kiếm</a>
        <a href="library.jsp">Thư viện</a>
        <a href="create.jsp">Tạo Playlist</a>
    </nav>
</div>


<!-- CONTENT -->
<div class="container">

    <!-- Playlist Info -->
    <div class="playlist-header">
        <div class="playlist-cover">
            Ảnh bìa
        </div>

        <div class="playlist-info">
            <h1><%= playlistName %></h1>
            <div class="user"><%= username %></div>
        </div>
    </div>


    <!-- Search Songs -->
    <input type="text" class="search-box" placeholder="Tìm bài hát để thêm vào playlist..." />


    <!-- Suggested Songs -->
    <h2 style="margin-bottom:15px; font-size:22px;">Gợi ý cho bạn</h2>

    <div class="song-row">

        <!-- 1 -->
        <div class="song-card">
            <div class="song-left">
                <img src="https://i.scdn.co/image/ab67616d0000b273579f41b7c18472dbae7ef73d">
                <div>
                    <div class="song-name">Dreamscape</div>
                    <div class="artist">Nova</div>
                </div>
            </div>
            <div class="add-btn">+</div>
        </div>

        <!-- 2 -->
        <div class="song-card">
            <div class="song-left">
                <img src="https://i.scdn.co/image/ab67616d0000b273b369e3a27c287fa42ccf7bbc">
                <div>
                    <div class="song-name">Deep Focus</div>
                    <div class="artist">Lofi Beats</div>
                </div>
            </div>
            <div class="add-btn">+</div>
        </div>

        <!-- 3 -->
        <div class="song-card">
            <div class="song-left">
                <img src="https://i.scdn.co/image/ab67616d0000b27300c1ff717a8ba4a8988e85b2">
                <div>
                    <div class="song-name">Summer Mood</div>
                    <div class="artist">Kira</div>
                </div>
            </div>
            <div class="add-btn">+</div>
        </div>

    </div>

</div> <!-- END CONTENT -->

</body>
</html>
