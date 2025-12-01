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

        System.out.println(">>> LOGIN REQUEST");
        System.out.println("Username nhập vào: " + username);
        System.out.println("Password nhập vào: " + password);

        User u = userDAO.checkLogin(username, password);

        if (u == null) {
            System.out.println(">>> LOGIN FAILED: Không tìm thấy user hoặc sai mật khẩu!");

            req.getSession().setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // LOGIN THÀNH CÔNG
        System.out.println(">>> LOGIN SUCCESS");
        System.out.println("User: " + u.getUsername());
        System.out.println("Role: " + u.getRole());

        HttpSession session = req.getSession();
        session.setAttribute("user", u);
        
        session.setAttribute("fullname", u.getFullname());
        session.setAttribute("user_id",u.getUserId());
        // Kiểm tra lại session set thành công chưa
        User sessionUser = (User) session.getAttribute("user");
        System.out.println("Session user đã set: " +
            (sessionUser != null ? sessionUser.getUsername() : "NULL"));
        System.out.println("Session user đã set: " + session.getAttribute("fullname"));
        resp.sendRedirect(req.getContextPath() + "/home");
    }

}
