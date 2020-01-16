package com.atguigu.crud.service;

import com.atguigu.crud.bean.Emp;
import com.atguigu.crud.bean.EmpExample;
import com.atguigu.crud.dao.EmpMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Empservice {



    @Autowired
    EmpMapper empMapper;
/**
 * 查询所有员工
 * */
    public List<Emp> getAll(){
        return empMapper.selectByExamplewithDept(null);
    }

    /**
     * 员工保存方法
     * */
    public void saveEmp(Emp emp) {
        empMapper.insertSelective(emp);
    }

    public boolean checkUser(String emName) {

        EmpExample example = new EmpExample();
        EmpExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(emName);
        long count = empMapper.countByExample(example);

        return  count==0;

    }

    /**
     * 按照员工id查询
     * */
    public Emp getEmp(Integer id) {
        Emp emp = empMapper.selectByPrimaryKey(id);

        return emp;
    }

    //员工更新
    public void Updateemp(Emp emp) {
        empMapper.updateByPrimaryKeySelective(emp);
    }

    //员工删除
    public void delectEmp(Integer id) {
        empMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {

        EmpExample example = new EmpExample();
        EmpExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);

        empMapper.deleteByExample(example);
    }
}
