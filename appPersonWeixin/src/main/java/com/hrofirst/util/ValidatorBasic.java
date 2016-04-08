package com.hrofirst.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;

public class ValidatorBasic {
	 /** 
     * 是否不为空
     * @param value 
     */  
    public static boolean isNotEmpty(String value){  
        if(StringUtils.isBlank(value) || value.trim().equals("null")) {
            return false;
        }
        return true;  
    }  
    
    /** 
     * 是否 为空
     * @param value 
     */  
    public static boolean isEmpty(String value){  
        return !isNotEmpty(value);  
    }  
    
    /**
     * 是否为身份证号码
     * @param value
     */
    public static boolean isCardId(String value){
        if(isEmpty(value)) {return true;}
        String pattern = "((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65|71|81|82|91)\\d{4})((((19|20)(([02468][048])|([13579][26]))0229))|((20[0-9][0-9])|(19[0-9][0-9]))((((0[1-9])|(1[0-2]))((0[1-9])|(1\\d)|(2[0-8])))|((((0[1,3-9])|(1[0-2]))(29|30))|(((0[13578])|(1[02]))31))))((\\d{3}(x|X))|(\\d{4}))";  
        Pattern p = Pattern.compile(pattern);  
        Matcher m = p.matcher(value);  
        return m.matches();
    }
    
    /**
     * 是否为银行卡卡号
     * @param value
     */
    public static boolean isBankCardNum(String value) {
    	 if(isEmpty(value)) {return true;}
         char bit = getBankCardCheckCode(value.substring(0, value.length() - 1));
         if(bit == 'N'){
             return false;
         }
         return value.charAt(value.length() - 1) == bit;
    }

    /**
     * 从不含校验位的银行卡卡号采用 Luhm 校验算法获得校验位
     * @param nonCheckCodeCardId
     * @return
     */
    private static char getBankCardCheckCode(String nonCheckCodeCardId){
        if(nonCheckCodeCardId == null || nonCheckCodeCardId.trim().length() == 0
                || !nonCheckCodeCardId.matches("\\d+")) {
            //如果传的不是数据返回N
            return 'N';
        }
        char[] chs = nonCheckCodeCardId.trim().toCharArray();
        int luhmSum = 0;
        for(int i = chs.length - 1, j = 0; i >= 0; i--, j++) {
            int k = chs[i] - '0';
            if(j % 2 == 0) {
                k *= 2;
                k = k / 10 + k % 10;
            }
            luhmSum += k;           
        }
        return (luhmSum % 10 == 0) ? '0' : (char)((10 - luhmSum % 10) + '0');
    }
	
