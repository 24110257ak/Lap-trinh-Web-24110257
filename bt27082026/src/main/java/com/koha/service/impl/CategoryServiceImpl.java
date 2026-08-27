package com.koha.service.impl;

import java.io.File;
import java.util.List;

import com.koha.dao.ICategoryDao;
import com.koha.dao.impl.CategoryDao;
import com.koha.entity.Category;
import com.koha.service.ICategoryService;
import com.koha.util.Constant;

public class CategoryServiceImpl implements ICategoryService {

    public ICategoryDao cateDao = new CategoryDao();

    @Override
    public List<Category> findAll() {
        return cateDao.findAll();
    }

    @Override
    public Category findById(int id) {
        return cateDao.findById(id);
    }

    @Override
    public List<Category> searchByName(String keyword) {
        return cateDao.searchByName(keyword);
    }

    @Override
    public void insert(Category category) {
        Category cate = this.findByCategoryname(category.getCategoryname());
        if (cate == null) {
            cateDao.insert(category);
        }
    }

    @Override
    public void update(Category category) {
        Category cate = this.findById(category.getCategoryId());
        if (cate != null) {
            // Xóa file ảnh cũ nếu có ảnh mới upload
            if (category.getImages() != null && !category.getImages().equals(cate.getImages())) {
                String oldImage = cate.getImages();
                if (oldImage != null && !oldImage.startsWith("http")) {
                    File oldFile = new File(Constant.DIR + "/" + oldImage);
                    if (oldFile.exists() && oldFile.isFile()) {
                        oldFile.delete();
                    }
                }
            }
            cateDao.update(category);
        }
    }

    @Override
    public void delete(int id) {
        try {
            Category cate = this.findById(id);
            if (cate != null) {
                String oldImage = cate.getImages();
                if (oldImage != null && !oldImage.startsWith("http")) {
                    File oldFile = new File(Constant.DIR + "/" + oldImage);
                    if (oldFile.exists() && oldFile.isFile()) {
                        oldFile.delete();
                    }
                }
            }
            cateDao.delete(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int count() {
        return cateDao.count();
    }

    @Override
    public List<Category> findAll(int page, int pagesize) {
        return cateDao.findAll(page, pagesize);
    }

    @Override
    public Category findByCategoryname(String name) {
        try {
            return cateDao.findByCategoryname(name);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
