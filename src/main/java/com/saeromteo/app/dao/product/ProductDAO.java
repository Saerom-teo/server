package com.saeromteo.app.dao.product;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.saeromteo.app.dto.product.ProductDTO.ProductRequest;
import com.saeromteo.app.dto.product.ProductDTO.ProductResponse;

@Repository
public class ProductDAO {
	
    @Autowired
    SqlSession sqlSession;

    String NAMESPACE = "com.saeromteo.app.product.";

    public List<ProductResponse> readAll() {
        return sqlSession.selectList(NAMESPACE + "readAll");
    }

    public ProductResponse readByProductCode(int productCode) {
        return sqlSession.selectOne(NAMESPACE + "readByProductCode", productCode);
    }

    public List<ProductResponse> readByCategory(int categoryNumber) {
        return sqlSession.selectList(NAMESPACE + "readByCategory", categoryNumber);
    }
    
    public int insertProduct(ProductRequest product) {
        return sqlSession.insert(NAMESPACE + "insertProduct", product);
    }

    public int updateProduct(ProductRequest product) {
        return sqlSession.update(NAMESPACE + "updateProduct", product);
    }

    public int deleteProduct(int productCode) {
        return sqlSession.delete(NAMESPACE + "deleteProduct", productCode);
    }


}
