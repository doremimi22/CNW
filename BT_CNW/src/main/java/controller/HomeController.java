package controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.dao.SongDAO;
import model.dao.AlbumDAO;
import model.dao.ArtistDAO;
import model.bean.Song;
import model.bean.Album;
import model.bean.Artist;

@WebServlet("/home")
public class HomeController extends HttpServlet {

    private SongDAO songDAO = new SongDAO();
    private AlbumDAO albumDAO = new AlbumDAO();
    private ArtistDAO artistDAO = new ArtistDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 🔒 Kiểm tra đăng nhập
        HttpSession session = req.getSession();
        if (session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Lấy dữ liệu từ DB
        ArrayList<Song> songs = songDAO.getAll();
        ArrayList<Album> albums = albumDAO.getAll();
        ArrayList<Artist> artists = artistDAO.getAll();

        req.setAttribute("songs", songs);
        req.setAttribute("albums", albums);
        req.setAttribute("artists", artists);

        req.getRequestDispatcher("/views/home.jsp").forward(req, resp);
    }

}
