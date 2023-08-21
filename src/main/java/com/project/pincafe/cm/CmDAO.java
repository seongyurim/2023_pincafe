package com.project.pincafe.cm;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CmDAO {
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    public int selectcmRowCount() throws Exception
    {
        return sqlSessionTemplate.selectOne("selectcmRowCount");
    }

    public List<CmTblVO> selectcmList(CmTblVO cmVO) throws Exception
    {
        System.out.println("selectcmList : " + cmVO);
        return sqlSessionTemplate.selectList("selectcmList", cmVO);

    }

    public CmTblVO selectcmContent(CmTblVO cmVO) throws Exception
    {
        System.out.println("selectcmContent : " + cmVO);
        return sqlSessionTemplate.selectOne("selectcmContent", cmVO);
    }


    public int updatecmContent(CmTblVO cmVO) throws Exception
    {
        return sqlSessionTemplate.update("updatecmContent", cmVO);
    }

    public int insertComment(CmTblVO cmVO) throws Exception
    {
        System.out.println("댓글 달림");
        return sqlSessionTemplate.insert("insertComment", cmVO);
    }

    public int deletecmComment(CmTblVO cmVO) throws Exception
    {
        return sqlSessionTemplate.delete("deletecmContent", cmVO);
    }

    public int insertPartNum(CmTblVO cmVO) throws Exception
    {
        return sqlSessionTemplate.insert("insertPartNum", cmVO);
    }


}
