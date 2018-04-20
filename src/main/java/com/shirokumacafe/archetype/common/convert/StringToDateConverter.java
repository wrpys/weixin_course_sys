package com.shirokumacafe.archetype.common.convert;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.core.convert.converter.Converter;

import java.util.Date;

/**
 * 字符串转日期 转换器
 *
 * @author lim
 */
public class StringToDateConverter implements Converter<String, Date> {
    private static DateTimeFormatter fmt = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
    private static DateTimeFormatter fmt2 = DateTimeFormat.forPattern("yyyyMMdd");

    @Override
    public Date convert(String source) {

        if (null == source || source.isEmpty() ) {
            return null;
        }

        try {
            DateTime dt;
            if( source.length()==19 && !source.contains("T") ){
                dt = fmt.parseDateTime( source );
            }
            else{
                dt = new DateTime( source );
            }
            return dt.toDate();
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException();
        }

    }

    public Date convert2(String source) {

        if (null == source || source.isEmpty() ) {
            return null;
        }

        try {
            DateTime dt;
            if( source.length()==8 ){
                dt = fmt2.parseDateTime( source );
            }
            else{
                return null;
            }
            return dt.toDate();
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException();
        }

    }
}
