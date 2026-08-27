package com.koha.service;

import com.koha.dao.CategoryDao;
import com.koha.dao.CategoryDaoImpl;
import com.koha.model.Category;
import com.koha.util.Constant;

import java.io.File;
import java.util.List;

public class CategoryServiceImpl implements CategoryService {
    private CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    public void insert(Category category) {
        categoryDao.insert(category);
    }

    @Override
    public void edit(Category newCategory) {
        Category oldCategory = categoryDao.get(newCategory.getId());
        if (oldCategory != null) {
            oldCategory.setName(newCategory.getName());
            if (newCategory.getIcon() != null && !newCategory.getIcon().trim().isEmpty()) {
                // Xóa ảnh cũ nếu có
                String oldIcon = oldCategory.getIcon();
                if (oldIcon != null && !oldIcon.trim().isEmpty()) {
                    File oldFile = new File(Constant.DIR + "/" + oldIcon);
                    if (oldFile.exists() && oldFile.isFile()) {
                        oldFile.delete();
                    }
                }
                oldCategory.setIcon(newCategory.getIcon());
            }
            categoryDao.edit(oldCategory);
        }
    }

    @Override
    public void delete(int id) {
        Category oldCategory = categoryDao.get(id);
        if (oldCategory != null) {
            String icon = oldCategory.getIcon();
            if (icon != null && !icon.trim().isEmpty()) {
                File file = new File(Constant.DIR + "/" + icon);
                if (file.exists() && file.isFile()) {
                    file.delete();
                }
            }
            categoryDao.delete(id);
        }
    }

    @Override
    public Category get(int id) {
        return categoryDao.get(id);
    }

    @Override
    public Category get(String name) {
        return categoryDao.get(name);
    }

    @Override
    public List<Category> getAll() {
        return categoryDao.getAll();
    }

    @Override
    public List<Category> search(String keyword) {
        return categoryDao.search(keyword);
    }
}
