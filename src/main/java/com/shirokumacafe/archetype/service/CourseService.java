package com.shirokumacafe.archetype.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.github.pagehelper.PageHelper;
import com.shirokumacafe.archetype.common.mybatis.Page;
import com.shirokumacafe.archetype.entity.Course;
import com.shirokumacafe.archetype.repository.CourseMapper;

/**
 * 课程
 */
@Service
@Transactional
public class CourseService {

    @Autowired
    private CourseMapper courseMapper;

    /**
     * 添加
     * @param course
     */
    public void add(Course course){
        course.setcCreateTime(new Date());
    	courseMapper.insert(course);
    }

    /**
     *批量删除
     * @param ids
     */
    public void deleteCourseList(List<Integer> ids){
        courseMapper.deleteCourseList(ids);
    }

    /**
     * 修改课程
     * @param course
     */
    public void update(Course course){
        courseMapper.updateByPrimaryKeySelective(course);
    }

    /**
     * 获取父课程或者子课程列表
     * @param course
     * @param startDate
     * @param endDate
     * @param page
     * @return
     */
    public Page<Course> listCourse(Course course, Date startDate, Date endDate, Page<Course> page){
    	com.github.pagehelper.Page<?> pageHelper = PageHelper.startPage(page.getPageIndex(), page.getLimit());
    	Map<String,Object> paramsMap = new HashMap<>();
    	paramsMap.put("cName", course.getcName());
    	paramsMap.put("startDate", startDate);
    	paramsMap.put("endDate", endDate);
        List<Course> courseList = courseMapper.listByParams(paramsMap);
        page.setRows(courseList);
        page.setResults((int) pageHelper.getTotal());
        return page;
    }
    
    
    

}
