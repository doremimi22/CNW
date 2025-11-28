package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.bo.AlbumBO;
import model.dao.AlbumDAO;
import model.dao.SongDAO;
import model.bean.Album;
import model.bean.Song;

@WebServlet("/album")
public class AlbumController extends HttpServlet {

    private AlbumBO albumBO = new AlbumBO();

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
            int id = Integer.parseInt(req.getParameter("id"));

            AlbumDAO adao = new AlbumDAO();
            SongDAO sdao = new SongDAO();

            Album al = adao.getAlbumById(id);
            ArrayList<Song> songs = sdao.getSongsByAlbum(id);

            req.setAttribute("album", al);
            req.setAttribute("songs", songs);

            req.getRequestDispatcher("/views/album_detail.jsp").forward(req, resp);
            return;

            default:
                list(req, resp);
        }
    }

    private void list(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        ArrayList<Album> list = albumBO.getAllAlbums();
        req.setAttribute("albums", list);

        req.getRequestDispatcher("/views/album_list.jsp").forward(req, resp);
    }

    private void detail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        Album album = albumBO.getAlbumById(id);
        ArrayList<Song> songs = albumBO.getSongsOfAlbum(id);

        req.setAttribute("album", album);
        req.setAttribute("songs", songs);

        req.getRequestDispatcher("/views/album_detail.jsp").forward(req, resp);
    }
}
