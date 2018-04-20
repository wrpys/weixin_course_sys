package com.shirokumacafe.archetype.repository;

import com.shirokumacafe.archetype.entity.Clzss;
import com.shirokumacafe.archetype.entity.ClzssExample;
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

public interface ClzssMapper {
    @SelectProvider(type=ClzssSqlProvider.class, method="countByExample")
    int countByExample(ClzssExample example);

    @DeleteProvider(type=ClzssSqlProvider.class, method="deleteByExample")
    int deleteByExample(ClzssExample example);

    @Delete({
        "delete from t_clzss",
        "where id = #{id,jdbcType=INTEGER}"
    })
    int deleteByPrimaryKey(Integer id);

    @Insert({
        "insert into t_clzss (grade, clzss)",
        "values (#{grade,jdbcType=VARCHAR}, #{clzss,jdbcType=VARCHAR})"
    })
    @SelectKey(statement="SELECT @@IDENTITY", keyProperty="id", before=false, resultType=Integer.class)
    int insert(Clzss record);

    @InsertProvider(type=ClzssSqlProvider.class, method="insertSelective")
    @SelectKey(statement="SELECT @@IDENTITY", keyProperty="id", before=false, resultType=Integer.class)
    int insertSelective(Clzss record);

    @SelectProvider(type=ClzssSqlProvider.class, method="selectByExample")
    @Results({
        @Result(column="id", property="id", jdbcType=JdbcType.INTEGER, id=true),
        @Result(column="grade", property="grade", jdbcType=JdbcType.VARCHAR),
        @Result(column="clzss", property="clzss", jdbcType=JdbcType.VARCHAR)
    })
    List<Clzss> selectByExampleWithRowbounds(ClzssExample example, RowBounds rowBounds);

    @SelectProvider(type=ClzssSqlProvider.class, method="selectByExample")
    @Results({
        @Result(column="id", property="id", jdbcType=JdbcType.INTEGER, id=true),
        @Result(column="grade", property="grade", jdbcType=JdbcType.VARCHAR),
        @Result(column="clzss", property="clzss", jdbcType=JdbcType.VARCHAR)
    })
    List<Clzss> selectByExample(ClzssExample example);

    @Select({
        "select",
        "id, grade, clzss",
        "from t_clzss",
        "where id = #{id,jdbcType=INTEGER}"
    })
    @Results({
        @Result(column="id", property="id", jdbcType=JdbcType.INTEGER, id=true),
        @Result(column="grade", property="grade", jdbcType=JdbcType.VARCHAR),
        @Result(column="clzss", property="clzss", jdbcType=JdbcType.VARCHAR)
    })
    Clzss selectByPrimaryKey(Integer id);

    @UpdateProvider(type=ClzssSqlProvider.class, method="updateByExampleSelective")
    int updateByExampleSelective(@Param("record") Clzss record, @Param("example") ClzssExample example);

    @UpdateProvider(type=ClzssSqlProvider.class, method="updateByExample")
    int updateByExample(@Param("record") Clzss record, @Param("example") ClzssExample example);

    @UpdateProvider(type=ClzssSqlProvider.class, method="updateByPrimaryKeySelective")
    int updateByPrimaryKeySelective(Clzss record);

    @Update({
        "update t_clzss",
        "set grade = #{grade,jdbcType=VARCHAR},",
          "clzss = #{clzss,jdbcType=VARCHAR}",
        "where id = #{id,jdbcType=INTEGER}"
    })
    int updateByPrimaryKey(Clzss record);
}