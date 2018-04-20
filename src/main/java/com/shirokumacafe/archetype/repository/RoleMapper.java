package com.shirokumacafe.archetype.repository;

import com.shirokumacafe.archetype.entity.Role;
import com.shirokumacafe.archetype.entity.RoleExample;
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

public interface RoleMapper {
    @SelectProvider(type=RoleSqlProvider.class, method="countByExample")
    int countByExample(RoleExample example);

    @DeleteProvider(type=RoleSqlProvider.class, method="deleteByExample")
    int deleteByExample(RoleExample example);

    @Delete({
        "delete from t_role",
        "where role_id = #{roleId,jdbcType=INTEGER}"
    })
    int deleteByPrimaryKey(Integer roleId);

    @Insert({
        "insert into t_role (role_code, role_name, ",
        "sys, remark, state, ",
        "create_id, update_id, ",
        "create_time, update_time)",
        "values (#{roleCode,jdbcType=VARCHAR}, #{roleName,jdbcType=VARCHAR}, ",
        "#{sys,jdbcType=INTEGER}, #{remark,jdbcType=VARCHAR}, #{state,jdbcType=INTEGER}, ",
        "#{createId,jdbcType=INTEGER}, #{updateId,jdbcType=INTEGER}, ",
        "#{createTime,jdbcType=TIMESTAMP}, #{updateTime,jdbcType=TIMESTAMP})"
    })
    @SelectKey(statement="SELECT @@IDENTITY", keyProperty="roleId", before=false, resultType=Integer.class)
    int insert(Role record);

    @InsertProvider(type=RoleSqlProvider.class, method="insertSelective")
    @SelectKey(statement="SELECT @@IDENTITY", keyProperty="roleId", before=false, resultType=Integer.class)
    int insertSelective(Role record);

    @SelectProvider(type=RoleSqlProvider.class, method="selectByExample")
    @Results({
        @Result(column="role_id", property="roleId", jdbcType=JdbcType.INTEGER, id=true),
        @Result(column="role_code", property="roleCode", jdbcType=JdbcType.VARCHAR),
        @Result(column="role_name", property="roleName", jdbcType=JdbcType.VARCHAR),
        @Result(column="sys", property="sys", jdbcType=JdbcType.INTEGER),
        @Result(column="remark", property="remark", jdbcType=JdbcType.VARCHAR),
        @Result(column="state", property="state", jdbcType=JdbcType.INTEGER),
        @Result(column="create_id", property="createId", jdbcType=JdbcType.INTEGER),
        @Result(column="update_id", property="updateId", jdbcType=JdbcType.INTEGER),
        @Result(column="create_time", property="createTime", jdbcType=JdbcType.TIMESTAMP),
        @Result(column="update_time", property="updateTime", jdbcType=JdbcType.TIMESTAMP)
    })
    List<Role> selectByExampleWithRowbounds(RoleExample example, RowBounds rowBounds);

    @SelectProvider(type=RoleSqlProvider.class, method="selectByExample")
    @Results({
        @Result(column="role_id", property="roleId", jdbcType=JdbcType.INTEGER, id=true),
        @Result(column="role_code", property="roleCode", jdbcType=JdbcType.VARCHAR),
        @Result(column="role_name", property="roleName", jdbcType=JdbcType.VARCHAR),
        @Result(column="sys", property="sys", jdbcType=JdbcType.INTEGER),
        @Result(column="remark", property="remark", jdbcType=JdbcType.VARCHAR),
        @Result(column="state", property="state", jdbcType=JdbcType.INTEGER),
        @Result(column="create_id", property="createId", jdbcType=JdbcType.INTEGER),
        @Result(column="update_id", property="updateId", jdbcType=JdbcType.INTEGER),
        @Result(column="create_time", property="createTime", jdbcType=JdbcType.TIMESTAMP),
        @Result(column="update_time", property="updateTime", jdbcType=JdbcType.TIMESTAMP)
    })
    List<Role> selectByExample(RoleExample example);

    @Select({
        "select",
        "role_id, role_code, role_name, sys, remark, state, create_id, update_id, create_time, ",
        "update_time",
        "from t_role",
        "where role_id = #{roleId,jdbcType=INTEGER}"
    })
    @Results({
        @Result(column="role_id", property="roleId", jdbcType=JdbcType.INTEGER, id=true),
        @Result(column="role_code", property="roleCode", jdbcType=JdbcType.VARCHAR),
        @Result(column="role_name", property="roleName", jdbcType=JdbcType.VARCHAR),
        @Result(column="sys", property="sys", jdbcType=JdbcType.INTEGER),
        @Result(column="remark", property="remark", jdbcType=JdbcType.VARCHAR),
        @Result(column="state", property="state", jdbcType=JdbcType.INTEGER),
        @Result(column="create_id", property="createId", jdbcType=JdbcType.INTEGER),
        @Result(column="update_id", property="updateId", jdbcType=JdbcType.INTEGER),
        @Result(column="create_time", property="createTime", jdbcType=JdbcType.TIMESTAMP),
        @Result(column="update_time", property="updateTime", jdbcType=JdbcType.TIMESTAMP)
    })
    Role selectByPrimaryKey(Integer roleId);

    @UpdateProvider(type=RoleSqlProvider.class, method="updateByExampleSelective")
    int updateByExampleSelective(@Param("record") Role record, @Param("example") RoleExample example);

    @UpdateProvider(type=RoleSqlProvider.class, method="updateByExample")
    int updateByExample(@Param("record") Role record, @Param("example") RoleExample example);

    @UpdateProvider(type=RoleSqlProvider.class, method="updateByPrimaryKeySelective")
    int updateByPrimaryKeySelective(Role record);

    @Update({
        "update t_role",
        "set role_code = #{roleCode,jdbcType=VARCHAR},",
          "role_name = #{roleName,jdbcType=VARCHAR},",
          "sys = #{sys,jdbcType=INTEGER},",
          "remark = #{remark,jdbcType=VARCHAR},",
          "state = #{state,jdbcType=INTEGER},",
          "create_id = #{createId,jdbcType=INTEGER},",
          "update_id = #{updateId,jdbcType=INTEGER},",
          "create_time = #{createTime,jdbcType=TIMESTAMP},",
          "update_time = #{updateTime,jdbcType=TIMESTAMP}",
        "where role_id = #{roleId,jdbcType=INTEGER}"
    })
    int updateByPrimaryKey(Role record);
}