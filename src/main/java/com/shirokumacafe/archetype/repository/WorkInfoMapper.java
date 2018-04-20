package com.shirokumacafe.archetype.repository;

import java.util.List;

import com.shirokumacafe.archetype.entity.WorkInfo;

public interface WorkInfoMapper {
    int deleteByPrimaryKey(Integer wiId);

    int insert(WorkInfo record);

    int insertSelective(WorkInfo record);

    WorkInfo selectByPrimaryKey(Integer wiId);

    int updateByPrimaryKeySelective(WorkInfo record);

    int updateByPrimaryKey(WorkInfo record);

	WorkInfo getWorkInfoByWiIdAndStuId(WorkInfo workInfo);

	WorkInfo getWorkInfoByWIdAndStuId(WorkInfo workInfo);

	List<WorkInfo> getWorkInfosByWorkId(Integer workId);
}