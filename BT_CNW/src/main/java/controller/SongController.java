package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.bo.SongBO;
import model.dao.ArtistDAO;
import model.dao.SongDAO;
import model.bean.Song;
import model.bean.User;
import model.bean.Artist;

@WebServlet("/song")
public class SongController extends HttpServlet {

    private SongBO songBO = new SongBO();
    private SongDAO songDAO = new SongDAO(); // để gọi getById và artists

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	System.out.println(">>> SONG CONTROLLER RUN <<<");

        String action = req.getParameter("action");

        if (action == null) {
            list(req, resp);
            return;
        }

        switch (action) {
        case "detail":
            int id = Integer.parseInt(req.getParameter("id"));
            SongDAO sdao = new SongDAO();
            ArtistDAO adao = new ArtistDAO();

            Song s = sdao.getSongById(id); // bạn sẽ thêm hàm này bên dưới
            s.setArtists(adao.getArtistsBySong(id));

            req.setAttribute("song", s);
            req.getRequestDispatcher("/views/song_detail.jsp").forward(req, resp);
            return;
        case "delete":
            deleteSong(req, resp);
            return;

            default:
                list(req, resp);
        }
    }

    private void list(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        ArrayList<Song> list = songBO.getAllSongs();
        req.setAttribute("songs", list);

        req.getRequestDispatcher("/views/song_list.jsp").forward(req, resp);
    }

    private void detail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        Song s = songDAO.getById(id);
        ArrayList<Artist> artists = songDAO.getArtistsBySong(id);

        req.setAttribute("song", s);
        req.setAttribute("artists", artists);

        req.getRequestDispatcher("/views/song_detail.jsp").forward(req, resp);
    }

private void deleteSong(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

    HttpSession session = req.getSession();

    User user = (User) session.getAttribute("user");

    if (user == null) {
        resp.sendRedirect(req.getContextPath() + "/login");
        return;
    }

    if (!"admin".equals(user.getRole())) {
        resp.sendError(403, "Không có quyền xóa bài hát");
        return;
    }

    int id = Integer.parseInt(req.getParameter("id"));
    boolean ok = songDAO.delete(id);

    if (ok) {
        resp.sendRedirect(req.getContextPath() + "/home");
    } else {
        resp.sendError(500, "Không thể xóa bài hát");
    }
}

}
