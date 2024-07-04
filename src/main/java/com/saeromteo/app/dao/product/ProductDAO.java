package com.saeromteo.app.dao.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.model.product.ProductEntity;

@Repository
public class ProductDAO {
	
	private final SqlSessionTemplate sqlSession;
    private String NAMESPACE = "com.saeromteo.app.product.";

    @Autowired
    public ProductDAO(@Qualifier("productSqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }


    public List<ProductEntity> readAll() {
        return sqlSession.selectList(NAMESPACE + "readAll");
    }

    public ProductEntity readByProductCode(String productCode) {
        return sqlSession.selectOne(NAMESPACE + "readByProductCode", productCode);
    }

    public List<ProductEntity> readByCategory(int categoryNumber) {
        return sqlSession.selectList(NAMESPACE + "readByCategory", categoryNumber);
    }
    
    public List<ProductEntity> readByParentCategory(int parentCategoryNumber) {
        return sqlSession.selectList(NAMESPACE + "readByParentCategory", parentCategoryNumber);
    }
    
    public List<ProductEntity> readByKeyword(String keyword) {
    	return sqlSession.selectList(NAMESPACE + "readByKeyword", keyword);
    }
    
    public int insertProduct(ProductEntity product) {
        return sqlSession.insert(NAMESPACE + "insertProduct", product);
    }

    public int updateProduct(ProductEntity product) {
        return sqlSession.update(NAMESPACE + "updateProduct", product);
    }

    public int deleteProduct(int productCode) {
        return sqlSession.delete(NAMESPACE + "deleteProduct", productCode);
    }
    

    public List<ProductEntity> readAllSorted(String sortBy) {
        Map<String, Object> params = new HashMap<>();
        params.put("sortBy", sortBy);
        return sqlSession.selectList(NAMESPACE + "readAllSorted", params);
    }
    
    // 인기순 정렬 메소드 
    public List<ProductEntity> readAllSortedByPopularity() {
        return sqlSession.selectList(NAMESPACE + "readAllSortedByPopularity");
    }
    
    //소분류, 중분류, 대분류로 조회
    public List<ProductEntity> selectBySmallCategory(String majorCategory, String middleCategory,
    		String smallCategory, String categoryType) {
        Map<String, String> params = new HashMap<>();
        params.put("majorCategory", majorCategory);
        params.put("middleCategory", middleCategory);
        params.put("smallCategory", smallCategory);
        params.put("categoryType", categoryType);
        return sqlSession.selectList(NAMESPACE + "selectByCategory", params);
    }

 
    


}
