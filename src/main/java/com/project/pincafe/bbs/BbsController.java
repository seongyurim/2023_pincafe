package com.project.pincafe.bbs;


import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.pincafe.common.SessionUtil;
import com.project.pincafe.file.FileService;
import com.project.pincafe.file.FileVO;
import com.project.pincafe.user.UserTblVO;


@Controller
public class BbsController {

    @Autowired
    BbsDAO bbsDAO;

    
    // system에 config 객체를 뒤지게끔
    @Value("${file.upload-dir}")
    private String uploadDir;

    // fileService 의존성 주입
    @Autowired
    FileService fileService;
    
    //////////////////////////////////////////////////////////////////////////////////////////

    @PostMapping("/bbs/list")
    @ResponseBody // divi, page, rosPerPage
    public BbsMstVO bbsList(@ModelAttribute("BbsTblVO") BbsTblVO vo) throws Exception {
        BbsMstVO bbsMstVO = new BbsMstVO();
        // System.out.println(vo.getDivi());
        // System.out.println(vo.getPage());
        // System.out.println(vo.getRowsPerPage());

        // 1. 전체 row의 개수를 가지고 온다.
        int rowCount = bbsDAO.selectBbsRowCount();
        // System.out.println("rowCount = " + rowCount);

        // 2. 페이지에 해당하는 BBS 데이터를 가지고 온다.
        List<BbsTblVO> list = bbsDAO.selectBbsList(vo);

        // 3. BbsMstVO에 저장하고 전송한다.
        bbsMstVO.setRowCount(rowCount);
        bbsMstVO.setBbsList(list);

        // 4. 결과를 반환한다.
        return bbsMstVO;        
    }


    ////// CREATE ///////////////////////////////////////////////////////////////////////////////
    @GetMapping("/bbs/newcontent")
    public String newcontent(@ModelAttribute("BbsTblVO") BbsTblVO vo,
                                Model model) throws Exception {
        UserTblVO userTblVO = (UserTblVO)SessionUtil.getAttribute("USER");
        model.addAttribute("session", userTblVO);
        return "/bbs/newcontent";
    }

    @PostMapping("/bbs/newcontent")
    @ResponseBody // userId, title, content, divi
    public ResponseEntity<String> newcontent(@ModelAttribute("BbsTblVO") BbsTblVO vo) throws Exception {
        System.out.println(vo.getUserId());
        System.out.println(vo.getTitle());
        System.out.println(vo.getContent());
        System.out.println(vo.getDivi());

        // 1. 받은 파일 데이터를 원하는 위치에 파일로 저장
        FileVO fileVO = null;
        
        // 파일을 전송 받았다면 파일을 저장하고 FILE_TBL에 INSERT 시키기
        if (vo.getThumbnail() != null)
        {
            fileVO = new FileVO();
            fileVO.setFile(vo.getThumbnail());
            fileVO.setFilePath(uploadDir + "member/thumbnail");

            // fileVO 생성
            fileVO = fileService.createFile(fileVO);

            // 생성한 file정보 DB(FILE_TBL)에 저장
            fileService.insertFileTbl(fileVO);

            // memberVO 에 FileCode 설정
            vo.setFileCode(fileVO.getFileCode());
        }
        
        // 이제 여기서 insert 쿼리를 실행해주면 됨
        bbsDAO.insertBbsContent(vo);

        // 성공 시 서버가 전송한 메세지 "INSERT_SUCCESS"가 출력되는 것
        return new ResponseEntity<String> ("INSERT_SUCCESS", HttpStatus.OK);
    }

    
    ////// READ /////////////////////////////////////////////////////////////////////////////////////
    
    @GetMapping("/bbs/readContent")
    public String readContent(@ModelAttribute("BbsTblVO") BbsTblVO vo,
                            Model model) throws Exception {
    
        BbsTblVO resultVO = bbsDAO.selectBbsReadContent(vo);
        UserTblVO userTblVO = (UserTblVO)SessionUtil.getAttribute("USER");

        // 게시물 정보와 세션 정보를 모델에 저장한다.
        model.addAttribute("vo", resultVO);    // content row 정보 보내기
        model.addAttribute("session", userTblVO); // 로그인한 유저의 정보 보내기

        return "/bbs/readContent";
    }


    ////// UPDATE ///////////////////////////////////////////////////////////////////////////////////
    @GetMapping("/bbs/updateContent/{userId}/{seq}")
    public String updateContent() {
      
    return "/bbs/updateContent";
}

    @PostMapping("/bbs/updateContent")
    @ResponseBody // HTTP의 body(payload)로 응답하겠다는 의미(모델, 뷰를 거치지 않고)
    public String updateContent(@ModelAttribute("BbsTblVO") BbsTblVO vo) throws Exception {
        // vo로 id, seq, title, content를 받았다.
        System.out.println(vo.getUserId());
        System.out.println(vo.getSeq());
        System.out.println(vo.getTitle());
        System.out.println(vo.getContent());

        int updateCount = bbsDAO.updateBbsContent(vo);
        // 반드시 1이어야 한다.
        // 키를 가지고 업데이트한 것이기 때문이다.

        if (updateCount == 1) {
            return "OK";
        }
        else {
            return "FAIL";
        }
    }

}

