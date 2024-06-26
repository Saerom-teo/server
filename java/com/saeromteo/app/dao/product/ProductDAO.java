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

    public ProductEntity readByProductCode(int productCode) {
        return sqlSession.selectOne(NAMESPACE + "readByProductCode", productCode);
    }

    public List<ProductEntity> readByCategory(int categoryNumber) {
        return sqlSession.selectList(NAMESPACE + "readByCategory", categoryNumber);
    }
    
    public List<ProductEntity> readByParentCategory(int parentCategoryNumber) {
        return sqlSession.selectList(NAMESPACE + "readByParentCategory", parentCategoryNumber);
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
    
    public List<ProductEntity> readAllPaged(int offset, int size) {
        Map<String, Integer> params = new HashMap<>();
        params.put("offset", offset); 
        params.put("size", size);
        return sqlSession.selectList(NAMESPACE + "readAllPaged", params);
    }
    

    public List<ProductEntity> readAllSorted(String sortBy) {
        Map<String, Object> params = new HashMap<>();
        params.put("sortBy", sortBy);
        return sqlSession.selectList(NAMESPACE + "readAllSorted", params);
    }
    


}
