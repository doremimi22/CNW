package controller;

import model.bean.Song;
import model.dao.ArtistDAO;
import model.dao.SongDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/song/create")
@MultipartConfig
public class SongCreateController extends HttpServlet {

    private SongDAO songDAO = new SongDAO();
    private ArtistDAO artistDAO = new ArtistDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("artists", artistDAO.getAll());
        req.getRequestDispatcher("/views/song_create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String title = req.getParameter("title");
        int year = Integer.parseInt(req.getParameter("year"));
        String link = req.getParameter("link");
        String description = req.getParameter("description");
        int artistId = Integer.parseInt(req.getParameter("artist_id"));

        // ==== UPLOAD FILE ====
        Part filePart = req.getPart("thumbnail");
        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

        String uploadPath = req.getServletContext().getRealPath("/") + "uploads";
        File dir = new File(uploadPath);
        if (!dir.exists()) dir.mkdirs();

        filePart.write(uploadPath + File.separator + fileName);

        String thumbnailPath = "uploads/" + fileName;

        // ==== CREATE SONG ====
        Song s = new Song();
        s.setTitle(title);
        s.setYear(year);
        s.setThumbnail(thumbnailPath);
        s.setDescription(description);
        s.setLink(link);

        int newSongID = songDAO.insertAndReturnId(s);

        if (newSongID <= 0) {
            req.setAttribute("error", "Không thể tạo bài hát!");
            doGet(req, resp);
            return;
        }

        // LƯU SONG_ARTISTS
        songDAO.insertSongArtist(newSongID, artistId);

        resp.sendRedirect(req.getContextPath() + "/home");
    }
}
