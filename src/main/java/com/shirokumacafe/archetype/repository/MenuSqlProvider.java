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

import com.shirokumacafe.archetype.entity.Menu;
import com.shirokumacafe.archetype.entity.MenuExample.Criteria;
import com.shirokumacafe.archetype.entity.MenuExample.Criterion;
import com.shirokumacafe.archetype.entity.MenuExample;
import java.util.List;
import java.util.Map;

public class MenuSqlProvider {

    public String countByExample(MenuExample example) {
        BEGIN();
        SELECT("count(*)");
        FROM("t_menu");
        applyWhere(example, false);
        return SQL();
    }

    public String deleteByExample(MenuExample example) {
        BEGIN();
        DELETE_FROM("t_menu");
        applyWhere(example, false);
        return SQL();
    }

    public String insertSelective(Menu record) {
        BEGIN();
        INSERT_INTO("t_menu");
        
        if (record.getMenuCode() != null) {
            VALUES("menu_code", "#{menuCode,jdbcType=VARCHAR}");
        }
        
        if (record.getMenuPid() != null) {
            VALUES("menu_pid", "#{menuPid,jdbcType=INTEGER}");
        }
        
        if (record.getMenuName() != null) {
            VALUES("menu_name", "#{menuName,jdbcType=VARCHAR}");
        }
        
        if (record.getMenuLink() != null) {
            VALUES("menu_link", "#{menuLink,jdbcType=VARCHAR}");
        }
        
        if (record.getSort() != null) {
            VALUES("sort", "#{sort,jdbcType=INTEGER}");
        }
        
        if (record.getState() != null) {
            VALUES("state", "#{state,jdbcType=INTEGER}");
        }
        
        return SQL();
    }

    public String selectByExample(MenuExample example) {
        BEGIN();
        if (example != null && example.isDistinct()) {
            SELECT_DISTINCT("menu_id");
        } else {
            SELECT("menu_id");
        }
        SELECT("menu_code");
        SELECT("menu_pid");
        SELECT("menu_name");
        SELECT("menu_link");
        SELECT("sort");
        SELECT("state");
        FROM("t_menu");
        applyWhere(example, false);
        
        if (example != null && example.getOrderByClause() != null) {
            ORDER_BY(example.getOrderByClause());
        }
        
        return SQL();
    }

    public String updateByExampleSelective(Map<String, Object> parameter) {
        Menu record = (Menu) parameter.get("record");
        MenuExample example = (MenuExample) parameter.get("example");
        
        BEGIN();
        UPDATE("t_menu");
        
        if (record.getMenuId() != null) {
            SET("menu_id = #{record.menuId,jdbcType=INTEGER}");
        }
        
        if (record.getMenuCode() != null) {
            SET("menu_code = #{record.menuCode,jdbcType=VARCHAR}");
        }
        
        if (record.getMenuPid() != null) {
            SET("menu_pid = #{record.menuPid,jdbcType=INTEGER}");
        }
        
        if (record.getMenuName() != null) {
            SET("menu_name = #{record.menuName,jdbcType=VARCHAR}");
        }
        
        if (record.getMenuLink() != null) {
            SET("menu_link = #{record.menuLink,jdbcType=VARCHAR}");
        }
        
        if (record.getSort() != null) {
            SET("sort = #{record.sort,jdbcType=INTEGER}");
        }
        
        if (record.getState() != null) {
            SET("state = #{record.state,jdbcType=INTEGER}");
        }
        
        applyWhere(example, true);
        return SQL();
    }

    public String updateByExample(Map<String, Object> parameter) {
        BEGIN();
        UPDATE("t_menu");
        
        SET("menu_id = #{record.menuId,jdbcType=INTEGER}");
        SET("menu_code = #{record.menuCode,jdbcType=VARCHAR}");
        SET("menu_pid = #{record.menuPid,jdbcType=INTEGER}");
        SET("menu_name = #{record.menuName,jdbcType=VARCHAR}");
        SET("menu_link = #{record.menuLink,jdbcType=VARCHAR}");
        SET("sort = #{record.sort,jdbcType=INTEGER}");
        SET("state = #{record.state,jdbcType=INTEGER}");
        
        MenuExample example = (MenuExample) parameter.get("example");
        applyWhere(example, true);
        return SQL();
    }

    public String updateByPrimaryKeySelective(Menu record) {
        BEGIN();
        UPDATE("t_menu");
        
        if (record.getMenuCode() != null) {
            SET("menu_code = #{menuCode,jdbcType=VARCHAR}");
        }
        
        if (record.getMenuPid() != null) {
            SET("menu_pid = #{menuPid,jdbcType=INTEGER}");
        }
        
        if (record.getMenuName() != null) {
            SET("menu_name = #{menuName,jdbcType=VARCHAR}");
        }
        
        if (record.getMenuLink() != null) {
            SET("menu_link = #{menuLink,jdbcType=VARCHAR}");
        }
        
        if (record.getSort() != null) {
            SET("sort = #{sort,jdbcType=INTEGER}");
        }
        
        if (record.getState() != null) {
            SET("state = #{state,jdbcType=INTEGER}");
        }
        
        WHERE("menu_id = #{menuId,jdbcType=INTEGER}");
        
        return SQL();
    }

    protected void applyWhere(MenuExample example, boolean includeExamplePhrase) {
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