package com.project.pincafe.cm;

import lombok.Data;

@Data
public class CmTblVO {    
    // 설계속성
    private int page;
    private int commentPage;
    

    // CMTBL
    private int rowNum;
    private String cmUserId;
    private String cmUserSeq;
    private String bbsSeq;
    private String cmContent;
    private String cmRegDate;
    private String bbsUserId;

}
