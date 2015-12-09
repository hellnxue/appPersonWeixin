package com.hrofirst.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by qixb.fnst on 2015/03/12.
 */
@Controller()
@RequestMapping("/aboutUs")
public class AboutUsController {
    @RequestMapping("/address")
    public String address(){
        return "aboutUs/address";
    }
    @RequestMapping("/tel")
    public String tel(){
        return "aboutUs/tel";
    }
    @RequestMapping("/phone")
    public String phone(){
        return "aboutUs/phone";
    }
    @RequestMapping("/mail")
    public String mail(){
        return "aboutUs/mail";
    }
    @RequestMapping("/qq")
    public String qq(){
        return "aboutUs/qq";
    }
    @RequestMapping("/weChat")
    public String weChat(){
        return "aboutUs/wechat";
    }
}
