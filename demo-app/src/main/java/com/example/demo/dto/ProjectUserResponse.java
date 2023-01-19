package com.example.demo.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.sql.Timestamp;

@NoArgsConstructor
@Data
@ToString
public class ProjectUserResponse {

    private int id;
    private String username;
    private String name;
    private String state;
    private String avatar_url;
    private String web_url;
    private Timestamp expire_at;
    private int access_level;
    private String email;
    private String group_saml_identity;

}
