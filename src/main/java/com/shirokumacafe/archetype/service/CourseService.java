package com.shirokumacafe.archetype.service;

import com.github.pagehelper.PageHelper;
import com.shirokumacafe.archetype.common.mybatis.Page;
import com.shirokumacafe.archetype.entity.Course;
import com.shirokumacafe.archetype.entity.FileImage;
import com.shirokumacafe.archetype.repository.CourseMapper;
import com.shirokumacafe.archetype.repository.FileImageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 课程
 */
@Service
@Transactional
public class CourseService {

    @Autowired
    private CourseMapper courseMapper;
    @Autowired
    private FileImageMapper fileImageMapper;

    /**
     * 添加
     * @param course
     */
    public void add(Course course){
        course.setcCreateTime(new Date());
        course.setDownloadNum(0);
        course.setHeatNum(0);
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
    	paramsMap.put("cId", course.getcId());
    	paramsMap.put("cPid", course.getcPid());
    	paramsMap.put("cName", course.getcName());
    	paramsMap.put("startDate", startDate);
    	paramsMap.put("endDate", endDate);
        List<Course> courseList = courseMapper.listByParams(paramsMap);
        page.setRows(courseList);
        page.setResults((int) pageHelper.getTotal());
        return page;
    }

    /**
     * 根据课程ID 获取课程和图片
     * @param cId
     * @return
     */
    public Course getCourseAndImageByCId(Integer cId) {
        Course course = courseMapper.selectByPrimaryKey(cId);
        course.setcPName(courseMapper.selectByPrimaryKey(course.getcPid()).getcName());
        FileImage fileImage = fileImageMapper.selectByFid(course.getfId());
        File file = new File(fileImage.getFiAddr());
        if (file.exists()) {
            File[] files = file.listFiles();
            List<String> fileImageList = new ArrayList<>();
            for (int i = 0; i < files.length; i++) {
                String[] fileNames = files[i].getAbsolutePath().split("file");
                fileImageList.add("/file" + fileNames[1]);
            }
            Collections.sort(fileImageList);
            course.setFileImageList(fileImageList);
        }
        return course;
    }

}
