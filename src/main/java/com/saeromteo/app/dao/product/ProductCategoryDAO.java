package com.saeromteo.app.dao.product;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import com.saeromteo.app.dto.product.ProductCategoryDTO.ProductCategoryRequest;
import com.saeromteo.app.dto.product.ProductCategoryDTO.ProductCategoryResponse;

@Repository
public class ProductCategoryDAO {
    
    private final SqlSessionTemplate sqlSession;
    private String NAMESPACE = "com.saeromteo.app.productcategory.";

    @Autowired
    public ProductCategoryDAO(@Qualifier("productCategorySqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }

    public List<ProductCategoryResponse> readAll() {
        return sqlSession.selectList(NAMESPACE + "readAll");
    }

    public ProductCategoryResponse readByCategoryNumber(int categoryNumber) {
        return sqlSession.selectOne(NAMESPACE + "readByCategoryNumber", categoryNumber);
    }

    public int insertCategory(ProductCategoryRequest category) {
        return sqlSession.insert(NAMESPACE + "insertCategory", category);
    }

    public int updateCategory(ProductCategoryRequest category) {
        return sqlSession.update(NAMESPACE + "updateCategory", category);
    }

    public int deleteCategory(int categoryNumber) {
        return sqlSession.delete(NAMESPACE + "deleteCategory", categoryNumber);
    }
}
