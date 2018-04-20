package com.shirokumacafe.archetype.service;

import com.github.pagehelper.PageHelper;
import com.shirokumacafe.archetype.common.Configs;
import com.shirokumacafe.archetype.common.Users;
import com.shirokumacafe.archetype.common.mybatis.Page;
import com.shirokumacafe.archetype.common.utilities.Responses;
import com.shirokumacafe.archetype.entity.Student;
import com.shirokumacafe.archetype.entity.StudentExt;
import com.shirokumacafe.archetype.repository.StudentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * 学生信息
 * User: wrp
 * Date: 14-12-18
 * Time: 下午10:51
 */
@Service
@Transactional
public class StudentService {

    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private Users sessionUsers;

    /**
     * 增加学生  默认密码123456
     *
     * @param student
     */
    public void add(Student student) {
        student.setUserRole(Configs.CUSTOMER_STUDENT);
        student.setsPassword(Configs.DEFAULT_PASSWORD);
        studentMapper.insert(student);
    }

    /**
     * 删除
     *
     * @param sId
     */
    public void delete(Integer sId) {
        studentMapper.deleteByPrimaryKey(sId);
    }

    /**
     * 修改
     *
     * @param student
     */
    public void update(Student student) {
        studentMapper.updateByPrimaryKeySelective(student);
    }

    /**
     * 分页查找
     *
     * @param studentExt
     * @param page
     * @return
     */
    public Page<StudentExt> findPage(StudentExt studentExt, Page page) {
        com.github.pagehelper.Page pageHelper = PageHelper.startPage(page.getPageIndex(), page.getLimit());
        List<StudentExt> rows = studentMapper.selectStudentExtByParams(studentExt);
        page.setRows(rows);
        page.setResults(Integer.valueOf(String.valueOf(pageHelper.getTotal())));
        return page;
    }

    /**
     * 批量重置密码
     */
    public void resetPassword(Integer sId) {
        Student student = new Student();
        student.setsId(sId);
        student.setsPassword(Configs.DEFAULT_PASSWORD);
        studentMapper.updateByPrimaryKeySelective(student);
    }

    /*****************************h5前台**************************************************************/

    public Map checkLogin(String sNo, String sPassword) {
        List<Student> students = studentMapper.selectBySNo(sNo);
        if (students == null || students.isEmpty()) {
            return Responses.writeFailAndMsg("学号不存在.");
        }
        Student student = students.get(0);
        if (!student.getsPassword().equals(sPassword)) {
            return Responses.writeFailAndMsg("学号/密码错误.");
        }
        sessionUsers.setStudent(student);
        return Responses.writeSuccess();
    }

}
