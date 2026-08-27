package com.koha.service;

import com.koha.dao.UserDao;
import com.koha.dao.UserDaoImpl;
import com.koha.model.UserModel;

public class UserServiceImpl implements UserService {
    private UserDao userDao = new UserDaoImpl();

    @Override
    public UserModel login(String username, String password) {
        UserModel user = userDao.findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
}
