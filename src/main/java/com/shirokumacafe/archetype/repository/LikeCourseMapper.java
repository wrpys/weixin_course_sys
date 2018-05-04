package com.shirokumacafe.archetype.repository;

import com.shirokumacafe.archetype.entity.LikeCourse;

public interface LikeCourseMapper {

    int deleteByParams(LikeCourse record);

    int insertSelective(LikeCourse record);

    LikeCourse selectByParams(LikeCourse record);

}