package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.bean.Album;
import model.bean.Artist;
import model.bean.Song;
import model.dao.AlbumDAO;
import model.dao.ArtistDAO;
import model.dao.SongDAO;
@WebServlet("/artist")
public class ArtistController extends HttpServlet {

    private ArtistDAO artistDAO = new ArtistDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	  System.out.println(">>> ARTIST CONTROLLER RUNNING <<<");
        String action = req.getParameter("action");

        if (action == null) {
            list(req, resp);
            return;
        }

        switch (action) {
            case "search":
                search(req, resp);
                break;

            case "detail":
                detail(req, resp);
                break;
            case "delete":
                deleteArtist(req, resp);
                return;

            default:
                list(req, resp);
        }
    }

    private void list(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("artists", artistDAO.getAll());
        req.getRequestDispatcher("/views/artist_list.jsp").forward(req, resp);
    }

    private void search(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("keyword");
        req.setAttribute("artists", artistDAO.searchArtists(keyword));
        req.setAttribute("keyword", keyword);
        req.getRequestDispatcher("views/artist_list.jsp").forward(req, resp);
    }

    private void detail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        req.setAttribute("artist", artistDAO.getById(id));
        req.setAttribute("songs", artistDAO.getSongsByArtist(id));
        req.setAttribute("albums", artistDAO.getAlbumsByArtist(id));

        req.getRequestDispatcher("views/artist_detail.jsp").forward(req, resp);
    }
    private void deleteArtist(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession();
        Object userObj = session.getAttribute("user");

        // Kiểm tra đăng nhập
        if (userObj == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Kiểm tra quyền admin
        String role = String.valueOf(session.getAttribute("role"));
        if (role == null || !role.equalsIgnoreCase("admin")) {
            resp.sendError(403, "Bạn không có quyền xóa nghệ sĩ");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));

        ArtistDAO dao = new ArtistDAO();
        boolean ok = dao.delete(id);

        if (ok) {
            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            resp.sendError(500, "Không thể xóa nghệ sĩ");
        }
    }

}
