package com.project.pincafe.cm;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.pincafe.bbs.BbsTblVO;
import com.project.pincafe.common.SessionUtil;
import com.project.pincafe.user.UserDAO;
import com.project.pincafe.user.UserTblVO;

@Controller
public class CmController {

    @Autowired
    CmDAO cmDAO;

    @Autowired
    UserDAO userDAO;


    @PostMapping("/cm/list")
    @ResponseBody  
    public CmMstVO cmList(@ModelAttribute("cmVO") CmTblVO cmVO, Model model) throws Exception
    {
        System.out.println("현재 vo : " + cmVO);
        CmMstVO cmMstVO = new CmMstVO();

        int rowCount = cmDAO.selectcmRowCount();

        System.out.println("rowCount : " + rowCount);

        List<CmTblVO> list = cmDAO.selectcmList(cmVO);
        
        System.out.println("댓글 리스트 : " + list);

        cmMstVO.setRowCount(rowCount);
        cmMstVO.setCmList(list);

        //////
        // CmTblVO resultVO = null;
        // List<String> cmAuthorNicknames = new ArrayList<>();
        // List<String> cmAuthorProfileImgs = new ArrayList<>();
    
        // for (int i = 0; i < list.size(); i++) {
        //     CmTblVO cmTblVO = list.get(i);
        //     resultVO = cmDAO.selectcmContent(cmTblVO);
        //     System.out.println("현재 CmTblVO는: " + resultVO);
    
        //     if (resultVO != null) {
        //         UserTblVO author = userDAO.getUserById(resultVO.getCmUserId());
    
        //         if (author != null) {
        //             String cmAuthorNickname = author.getName();
        //             String cmAuthorProfileImg = author.getFileCode();
        //             cmAuthorNicknames.add(cmAuthorNickname);
        //             cmAuthorProfileImgs.add(cmAuthorProfileImg);                   
        //         }
        //     }
        // }
        // model.addAttribute("cmAuthorNicknames", cmAuthorNicknames);
        // model.addAttribute("cmAuthorProfileImgs", cmAuthorProfileImgs);
        // System.out.println(cmAuthorNicknames);
        // System.out.println(cmAuthorProfileImgs);

        return cmMstVO;
    }

    @PostMapping("/cm/comment")
    @ResponseBody         
    public String comment(@ModelAttribute("cmVO") CmTblVO cmVO) throws Exception
    {

        CmMstVO cmMstVO = new CmMstVO();
        int rowCount = cmDAO.selectcmRowCount();
        System.out.println(rowCount);

        List<CmTblVO> list = cmDAO.selectcmList(cmVO);
        
        cmMstVO.setRowCount(rowCount);
        cmMstVO.setCmList(list);

        System.out.println("rowCount : " + rowCount);

        int count = cmDAO.insertComment(cmVO);

        System.out.println("count : " + count);
        
        if (count == 1) {
            return "OK";
        }
        else {
            return "FAIL";
        }
    }

}