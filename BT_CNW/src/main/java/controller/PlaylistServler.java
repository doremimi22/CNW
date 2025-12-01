package controller;

import model.dao.*;
import model.bean.Playlist;
import model.bean.PlaylistSongItem;
import model.bean.Song;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/playlist")
public class PlaylistServler extends HttpServlet {

    private PlaylistDAO playlistDAO = new PlaylistDAO();
    private SongDAO songDAO = new SongDAO();
    private PlaylistSongDAO playlistSongDAO = new PlaylistSongDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");


        // CHƯA ĐĂNG NHẬP → VỀ LOGIN
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "";

        // ==================== CREATE FORM ====================
        if (action.equals("create")) {
            req.setAttribute("songs", songDAO.getAll());
            req.getRequestDispatcher("/views/createPlaylist.jsp").forward(req, resp);
            return;
        }

        // ==================== DETAIL ====================
        if (action.equals("detail")) {

            int playlistId = Integer.parseInt(req.getParameter("id"));

            Playlist pl = playlistDAO.getById(playlistId);
            ArrayList<PlaylistSongItem> songs = playlistSongDAO.getSongsByPlaylist(playlistId);

            req.setAttribute("playlist", pl);
            req.setAttribute("songs", songs);
            System.out.println(">>> SONGS IN PLAYLIST:");
            for (PlaylistSongItem it : songs) {
                System.out.println("Song ID = " + it.getSong().getSongId() + 
                                   " | Title = " + it.getSong().getTitle());
            }

            // list bài hát để thêm
            req.setAttribute("allSongs", songDAO.getAll());

            req.getRequestDispatcher("/views/playlistDetail.jsp").forward(req, resp);
            return;
        }

        // ==================== REMOVE SONG ====================
        if (action.equals("removeSong")) {

            int playlistSongId = Integer.parseInt(req.getParameter("playlistSongId"));
            int playlistId = Integer.parseInt(req.getParameter("playlistId"));

            playlistSongDAO.removeSong(playlistSongId);

            resp.sendRedirect(req.getContextPath() + "/playlist?action=detail&id=" + playlistId);
            return;
        }

        // ==================== DEFAULT: LIST PLAYLIST ====================
        req.setAttribute("playlists", playlistDAO.getAllByUser(userId));
        req.getRequestDispatcher("/views/library.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Integer userId = (Integer) req.getSession().getAttribute("user_id");
        String action = req.getParameter("action");

        // =========== TẠO PLAYLIST ===========
        if ("new".equals(action)) {

            String name = req.getParameter("name");

            int playlistId = playlistDAO.createPlaylistReturnId(userId, name);

            resp.sendRedirect(req.getContextPath() + "/playlist?action=detail&id=" + playlistId);
            return;
        }

        // =========== AJAX ADD SONG ===========
        if ("addSong".equals(action)) {

            String p = req.getParameter("playlistId");
            String s = req.getParameter("songId");

            System.out.println(">>> addSong playlistId=" + p + ", songId=" + s);

            if (p == null || s == null || "undefined".equals(p) || "undefined".equals(s) || p.isEmpty() || s.isEmpty()) {
                resp.setStatus(400);
                return;
            }

            int playlistId = Integer.parseInt(p);
            int songId = Integer.parseInt(s);

            playlistSongDAO.addSong(playlistId, songId);
            resp.setStatus(200);
            return;
        }

    }
}
