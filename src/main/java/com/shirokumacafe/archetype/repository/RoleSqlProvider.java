package com.shirokumacafe.archetype.repository;

import static org.apache.ibatis.jdbc.SqlBuilder.BEGIN;
import static org.apache.ibatis.jdbc.SqlBuilder.DELETE_FROM;
import static org.apache.ibatis.jdbc.SqlBuilder.FROM;
import static org.apache.ibatis.jdbc.SqlBuilder.INSERT_INTO;
import static org.apache.ibatis.jdbc.SqlBuilder.ORDER_BY;
import static org.apache.ibatis.jdbc.SqlBuilder.SELECT;
import static org.apache.ibatis.jdbc.SqlBuilder.SELECT_DISTINCT;
import static org.apache.ibatis.jdbc.SqlBuilder.SET;
import static org.apache.ibatis.jdbc.SqlBuilder.SQL;
import static org.apache.ibatis.jdbc.SqlBuilder.UPDATE;
import static org.apache.ibatis.jdbc.SqlBuilder.VALUES;
import static org.apache.ibatis.jdbc.SqlBuilder.WHERE;

import com.shirokumacafe.archetype.entity.Role;
import com.shirokumacafe.archetype.entity.RoleExample.Criteria;
import com.shirokumacafe.archetype.entity.RoleExample.Criterion;
import com.shirokumacafe.archetype.entity.RoleExample;
import java.util.List;
import java.util.Map;

public class RoleSqlProvider {

    public String countByExample(RoleExample example) {
        BEGIN();
        SELECT("count(*)");
        FROM("t_role");
        applyWhere(example, false);
        return SQL();
    }

    public String deleteByExample(RoleExample example) {
        BEGIN();
        DELETE_FROM("t_role");
        applyWhere(example, false);
        return SQL();
    }

    public String insertSelective(Role record) {
        BEGIN();
        INSERT_INTO("t_role");
        
        if (record.getRoleCode() != null) {
            VALUES("role_code", "#{roleCode,jdbcType=VARCHAR}");
        }
        
        if (record.getRoleName() != null) {
            VALUES("role_name", "#{roleName,jdbcType=VARCHAR}");
        }
        
        if (record.getSys() != null) {
            VALUES("sys", "#{sys,jdbcType=INTEGER}");
        }
        
        if (record.getRemark() != null) {
            VALUES("remark", "#{remark,jdbcType=VARCHAR}");
        }
        
        if (record.getState() != null) {
            VALUES("state", "#{state,jdbcType=INTEGER}");
        }
        
        if (record.getCreateId() != null) {
            VALUES("create_id", "#{createId,jdbcType=INTEGER}");
        }
        
        if (record.getUpdateId() != null) {
            VALUES("update_id", "#{updateId,jdbcType=INTEGER}");
        }
        
        if (record.getCreateTime() != null) {
            VALUES("create_time", "#{createTime,jdbcType=TIMESTAMP}");
        }
        
        if (record.getUpdateTime() != null) {
            VALUES("update_time", "#{updateTime,jdbcType=TIMESTAMP}");
        }
        
        return SQL();
    }

    public String selectByExample(RoleExample example) {
        BEGIN();
        if (example != null && example.isDistinct()) {
            SELECT_DISTINCT("role_id");
        } else {
            SELECT("role_id");
        }
        SELECT("role_code");
        SELECT("role_name");
        SELECT("sys");
        SELECT("remark");
        SELECT("state");
        SELECT("create_id");
        SELECT("update_id");
        SELECT("create_time");
        SELECT("update_time");
        FROM("t_role");
        applyWhere(example, false);
        
        if (example != null && example.getOrderByClause() != null) {
            ORDER_BY(example.getOrderByClause());
        }
        
        return SQL();
    }

