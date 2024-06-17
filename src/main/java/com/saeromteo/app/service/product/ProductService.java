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
    
    public List<ProductResponse> readByParentCategory(int parentCategoryNumber) {
        return productDAO.readByParentCategory(parentCategoryNumber);
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
    
    /* page : 현재 보고자 하는 페이지 번호
       size : 한 페이지에 보여줄 데이터의 개수
       offset : 데이터베이스 쿼리에서 몇 번째 데이터부터 가져올지를 결정하는 값 */
    public List<ProductResponse> readAllPaged(int page, int size) {
        int offset = (page - 1) * size; 
        return productDAO.readAllPaged(offset, size);
    }
    
}
