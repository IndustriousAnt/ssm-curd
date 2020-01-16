package com.atguigu.crud.test;

import com.atguigu.crud.bean.Dept;
import com.atguigu.crud.bean.Emp;
import com.atguigu.crud.dao.DeptMapper;
import com.atguigu.crud.dao.EmpMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
* 测试dao层的工作
* */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class mappertest {
    @Autowired
    DeptMapper deptMapper;
    @Autowired
    EmpMapper empMapper;
    @Autowired
    SqlSession sqlSession;
    /**
     * 测试DeptMapper
     * */
    @Test
    public void testcrud(){

       /* ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
        ioc.getBean(DeptMapper.class);*/
    /*;
    deptMapper.insertSelective(new Dept(null,"开发部"));
    deptMapper.insertSelective(new Dept(null,"测试部"));
    */
   /* System.out.println(empMapper);
    empMapper.insertSelective(new Emp(null,"Jerry","M","Jerry@atguigu.com",1));
*/
        EmpMapper mapper = sqlSession.getMapper(EmpMapper.class);
        for (int i = 0; i < 1000; i++) {
           String uid= UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Emp(null,uid,"M",uid+"@atguigu.com",1));
        }
        System.out.println("批量完成");
    }
}
