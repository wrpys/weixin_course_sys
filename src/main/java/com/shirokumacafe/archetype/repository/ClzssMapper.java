package com.shirokumacafe.archetype.repository;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.shirokumacafe.archetype.entity.Clzss;

/**
 * 班级管理mapper
 * @author CZX
 *
 */
public interface ClzssMapper {
	
	int deleteByPrimaryKey(Integer id);
	
	void deleteClzssList(List<Integer> ids);

    int insert(Clzss record);

    int insertSelective(Clzss record);

    Clzss selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Clzss record);

    int updateByPrimaryKey(Clzss record);
    
    List<Clzss> findAll();
    
    Clzss selectClzssByGradeAndClzss(@Param("grade")String grade,@Param("clzss")String clzss);
}
