package services;

import dao.CategoryDao;
import models.Category;
import java.util.List;

public class CategoryService {
    private CategoryDao categoryDao;

    public CategoryService() {
        this.categoryDao = new CategoryDao();
    }

    public List<Category> getAllCategories() {
        return categoryDao.findAll();
    }

    public Category getCategoryById(int id) {
        return categoryDao.findById(id);
    }

    public Category getCategoryByName(String name) {
        return categoryDao.findByName(name);
    }
} 