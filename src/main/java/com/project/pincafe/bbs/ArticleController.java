package com.project.pincafe.bbs;

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
public class ArticleController {
    
    @Autowired
    ArticleDAO articleDAO;

    @GetMapping("/bbs/newarticle")
    public String newArticle(@ModelAttribute("ArticleVO") ArticleVO vo,  
                                                        Model model) throws Exception
    {
        UserTblVO userTblVO = (UserTblVO) SessionUtil.getAttribute("USER");

        model.addAttribute("session", userTblVO); 
        return "/bbs/newarticle";
    }

    @PostMapping("/bbs/newarticle")
    @ResponseBody   // ok라는 문자열을 받아서 보내기, responseBody가 없으면 ok.jsp를 찾으려고 함
    public String newArticle(@ModelAttribute("ArticleVO") ArticleVO vo) throws Exception
    {
        // insertNewContent함수 호출하고 vo넣어줌
        int newArticle = articleDAO.insertNewArticle(vo);

        System.out.println(vo.getNickname());
        System.out.println(vo.getTitle());
        System.out.println(vo.getContent());
        
        // 컨텐츠가 1개여야 하므로
        if (newArticle == 1)
        {
            // ok를 model이나 view를 거치지 않고 body로 바로 보내는 것
            return "OK";   
        }
        else
        {
            return "FAIL";
        }
    }
}

