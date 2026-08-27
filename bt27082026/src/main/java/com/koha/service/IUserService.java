package com.koha.service;

import java.util.List;
import com.koha.entity.User;

public interface IUserService {

    User login(String username, String password);

    boolean register(String username, String password, String fullname, String email, String phone);

    boolean checkExistUsername(String username);

    boolean checkExistEmail(String email);

    User findByUsername(String username);

    User findById(int id);

    void insert(User user);

    void update(User user);

    List<User> findAll();
}