    public String updateByExampleSelective(Map<String, Object> parameter) {
        Role record = (Role) parameter.get("record");
        RoleExample example = (RoleExample) parameter.get("example");
        
        BEGIN();
        UPDATE("t_role");
        
        if (record.getRoleId() != null) {
            SET("role_id = #{record.roleId,jdbcType=INTEGER}");
        }
        
        if (record.getRoleCode() != null) {
            SET("role_code = #{record.roleCode,jdbcType=VARCHAR}");
        }
        
        if (record.getRoleName() != null) {
            SET("role_name = #{record.roleName,jdbcType=VARCHAR}");
        }
        
        if (record.getSys() != null) {
            SET("sys = #{record.sys,jdbcType=INTEGER}");
        }
        
        if (record.getRemark() != null) {
            SET("remark = #{record.remark,jdbcType=VARCHAR}");
        }
        
        if (record.getState() != null) {
            SET("state = #{record.state,jdbcType=INTEGER}");
        }
        
        if (record.getCreateId() != null) {
            SET("create_id = #{record.createId,jdbcType=INTEGER}");
        }
        
        if (record.getUpdateId() != null) {
            SET("update_id = #{record.updateId,jdbcType=INTEGER}");
        }
        
        if (record.getCreateTime() != null) {
            SET("create_time = #{record.createTime,jdbcType=TIMESTAMP}");
        }
        
        if (record.getUpdateTime() != null) {
            SET("update_time = #{record.updateTime,jdbcType=TIMESTAMP}");
        }
        
        applyWhere(example, true);
        return SQL();
    }

    public String updateByExample(Map<String, Object> parameter) {
        BEGIN();
        UPDATE("t_role");
        
        SET("role_id = #{record.roleId,jdbcType=INTEGER}");
        SET("role_code = #{record.roleCode,jdbcType=VARCHAR}");
        SET("role_name = #{record.roleName,jdbcType=VARCHAR}");
        SET("sys = #{record.sys,jdbcType=INTEGER}");
        SET("remark = #{record.remark,jdbcType=VARCHAR}");
        SET("state = #{record.state,jdbcType=INTEGER}");
        SET("create_id = #{record.createId,jdbcType=INTEGER}");
        SET("update_id = #{record.updateId,jdbcType=INTEGER}");
        SET("create_time = #{record.createTime,jdbcType=TIMESTAMP}");
        SET("update_time = #{record.updateTime,jdbcType=TIMESTAMP}");
        
        RoleExample example = (RoleExample) parameter.get("example");
        applyWhere(example, true);
        return SQL();
    }

    public String updateByPrimaryKeySelective(Role record) {
        BEGIN();
        UPDATE("t_role");
        
        if (record.getRoleCode() != null) {
            SET("role_code = #{roleCode,jdbcType=VARCHAR}");
        }
        
        if (record.getRoleName() != null) {
            SET("role_name = #{roleName,jdbcType=VARCHAR}");
        }
        
        if (record.getSys() != null) {
            SET("sys = #{sys,jdbcType=INTEGER}");
        }
        
        if (record.getRemark() != null) {
            SET("remark = #{remark,jdbcType=VARCHAR}");
        }
        
        if (record.getState() != null) {
            SET("state = #{state,jdbcType=INTEGER}");
        }
        
        if (record.getCreateId() != null) {
            SET("create_id = #{createId,jdbcType=INTEGER}");
        }
        
        if (record.getUpdateId() != null) {
            SET("update_id = #{updateId,jdbcType=INTEGER}");
        }
        
        if (record.getCreateTime() != null) {
            SET("create_time = #{createTime,jdbcType=TIMESTAMP}");
        }
        
        if (record.getUpdateTime() != null) {
            SET("update_time = #{updateTime,jdbcType=TIMESTAMP}");
        }
        
        WHERE("role_id = #{roleId,jdbcType=INTEGER}");
        
        return SQL();
    }

