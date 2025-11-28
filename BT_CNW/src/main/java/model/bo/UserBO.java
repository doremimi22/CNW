package model.bo;

import model.bean.User;
import model.dao.UserDAO;

public class UserBO {

    private UserDAO dao = new UserDAO();

    public User login(String username, String password) {
        return dao.login(username, password);
    }
}
