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

        // ===== TITLE =====
        String title = req.getParameter("title");

        // ===== YEAR (fix error) =====
        String yearStr = req.getParameter("year");
        int year = 0;
        if (yearStr != null && !yearStr.trim().isEmpty()) {
            try { year = Integer.parseInt(yearStr.trim()); }
            catch (Exception ignore) {}
        }

        String link = req.getParameter("link");
        String description = req.getParameter("description");

        // ===== ARTIST (fix error) =====
        String artistStr = req.getParameter("artist_id");
        int artistId = 0;
        if (artistStr != null && !artistStr.trim().isEmpty()) {
            try { artistId = Integer.parseInt(artistStr.trim()); }
            catch (Exception ignore) {}
        }

        if (artistId == 0) {
            req.setAttribute("error", "Bạn chưa chọn nghệ sĩ!");
            doGet(req, resp);
            return;
        }

        // ===== UPLOAD FILE =====
        Part filePart = req.getPart("thumbnail");
        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

        String uploadPath = req.getServletContext().getRealPath("/") + "uploads/songs";
        File dir = new File(uploadPath);
        if (!dir.exists()) dir.mkdirs();

        filePart.write(uploadPath + File.separator + fileName);
        String thumbnailPath = "uploads/songs/" + fileName;

        // ===== CREATE SONG =====
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

        // ===== INSERT song_artists =====
        songDAO.insertSongArtist(newSongID, artistId);

        // DONE
        resp.sendRedirect(req.getContextPath() + "/home");
    }
}
