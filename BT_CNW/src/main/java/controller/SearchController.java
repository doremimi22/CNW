package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.dao.AlbumDAO;
import model.dao.ArtistDAO;
import model.dao.SongDAO;

@WebServlet("/search")
public class SearchController extends HttpServlet {

    SongDAO songDAO = new SongDAO();
    ArtistDAO artistDAO = new ArtistDAO();
    AlbumDAO albumDAO = new AlbumDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String q = req.getParameter("q");

        if (q != null && !q.trim().isEmpty()) {
            req.setAttribute("songs", songDAO.searchSongs(q));
            req.setAttribute("artists", artistDAO.searchArtists(q));
            req.setAttribute("albums", albumDAO.searchAlbums(q));
        }

        req.getRequestDispatcher("/views/search.jsp").forward(req, resp);
    }
}
