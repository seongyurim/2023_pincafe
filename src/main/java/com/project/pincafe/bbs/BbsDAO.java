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

    // 내가 클릭한 게시물 페이지 나타내기
    public BbsTblVO selectBbsContent(BbsTblVO vo) throws Exception {
        return sqlSessionTemplate.selectOne("selectBbsContent", vo);
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

    // 게시글 삭제하기
    public int deleteBbsContent(BbsTblVO vo) throws Exception {
        return sqlSessionTemplate.delete("deleteBbsContent", vo);
    }

    // 조회수 증가시키기
    public void increaseViewCount(BbsTblVO vo) throws Exception {
        sqlSessionTemplate.update("increaseViewCount", vo);
    }

    // 게시판 검색 목록 조회하기
    public List<BbsTblVO> selectBbsListSearched(BbsTblVO vo) throws Exception {
        return sqlSessionTemplate.selectList("selectBbsListSearched", vo);
    }

    // 다음글 조회
    public BbsTblVO selectNextContent(BbsTblVO vo) throws Exception {
        return sqlSessionTemplate.selectOne("selectNextContent", vo);
    }

    // 다음글 조회
    public BbsTblVO selectPrevContent(BbsTblVO vo) throws Exception {
        return sqlSessionTemplate.selectOne("selectPrevContent", vo);
    }
}