    /** 
     * 是否是整数 
     * @param value 
     */  
    public static boolean isIntege(String value){  
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^-?[1-9]\\d*$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是正整数 
     * @param value 
     */  
    public static boolean isIntegeU(String value){  
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^[1-9]\\d*$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是负整数 
     * @param value 
     */  
    public static boolean isIntegeL(String value){  
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^-[1-9]\\d*$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是数字 
     * @param value 
     */  
    public static boolean isNum(String value){ 
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^([+-]?)\\d*\\.?\\d+$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是正数（正整数 + 0） 
     * @param value 
     */  
    public static boolean isNumU(String value){  
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^[1-9]\\d*|0$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是负数（负整数 + 0） 
     * @param value 
     */  
    public static boolean isNumL(String value){ 
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^-[1-9]\\d*|0$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是浮点数 
     * @param value 
     */  
    public static boolean isDecmal(String value){ 
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^([+-]?)\\d*\\.\\d+$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是正浮点数 
     * @param value 
     */  
    public static boolean isDecmalU(String value){  
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^[1-9]\\d*.\\d*|0.\\d*[1-9]\\d*$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是负浮点数 
     * @param value 
     */  
    public static boolean isDecmalL(String value){ 
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^-([1-9]\\d*.\\d*|0.\\d*[1-9]\\d*)$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是浮点数 
     * @param value 
     */  
    public static boolean isDecmalZ(String value){  
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^-?([1-9]\\d*.\\d*|0.\\d*[1-9]\\d*|0?.0+|0)$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是非负浮点数（正浮点数 + 0） 
     * @param value 
     */  
    public static boolean isDecmalZU(String value){ 
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^[1-9]\\d*.\\d*|0.\\d*[1-9]\\d*|0?.0+|0$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是非正浮点数（负浮点数 + 0） 
     * @param value 
     */  
    public static boolean isDecmalZL(String value){ 
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^(-([1-9]\\d*.\\d*|0.\\d*[1-9]\\d*))|0?.0+|0$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是邮件 
     * @param value 
     */  
    public static boolean isEmail(String value){  
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z0-9]+$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是颜色 
     * @param value 
     */  
    public static boolean isColor(String value){  
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^[a-fA-F0-9]{6}$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是url 
     * @param value 
     */  
    public static boolean isUrl(String value){  
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^http[s]?:\\/\\/([\\w-]+\\.)+[\\w-]+([\\w-./?%&=]*)?$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是中文 
     * @param value 
     */  
    public static boolean isChinese(String value){  
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^[\\u4E00-\\u9FA5\\uF900-\\uFA2D]+$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是ACSII字符 
     * @param value 
     */  
    public static boolean isAscii(String value){  
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^[\\x00-\\xFF]+$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是邮编 
     * @param value 
     */  
    public static boolean isZipcode(String value){ 
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^\\d{6}$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是手机 
     * @param value 
     */  
    public static boolean isMobile(String value){ 
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^(13|14|15|18|17|)[0-9]{9}$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是ip地址 
     * @param value 
     */  
    public static boolean isIp(String value){ 
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)\\.(25[0-5]|2[0-4]\\d|[0-1]\\d{2}|[1-9]?\\d)$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是图片 
     * @param value 
     */  
    public static boolean isPicture(String value){  
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("(.*)\\.(jpg|bmp|gif|ico|pcx|jpeg|tif|png|raw|tga)$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是压缩文件 
     * @param value 
     */  
    public static boolean isRar(String value){  
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("(.*)\\.(rar|zip|7zip|tgz)$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是日期 
     * @param value 
     */  
    public static boolean isDate(String value){ 
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^((\\d{2}(([02468][048])|([13579][26]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])))))|(\\d{2}(([02468][1235679])|([13579][01345789]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\\s(((0?[0-9])|([1-2][0-3]))\\:([0-5]?[0-9])((\\s)|(\\:([0-5]?[0-9])))))?$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是QQ号码 
     * @param value 
     */  
    public static boolean isQQ(String value){  
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^[1-9]*[1-9][0-9]*$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是电话号码的函数(包括验证国内区号,国际区号,分机号) 
     * @param value 
     */  
    public static boolean isTel(String value){  
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^(([0\\+]\\d{2,3}-)?(0\\d{2,3})-)?(\\d{7,8})(-(\\d{3,}))?$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 用来用户注册。匹配由数字、26个英文字母或者下划线组成的字符串 
     * @param value 
     */  
    public static boolean isUsername(String value){  
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^\\w+$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是字母 
     * @param value 
     */  
    public static boolean isLetter(String value){  
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^[A-Za-z]+$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是大写字母 
     * @param value 
     */  
    public static boolean isLetter_u(String value){  
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^[A-Z]+$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是大写字母 
     * @param value 
     */  
    public static boolean isLetter_l(String value){ 
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^[a-z]+$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
      
    /** 
     * 是否是金额
     * @param value 
     */  
    public static boolean isPriceCH(String value){ 
    	if(isEmpty(value)) {return true;}
        Pattern p=null;//正则表达式  
        Matcher m=null;//操作符表达式  
        boolean b=false;  
        p=Pattern.compile("^([1-9]{1}[0-9]{0,}(\\.[0-9]{0,2})?|0(\\.[0-9]{0,2})?|\\.[0-9]{1,2})$");  
        m=p.matcher(value);  
        b=m.matches();  
        return b;  
    }  
}
