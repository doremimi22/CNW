package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.bean.Album;
import model.bean.Artist;
import model.bean.Song;
import model.bean.User;
import model.dao.AlbumDAO;
import model.dao.ArtistDAO;
import model.dao.SongDAO;

@WebServlet("/album")
public class AlbumController extends HttpServlet {

    private AlbumDAO albumDAO = new AlbumDAO();
    private SongDAO songDAO = new SongDAO();
    private ArtistDAO artistDAO = new ArtistDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if (action == null) {
            list(req, resp);
            return;
        }

        switch (action) {
            case "detail":
                showDetail(req, resp);
                return;
            case "delete":
                deleteAlbum(req, resp);
                return;

            default:
                list(req, resp);
        }
    }

    /* ================= SHOW LIST ================= */
    private void list(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        ArrayList<Album> list = albumDAO.getAll();
        req.setAttribute("albums", list);

        req.getRequestDispatcher("/views/album_list.jsp").forward(req, resp);
    }
    private void deleteAlbum(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        model.bean.User user = (model.bean.User) session.getAttribute("user");

        if (user == null || !"admin".equals(user.getRole())) {
            resp.sendError(403, "Không có quyền xóa album");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));

        AlbumDAO adao = new AlbumDAO();
        boolean ok = adao.delete(id);

        if (ok) {
            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            resp.sendError(500, "Không thể xóa album");
        }
    }


    /* ================= DETAIL ALBUM ================= */
    private void showDetail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int albumId = Integer.parseInt(req.getParameter("id"));

        // Lấy album
        Album album = albumDAO.getAlbumById(albumId);

        // Lấy bài hát trong album
        ArrayList<Song> songs = songDAO.getSongsByAlbum(albumId);

        // Gắn nghệ sĩ cho từng bài hát
        for (Song s : songs) {
            s.setArtists(artistDAO.getArtistsBySong(s.getSongId()));
        }

        // ======================
        // Lấy danh sách nghệ sĩ thuộc album (tránh trùng)
        // ======================
        ArrayList<Artist> artists = new ArrayList<>();

        for (Song s : songs) {
            for (Artist ar : s.getArtists()) {
                boolean exists = false;
                for (Artist ax : artists) {
                    if (ax.getArtistId() == ar.getArtistId()) {
                        exists = true;
                        break;
                    }
                }
                if (!exists) artists.add(ar);
            }
        }

        req.setAttribute("album", album);
        req.setAttribute("songs", songs);
        req.setAttribute("artists", artists);

        req.getRequestDispatcher("/views/album_detail.jsp").forward(req, resp);
    }
}
