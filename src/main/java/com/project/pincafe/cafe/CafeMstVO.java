package com.project.pincafe.cafe;

import java.util.List;

import lombok.Data;

@Data
public class CafeMstVO {
    private int rowCount;
    private List<CafeTblVO> cafeList;
    
}
