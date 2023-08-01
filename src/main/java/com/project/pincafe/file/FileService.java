package com.project.pincafe.file;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FileService {

    @Autowired
    private FileDAO fileDAO;

    // FileVO 정보를 기반으로 파일을 생성한다.
    public FileVO createFile(FileVO vo) throws Exception 
    {
        String fileCode = "";     // 파일코드 (파일명이 된다, UUID)
        String fileExt = "";      // 파일의 확장자.

        if (false == vo.getFile().getOriginalFilename().isEmpty()) 
        {
			fileCode = UUID.randomUUID().toString().replaceAll("-", "");			
            fileExt = vo.getFile().getOriginalFilename().substring(vo.getFile().getOriginalFilename().lastIndexOf("."),
                                                                   vo.getFile().getOriginalFilename().length());
			
			vo.setFileCode(fileCode);
			vo.setStoredName(fileCode + fileExt);
			vo.setOriginName(vo.getFile().getOriginalFilename());			
			
			FileUploadUtil.saveFile(vo);
			
		}
		
		return vo;
	}

    public int insertFileTbl(FileVO vo) throws Exception
    {
		return fileDAO.insertFileTbl(vo);
	}
	
}
