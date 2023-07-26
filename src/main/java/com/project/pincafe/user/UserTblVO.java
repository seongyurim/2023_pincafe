package com.project.pincafe.user;

import lombok.Data;

@Data
public class UserTblVO {
    private String id;
    private String nickname;
    private String password;
    private String email;
    private String address;
    private String userpic;
}
