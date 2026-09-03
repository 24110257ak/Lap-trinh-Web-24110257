package com.koha.service.impl;

import java.util.List;
import java.util.Random;

import com.koha.dao.IUserDao;
import com.koha.dao.impl.UserDao;
import com.koha.entity.User;
import com.koha.service.IUserService;
import com.koha.util.EmailUtil;

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
        if (userDao.checkExistUsername(username) || (email != null && userDao.checkExistEmail(email))) {
            return false;
        }
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setFullName(fullname);
        user.setEmail(email);
        user.setPhone(phone);
        user.setRoleid(2);
        user.setStatus(1); // Mặc định kích hoạt nếu không dùng OTP
        userDao.insert(user);
        return true;
    }

    @Override
    public boolean registerWithOtp(String username, String password, String fullname, String email, String phone) {
        if (userDao.checkExistUsername(username) || (email != null && userDao.checkExistEmail(email))) {
            return false;
        }

        // 1. Sinh mã OTP ngẫu nhiên 6 chữ số
        String otp = String.format("%06d", new Random().nextInt(999999));

        // 2. Tạo đối tượng User với trạng thái chưa kích hoạt (status = 0) và lưu mã OTP vào cột code
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setFullName(fullname);
        user.setEmail(email);
        user.setPhone(phone);
        user.setRoleid(2);
        user.setStatus(0); // 0: Chưa kích hoạt
        user.setCode(otp); // Lưu mã OTP

        userDao.insert(user);

        // 3. Gửi email chứa mã OTP kích hoạt tài khoản
        if (email != null && !email.trim().isEmpty()) {
            EmailUtil.sendOtpEmail(email.trim(), otp, "kích hoạt tài khoản");
        }

        return true;
    }

    @Override
    public boolean verifyOtp(String username, String otp) {
        if (username == null || otp == null) {
            return false;
        }
        User user = userDao.findByUsername(username.trim());
        if (user != null && user.getCode() != null && user.getCode().trim().equals(otp.trim())) {
            user.setStatus(1); // Kích hoạt tài khoản thành công
            user.setCode(null); // Xóa OTP đã sử dụng
            userDao.update(user);
            return true;
        }
        return false;
    }

    @Override
    public boolean resendOtp(String username) {
        if (username == null) {
            return false;
        }
        User user = userDao.findByUsername(username.trim());
        if (user != null && user.getEmail() != null) {
            String newOtp = String.format("%06d", new Random().nextInt(999999));
            user.setCode(newOtp);
            userDao.update(user);
            EmailUtil.sendOtpEmail(user.getEmail(), newOtp, "kích hoạt tài khoản (gửi lại)");
            return true;
        }
        return false;
    }

    @Override
    public boolean sendForgotPasswordOtp(String account) {
        if (account == null || account.trim().isEmpty()) {
            return false;
        }
        account = account.trim();
        User user = userDao.findByUsername(account);
        if (user == null) {
            user = userDao.findByEmail(account);
        }

        if (user != null && user.getEmail() != null && !user.getEmail().trim().isEmpty()) {
            String otp = String.format("%06d", new Random().nextInt(999999));
            user.setCode(otp);
            userDao.update(user);
            EmailUtil.sendOtpEmail(user.getEmail(), otp, "đặt lại mật khẩu");
            return true;
        }
        return false;
    }

    @Override
    public boolean resetPassword(String account, String otp, String newPassword) {
        if (account == null || otp == null || newPassword == null) {
            return false;
        }
        account = account.trim();
        User user = userDao.findByUsername(account);
        if (user == null) {
            user = userDao.findByEmail(account);
        }

        if (user != null && user.getCode() != null && user.getCode().trim().equals(otp.trim())) {
            user.setPassword(newPassword);
            user.setCode(null); // Xóa mã OTP
            userDao.update(user);
            return true;
        }
        return false;
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
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
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
    public boolean updateProfile(int id, String fullname, String phone, String images) {
        User user = userDao.findById(id);
        if (user != null) {
            if (fullname != null && !fullname.trim().isEmpty()) {
                user.setFullName(fullname.trim());
            }
            if (phone != null) {
                user.setPhone(phone.trim());
            }
            if (images != null && !images.trim().isEmpty()) {
                user.setImages(images.trim());
            }
            userDao.update(user);
            return true;
        }
        return false;
    }

    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }
}
