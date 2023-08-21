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

    public List<CmTblVO> selectcmList(CmTblVO vo) throws Exception
    {
        System.out.println("selectcmList : "+vo);
        return sqlSessionTemplate.selectList("selectcmList", vo);

    }

    public CmTblVO selectcmContent(CmTblVO vo) throws Exception
    {
        System.out.println("selectcmContent : "+vo);
        return sqlSessionTemplate.selectOne("selectcmContent", vo);
    }


    public int updatecmContent(CmTblVO vo) throws Exception
    {
        return sqlSessionTemplate.update("updatecmContent", vo);
    }

    public int insertComment(CmTblVO vo) throws Exception
    {
        System.out.println("댓글 달림");
        return sqlSessionTemplate.insert("insertComment", vo);
    }

    public int deletecmComment(CmTblVO vo) throws Exception
    {
        return sqlSessionTemplate.delete("deletecmContent", vo);
    }

    public int insertPartNum(CmTblVO vo) throws Exception
    {
        return sqlSessionTemplate.insert("insertPartNum", vo);
    }


}
