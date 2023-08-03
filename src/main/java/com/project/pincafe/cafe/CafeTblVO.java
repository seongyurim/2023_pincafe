package com.project.pincafe.cafe;

import lombok.Data;

@Data
public class CafeTblVO {
    // 설계속성
    private int page;
    private int rowsPerPage;
    
    private int cafe_no;
    private String cafe_name;
    private String cafe_addr;
    private int cafe_like;
    private int category_no;
    private int comment_no;
}
