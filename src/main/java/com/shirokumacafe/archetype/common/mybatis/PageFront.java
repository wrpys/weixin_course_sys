package com.shirokumacafe.archetype.common.mybatis;
import org.apache.ibatis.session.RowBounds;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

/**
 * 分页
 * @author wrp
 */
public class PageFront<T> {

    private int results;

    private List<T> rows=new ArrayList<T>();

    private int limit = 10;

    private int totalPage ;

    private int currentpage = 1;


    public PageFront(){

    }

    public PageFront(int limit){
        this.limit=limit;
    }

    public RowBounds createRowBounds(){
        RowBounds rowBounds=new RowBounds((currentpage-1)*limit,limit);
        return  rowBounds;
    }

    public int getResults() {
        return results;
    }

    /**
     * 分页工具条
     * @param pageFront
     * @param request
     * @return
     */
    public static void pagetoolFront(PageFront pageFront,HttpServletRequest request) {

        StringBuffer str = new StringBuffer();

        String url = getParamUrl(request);

        int currentpage = pageFront.getCurrentpage(); //当前页
        int pagecount = pageFront.getTotalPage(); //总页数

        int propage = currentpage - 1;   //上一页
        int nextpage = currentpage + 1;  //下一页

        /**
         * 判断url中是否包含=
         * 如果不包含= 则currentpage则为第一个参数,前面就不用加&
         */
        if (url.indexOf("=") != -1) {
            url = url + "&";
        }

        //判断是否有上一页
        if (currentpage > 1) {
            str.append("<li><a href='"+url+"currentpage="+propage+"'>&laquo;</a></li>");
        }else {
            str.append("<li class='disabled'><a href='javascript:;'>&laquo;</a></li>");
        }

        if (pagecount <= 9) {
            //总页数小等于9页
            for (int i = 1; i <= pagecount; i++) {
                if (currentpage == i) {
                    str.append("<li  class='active'><a href='javascript:;'>" + i + "</a></li>");
                } else {
                    str.append("<li><a href='" + url + "currentpage=" + i + "'>"+ i + "</a></li>");
                }
            }
        }else{
            //总页数超过9页
            if(currentpage<=4){
                //当前页小于等于4的时候。显示（1~7...最后一页如：1 2 3 4 5 6 7 ... 15）
                for(int i=1;i<=7;i++){
                    if (currentpage == i) {
                        str.append("<li class='active'><a href='javascript:;'>" + i + "</a></li>");
                    } else {
                        str.append("<li><a href='" + url + "currentpage=" + i + "'>"+ i + "</a></li>");
                    }
                }
                str.append("<li><a>&#183;&#183;&#183;</a><li>");
                str.append("<li><a href='" + url + "currentpage=" + pagecount + "'>" + pagecount + "</a></li>");
            }else if((currentpage+5)<=pagecount){
                str.append("<li><a href='" + url + "currentpage=1'>1</a></li>");
                str.append("<li><a>&#183;&#183;&#183;</a></li>");
                for(int i=(currentpage-2);i<=(currentpage+2);i++){
                    if (currentpage == i) {
                            str.append("<li  class='active'><a href='javascript:;'>" + i + "</a></li>");
                    } else {
                        str.append("<li><a href='" + url + "currentpage=" + i + "'>"+ i + "</a></li>");
                    }
                }
                str.append("<li><a>&#183;&#183;&#183;</a></li>");
                str.append("<li><a href='" + url + "currentpage=" + pagecount + "'>" + pagecount + "</a></li>");
            }else{
                str.append("<li><a href='" + url + "currentpage=1'>1</a></li>");
                str.append("<li><a class='page_other_no'>&#183;&#183;&#183;</a></li>");
                for(int i=(pagecount-6);i<=pagecount;i++){
                    if (currentpage == i) {
                        str.append("<li  class='active'><a href='javascript:;'>" + i + "</a></li>");
                    } else {
                        str.append("<li><a href='" + url + "currentpage=" + i + "'>"+ i + "</a></li>");
                    }
                }
            }
        }
        // 判断下一页
        if (currentpage < pagecount) {
            str.append("<li><a href='" + url + "currentpage=" + nextpage + "'>&raquo;</a></li>");
        }else{
            str.append("<li class='disabled'><a href='javascript:;'>&raquo;</a></li>");
        }

        request.setAttribute("pageBar",str.toString());
    }


    /**
     * 获取url
     * @param request
     * @return
     */
    public static String getParamUrl(HttpServletRequest request) {
        String url = "";
        url = request.getRequestURI().toString();
        if (url.indexOf("?") == -1) {
            url = url + "?";
        }
        String totalParams = "";
        Enumeration params = request.getParameterNames();// 得到所有参数名
        while (params.hasMoreElements()) {
            String tempName = params.nextElement().toString();
            String tempValue = request.getParameter(tempName);
            if (tempValue != null && !tempValue.equals("") && !tempName.startsWith("currentpage")) {
                if (totalParams.equals("")) {
                    totalParams = totalParams + tempName + "=" + tempValue;
                } else {
                    totalParams = totalParams + "&" + tempName + "=" + tempValue;
                }
            }
        }
        String totalUrl = url + totalParams;
        if(totalUrl != null && !totalUrl.equals("")){
            totalUrl = totalUrl.replaceAll("'", "&#39;");
        }

        return totalUrl;
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

    public int getLimit() {
        return limit;
    }

    public void setLimit(int limit) {
        this.limit = limit;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int total) {
        try {
            this.totalPage= ((total-1)/limit) + 1;//计算总页数
        } catch (Exception e) {

        }
    }

    public int getCurrentpage() {
        return currentpage;
    }

    public void setCurrentpage(int currentpage) {
        this.currentpage = currentpage;
    }

}
