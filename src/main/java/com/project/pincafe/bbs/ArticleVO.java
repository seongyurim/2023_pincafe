package com.project.pincafe.bbs;

import lombok.Data;

@Data
public class ArticleVO {
    
    // 기본 속성
    private int article_no;
    private String title;
    private String content;
    private int article_like;
    private int cafe_no;
    private String article_date; 
    private String nickname;
}
