package com.saeromteo.app.service.product;

import com.saeromteo.app.dto.product.ProductDTO.ProductResponse;
import com.saeromteo.app.dto.product.ProductDTO.ProductRequest;
import com.saeromteo.app.dao.product.ProductDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {

    @Autowired
    ProductDAO productDAO;

    public List<ProductResponse> readAll() {
        return productDAO.readAll();
    }

    public ProductResponse readByProductCode(int productCode) {
        return productDAO.readByProductCode(productCode);
    }

    public List<ProductResponse> readByCategory(int categoryNumber) {
        return productDAO.readByCategory(categoryNumber);
    }

    public int insertProduct(ProductRequest product) {
       return productDAO.insertProduct(product);
    }

    public int updateProduct(ProductRequest product) {
       return productDAO.updateProduct(product);
    }

    public int deleteProduct(int productCode) {
       return productDAO.deleteProduct(productCode);
    }
    
}
