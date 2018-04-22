package com.shirokumacafe.archetype.repository;

import com.shirokumacafe.archetype.entity.File;

public interface FileMapper {
    int deleteByPrimaryKey(Integer fId);

    int insert(File record);

    int insertAndGetId(File record);
    
    int insertSelective(File record);

    File selectByPrimaryKey(Integer fId);

    int updateByPrimaryKeySelective(File record);

    int updateByPrimaryKey(File record);
}