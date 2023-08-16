package com.project.pincafe.bbs;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
public class BbsTblVO {
    // 설계속성
    private int page;
    private int rowsPerPage;

    // 기본속성
    private String rowNum;
    private String userId;
    private String seq;
    private String title;
    private String content;
    private String divi;
    private String regdate;
    private String fileCode;
    private String address;
    private double lat;
    private double lng;
    private int viewCount;

    @JsonIgnore 
    private MultipartFile thumbnail;
}
