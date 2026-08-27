package com.koha.service.impl;

import java.util.List;

import com.koha.dao.IUserDao;
import com.koha.dao.impl.UserDao;
import com.koha.entity.User;
import com.koha.service.IUserService;

public class UserServiceImpl implements IUserService {

    private IUserDao userDao = new UserDao();

    @Override
    public User login(String username, String password) {
        User user = userDao.findByUsername(username);
        if (user != null && user.getPassword() != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    @Override
    public boolean register(String username, String password, String fullname, String email, String phone) {
        if (userDao.checkExistUsername(username)) {
            return false;
        }
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setFullName(fullname);
        user.setEmail(email);
        user.setPhone(phone);
        user.setRoleid(2);
        userDao.insert(user);
        return true;
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }

    @Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public User findById(int id) {
        return userDao.findById(id);
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }
}
