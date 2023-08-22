package com.project.pincafe.cm;

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
    public CmMstVO cmList(@ModelAttribute("CmTblVO") CmTblVO cmVO, Model model) throws Exception
    {
        System.out.println("현재 vo : " + cmVO);
        CmMstVO cmMstVO = new CmMstVO();

        int rowCount = cmDAO.selectcmRowCount();

        System.out.println("rowCount : " + rowCount);

        List<CmTblVO> list = cmDAO.selectcmList(cmVO);
        
        // System.out.println("댓글 리스트 : " + list);

        cmMstVO.setRowCount(rowCount);
        cmMstVO.setCmList(list);

        return cmMstVO;        
    }

    @PostMapping("/cm/comment")
    @ResponseBody         
    public String comment(@ModelAttribute("CmTblVO") CmTblVO cmVO) throws Exception
    {

        CmMstVO cmMstVO = new CmMstVO();
        int rowCount = cmDAO.selectcmRowCount();
        System.out.println(rowCount);
        System.out.println(cmVO);

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

     ////// 댓글 삭제 ////////////////////////////////////////////////////////////////
    // post 댓글 삭제
    @PostMapping("/cm/deleteComment")
    @ResponseBody
    public String cmDelete(@ModelAttribute("CmTblVO") CmTblVO cmVO) throws Exception
    {
        // 1. 게시물 정보(userId, seq)에 맞는 게시물을 가지고 오기
        CmTblVO resultVO = cmDAO.selectcmComment(cmVO);
        System.out.println("삭제구현(댓글번호) : " + resultVO.getCmSeq());
        System.out.println("삭제구현(댓글회원) : " + resultVO.getCmUserId());

        // 2. 게시글 삭제
        int deleteCount = cmDAO.deletecmComment(resultVO);
        System.out.println("삭제 댓글 개수 : " + deleteCount);

        // 3. 게시글 삭제 체크
        if (deleteCount == 1) {
            return "success";
        } else {
            // 삭제 실패 시, 실패 메시지 보내기
            return "fail";
        }
    }

}