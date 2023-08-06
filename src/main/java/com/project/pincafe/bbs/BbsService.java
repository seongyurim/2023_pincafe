package com.project.pincafe.bbs;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

@Transactional
public class BbsService {

    // public List<BbsMstVO> searchCafe (String keyword)
    // {
    //     List<BbsMstVO> cafes = BbsDAO.findByTitleContaining(keyword);
    //     List<BbsMstVO> cafeList = new ArrayList<>();

    //     if (cafes.isEmpty())
    //     {
    //         return cafeList;
    //     }

    //     for (BbsMstVO bbsMstVO : cafes)
    //     {
    //         cafeList.add(this.convertEntityToList(bbsMstVO));
    //     }

    //     return cafeList;
    // }

    // private BbsMstVO convertEntityToList (BbsMstVO bbsMstVO)
    // {
    //     return BbsMstVO.builder();
    // }
}