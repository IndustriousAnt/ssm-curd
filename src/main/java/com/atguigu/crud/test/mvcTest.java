package com.atguigu.crud.test;


import com.atguigu.crud.bean.Emp;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.htmlunit.MockMvcWebClientBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;
/*
 * 使用spring测试模块提供的测试请求，
 * spring4测试的时候，需要servlet3.0的支持
 * */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:spring-servlet.xml"})
public class mvcTest {
    @Autowired
    WebApplicationContext Context;
    MockMvc mockMvc;
    @Before
    public  void initMokcmvc(){

        mockMvc = MockMvcBuilders.webAppContextSetup(Context).build();
    }
    @Test
    public  void testPage() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5")).andReturn();
    //请求成功后，请求域中会有pageInfo,我们取出pageInfo
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi =(PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页："+pi.getPageNum());
        System.out.println("总页码："+pi.getPages());
        System.out.println("总记录数:"+pi.getTotal());
        System.out.println("连续显示的页码");
        int[] navigatepageNums = pi.getNavigatepageNums();
        for (int i:navigatepageNums) {
            System.out.print(" "+i);
        }
        System.out.println();
        //获取员工数据
        List<Emp> list = pi.getList();
        for (Emp emp:list) {
            System.out.println("Id:"+emp.getEmpId()+"==>Name:"+emp.getEmpName());

        }
    }

}
