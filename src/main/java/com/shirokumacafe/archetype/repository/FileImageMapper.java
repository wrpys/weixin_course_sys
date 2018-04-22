package com.shirokumacafe.archetype.repository;

import com.shirokumacafe.archetype.entity.FileImage;

public interface FileImageMapper {
    int deleteByPrimaryKey(Integer fiId);

    int insert(FileImage record);

    int insertSelective(FileImage record);

    FileImage selectByPrimaryKey(Integer fiId);

    int updateByPrimaryKeySelective(FileImage record);

    int updateByPrimaryKey(FileImage record);
}