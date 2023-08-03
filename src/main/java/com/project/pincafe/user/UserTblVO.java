package com.project.pincafe.user;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
public class UserTblVO {
    private String userId;
    private String userPw;
    private String name;
    private String email;
    private String address;
    private String fileCode;

    @JsonIgnore 
    private MultipartFile thumbnail;
    // JSON 직렬화시 무시한다.
    // 즉 해당VO를 JSON으로 만들 때에 thumbnail은 생략하라는 의미   
}
