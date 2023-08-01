package com.project.pincafe.file;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FileDAO 
{
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    public int insertFileTbl(FileVO vo) throws Exception
    {
		return sqlSessionTemplate.insert("insertFileTbl", vo);
	}
        
}
