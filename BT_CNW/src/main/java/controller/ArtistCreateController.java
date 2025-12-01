package controller;

import model.dao.ArtistDAO;
import model.bean.Artist;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import config.DBConnect;

@WebServlet("/artist/create")
@MultipartConfig
public class ArtistCreateController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/artist_create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String name = req.getParameter("name");
        String biography = req.getParameter("biography");
        String birthday = req.getParameter("birthday");

        // Upload avatar
        Part avatarPart = req.getPart("avatar");
        String fileName = Paths.get(avatarPart.getSubmittedFileName()).getFileName().toString();

        // nơi lưu ảnh: webapp/uploads/
        String uploadDir = req.getServletContext().getRealPath("/uploads");
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        String savePath = uploadDir + File.separator + fileName;
        avatarPart.write(savePath);

        String avatarRelativePath = "uploads/" + fileName;

        // Lưu DB
        ArtistDAO dao = new ArtistDAO();

        Artist ar = new Artist();
        ar.setName(name);
        ar.setBiography(biography);
        ar.setBirthday(birthday);
        ar.setAvatar(avatarRelativePath);

        dao.insertArtist(ar);

        resp.sendRedirect(req.getContextPath() + "/artist/create?success=1");
    }
}
