package com.shirokumacafe.archetype.service;

import com.github.pagehelper.PageHelper;
import com.shirokumacafe.archetype.common.Configs;
import com.shirokumacafe.archetype.common.Users;
import com.shirokumacafe.archetype.common.mybatis.Page;
import com.shirokumacafe.archetype.common.utilities.Responses;
import com.shirokumacafe.archetype.entity.Student;
import com.shirokumacafe.archetype.repository.StudentMapper;
import org.apache.commons.lang3.StringUtils;
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
     * @param student
     * @param page
     * @return
     */
    public Page<Student> findPage(Student student, Page page) {
        com.github.pagehelper.Page pageHelper = PageHelper.startPage(page.getPageIndex(), page.getLimit());
        List<Student> rows = studentMapper.selectByParams(student);
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

    public Map binding(String weixinId, String account) {

        Student params = new Student();
        params.setWeixinId(weixinId);
        List<Student> students1 = studentMapper.selectByParams(params);
        if (students1 != null && !students1.isEmpty()) {
            if (!students1.get(0).getsNo().equals(account)) {
                return Responses.writeFailAndMsg("你的微信号【" + weixinId + "】已经绑定过学号，请联系管理员进行进行更换.");
            }
        }

        List<Student> students2 = studentMapper.selectBySNo(account);
        if (students2 == null || students2.isEmpty()) {
            return Responses.writeFailAndMsg("你填的学号不存在.");
        }
        Student student = students2.get(0);
        if (StringUtils.isNotEmpty(student.getWeixinId()) && !weixinId.equals(student.getWeixinId())) {
            return Responses.writeFailAndMsg("你填的学号【" + account + "】已经绑定过其他微信号，请联系管理员进行进行更换.");
        }

        student.setWeixinId(weixinId);
        int count = studentMapper.updateByPrimaryKeySelective(student);
        if (count < 1) {
            return Responses.writeFailAndMsg("修改失败，请重试.");
        } else {
            return Responses.writeSuccess();
        }
    }

}
