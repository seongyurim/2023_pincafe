package com.project.pincafe.cm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.pincafe.common.SessionUtil;
import com.project.pincafe.user.UserTblVO;

@Controller
public class CmController {

    @Autowired
    CmDAO cmDAO;

    @PostMapping("/cm/list")
    @ResponseBody  
    public CmMstVO cmList(@ModelAttribute("CmTblVO") CmTblVO vo) throws Exception
    {
        System.out.println("현재 vo : " + vo);
        CmMstVO mbsMstVO = new CmMstVO();

        int rowCount = cmDAO.selectcmRowCount();

        System.out.println("rowCount : " + rowCount);

        List<CmTblVO> list = cmDAO.selectcmList(vo);
        
        System.out.println("댓글 리스트 : " + list);

        mbsMstVO.setRowCount(rowCount);
        mbsMstVO.setCmList(list);

        return mbsMstVO;
        
    }

    @PostMapping("/cm/comment")
    @ResponseBody         
    public String comment(@ModelAttribute("CmTblVO") CmTblVO vo) throws Exception
    {

        CmMstVO cmMstVO = new CmMstVO();
        int rowCount = cmDAO.selectcmRowCount();
        System.out.println(rowCount);

        List<CmTblVO> list = cmDAO.selectcmList(vo);
        
        cmMstVO.setRowCount(rowCount);
        cmMstVO.setCmList(list);

        System.out.println("rowCount : " + rowCount);

        int count = cmDAO.insertComment(vo);

        System.out.println("count : " + count);
        
        if (count == 1) {
            return "OK";
        }
        else {
            return "FAIL";
        }
    }

}