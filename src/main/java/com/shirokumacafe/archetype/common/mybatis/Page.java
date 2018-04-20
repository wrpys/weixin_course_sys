package com.shirokumacafe.archetype.common.mybatis;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.apache.ibatis.session.RowBounds;

import java.util.ArrayList;
import java.util.List;

/**
 * 分页
 * @author wrp
 */
public class Page<T> {

    private int results;

    private List<T> rows=new ArrayList<T>();

    private int start;

    private int limit = 10;

    private int totalPage ;
    
    private int pageIndex;

    private Boolean hasError;

    private String error;

    public Page(){

    }

    public Page(int start, int limit){
        this.start=start;
        this.limit=limit;
    }

    public RowBounds createRowBounds(){
        RowBounds rowBounds=new RowBounds(start,limit);
        return  rowBounds;
    }

    public int getResults() {
        return results;
    }

    public void setResults(int results) {
        this.results = results;
    }

    public List<T> getRows() {
        return rows;
    }

    public void setRows(List<T> rows) {
        this.rows = rows;
    }

    public void setHasError(Boolean hasError) {
        this.hasError = hasError;
    }

    public void setError(String error) {
        this.error = error;
    }

    @JsonIgnore
    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    @JsonIgnore
    public int getLimit() {
        return limit;
    }

    public void setLimit(int limit) {
        this.limit = limit;
    }

    @JsonIgnore
    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int total) {
        try {
            this.totalPage= ((total-1)/limit) + 1;//计算总页数
        } catch (Exception e) {

        }
    }

    public int getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex + 1;
    }
}
