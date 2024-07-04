package com.saeromteo.app.service.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.saeromteo.app.dao.product.ProductDAO;
import com.saeromteo.app.model.product.ProductEntity;

@Service
public class ProductService {

    @Autowired
    ProductDAO productDAO;

    public List<ProductEntity> readAll() {
        return productDAO.readAll();
    }

    public ProductEntity readByProductCode(String productCode) {
        return productDAO.readByProductCode(productCode);
    }

    public List<ProductEntity> readByCategory(int categoryNumber) {
        return productDAO.readByCategory(categoryNumber);
    }
    
    public List<ProductEntity> readByParentCategory(int parentCategoryNumber) {
        return productDAO.readByParentCategory(parentCategoryNumber);
    }
    
    public List<ProductEntity> readByKeyword(String keyword) {
    	return productDAO.readByKeyword(keyword);
    }

    public int insertProduct(ProductEntity product) {
       return productDAO.insertProduct(product);
    }

    public int updateProduct(ProductEntity product) {
       return productDAO.updateProduct(product);
    }

    public int deleteProduct(int productCode) {
       return productDAO.deleteProduct(productCode);
    }
    
    public List<ProductEntity> readAllSorted(String sortBy) {
        return productDAO.readAllSorted(sortBy);
    }
    
    // 인기순 정렬 메소드
    public List<ProductEntity> readAllSortedByPopularity() { 
        return productDAO.readAllSortedByPopularity();
    }
    
    // 소분류, 중분류, 대분류로 조회
    public List<ProductEntity> selectBySmallCategory(String majorCategory, 
    		String middleCategory, String smallCategory, String categoryType) {
        return productDAO.selectBySmallCategory(majorCategory, middleCategory, smallCategory, categoryType);
    }

 
    
}
