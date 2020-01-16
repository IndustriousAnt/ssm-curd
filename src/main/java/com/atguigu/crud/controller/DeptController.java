package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Dept;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.Deptservice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理和部门有关的请求
* */
@Controller
public class DeptController {
    @Autowired
    private Deptservice deptservice;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
       List<Dept>  list=deptservice.getDepts();

        return Msg.successs().add("depts",list);
    }

}
