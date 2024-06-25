package com.saeromteo.app.dao.user;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.dto.user.UserDTO;

@Repository
public class UserDAO  {  
	private final SqlSessionTemplate sqlSession;
	
    private String NAMESPACE = "com.saeromteo.app.user.";
    
    @Autowired
    public UserDAO(@Qualifier("userSqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }
    
	public UserDTO loadUserByUsername(String userEmail) {
		UserDTO user = sqlSession.selectOne(NAMESPACE + "readUser" , userEmail);
		return user;
	}

	public int registrationUser(UserDTO user) {
		int result = sqlSession.insert(NAMESPACE);
		return result;
	}
}
   
   