package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Emp;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.Empservice;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工CRUD请求
 *
 * */
@Controller
public class EmpController {

    @Autowired
    Empservice empservice;
    /**
     * 查询员工数据（分页查询）
     * 引入pageHelper插件
     * */
    /*
    *
    * 导入jackson包
    * 员工信息查询
    * */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        PageHelper.startPage(pn,5);
        List<Emp> emps = empservice.getAll();
        //使用PageInfo包装查询的结果，封装了详细的分页信息
        PageInfo page = new PageInfo(emps,5);
        return Msg.successs().add("pageInfo",page);
    }
    /**
     * 员工保存
     *
     * */
    @RequestMapping(value = "/emp" ,method = RequestMethod.POST)
    @ResponseBody
    public  Msg saveEmp(@Valid Emp emp, BindingResult result){
        if(result.hasErrors()){
            Map<String,Object> map=new HashMap<String,Object>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError:errors) {
                    System.out.println("错误的字段名"+fieldError.getField());
                    System.out.println("错误信息"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            empservice.saveEmp(emp);
            return Msg.successs();
        }
    }
    /**
     * 检查用户名是否存在
     * */
    @RequestMapping("/checkuser")
    @ResponseBody
    public  Msg checkuser(@RequestParam("empName")String emName){
          String regName="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u4e00-\\u9fa5]{2,5})";
          if(!emName.matches(regName)){
              return Msg.fail().add("va_msg","用户必须是6-16位英文和数字的组合或者是2-5位中文");
          }
           boolean b =empservice.checkUser(emName);
        if(b){
          return Msg.successs();
        }else {
           return Msg.fail().add("va_msg","用户名不可用");
        }
    }

    /**
     * 根据Id查询员工
     * */
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id")Integer id){
        Emp emp = empservice.getEmp(id);

        return Msg.successs().add("emp",emp);
    }

    /**
     * 员工更新
     * */

    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public  Msg saveUpdateEmp(Emp emp){
        System.out.println("将更新的员工"+emp);
        empservice.Updateemp(emp);
        return Msg.successs();
    }

    //删除员工
    /*
    * 单个批量二合一
    * */
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg delectEmpById(@PathVariable("ids") String ids){
        if(ids.contains("-")){
            List<Integer> del_ids= new ArrayList<Integer>();
            String[] str_ids = ids.split("-");
            for (String id:str_ids) {
                del_ids.add(Integer.parseInt(id));
            }
            empservice.deleteBatch(del_ids);

        }else {
            Integer id= Integer.parseInt(ids);
            empservice.delectEmp(id);
        }
        return Msg.successs();
    }

}
