/*
 * Copyright © 2014 FNST Co., Ltd. All Rights Reserved.
 */

package com.hrofirst.util;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;

import java.util.Date;

public class DateUtils {

    public static final String DATE_FMT_1 = "yyyy-MM-dd HH:mm:ss";
    public static final String FOLDER_DATE="yyyyMMdd";

    public static Date toDate(final String sDate) {
        if (sDate == null || sDate.trim().equals("")) {
            return null;
        }
        return toDate(sDate, DATE_FMT_1);
    }
    public static String formatFolderName(final Date date){
        return new DateTime(date).toString(FOLDER_DATE);
    }

    public static String format(Date date) {
        return new DateTime(date).toString(DATE_FMT_1);
    }


    public static Date toDate(final String sDate, final String sFmt) {
        return DateTimeFormat.forPattern(sFmt).parseDateTime(sDate).toDate();
    }

    public static Date addDay(final Date date, final int days) {
        return new DateTime(date).plusDays(days).toDate();
    }

    public static Date getTomorrow(Date date) {
        DateTime dateTime = new DateTime(date).hourOfDay().setCopy(0).minuteOfDay().setCopy(0).secondOfDay().setCopy(0);
        return dateTime.plusDays(1).toDate();
    }
}
