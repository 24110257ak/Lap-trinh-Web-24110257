package com.koha.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import com.koha.entity.Category;
import com.koha.entity.User;

public class Test {

    public static void main(String[] args) {
        System.out.println("=== BẮT ĐẦU KIỂM THỬ KẾT NỐI VÀ THAO TÁC JPA 3.0 (Database: bt27082026, Package: com.koha) ===");
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();

        try {
            trans.begin();

            // 1. Kiểm thử tạo Category
            Category cate = new Category();
            cate.setCategoryname("Điện Thoại Di Động Koha");
            cate.setImages("iphone15.jpg");
            cate.setStatus(1);
            enma.persist(cate);

            // 2. Kiểm thử tạo User mẫu cho chức năng Login Session & Cookie
            User user = new User();
            user.setUsername("koha_" + System.currentTimeMillis() % 1000);
            user.setPassword("123");
            user.setFullName("Lập Trình Viên Koha");
            user.setEmail("koha@student.hcmute.edu.vn");
            user.setPhone("0901234567");
            user.setRoleid(1);
            enma.persist(user);

            trans.commit();
            System.out.println("=== THÀNH CÔNG: Đã lưu Category và User vào CSDL bt27082026 qua JPA! ===");
        } catch (Exception e) {
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
        } finally {
            enma.close();
            JpaConfig.shutdown();
        }
    }
}
