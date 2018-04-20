package com.shirokumacafe.archetype.repository;

import com.shirokumacafe.archetype.entity.Question;

import java.util.List;

public interface QuestionMapper {
    int deleteByPrimaryKey(Integer qId);

    int insert(Question record);

    int insertSelective(Question record);

    Question selectByPrimaryKey(Integer qId);

    int updateByPrimaryKeySelective(Question record);

    int updateByPrimaryKey(Question record);

    List<Question> selectByParams(Question question);

}