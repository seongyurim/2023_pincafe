package com.project.pincafe.user;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
public class UserTblVO {
    private String id;
    private String nickname;
    private String password;
    private String email;
    private String address;
    private String fileCode;

    @JsonIgnore // JSON 직렬화시 무시한다.
    private MultipartFile thumbnail;

   
}
