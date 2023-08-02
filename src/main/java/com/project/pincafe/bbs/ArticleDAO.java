package com.project.pincafe.bbs;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ArticleDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    // newArticle 등록
    public int insertNewArticle(ArticleVO vo) throws Exception {
        return sqlSessionTemplate.insert("insertNewArticle", vo);
    }
}
