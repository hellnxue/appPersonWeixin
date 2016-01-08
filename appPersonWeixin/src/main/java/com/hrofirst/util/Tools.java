package com.hrofirst.util;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 工具类
 * @author zhiyanguser
 *
 */
public  class Tools {
	/**
	 * 中文编码转换（linux下不太好用）
	 */
    public static String handleEncoding(String args){
   	 try {
		return new String(args.getBytes("ISO-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 
   	  return "";
    }
	
    /** 
     * emoji符号表情转换(hex -> utf-16) 
     *  
     * @param hexEmoji 
     * @return 
     */  
    public static String emoji(int hexEmoji) {  
        return String.valueOf(Character.toChars(hexEmoji));  
    } 
    
    /**
     * 判断一个时间是否在另一个时间段内（时分秒判断）
     * 参数格式 yyyy-MM-dd HH:mm:ss
     * @param strDate
     * @param strDateBegin
     * @param strDateEnd
     * @return
     */
    public static boolean isInDates(){   
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
        SimpleDateFormat CurTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar Cal = Calendar.getInstance();
		String strDate=CurTime.format(Cal.getTime());
        String strDateBegin=strDate.substring(0,10)+" 09:00:00";
		String strDateEnd=strDate.substring(0,10)+" 18:00:00";
        Date myDate = null;  
        Date dateBegin = null;  
        Date dateEnd = null;  
        try {  
            myDate = sd.parse(strDate);  
            dateBegin = sd.parse(strDateBegin);  
            dateEnd = sd.parse(strDateEnd);  
        } catch (ParseException e) {  
            e.printStackTrace();  
        }  
        strDate = String.valueOf(myDate);  
        strDateBegin = String.valueOf(dateBegin);  
        strDateEnd = String.valueOf(dateEnd);  
          
        int strDateH = Integer.parseInt(strDate.substring(11,13));  
        int strDateM = Integer.parseInt(strDate.substring(14,16));  
        int strDateS = Integer.parseInt(strDate.substring(17,19));  
          
        int strDateBeginH = Integer.parseInt(strDateBegin.substring(11,13));  
        int strDateBeginM = Integer.parseInt(strDateBegin.substring(14,16));  
        int strDateBeginS = Integer.parseInt(strDateBegin.substring(17,19));  
          
        int strDateEndH = Integer.parseInt(strDateEnd.substring(11,13));  
        int strDateEndM = Integer.parseInt(strDateEnd.substring(14,16));  
        int strDateEndS = Integer.parseInt(strDateEnd.substring(17,19));  
          
        if((strDateH>=strDateBeginH && strDateH<=strDateEndH)){  
            if(strDateH>strDateBeginH && strDateH<strDateEndH){  
                return true;  
            }else if(strDateH==strDateBeginH && strDateM>strDateBeginM && strDateH<strDateEndH){  
                return true;  
            }else if(strDateH==strDateBeginH && strDateM==strDateBeginM && strDateS>strDateBeginS && strDateH<strDateEndH){  
                return true;  
            }else if(strDateH==strDateBeginH && strDateM==strDateBeginM && strDateS==strDateBeginS && strDateH<strDateEndH){  
                return true;  
            }else if(strDateH>strDateBeginH && strDateH==strDateEndH && strDateM<strDateEndM){  
                return true;  
            }else if(strDateH>strDateBeginH && strDateH==strDateEndH && strDateM==strDateEndM && strDateS<strDateEndS){  
                return true;  
            }else if(strDateH>strDateBeginH && strDateH==strDateEndH && strDateM==strDateEndM && strDateS==strDateEndS){  
                return true;  
            }else{  
                return false;  
            }  
        }else{  
            return false;  
        }  
    }  
    
    public static void main(String args[]){
    	SimpleDateFormat CurTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar Cal = Calendar.getInstance();
		String nowDate=CurTime.format(Cal.getTime());
		System.out.println(nowDate);
		
		String start=nowDate.substring(0,10)+" 09:00:00";
		String end=nowDate.substring(0,10)+" 18:00:00";
		System.out.println(start);
		System.out.println(end);
    	boolean f=Tools.isInDates();
    	System.out.println(f);
    }
}
