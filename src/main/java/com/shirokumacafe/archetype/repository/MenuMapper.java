package com.shirokumacafe.archetype.repository;

import com.shirokumacafe.archetype.entity.Menu;
import com.shirokumacafe.archetype.entity.MenuExample;
import java.util.List;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.DeleteProvider;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.InsertProvider;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.annotations.UpdateProvider;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.type.JdbcType;

public interface MenuMapper {
    @SelectProvider(type=MenuSqlProvider.class, method="countByExample")
    int countByExample(MenuExample example);

    @DeleteProvider(type=MenuSqlProvider.class, method="deleteByExample")
    int deleteByExample(MenuExample example);

    @Delete({
        "delete from t_menu",
        "where menu_id = #{menuId,jdbcType=INTEGER}"
    })
    int deleteByPrimaryKey(Integer menuId);

    @Insert({
        "insert into t_menu (menu_code, menu_pid, ",
        "menu_name, menu_link, ",
        "sort, state)",
        "values (#{menuCode,jdbcType=VARCHAR}, #{menuPid,jdbcType=INTEGER}, ",
        "#{menuName,jdbcType=VARCHAR}, #{menuLink,jdbcType=VARCHAR}, ",
        "#{sort,jdbcType=INTEGER}, #{state,jdbcType=INTEGER})"
    })
    @SelectKey(statement="SELECT @@IDENTITY", keyProperty="menuId", before=false, resultType=Integer.class)
    int insert(Menu record);

    @InsertProvider(type=MenuSqlProvider.class, method="insertSelective")
    @SelectKey(statement="SELECT @@IDENTITY", keyProperty="menuId", before=false, resultType=Integer.class)
    int insertSelective(Menu record);

    @SelectProvider(type=MenuSqlProvider.class, method="selectByExample")
    @Results({
        @Result(column="menu_id", property="menuId", jdbcType=JdbcType.INTEGER, id=true),
        @Result(column="menu_code", property="menuCode", jdbcType=JdbcType.VARCHAR),
        @Result(column="menu_pid", property="menuPid", jdbcType=JdbcType.INTEGER),
        @Result(column="menu_name", property="menuName", jdbcType=JdbcType.VARCHAR),
        @Result(column="menu_link", property="menuLink", jdbcType=JdbcType.VARCHAR),
        @Result(column="sort", property="sort", jdbcType=JdbcType.INTEGER),
        @Result(column="state", property="state", jdbcType=JdbcType.INTEGER)
    })
    List<Menu> selectByExampleWithRowbounds(MenuExample example, RowBounds rowBounds);

    @SelectProvider(type=MenuSqlProvider.class, method="selectByExample")
    @Results({
        @Result(column="menu_id", property="menuId", jdbcType=JdbcType.INTEGER, id=true),
        @Result(column="menu_code", property="menuCode", jdbcType=JdbcType.VARCHAR),
        @Result(column="menu_pid", property="menuPid", jdbcType=JdbcType.INTEGER),
        @Result(column="menu_name", property="menuName", jdbcType=JdbcType.VARCHAR),
        @Result(column="menu_link", property="menuLink", jdbcType=JdbcType.VARCHAR),
        @Result(column="sort", property="sort", jdbcType=JdbcType.INTEGER),
        @Result(column="state", property="state", jdbcType=JdbcType.INTEGER)
    })
    List<Menu> selectByExample(MenuExample example);

    @Select({
        "select",
        "menu_id, menu_code, menu_pid, menu_name, menu_link, sort, state",
        "from t_menu",
        "where menu_id = #{menuId,jdbcType=INTEGER}"
    })
    @Results({
        @Result(column="menu_id", property="menuId", jdbcType=JdbcType.INTEGER, id=true),
        @Result(column="menu_code", property="menuCode", jdbcType=JdbcType.VARCHAR),
        @Result(column="menu_pid", property="menuPid", jdbcType=JdbcType.INTEGER),
        @Result(column="menu_name", property="menuName", jdbcType=JdbcType.VARCHAR),
        @Result(column="menu_link", property="menuLink", jdbcType=JdbcType.VARCHAR),
        @Result(column="sort", property="sort", jdbcType=JdbcType.INTEGER),
        @Result(column="state", property="state", jdbcType=JdbcType.INTEGER)
    })
    Menu selectByPrimaryKey(Integer menuId);

    @UpdateProvider(type=MenuSqlProvider.class, method="updateByExampleSelective")
    int updateByExampleSelective(@Param("record") Menu record, @Param("example") MenuExample example);

    @UpdateProvider(type=MenuSqlProvider.class, method="updateByExample")
    int updateByExample(@Param("record") Menu record, @Param("example") MenuExample example);

    @UpdateProvider(type=MenuSqlProvider.class, method="updateByPrimaryKeySelective")
    int updateByPrimaryKeySelective(Menu record);

    @Update({
        "update t_menu",
        "set menu_code = #{menuCode,jdbcType=VARCHAR},",
          "menu_pid = #{menuPid,jdbcType=INTEGER},",
          "menu_name = #{menuName,jdbcType=VARCHAR},",
          "menu_link = #{menuLink,jdbcType=VARCHAR},",
          "sort = #{sort,jdbcType=INTEGER},",
          "state = #{state,jdbcType=INTEGER}",
        "where menu_id = #{menuId,jdbcType=INTEGER}"
    })
    int updateByPrimaryKey(Menu record);
}