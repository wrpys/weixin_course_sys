package com.shirokumacafe.archetype.repository;

import com.shirokumacafe.archetype.entity.Message;
import com.shirokumacafe.archetype.entity.MessageExt;

import java.util.List;

public interface MessageMapper {
    int deleteByPrimaryKey(Integer msgId);

    int insert(Message record);

    int insertSelective(Message record);

    Message selectByPrimaryKey(Integer msgId);

    int updateByPrimaryKeySelective(Message record);

    int updateByPrimaryKey(Message record);

    List<MessageExt> selectMessageExtByParams(MessageExt messageExt);

    List<MessageExt> selectMyInfoMessageExtByParams(MessageExt messageExt);

}