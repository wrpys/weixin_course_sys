package com.shirokumacafe.archetype.repository;

import com.shirokumacafe.archetype.entity.Student;
import com.shirokumacafe.archetype.entity.StudentExt;
import com.shirokumacafe.archetype.entity.Work;

import java.util.List;

public interface StudentMapper {
    int deleteByPrimaryKey(Integer sId);

    int insert(Student record);

    int insertSelective(Student record);

    Student selectByPrimaryKey(Integer sId);

    int updateByPrimaryKeySelective(Student record);

    int updateByPrimaryKey(Student record);

    List<Student> getWorkAnalysis(Work work);

    List<StudentExt> selectStudentExtByParams(StudentExt studentExt);

    List<Student> selectByParams(Student student);

    List<Student> selectBySNo(String sNo);
}