package com.koha.dao;

import com.koha.model.Category;
import java.util.List;

public interface CategoryDao {
    void insert(Category category);
    void edit(Category category);
    void delete(int id);
    Category get(int id);
    Category get(String name);
    List<Category> getAll();
    List<Category> search(String keyword);
}
