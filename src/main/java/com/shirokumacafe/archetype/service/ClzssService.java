package com.shirokumacafe.archetype.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.shirokumacafe.archetype.entity.Clzss;
import com.shirokumacafe.archetype.repository.ClzssMapper;


/**
 * 班级管理
 * @author CZX
 *
 */
@Service
@Transactional
public class ClzssService {

    @Autowired
    private ClzssMapper clzssMapper;

    /**
     * 获取所有班级
     * @return
     */
    public List<Clzss> findAll(){
        return clzssMapper.findAll();
    }

    /**
     * 添加
     * @param Clzss
     */
    public void add(Clzss Clzss){
        clzssMapper.insert(Clzss);
    }

    /**
     *修改
     * @param Clzss
     */
    public void update(Clzss Clzss){
        clzssMapper.updateByPrimaryKeySelective(Clzss);
    }

    /**
     *删除
     * @param dId
     */
    public void delete(List<Integer> ids){
        clzssMapper.deleteClzssList(ids);
    }

}
