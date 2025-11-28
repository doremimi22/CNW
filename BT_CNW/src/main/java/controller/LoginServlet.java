package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.bean.User;
import model.dao.UserDAO;
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User u = userDAO.checkLogin(username, password);

        if (u == null) {
            // Ghi lỗi vào session
            req.getSession().setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
            // Quay về login bằng redirect để không giữ dữ liệu cũ
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Đăng nhập đúng
        req.getSession().setAttribute("user", u);
        resp.sendRedirect(req.getContextPath() + "/home");
    }
}
