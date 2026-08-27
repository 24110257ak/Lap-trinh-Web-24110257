package com.koha.service;

import com.koha.model.UserModel;

public interface UserService {
    UserModel login(String username, String password);
}
