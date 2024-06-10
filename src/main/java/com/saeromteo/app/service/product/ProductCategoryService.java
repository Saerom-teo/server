package com.saeromteo.app.service.product;

import com.saeromteo.app.dto.product.ProductCategoryDTO.ProductCategoryResponse;
import com.saeromteo.app.dto.product.ProductCategoryDTO.ProductCategoryRequest;
import com.saeromteo.app.dao.product.ProductCategoryDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductCategoryService {

    @Autowired
    ProductCategoryDAO productCategoryDAO;

    public List<ProductCategoryResponse> readAll() {
        return productCategoryDAO.readAll();
    }

    public ProductCategoryResponse readByCategoryNumber(int categoryNumber) {
        return productCategoryDAO.readByCategoryNumber(categoryNumber);
    }

    public int insertCategory(ProductCategoryRequest category) {
       return productCategoryDAO.insertCategory(category);
    }

    public int updateCategory(ProductCategoryRequest category) {
       return productCategoryDAO.updateCategory(category);
    }

    public int deleteCategory(int categoryNumber) {
       return productCategoryDAO.deleteCategory(categoryNumber);
    }
}
