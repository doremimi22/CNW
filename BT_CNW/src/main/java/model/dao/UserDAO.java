package model.dao;

import java.sql.*;
import model.bean.User;
import config.DBConnect;

public class UserDAO {

    public User login(String username, String password) {
        String sql = "SELECT * FROM users WHERE username=? AND password=?";
        User u = null;

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setRole(rs.getString("role"));
            }

        } catch (Exception e) { e.printStackTrace(); }
        return u;
    }
    public User checkLogin(String username, String password) {
        User user = null;

        String sql = "SELECT * FROM users WHERE username=? AND password=?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role")); 
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    public boolean insertUser(User u) {
        String sql = "INSERT INTO users(username, password) VALUES(?, ?)";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPassword());  // Chưa mã hóa, bạn muốn mã hóa thì tôi làm thêm

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean checkUserExists(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            return rs.next(); // có tồn tại -> true

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}
