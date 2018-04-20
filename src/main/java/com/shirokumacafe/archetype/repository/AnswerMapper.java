package com.shirokumacafe.archetype.repository;

import com.shirokumacafe.archetype.entity.Answer;

import java.util.List;

public interface AnswerMapper {
    int deleteByPrimaryKey(Integer aId);

    int insert(Answer record);

    int insertSelective(Answer record);

    Answer selectByPrimaryKey(Integer aId);

    int updateByPrimaryKeySelective(Answer record);

    int updateByPrimaryKey(Answer record);

    List<Answer> selectByParams(Answer answer);
}