package com.shirokumacafe.archetype.repository;

import com.shirokumacafe.archetype.entity.RolePermission;
import com.shirokumacafe.archetype.entity.RolePermissionExample;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.type.JdbcType;

import java.util.List;

public interface RolePermissionMapper {
    @SelectProvider(type=RolePermissionSqlProvider.class, method="countByExample")
    int countByExample(RolePermissionExample example);

    @DeleteProvider(type=RolePermissionSqlProvider.class, method="deleteByExample")
    int deleteByExample(RolePermissionExample example);

    @Insert({
        "insert into t_role_permission (role_id, permission)",
        "values (#{roleId,jdbcType=INTEGER}, #{permission,jdbcType=VARCHAR})"
    })
    int insert(RolePermission record);

    @InsertProvider(type=RolePermissionSqlProvider.class, method="insertSelective")
    int insertSelective(RolePermission record);

    @SelectProvider(type=RolePermissionSqlProvider.class, method="selectByExample")
    @Results({
        @Result(column="role_id", property="roleId", jdbcType=JdbcType.INTEGER),
        @Result(column="permission", property="permission", jdbcType=JdbcType.VARCHAR)
    })
    List<RolePermission> selectByExampleWithRowbounds(RolePermissionExample example, RowBounds rowBounds);

    @SelectProvider(type=RolePermissionSqlProvider.class, method="selectByExample")
    @Results({
        @Result(column="role_id", property="roleId", jdbcType=JdbcType.INTEGER),
        @Result(column="permission", property="permission", jdbcType=JdbcType.VARCHAR)
    })
    List<RolePermission> selectByExample(RolePermissionExample example);

    @UpdateProvider(type=RolePermissionSqlProvider.class, method="updateByExampleSelective")
    int updateByExampleSelective(@Param("record") RolePermission record, @Param("example") RolePermissionExample example);

    @UpdateProvider(type=RolePermissionSqlProvider.class, method="updateByExample")
    int updateByExample(@Param("record") RolePermission record, @Param("example") RolePermissionExample example);
}