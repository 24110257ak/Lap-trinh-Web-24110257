package com.koha.dao;

import com.koha.model.UserModel;

public interface UserDao {
    UserModel findByUsername(String username);
}
