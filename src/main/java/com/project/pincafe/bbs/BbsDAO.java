package com.project.pincafe.bbs;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BbsDAO {
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
    
    public int selectBbsRowCount() throws Exception {
        return sqlSessionTemplate.selectOne("selectBbsRowCount");
    }

    // 게시판 전체 목록 조회하기
    public List<BbsTblVO> selectBbsList(BbsTblVO vo) throws Exception {
        return sqlSessionTemplate.selectList("selectBbsList", vo);
    }

     //게시물을 받아와서 뿌려주는 역활 
    public BbsTblVO getUpdatedContent(BbsTblVO vo) throws Exception {
        return sqlSessionTemplate.selectOne("getUpdatedContent", vo);
    }

    // 게시물 수정하기
    // 개수를 리턴하므로 int여야 한다.
    public int updateBbsContent(BbsTblVO vo) throws Exception {
        return sqlSessionTemplate.update("updateBbsContent", vo);
    }

    // 게시물 등록하기
    public int insertBbsContent(BbsTblVO vo) throws Exception {
        return sqlSessionTemplate.insert("insertBbsContent", vo);
    }

    //게시물 페이지 
    public BbsTblVO selectBbsReadContent(BbsTblVO vo) throws Exception {
        return sqlSessionTemplate.selectOne("selectBbsReadContent", vo);
    }

}
