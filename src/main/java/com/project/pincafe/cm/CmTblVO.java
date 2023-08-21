package com.project.pincafe.cm;

import lombok.Data;

@Data
public class CmTblVO {    
    // 설계속성
    private int page;
    private int commentPage;
    
    // 기본속성
    private int rowNum;
    private String cmUserId;
    private String cmSeq;
    private String bbsUserId;
    private String bbsSeq;
    private String cmContent;
    private String cmRegdate;

}
