package com.saeromteo.app.dao.user;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.saeromteo.app.model.admin.AdminDTO;
import com.saeromteo.app.model.user.UserDTO;

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

	public int registrationoAuthUser(UserDTO user) {
		int result = sqlSession.insert(NAMESPACE+"registrationoAuthUser",user);
		return result;
	}
	
	public UserDTO readUserByUserIdforCollection(int userId) {
		UserDTO user = sqlSession.selectOne(NAMESPACE + "readUserByUserIdforCollection" , userId);
		return user;
	}
	
	public int registrationUser(UserDTO user){
		int result = sqlSession.insert(NAMESPACE+"registrationUser",user);
		return result;
	}
	
	public AdminDTO adminLogin(String adminId) {
		AdminDTO admin = sqlSession.selectOne(NAMESPACE + "adminLogin" ,adminId);
		return admin ;
	}
	

	public int resetPassword (UserDTO user){
		int result = sqlSession.update(NAMESPACE + "resetPassword",user);
		return result;
	}
	
	public UserDTO readUserByUserId(int userId) {
		return sqlSession.selectOne(NAMESPACE + "readUserByUserId" , userId);
	}
	
	public int updateUser(UserDTO user){
		int result = sqlSession.insert(NAMESPACE+"updateUser",user);

		return result;
	}
}

   