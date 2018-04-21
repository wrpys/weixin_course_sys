//package com.shirokumacafe.archetype.service;
//
//import com.shirokumacafe.archetype.common.mybatis.Page;
//import com.shirokumacafe.archetype.common.utilities.DateTimes;
//import com.shirokumacafe.archetype.repository.StudentMapper;
//import org.apache.commons.lang3.StringUtils;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//import org.springframework.transaction.annotation.Transactional;
//
//import java.util.Date;
//import java.util.List;
//
///**
// * Created with IntelliJ IDEA.
// * User: wrp
// * Date: 14-12-30
// * Time: 下午9:28
// * 课程
// */
//@Service
//@Transactional
//public class CourseService {
//
//    @Autowired
//    private CourseMapper courseMapper;
//    @Autowired
//    private ViewCourseMapper viewCourseMapper;
//    @Autowired
//    private CourseStudentMapper courseStudentMapper;
//    @Autowired
//    private CourseTimeMapper courseTimeMapper;
//    @Autowired
//    private StudentMapper studentMapper;
//
//    /**
//     * 添加
//     * @param course
//     */
//    public void add(Course course){
//        course.setcAttendTime(new Date());
//        courseMapper.insert(course);
//    }
//
//    /**
//     *批量删除
//     * @param ids
//     */
//    public void delete(List<Integer> ids){
//        CourseExample example = new CourseExample();
//        CourseExample.Criteria criteria = example.createCriteria();
//        criteria.andCIdIn(ids);
//        courseMapper.deleteByExample(example);
//    }
//
//    /**
//     * 修改课程
//     * @param course
//     */
//    public void update(Course course){
//        courseMapper.updateByPrimaryKeySelective(course);
//    }
//
//    /**
//     * 列表
//     * @param course
//     * @param startDate
//     * @param endDate
//     * @param page
//     * @return
//     */
//    public Page list(Course course, Date startDate, Date endDate, Page page){
//
//        ViewCourseExample example = new ViewCourseExample();
//        ViewCourseExample.Criteria criteria = example.createCriteria();
//        if (StringUtils.isNotBlank(course.getcName())){
//            criteria.andCNameLike("%"+course.getcName()+"%");
//        }
//        if (startDate!=null){
//            criteria.andCAttendTimeGreaterThanOrEqualTo(startDate);
//        }
//        if (endDate!=null){
//            criteria.andCAttendTimeLessThan(DateTimes.addDate(endDate,1));
//        }
//        List<ViewCourse> rows = viewCourseMapper.selectByExampleWithRowbounds(example,page.createRowBounds());
////        for (int i=0,len=rows.size();i<len;i++){
////            ViewCourse viewCourse =  rows.get(i);
////            AttendAddr attendAddr = attendAddrMapper.selectByPrimaryKey(viewCourse.getAaPid());
////            rows.get(i).setAaName(attendAddr.getAaName()+"-"+viewCourse.getAaName());
////        }
//        int results = viewCourseMapper.countByExample(example);
//        page.setRows(rows);
//        page.setResults(results);
//        return page;
//    }
//
//    /**
//     * 获取课程上课时间
//     * @param cId
//     * @return
//     */
//    public List<CourseTime> getCourseTimeByCId(Integer cId){
//        CourseTimeExample example = new CourseTimeExample();
//        CourseTimeExample.Criteria criteria = example.createCriteria();
//        criteria.andCIdEqualTo(cId);
//        return courseTimeMapper.selectByExample(example);
//    }
//
//    /**
//     *编辑上课时间
//     * @param cId
//     * @param ctIdAndTimes
//     */
//    public void updateCourseTime(Integer cId, List<String> ctIdAndTimes){
//        for (String ctIdAndTime : ctIdAndTimes){
//            String[] ctIdAndTimeArray = ctIdAndTime.split("\\=");
//            if("null".equals(ctIdAndTimeArray[0])){
//                CourseTime courseTime = new CourseTime();
//                courseTime.setcId(cId);
//                courseTime.setCtTime(DateTimes.convertFromString(ctIdAndTimeArray[1]).toDate());
//                courseTime.setIsAttendance(0);
//                courseTime.setIsWork(0);
//                courseTimeMapper.insert(courseTime);
//            }else{
//                continue;
//            }
//        }
//    }
//
//    /**
//     * 删除上课时间
//     * @param ctIds
//     */
//    public void deleteCourseTime(List<Integer> ctIds){
//        if(ctIds.size()>0){
//            CourseTimeExample example = new CourseTimeExample();
//            CourseTimeExample.Criteria criteria = example.createCriteria();
//            criteria.andCtIdIn(ctIds);
//            courseTimeMapper.deleteByExample(example);
//        }
//    }
//
//    /**
//     * 上课时间列表
//     * @param cId
//     * @param page
//     * @return
//     */
//    public Page courseTimeList(Integer cId, Page page){
//        CourseTimeExample example = new CourseTimeExample();
//        CourseTimeExample.Criteria criteria = example.createCriteria();
//        criteria.andCIdEqualTo(cId);
//        example.setOrderByClause("ct_time asc");
//        List<CourseTime> rows = courseTimeMapper.selectByExampleWithRowbounds(example,page.createRowBounds());
//        int resules = courseTimeMapper.countByExample(example);
//        page.setRows(rows);
//        page.setResults(resules);
//        return page;
//    }
//
//    /***
//     * 获取全部课程
//     * @return
//     */
//    public List<Course> findAll(){
//        return courseMapper.selectByExample(null);
//    }
//
//}
