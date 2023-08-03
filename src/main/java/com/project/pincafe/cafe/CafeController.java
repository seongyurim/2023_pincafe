package com.project.pincafe.cafe;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CafeController {

    @Autowired
    CafeDAO cafeDAO;


    @PostMapping("/cafe/list")
    @ResponseBody
    public CafeMstVO cafeList(@ModelAttribute("CafeTblVO") CafeTblVO vo) throws Exception {
        CafeMstVO cafeMstVO = new CafeMstVO();

        // 1. 전체 row의 개수를 가지고온다.
        int rowCount = cafeDAO.selectCafeRowCount();

        // 2. page에 해당하는 BBS데이터를 가지고 온다.
        List<CafeTblVO> list = cafeDAO.selectCafeList(vo);

        // 3. CafeMstVO에 저장하고 전송한다.
        cafeMstVO.setRowCount(rowCount);
        cafeMstVO.setCafeList(list);

        return cafeMstVO;
    }
    

}
