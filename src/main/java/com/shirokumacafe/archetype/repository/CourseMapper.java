package com.shirokumacafe.archetype.repository;

import java.util.List;
import java.util.Map;

import com.shirokumacafe.archetype.entity.Course;
import com.shirokumacafe.archetype.entity.CourseExt;

public interface CourseMapper {
    int deleteByPrimaryKey(Integer cId);

    int insert(Course record);

    int insertSelective(Course record);

    Course selectByPrimaryKey(Integer cId);

    int updateByPrimaryKeySelective(Course record);

    int updateByPrimaryKey(Course record);

	void deleteCourseList(List<Integer> ids);

	List<CourseExt> listByParams(Map<String, Object> paramsMap);

    List<Course> getSubCourseListByCid(Integer cId);
}