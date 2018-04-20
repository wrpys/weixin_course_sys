package com.shirokumacafe.archetype.common.utilities;

import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.joda.time.Days;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * JodaTime辅助类
 *
 * @author wrp
 *
 */
public class DateTimes {
    public final static String FORMAT_FULL = "yyyy-MM-dd HH:mm:ss";
    public final static String FORMAT_SHORT = "yyyy-MM-dd";

    /**
     * 将日期转换为指定格式的字符串
     */
    public static String convertToString(Date date, String format) {
        DateTime dateTime = new DateTime(date);
        DateTimeFormatter fmt = DateTimeFormat.forPattern(format);
        return fmt.print(dateTime);
    }

    /**
     * 将日期转换为默认设置的字符串
     */
    public static String convertToString(Date date) {
        DateTime dateTime = new DateTime(date);
        DateTimeFormatter fmt = DateTimeFormat.forPattern(FORMAT_FULL);
        return fmt.print(dateTime);
    }
    /**
     * 将日期转换为字符串
     */
    public static String convertToShortString(Date date) {
        DateTime dateTime = new DateTime(date);
        DateTimeFormatter fmt = DateTimeFormat.forPattern(FORMAT_SHORT);
        return fmt.print(dateTime);
    }

    /**
     * 将字符串按指定的格式转换为日期
     */
    public static DateTime convertFromString(String str, String format) {
        if(StringUtils.isNotBlank(str)){
            DateTimeFormatter fmt = DateTimeFormat.forPattern(format);
            DateTime dateTime = fmt.parseDateTime(str);
            return dateTime;
        }else{
            return null;
        }
    }

    /**
     * 将字符串按默认的格式转换为日期
     */
    public static DateTime convertFromString(String str) {
        return convertFromString(str, FORMAT_FULL);
    }

    /**
     * 取得月份的头一天
     */
    public static DateTime startOfMonth(Date date) {
        DateTime dateTime = new DateTime(date);
        DateTime startOfMonth = dateTime.dayOfMonth().withMinimumValue();
        return startOfMonth;
    }

    /**
     * 取得月份的头一天
     */
    public static DateTime startOfMonth() {
        DateTime dateTime = new DateTime();
        return startOfMonth(dateTime.millisOfDay().withMinimumValue().toDate());
    }

    /**
     * 取得月份的最后一天
     */
    public static DateTime endOfMonth(Date date) {
        DateTime dateTime = new DateTime(date);
        DateTime endOfMonth = dateTime.dayOfMonth().withMaximumValue();
        return endOfMonth;
    }

    /**
     * 取得月份的最后一天
     */
    public static DateTime endOfMonth() {
        DateTime dateTime = new DateTime();
        return endOfMonth(dateTime.millisOfDay().withMaximumValue().toDate());
    }

    /**
     * 取得时间一天的0:00
     */
    public static DateTime startOfDate(Date date) {
        DateTime dateTime = new DateTime(date);
        return dateTime.millisOfDay().withMinimumValue();
    }

    /**
     * 取得时间一天的23:59:59
     */
    public static DateTime endOfDate(Date date) {
        DateTime dateTime = new DateTime(date);
        return dateTime.millisOfDay().withMaximumValue();
    }

    /**
     * 取得时间一天的0:00
     */
    public static DateTime startOfDate(DateTime dateTime) {
        return dateTime.millisOfDay().withMinimumValue();
    }

    /**
     * 指定日期date天数加count
     */
    public static Date addDate(Date date,int count){
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE,count);
        return cal.getTime();
    }
    /**
     * 取得时间一天的23:59:59
     */
    public static DateTime endOfDate(DateTime dateTime) {
        return dateTime.millisOfDay().withMaximumValue();
    }

    /**
     * 取得本周的头一天
     */
    public static DateTime startOfWeek() {
        DateTime dateTime = new DateTime();
        DateTime startOfWeek = dateTime.millisOfDay().withMinimumValue().dayOfWeek().withMinimumValue();
        return startOfWeek;
    }

    /**
     * 取得本周的最后一天
     */
    public static DateTime endOfWeek() {
        DateTime dateTime = new DateTime();
        DateTime startOfWeek = dateTime.millisOfDay().withMinimumValue().dayOfWeek().withMaximumValue();
        return startOfWeek;
    }

    public static String now(){
        return convertToString(new Date());
    }

    public static String nowToShort(){
        return convertToShortString(new Date());
    }

    public static List<String> betweenDays(Date startDate,Date endDate){

        if( null == startDate || null == endDate ){
            return null;
        }

        DateTime start = new DateTime(startDate);
        DateTime end = new DateTime(endDate);

        if( start.isAfter(end) ){
            return null;
        }

        List<String> days = new ArrayList<String>();
        int day = Days.daysBetween(start,end).getDays();

        for(int i=0;i<=day;i++){

            days.add( start.plusDays(i).toString(FORMAT_SHORT) );
        }

        return days;
    }

    public static DateTime get(){
        return new DateTime();
    }

    public static void main(String[] args) {

    }
}