    protected void applyWhere(RoleExample example, boolean includeExamplePhrase) {
        if (example == null) {
            return;
        }
        
        String parmPhrase1;
        String parmPhrase1_th;
        String parmPhrase2;
        String parmPhrase2_th;
        String parmPhrase3;
        String parmPhrase3_th;
        if (includeExamplePhrase) {
            parmPhrase1 = "%s #{example.oredCriteria[%d].allCriteria[%d].value}";
            parmPhrase1_th = "%s #{example.oredCriteria[%d].allCriteria[%d].value,typeHandler=%s}";
            parmPhrase2 = "%s #{example.oredCriteria[%d].allCriteria[%d].value} and #{example.oredCriteria[%d].criteria[%d].secondValue}";
            parmPhrase2_th = "%s #{example.oredCriteria[%d].allCriteria[%d].value,typeHandler=%s} and #{example.oredCriteria[%d].criteria[%d].secondValue,typeHandler=%s}";
            parmPhrase3 = "#{example.oredCriteria[%d].allCriteria[%d].value[%d]}";
            parmPhrase3_th = "#{example.oredCriteria[%d].allCriteria[%d].value[%d],typeHandler=%s}";
        } else {
            parmPhrase1 = "%s #{oredCriteria[%d].allCriteria[%d].value}";
            parmPhrase1_th = "%s #{oredCriteria[%d].allCriteria[%d].value,typeHandler=%s}";
            parmPhrase2 = "%s #{oredCriteria[%d].allCriteria[%d].value} and #{oredCriteria[%d].criteria[%d].secondValue}";
            parmPhrase2_th = "%s #{oredCriteria[%d].allCriteria[%d].value,typeHandler=%s} and #{oredCriteria[%d].criteria[%d].secondValue,typeHandler=%s}";
            parmPhrase3 = "#{oredCriteria[%d].allCriteria[%d].value[%d]}";
            parmPhrase3_th = "#{oredCriteria[%d].allCriteria[%d].value[%d],typeHandler=%s}";
        }
        
        StringBuilder sb = new StringBuilder();
        List<Criteria> oredCriteria = example.getOredCriteria();
        boolean firstCriteria = true;
        for (int i = 0; i < oredCriteria.size(); i++) {
            Criteria criteria = oredCriteria.get(i);
            if (criteria.isValid()) {
                if (firstCriteria) {
                    firstCriteria = false;
                } else {
                    sb.append(" or ");
                }
                
                sb.append('(');
                List<Criterion> criterions = criteria.getAllCriteria();
                boolean firstCriterion = true;
                for (int j = 0; j < criterions.size(); j++) {
                    Criterion criterion = criterions.get(j);
                    if (firstCriterion) {
                        firstCriterion = false;
                    } else {
                        sb.append(" and ");
                    }
                    
                    if (criterion.isNoValue()) {
                        sb.append(criterion.getCondition());
                    } else if (criterion.isSingleValue()) {
                        if (criterion.getTypeHandler() == null) {
                            sb.append(String.format(parmPhrase1, criterion.getCondition(), i, j));
                        } else {
                            sb.append(String.format(parmPhrase1_th, criterion.getCondition(), i, j,criterion.getTypeHandler()));
                        }
                    } else if (criterion.isBetweenValue()) {
                        if (criterion.getTypeHandler() == null) {
                            sb.append(String.format(parmPhrase2, criterion.getCondition(), i, j, i, j));
                        } else {
                            sb.append(String.format(parmPhrase2_th, criterion.getCondition(), i, j, criterion.getTypeHandler(), i, j, criterion.getTypeHandler()));
                        }
                    } else if (criterion.isListValue()) {
                        sb.append(criterion.getCondition());
                        sb.append(" (");
                        List<?> listItems = (List<?>) criterion.getValue();
                        boolean comma = false;
                        for (int k = 0; k < listItems.size(); k++) {
                            if (comma) {
                                sb.append(", ");
                            } else {
                                comma = true;
                            }
                            if (criterion.getTypeHandler() == null) {
                                sb.append(String.format(parmPhrase3, i, j, k));
                            } else {
                                sb.append(String.format(parmPhrase3_th, i, j, k, criterion.getTypeHandler()));
                            }
                        }
                        sb.append(')');
                    }
                }
                sb.append(')');
            }
        }
        
        if (sb.length() > 0) {
            WHERE(sb.toString());
        }
    }
}