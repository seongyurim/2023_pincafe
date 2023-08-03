package com.project.pincafe.cafe;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CafeDAO {
    
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;


    public int selectCafeRowCount() throws Exception
    {
        return sqlSessionTemplate.selectOne("selectCafeRowCount");
    }

    public List<CafeTblVO> selectCafeList(CafeTblVO vo) throws Exception
    {
        return sqlSessionTemplate.selectList("selectCafeList", vo);

    }

}
