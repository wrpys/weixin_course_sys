package com.shirokumacafe.archetype.repository;

import com.shirokumacafe.archetype.entity.WorkQuestion;
import com.shirokumacafe.archetype.entity.WorkQuestionExt;

import java.util.List;

public interface WorkQuestionMapper {
    int deleteByPrimaryKey(Integer wqId);

    int insert(WorkQuestion record);

    int insertSelective(WorkQuestion record);

    WorkQuestion selectByPrimaryKey(Integer wqId);

    int updateByPrimaryKeySelective(WorkQuestion record);

    int updateByPrimaryKey(WorkQuestion record);

    List<WorkQuestionExt> findWorkQuestionExtByParams(WorkQuestionExt workQuestionExt);

}