package com.project.pincafe.user;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAO {
    
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    public UserTblVO selectOneUserForLogin(UserTblVO vo) throws Exception {
        return sqlSessionTemplate.selectOne("selectOneUserForLogin", vo);
    }

    public UserTblVO selectOneUserForId(UserTblVO vo) throws Exception {
        return sqlSessionTemplate.selectOne("selectOneUserForId", vo);
    }

    public UserTblVO selectOneUserForNick(UserTblVO vo) throws Exception {
        return sqlSessionTemplate.selectOne("selectOneUserForNick", vo);
    }

    public int insertUser(UserTblVO vo) throws Exception {
        return sqlSessionTemplate.insert("insertUser", vo);
    }

    public int updateUser(UserTblVO vo) throws Exception {
        return sqlSessionTemplate.update("updateUser", vo);
    }

    public UserTblVO getIdByNnEmail (UserTblVO vo) throws Exception
    {
        return sqlSessionTemplate.selectOne("getIdByNnEmail", vo);
    }

    public UserTblVO getPwByIdEmail (UserTblVO vo) throws Exception
    {
        return sqlSessionTemplate.selectOne("getPwByIdEmail", vo);
    }

    // 탈퇴 구현
    public UserTblVO getUserByPw (UserTblVO vo) throws Exception
    {
        return sqlSessionTemplate.selectOne("getUserByPw", vo);
    }

    public int deleteUser (UserTblVO vo) throws Exception
    {
        return sqlSessionTemplate.delete("deleteUser", vo);
    }

    // readContent 페이지에 작성자 닉네임, 프로필사진 띄우기
    public UserTblVO getUserById (String id) throws Exception
    {
        return sqlSessionTemplate.selectOne("getUserById", id);
    }
}
