package controller;

import model.dao.AlbumDAO;
import model.dao.SongDAO;
import model.bean.Album;
import model.bean.Song;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/album/create")
@MultipartConfig
public class AlbumCreateController extends HttpServlet {

    private AlbumDAO albumDAO = new AlbumDAO();
    private SongDAO songDAO = new SongDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("songs", songDAO.getAll());

        req.getRequestDispatcher("/views/album_create.jsp")
                .forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        System.out.println("\n===== [AlbumCreateController] START =====");

        String title = req.getParameter("title");
        String desc = req.getParameter("description");
        String songIds = req.getParameter("song_ids");
        String yearStr = req.getParameter("year");
        int year = (yearStr == null || yearStr.isEmpty()) ? 0 : Integer.parseInt(yearStr);

        System.out.println("Title = " + title);
        System.out.println("Year = " + year);
        System.out.println("SongIDs raw = " + songIds);

        /* ===== UPLOAD COVER ===== */
        Part imgPart = req.getPart("cover");
        String fileName = System.currentTimeMillis() + "_" + imgPart.getSubmittedFileName();

        String realPath = req.getServletContext().getRealPath("/images");
        File folder = new File(realPath);
        if (!folder.exists()) folder.mkdirs();

        imgPart.write(realPath + "/" + fileName);

        String coverPath = "images/" + fileName;

        System.out.println("Cover saved to: " + coverPath);

        /* ===== INSERT ALBUM ===== */
        Album album = new Album();
        album.setTitle(title);
        album.setCover(coverPath);
        album.setDescription(desc);
        album.setReleaseYear(year);

        int albumId = albumDAO.insert(album);

        System.out.println("New Album ID = " + albumId);

        if (albumId <= 0) {
            req.setAttribute("error", "Không thể tạo album!");
            doGet(req, resp);
            return;
        }

        /* ===== INSERT ALBUM_SONGS ===== */
        if (songIds != null && !songIds.isEmpty()) {

            System.out.println("SongIDs Split:");

            for (String sid : songIds.split(",")) {
                sid = sid.trim();
                if (sid.length() == 0) continue;

                System.out.println(" → Adding SongID = " + sid + " to album " + albumId);

                albumDAO.addSongToAlbum(albumId, Integer.parseInt(sid));
            }

        } else {
            System.out.println("NO SONG SELECTED.");
        }

        System.out.println("===== [AlbumCreateController] END =====\n");

        resp.sendRedirect(req.getContextPath() + "/album?action=detail&id=" + albumId);
    }
}
