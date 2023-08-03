package com.project.pincafe;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.pincafe.common.GmailSender;
import com.project.pincafe.common.SessionUtil;
import com.project.pincafe.file.FileService;
import com.project.pincafe.file.FileVO;
import com.project.pincafe.user.UserDAO;
import com.project.pincafe.user.UserTblVO;

@Controller
public class MainController {

    @Autowired
    UserDAO userDAO;

    @Value("${file.upload-dir}")
    private String uploadDir;

    @Autowired
    FileService fileService;
    
    @GetMapping("/index")
    public String index(Model model) throws Exception {
        // 1. 요청한 주체에게 세션(사용자 정보)이 존재하는가?
        UserTblVO resultVO = (UserTblVO)SessionUtil.getAttribute("USER");

        // 2. 만약에 세션이 존재한다면 Model에 사용자 정보를 저장하여 index.jsp로 전송한다.
        if (resultVO != null) {
            model.addAttribute("vo", resultVO);
        }
        return "index";
    }


    ////// 로그인 //////////////////////////////////////////////////////////

    @GetMapping("/login")
    public String login()
    {
        return "login";
    }

    // 아이디 패스워드를 넘겨서 로그인을 실제로 처리해달라는 요청.
    @PostMapping("/login")
    public void login(@ModelAttribute("UserTblVO") UserTblVO vo,
                    HttpServletRequest request, 
                    HttpServletResponse response) throws Exception
    {
        
        UserTblVO resultVO = userDAO.selectOneUserForLogin(vo);

        if (resultVO == null)
        {
            response.sendRedirect("login");
            System.out.println("로그인 실패");
        }
        else
        {            
            SessionUtil.set(request, "USER", resultVO);
            response.sendRedirect("index");            
            System.out.println("로그인 성공");
            System.out.println(resultVO);            
        }        
    }


    ////// 로그아웃 ////////////////////////////////////////////////////////

    @GetMapping("/logout")
    public void logout(HttpServletRequest request,
                       HttpServletResponse response) throws Exception {
        // 로그아웃으로 왔다는 것은 현재 로그인이 되어있다는 의미
        // 즉 세션에 사용자 정보가 존재한다는 의미이므로 세션을 비워야 한다.
        SessionUtil.remove(request, "USER");
        response.sendRedirect("index"); // 세션이 비워진 채로 index()로 이동
    }
    


    ////// 회원가입 ///////////////////////////////////////////////////////////

    @GetMapping("/join")
    public String join() {

        return "join";
    }

    // 아이디 중복확인
    @PostMapping("/checkId")
    @ResponseBody
    public String checkId(@RequestBody UserTblVO vo) throws Exception {
        
        UserTblVO resultVO = userDAO.selectOneUserForId(vo);

        if (resultVO == null) {
            return "OK";
        }
        else {
            return "FAIL";
        }
    }

    // 닉네임 중복확인
    @PostMapping("/checkNick")
    @ResponseBody
    public String checkNick(@RequestBody UserTblVO vo) throws Exception
    {        
        UserTblVO resultVO = userDAO.selectOneUserForNick(vo);

        if (resultVO == null) {
            return "OK";
        }
        else {
            return "FAIL";
        }
    }

    @PostMapping("/join")
    public ResponseEntity<String> join(@ModelAttribute("UserTblVO") UserTblVO vo) throws Exception
    {        
        FileVO fileVO = null;
        
        // 섬네일이 있는 경우 파일처리를 수행한다.
        if (vo.getThumbnail() != null)
        {   
            fileVO = new FileVO();
            // fileVO에 전송받은 thumbnail, path 를 넣어준다.
            fileVO.setFile(vo.getThumbnail());
            fileVO.setFilePath(uploadDir + "member/thumbnail");
            
            fileVO = fileService.createFile(fileVO);
            fileService.insertFileTbl(fileVO);
            vo.setFileCode(fileVO.getFileCode());
        }
        // 프로필 사진이 없는 경우 디폴트 이미지를 사용
        else {
            vo.setFileCode("0000");
        }

        int insertCount = userDAO.insertUser(vo);
        System.out.println(vo);
        
        if (insertCount == 1) {
            return new ResponseEntity<>("OK", HttpStatus.OK);
        }
        else {
            return new ResponseEntity<>("FAIL", HttpStatus.OK);
        }
    }    


    
    ////// 아이디/비밀번호 찾기 /////////////////////////////////////////////////////

    // GET Find Id 
    @GetMapping("/idinquiry")
    public String findId() {
        return "idinquiry";
    }

    // POST Find Id   
    @PostMapping("/idinquiry")
    @ResponseBody
    public String idinquiry (@ModelAttribute("UserTblVO") UserTblVO vo) throws Exception
    {
        // 닉네임과 이메일을 입력받아 vo가져오기
        UserTblVO accountVO = userDAO.getIdByNnEmail(vo);
        System.out.println(accountVO);

        // vo값을 가져왔을 경우 (해당하는 account가 있을 경우)
        if (accountVO != null)
        {
            // accountVO의 userId를 변수에 저장
            String userId = accountVO.getId();

            // 가져온 userId 끝 세 자리를 마스킹해서 변수에 저장
            String maskedUserId = userId.substring(0, userId.length() - 3) + "***";
            System.out.println(maskedUserId);
            
            return maskedUserId;
        }
        else
        {
            // 아이디가 FAIl일 수 있으므로 아이디에 넣을 수 없는 특수문자 추가
            return "$FAIL"; 
        }        
    }
    
    // GET Find PW
    @GetMapping("/pwinquiry")
    public String findPw() {
        return "pwinquiry";
    }

    // POST Find PW
    @PostMapping("/pwinquiry")
    @ResponseBody
    public String pwinquiry(@ModelAttribute("UserTblVO") UserTblVO vo) throws Exception {

        // 받아온 id 와 email로 vo를 가져옴
        UserTblVO accountVO = userDAO.getPwByIdEmail(vo); 
        System.out.println(accountVO);

        String senderName = "noeyhus.p@gmail.com"; // 관리자의 이메일을 세팅
        String senderPasswd = "gxixnqnvfkxrhhnl";   // 구글 계정의 앱 비밀번호 16자
        GmailSender gmailSender = null;
        
        // vo에 들어온 게 없으면
        if (accountVO == null) {
            return "$FAIL";
        }
        else {
            // 비밀번호를 메일로 전송한다.
            gmailSender = new GmailSender(senderName, senderPasswd);
            gmailSender.sendEmail(accountVO.getEmail(), "비밀번호 전송", "비밀번호: " + accountVO.getPassword());
            // sendEmail의 파라미터(3개)
            // param 1. 받을 사람의 이메일 주소
            // param 2. 이메일의 제목
            // param 3. 이메일의 내용

            return "$OK";
        }
    }
    /////////////카페관련 //////////////////////////////////////////////////////////////////

    @GetMapping("/cafe/cafehomepage")
    public String cafehomepage() {
        return "/cafe/cafehomepage";
    }
  
    ////// 새글 작성 ////////////////////////////////////////////////////////////////

    // GET newarticle 
    @GetMapping("/bbs/newarticle")
    public String newArticle() {
        return "/bbs/newarticle";
    }
}
