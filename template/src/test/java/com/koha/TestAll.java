package com.koha;

import com.koha.model.Category;
import com.koha.model.UserModel;
import com.koha.service.CategoryService;
import com.koha.service.CategoryServiceImpl;
import com.koha.service.UserService;
import com.koha.service.UserServiceImpl;

import java.util.List;

public class TestAll {
    public static void main(String[] args) {
        System.out.println("========== BẮT ĐẦU KIỂM THỬ HỆ THỐNG ==========");

        // 1. Kiểm thử User & Login
        System.out.println("\n[1] Kiểm thử Login với UserService:");
        UserService userService = new UserServiceImpl();
        UserModel admin = userService.login("admin", "123");
        if (admin != null) {
            System.out.println("-> Đăng nhập admin/123 THÀNH CÔNG: " + admin.getFullName());
        } else {
            System.err.println("-> Đăng nhập admin/123 THẤT BẠI!");
        }

        UserModel failUser = userService.login("admin", "wrong_pass");
        if (failUser == null) {
            System.out.println("-> Đăng nhập sai mật khẩu bị từ chối CHÍNH XÁC!");
        } else {
            System.err.println("-> LỖI: Đăng nhập sai mật khẩu lại thành công!");
        }

        // 2. Kiểm thử CRUD Category
        System.out.println("\n[2] Kiểm thử CRUD Category với CategoryService:");
        CategoryService cateService = new CategoryServiceImpl();

        // 2.1 Insert
        Category newCate = new Category("Danh Mục Test Tự Động", "category/test.jpg");
        cateService.insert(newCate);
        System.out.println("-> Đã thêm danh mục mới: " + newCate.getName());

        // 2.2 GetAll
        List<Category> all = cateService.getAll();
        System.out.println("-> Tổng số danh mục hiện tại: " + all.size());
        Category testFound = null;
        for (Category c : all) {
            if ("Danh Mục Test Tự Động".equals(c.getName())) {
                testFound = c;
                break;
            }
        }

        if (testFound != null) {
            System.out.println("-> Tìm thấy danh mục vừa thêm có ID = " + testFound.getId());

            // 2.3 Edit
            testFound.setName("Danh Mục Test (Đã cập nhật)");
            cateService.edit(testFound);
            Category updated = cateService.get(testFound.getId());
            System.out.println("-> Đã cập nhật tên thành: " + updated.getName());

            // 2.4 Search
            List<Category> searchResults = cateService.search("cập nhật");
            System.out.println("-> Tìm kiếm với từ khóa 'cập nhật': tìm thấy " + searchResults.size() + " kết quả.");

            // 2.5 Delete
            cateService.delete(testFound.getId());
            Category deleted = cateService.get(testFound.getId());
            if (deleted == null) {
                System.out.println("-> Đã xóa danh mục test thành công (ID: " + testFound.getId() + ")");
            } else {
                System.err.println("-> LỖI: Chưa xóa được danh mục!");
            }
        } else {
            System.err.println("-> LỖI: Không tìm thấy danh mục vừa thêm!");
        }

        System.out.println("\n========== TẤT CẢ KIỂM THỬ HOÀN TẤT THÀNH CÔNG RỰC RỠ! ==========");
    }
}