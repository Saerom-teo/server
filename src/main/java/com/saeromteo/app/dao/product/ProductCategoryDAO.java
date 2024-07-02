package com.saeromteo.app.dao.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.model.product.ProductCategoryEntity;

@Repository
public class ProductCategoryDAO {
    
    private final SqlSessionTemplate sqlSession;
    private String NAMESPACE = "com.saeromteo.app.productcategory.";

    @Autowired
    public ProductCategoryDAO(@Qualifier("productCategorySqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }

    public List<String> readAll_major() {
        return sqlSession.selectList(NAMESPACE + "readAll_major");
    }
    public List<Map<String, String>> readAll_middle() {
        return sqlSession.selectList(NAMESPACE + "readAll_middle");
    }
    public List<ProductCategoryEntity> readAll() {
        return sqlSession.selectList(NAMESPACE + "readAll");
    }
    

    public ProductCategoryEntity readByCategoryNumber(int categoryNumber) {
        return sqlSession.selectOne(NAMESPACE + "readByCategoryNumber", categoryNumber);
    }

    public int insertCategory(ProductCategoryEntity category) {
        return sqlSession.insert(NAMESPACE + "insertCategory", category);
    }

    public int updateCategory(ProductCategoryEntity category) {
        return sqlSession.update(NAMESPACE + "updateCategory", category);
    }

    public int deleteCategory(int categoryNumber) {
        return sqlSession.delete(NAMESPACE + "deleteCategory", categoryNumber);
    }
    
    // 카테고리 조회
    public List<ProductCategoryEntity> readByCategoryDetails(String majorCategory, String middleCategory, String smallCategory) {
        Map<String, String> params = new HashMap<>();
        params.put("majorCategory", majorCategory);
        params.put("middleCategory", middleCategory);
        params.put("smallCategory", smallCategory);
        return sqlSession.selectList(NAMESPACE + "readByCategoryDetails", params);
    }

    // 상품 코드로 카테고리 조회
	public List<ProductCategoryEntity> readCategoriesByProductCode(Integer productCode) {
		Map<Object, Object> params = new HashMap<>();
		params.put("productCode", productCode);
		return sqlSession.selectList(NAMESPACE + "readCategoriesByProductCode", params);
	}
}
