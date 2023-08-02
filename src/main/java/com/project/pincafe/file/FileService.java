package com.project.pincafe.file;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service // 객체를 스프링부트가 직접 생성
public class FileService {

    private final String DEFAULT_IMAGE_CODE = "0000";

    @Autowired
    private FileDAO fileDAO;

    @Value("${file.upload-dir}")
    private String uploadDir;

    // FileVO 정보를 기반으로 파일을 생성한다.
    public FileVO createFile(FileVO vo) throws Exception 
    {
        UUID uuid;
        String orgFileName = ""; // 사용자 파일의 원래이름(ex. cutepuu.jpg)
        String fileCode = "";  // 파일코드(파일명이 된다, UUID)
        String fileExt = "";   // 파일의 확장자

        if (false == vo.getFile().getOriginalFilename().isEmpty()) {
            // 여기로 들어오면 사용자가 파일을 등록했다는 뜻

            // fileCode를 만든다.
            uuid = UUID.randomUUID();
			fileCode = uuid.toString().replaceAll("-", "");

            // orgFileName에서 확장자만 추출해낸다.
            orgFileName = vo.getFile().getOriginalFilename();
            fileExt = orgFileName.substring(orgFileName.lastIndexOf("."), orgFileName.length());

			// fileVO를 설정한다.
			vo.setFileCode(fileCode);
			vo.setStoredName(fileCode + fileExt);
			vo.setOriginName(orgFileName);			
			
            // 파일을 vo에 알맞게 최종저장한다.
			FileUploadUtil.saveFile(vo);			
		}
		return vo;
	}

    public FileVO getDefaultImage() throws Exception {
        return fileDAO.getFileByCode(DEFAULT_IMAGE_CODE);
    }

    public int insertFileTbl(FileVO vo) throws Exception {
		return fileDAO.insertFileTbl(vo);
	}	
}
