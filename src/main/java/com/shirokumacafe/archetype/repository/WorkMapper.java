package com.shirokumacafe.archetype.repository;

import java.util.List;

import com.shirokumacafe.archetype.entity.Question;
import com.shirokumacafe.archetype.entity.Work;
import com.shirokumacafe.archetype.entity.WorkExt;
import org.apache.ibatis.annotations.Param;

public interface WorkMapper {
    int deleteByPrimaryKey(Integer wId);

    int insert(Work record);

    int insertSelective(Work record);

    Work selectByPrimaryKey(Integer wId);

    int updateByPrimaryKeySelective(Work record);

    int updateByPrimaryKey(Work record);

	void deleteWorkList(List<Integer> ids);
	
	List<Work> selectByParams(Work work);

	List<WorkExt> selectByExtParams(Work work);

    List<Question> getQuestionAnswers(@Param("workId")int workId, @Param("stuId")int stuId);
}