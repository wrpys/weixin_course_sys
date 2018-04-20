package com.shirokumacafe.archetype.repository;

import com.shirokumacafe.archetype.entity.StuQuestion;
import com.shirokumacafe.archetype.entity.StuQuestionExt;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StuQuestionMapper {
    int deleteByPrimaryKey(Integer sqId);

    int insert(StuQuestion record);

    int insertSelective(StuQuestion record);

    StuQuestion selectByPrimaryKey(Integer sqId);

    int updateByPrimaryKeySelective(StuQuestion record);

    int updateByPrimaryKey(StuQuestion record);

    List<StuQuestionExt> getQuestionDesc(@Param("wId") Integer wId, @Param("sId") Integer sId);

}