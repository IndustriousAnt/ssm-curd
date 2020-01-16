package com.atguigu.crud.service;

import com.atguigu.crud.bean.Dept;
import com.atguigu.crud.dao.DeptMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Deptservice {
    @Autowired
    private DeptMapper deptMapper;

    public List<Dept> getDepts() {
        List<Dept> depts = deptMapper.selectByExample(null);
        return depts;
    }
}
