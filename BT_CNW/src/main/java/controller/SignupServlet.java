package controller;

import model.bean.User;
import model.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/views/signup.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirm = req.getParameter("confirm");

        // Kiểm tra mật khẩu khớp
        if (!password.equals(confirm)) {
            req.getSession().setAttribute("error", "Mật khẩu xác nhận không khớp!");
            resp.sendRedirect(req.getContextPath() + "/views/signup.jsp");
            return;
        }

        // Kiểm tra username đã tồn tại
        if (userDAO.checkUserExists(username)) {
            req.getSession().setAttribute("error", "Tên đăng nhập đã tồn tại!");
            resp.sendRedirect(req.getContextPath() + "/views/signup.jsp");
            return;
        }

        // Tạo user mới
        User u = new User();
        u.setUsername(username);
        u.setPassword(password);

        boolean ok = userDAO.insertUser(u);

        if (!ok) {
            req.getSession().setAttribute("error", "Lỗi hệ thống, vui lòng thử lại!");
            resp.sendRedirect(req.getContextPath() + "/views/signup.jsp");
            return;
        }

        // Thành công -> chuyển về login
        req.getSession().setAttribute("success", "Tạo tài khoản thành công! Hãy đăng nhập.");
        resp.sendRedirect(req.getContextPath() + "/login");
    }
}
