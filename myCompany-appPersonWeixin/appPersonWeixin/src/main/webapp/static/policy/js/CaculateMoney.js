//已经选择的社保类,**********已使用
function writeSocial(){
  if (datasetSbzSetInfo.getCurrent()==null){
     datasetSbzSetInfo.insertRecord();
  }
  var rcd = datasetSb.getFirstRecord();
  var ids="-100,", names="",cityIds="";
  while (rcd) {
    if (ids.indexOf(","+rcd.getString("SBZ_ID")+",")<0 && rcd.getString("SF_YCX")!="1"){
       ids=ids+rcd.getString("SBZ_ID")+",";
       names=names+rcd.getString("SBZ_MC")+" ";  
       cityIds=cityIds+rcd.getString("CS_ID")+",";
    }
    rcd = rcd.getNextRecord();
  }
  ids+="-100";
  cityIds+="-100";
  datasetSbzSetInfo.setValue("selected_group_ids",ids);
  datasetSbzSetInfo.setValue("selected_group_names",names);
  datasetSbzSetInfo.setValue("selected_city_ids",cityIds);
}

function checkBili(record,prefix,oldValue){
   var bllx=record.getString("BLLX");
   if (record.getString(prefix+"_BL")==""){
       return true;
   }
   if (bllx=="1"){ //固定比例
      if (record.getValue(prefix+"_BL")!=record.getValue(prefix+"_BLZD")){
         record.setValue(prefix+"_BL",record.getValue(prefix+"_BLZD"));
      }
   }
   if (bllx=="2"){//浮动比例
      var cha=floatRound(record.getValue(prefix+"_BL")-record.getValue(prefix+"_BLZD"),8);
      //alert(cha);
      if (cha==0) return true;      
      var buchang=floatRound(record.getValue(prefix+"_BLBC"),8);
      //alert(buchang);
      if (floatRound((cha*100000000)%(buchang*100000000),2)>0){
         alert("比例不符合设定规则！");
         record.setValue(prefix+"_BL",oldValue);
         return false;
      }      
   }
   return true;
}


/**计算一个社保
 anMoney=base*ratio( 基数*比例) addMoney 附加金额 jingdu 精确值 jisuanfangshi 进位方式
**/
function calSbCp(anMoney,addMoney,jingdu,jisuanfangshi){
	var iJd = "" + jingdu;
	var iJsfs = "" + jisuanfangshi;
	if (iJd == "")
		iJd = "2";
	if (iJsfs == "")
		iJsfs = "1";
	anMoney = floatRound(anMoney, 5);
	if (parseFloat(iJd) <= 2) {// 小数位小于等于2位，不是精确值
		if (iJsfs == "1") {// 四舍五入
		} else if (iJsfs == "4") {// 先四舍五入再见零进整
			anMoney = floatRound(anMoney, parseFloat(iJd) + 1);
			var extStr = "0.";
			for (var i = 0; i < parseFloat(iJd); i++) {
				extStr = extStr + "0";
			}
			extStr = extStr + "4";
			var extDouble = parseFloat(extStr);
			anMoney = anMoney + extDouble;
		} else if (iJsfs == "2") {// 见零进整
			var tmpMoney = anMoney + "";
			var dotPos = tmpMoney.indexOf(".");
			if (dotPos >= 0) {// 有小数点
				var preMoney = tmpMoney.substring(0, dotPos + 1
						+ parseFloat(iJd))
						+ "0";
				tmpMoney = tmpMoney.substring(dotPos + 1 + parseFloat(iJd));
				if (tmpMoney != "") {
					if (parseFloat(tmpMoney) > 0) {// 需要见零进位
						anMoney = parseFloat(preMoney)
								+ Math.pow(10, -1 * parseFloat(iJd));
					}
				}
			}
		} else if (iJsfs == "5") {// 先截位再进位
			var tmpMoney = anMoney + "";
			var dotPos = tmpMoney.indexOf(".");
			if (dotPos >= 0) {// 有小数点
				// tmpMoney=tmpMoney+"00000";
				// 10.001
				// 012345
				var preMoney = tmpMoney.substring(0, dotPos + 1
						+ parseFloat(iJd))
						+ "0";
				tmpMoney = tmpMoney.substring(dotPos + 1 + parseFloat(iJd),
						dotPos + 2 + parseFloat(iJd));
				if (tmpMoney != "") {
					if (parseFloat(tmpMoney) > 0) {// 需要见零进位
						anMoney = parseFloat(preMoney)
								+ Math.pow(10, -1 * parseFloat(iJd));
					}
				}
			}
		} else if (iJsfs == "3") {// 截位
			var tmpMoney = anMoney + "";
			var dotPos = tmpMoney.indexOf(".");
			if (dotPos >= 0) {// 有小数点
				tmpMoney = tmpMoney + "00000";
				// 10.001
				// 012345
				if (parseFloat(iJd) == 0) {
					tmpMoney = tmpMoney.substring(0, dotPos);
				} else {
					tmpMoney = tmpMoney.substring(0, dotPos + 1
							+ parseFloat(iJd))
							+ "0";
				}
				anMoney = parseFloat(tmpMoney);
			}
		}
		anMoney = floatRound(anMoney, parseFloat(iJd));
	} else { // 小数位大于2位，是精确值
		anMoney = floatRound(anMoney, parseFloat(iJd));
	}
	if( !addMoney ){
		addMoney = 0 ;
	}
	var result = parseFloat(anMoney + addMoney);
	if( !result ){
		result = 0 ;
	}
	return result;
}

// 具体页面中计算.入离职用到，与calculateInsurance1不同处用“*”标出
function calculateInsurance(record){
   var base=getNumber(record.getValue("QY_JS"));
   var eRatio=getNumber(record.getValue("QY_BL"));// 企业比例
   var pRatio=getNumber(record.getValue("GR_BL")); // 个人比例
   var eApdMoney=getNumber(record.getValue("QY_FJJE")); // 企业附加金额
   var pApdMoney=getNumber(record.getValue("GR_FJJE")); //个人附加金额

   var eMoney=0,pMoney=0,money=0;
   //单位金额   
   if (eRatio>0||eApdMoney>0){
      if (eRatio>0 && base<0) return false;
      eMoney=calSbCp(base,eRatio,eApdMoney,record.getString("QY_JD"),record.getString("QY_JSFS"));
   }
   //个人金额
   if (pRatio>0||pApdMoney>0){
      if (pRatio>0 && base<0) return false;
      pMoney=calSbCp(base,pRatio,pApdMoney,record.getString("GR_JD"),record.getString("GR_JSFS"));
   }   
   if (eMoney+pMoney>=0){
      money=eMoney+pMoney;      
      record.setValue("QY_JE",eMoney);
      record.setValue("GR_JE",pMoney);
      record.setValue("CPJE",money);
   }
}
//具体页面中计算.社保用到,与calculateInsurance不同处用“*”标出
function calculateInsurance1(record){
   var base=getNumber(record.getValue("QY_JS"));
   var eRatio=getNumber(record.getValue("QY_BL"));//企业比例
   var pRatio=getNumber(record.getValue("GR_BL")); //个人比例
   var eApdMoney=getNumber(record.getValue("QY_FJJE")); //企业附加金额
   var pApdMoney=getNumber(record.getValue("GR_FJJE")); //个人附加金额

   var eMoney=0,pMoney=0,money=0;
   //单位金额   
   if (eRatio>0||eApdMoney>0){
      if (eRatio>0 && base<0) return false;
      eMoney=calSbCp(base,eRatio,eApdMoney,record.getString("QY_JD"),record.getString("QY_JSFS"));
   }
   //个人金额
   if (pRatio>0||pApdMoney>0){
      if (pRatio>0 && base<0) return false;
      pMoney=calSbCp(base,pRatio,pApdMoney,record.getString("GR_JD"),record.getString("GR_JSFS"));
   }   
   if (eMoney+pMoney>=0){
      money=eMoney+pMoney;      
      record.setValue("QY_JE",eMoney);
      record.setValue("GR_JE",pMoney);
      record.setValue("JE",money);
   }
}
/**
 * 批量入职和变更的横表计算
 *recordEmp 一个员工（一行记录）; fieldName 改变了基数的列名; recordInsurance 一个产品的比例及计算方式信息
**/
function calculateInsuranceMulti(recordEmp,fieldName,recordInsurance){
   var base=getNumber(recordEmp.getValue(fieldName));
   var suffix=fieldName.substring(5); //"base_********"
   var eRatio=getNumber(recordInsurance.getValue("E_RATIO"));//企业比例****************************
   var pRatio=getNumber(recordInsurance.getValue("P_RATIO")); //个人比例****************************
   var eApdMoney=getNumber(recordInsurance.getValue("E_ADD_MONEY")); //企业附加金额****************************
   var pApdMoney=getNumber(recordInsurance.getValue("P_ADD_MONEY")); //个人附加金额****************************
   var eMoney=0,pMoney=0,money=0;
   //单位金额   
   if (eRatio>0||eApdMoney>0){
      if (eRatio>0 && base<=0) return false;
      eMoney=calSbCp(base,eRatio,eApdMoney,recordInsurance.getString("E_PRECISION"),recordInsurance.getString("E_CACULATE_TYPE"));
   }
   //个人金额
   if (pRatio>0||pApdMoney>0){
      if (pRatio>0 && base<=0) return false;
      pMoney=calSbCp(base,pRatio,pApdMoney,recordInsurance.getString("P_PRECISION"),recordInsurance.getString("P_CACULATE_TYPE"));
   }   
   if (eMoney+pMoney>0){
      money=eMoney+pMoney;      
      recordEmp.setValue("emoney_"+suffix,eMoney);
      recordEmp.setValue("pmoney_"+suffix,pMoney);
      recordEmp.setValue("money_"+suffix,money);
   }
   addSumMulti(recordEmp);
}

//检查基数范围逻辑
function checkBase(record){
   if (record.getString("QY_JS")!=""){
       if(getNumber(record.getValue("FIXED_BASE"))>0){
            if(record.getValue("base")!=record.getValue("FIXED_BASE")){
               alert(record.getString("CP_MC")+"\u57FA\u6570\u5E94\u56FA\u5B9A\u4E3A"+record.getValue("FIXED_BASE"));  //基数应固定为
               //clearRecord(record);
               return false;
            }
       }
       if(getNumber(record.getValue("TOP_BASE"))>0){
            if(record.getValue("base")>record.getValue("TOP_BASE")){
               alert(record.getString("CP_MC")+"\u57FA\u6570\u4E0D\u80FD\u5927\u4E8E"+record.getValue("TOP_BASE")); //基数不能大于
               //clearRecord(record);
               return false;
            }
       }
       if(getNumber(record.getValue("LOW_BASE"))>0){
            if(record.getValue("base")<record.getValue("LOW_BASE")){
               alert(record.getString("CP_MC")+"\u57FA\u6570\u4E0D\u80FD\u5C0F\u4E8E"+record.getValue("LOW_BASE"));  //基数不能小于
               //clearRecord(record);
               return false;
            }
       }       
   }
   return true;
}

//检查社保产品是否在时间段上冲突
function checkConflictSb(){
  var rcd = datasetSb.getFirstRecord();
  var i=0;
  while (rcd) {
    var wai_qs=trim(rcd.getString("FWQS_NY"));
    if (wai_qs==null ||wai_qs==""){
    	wai_qs="999999";
    }
    var wai_js=trim(rcd.getString("FWJS_NY"));
    if (wai_js==null ||wai_js==""){
    	wai_js="999999";
    }    
    if (wai_qs<=wai_js){
       var j=0;
       var rcd0 = datasetSb.getFirstRecord();
       while (rcd0) {
         var nei_qs=trim(rcd0.getString("FWQS_NY"));
         if (nei_qs==null ||nei_qs==""){
	     nei_qs="999999";
	 }
         var nei_js=trim(rcd0.getString("FWJS_NY"));
         if (nei_js==null ||nei_js==""){
	     nei_js="999999";
	 }
         if (nei_qs<=nei_js && i!=j && rcd.getString("SBZ_ID")==rcd0.getString("SBZ_ID") && rcd.getString("CP_ID")==rcd0.getString("CP_ID")){
            if(wai_qs>nei_js || nei_qs>wai_js){            
            }else{
               alert(rcd0.getString("SBZ_MC")+" "+rcd0.getString("CP_MC")+" \u65F6\u95F4\u51B2\u7A81\uFF01"); 
               return false;
            }
         }
         j++;
         rcd0 = rcd0.getNextRecord();
       }       
    }    
    i++;
    rcd = rcd.getNextRecord();
  } 
  return true;
}

//检查非社保产品是否在时间段上冲突
function checkConflictNotSb(){
  var rcd = datasetBjd.getFirstRecord();
  var i=0;
  while (rcd) {
    var wai_qs=getFloatFromDate(rcd.getString("FWQS_RQ"));
    var wai_js=getFloatFromDate(rcd.getString("FWJS_RQ"));
    if (wai_qs<=wai_js){
       var j=0;
       var rcd0 = datasetBjd.getFirstRecord();
       while (rcd0) {
         var nei_qs=getFloatFromDate(rcd0.getString("FWQS_RQ"));
         var nei_js=getFloatFromDate(rcd0.getString("FWJS_RQ"));
         if (nei_qs<=nei_js && i!=j && rcd.getString("CP_ID")==rcd0.getString("CP_ID")){
            if(wai_qs>nei_js || nei_qs>wai_js){            
            }else{
               alert(rcd0.getString("CP_MC")+" \u65F6\u95F4\u51B2\u7A81\uFF01"); 
               return false;
            }
         }
         j++;
         rcd0 = rcd0.getNextRecord();
       }       
    }    
    i++;
    rcd = rcd.getNextRecord();
  } 
  return true;
}

//计算总额
//与addSum1不同用“*”标出
function addSum(writeDataset){
    /*var sum=0;
    var rcd=datasetInsurance.getFirstRecord();
    while (rcd!=null){
       //if (rcd.getValue("select")==true){
          //if (getNumber(rcd.getValue("money"))>0){
             sum+=getNumber(rcd.getValue("money"));
          //}
       //}
       rcd=rcd.getNextRecord();
    }
    var rcd1=datasetNotInsurance.getFirstRecord();
    while(rcd1!=null){
               if (getNumber(rcd1.getValue("PRODUCT_PRICE"))>0){//******************************
	           sum+=getNumber(rcd1.getValue("PRODUCT_PRICE"));//******************************
	       }       
       rcd1=rcd1.getNextRecord();
    }
    writeDataset.setValue("contract_fund",sum+"");*/
}
//计算总额
//
function addSumMulti(rcd){
    var sum=0;
    var dataset=rcd.getDataset();
    for (var i=0;i<dataset.getFieldCount();i++){
       var fieldName=dataset.getField(i).getName();
       if (fieldName.indexOf("money_")>=0 && fieldName.indexOf("emoney_")<0&&fieldName.indexOf("pmoney_")<0){
       	  sum+=getNumber(rcd.getValue(fieldName));
       }
    }   
    rcd.setValue("contract_fund",sum+"");
}
//计算总额
//与addSum不同用“*”标出
function addSum1(writeDataset){
    var sum=0;
    var rcd=datasetInsurance.getFirstRecord();
    while (rcd!=null){
       if (rcd.getValue("select")==true){
          if (getNumber(rcd.getValue("money"))>0){
             sum+=getNumber(rcd.getValue("money"));
          }
       }
       rcd=rcd.getNextRecord();
    }
    var rcd1=datasetNotInsurance.getFirstRecord();
    while(rcd1!=null){
               if (getNumber(rcd1.getValue("money"))>0){//******************************
	           sum+=getNumber(rcd1.getValue("money"));//******************************
	       }       
       rcd1=rcd1.getNextRecord();
    }
    writeDataset.setValue("contract_fund",sum+"");
}

/**
 社保补缴计算
 parma@cityIdentify:标记几个特殊城市，用来算滞纳金。"0"：普通城市 "010"：北京 ......
 parma@datasetLateFee:存放滞纳金的计算方法
**/
function calculatSupply(startMonth,endMonth,fundMonth,productId,base,datasetRatio,cityIdentify,datasetLateFee){	
    var curMonth=startMonth;
    var supplyEMoney=0,supplyPMoney=0,eLatefee=0,pLatefee=0,exactEMoney=0,exactPMoney=0;
    while (parseFloat(curMonth)<=parseFloat(endMonth)){
    	  if (productId=="200" && cityIdentify=="010" &&
    	       (parseFloat(curMonth.substring(0,4))<parseFloat(fundMonth.substring(0,4)))
    	  ) { //北京养老保险 ****************************************
              var tmp=calInsurance_beijing_200(getNumber(base),curMonth,fundMonth,datasetLateFee);
              supplyEMoney+=tmp[0];
              supplyPMoney+=tmp[1];
              eLatefee+=tmp[2];
              pLatefee+=tmp[3];
              exactEMoney+=tmp[0];
              exactPMoney+=tmp[1];
          }else{     //**************************************************************************************     
	       var rcd=datasetRatio.getFirstRecord();
	       while (rcd!=null){
		  if (rcd.getString("PRODUCT_ID")==productId){			  
			  var ratioStartMonth=toStr(rcd.getString("START_MONTH"));
			  var ratioEndMonth=toStr(rcd.getString("END_MONTH"));
			  if( (parseFloat(ratioStartMonth)<=parseFloat(curMonth))&&
			     (ratioEndMonth=="" || parseFloat(ratioEndMonth)>=parseFloat(curMonth))
			    ) {
				  var eRatio=getNumber(rcd.getString("E_RATIO"));//企业比例
				  var pRatio=getNumber(rcd.getString("P_RATIO")); //个人比例
				  var ePrice=getNumber(rcd.getString("E_ADD_MONEY")); //企业附加金额
				  var pPrice=getNumber(rcd.getString("P_ADD_MONEY"));  //个人附加金额
				  //var fixBase=getNumber(rcd.getString("FIXED_BASE"));  //固定基数
				  var ePrecision=rcd.getString("E_PRECISION");  //企业精确度
				  var pPrecision=rcd.getString("P_PRECISION");  //个人精确度
				  var eCaculateType=rcd.getString("E_CACULATE_TYPE");  //企业进位方式
				  var pCaculateType=rcd.getString("P_CACULATE_TYPE");  //个人进位方式				  
	                          
	                          var eMoney=calSbCp(getNumber(base),eRatio,ePrice,ePrecision,eCaculateType);
				  var pMoney=calSbCp(getNumber(base),pRatio,pPrice,pPrecision,pCaculateType);
				  supplyEMoney+=eMoney;
				  supplyPMoney+=pMoney;  
				  
				  exactEMoney+=floatRound(getNumber(base)*eRatio+ePrice,5);
				  exactPMoney+=floatRound(getNumber(base)*pRatio+pPrice,5);
				  break;
			  }				  
		  }
		  rcd=rcd.getNextRecord();
	       }//while
	  }//if*******************************************************************************************
	  curMonth=addMonth(curMonth); //加一个月 
    }//while
    var rtn=new Array();
    rtn[0]=supplyEMoney;
    rtn[1]=supplyPMoney;
    rtn[2]=eLatefee;
    rtn[3]=pLatefee;
    rtn[4]=exactEMoney;
    rtn[5]=exactPMoney;
    return rtn;
}

//社保补缴三个月份检查
function checkSupplyMonth(dataset,field,startMonth,endMonth,fundMonth){
	if(field.getName()=="START_MONTH"){
	   if(!checkMonth(startMonth,"\u8865\u7F34\u8D77\u59CB\u6708")){ //补缴起始月
	       dataset.setValue("START_MONTH",""); 
	       return false;
	   }else if(startMonth!=""){
	       //if(parseFloat(startMonth)<parseFloat(datasetSocialSecurity.getString("START_MONTH"))){
	          //alert("补缴起始月不能早于缴费起始月！");
	          //dataset.setValue("START_MONTH",""); 
	       //}
	   }         
	}
	if(field.getName()=="END_MONTH"){
	   if(!checkMonth(endMonth,"\u8865\u7F34\u622A\u81F3\u6708")){  //补缴截至月
	       dataset.setValue("END_MONTH","");
	       return false;   
	   }       
	}
	if(field.getName()=="FUND_MONTH"){
	   if(!checkMonth(fundMonth,"\u62A5\u8868\u6708")){  //报表月
	       dataset.setValue("FUND_MONTH","");
	       return false;   
	   }    
	}
	if(startMonth!="" && endMonth!=""){
	     if(parseFloat(startMonth)>parseFloat(endMonth)){
	        alert("\u8865\u7F34\u8D77\u59CB\u6708\u4E0D\u80FD\u665A\u4E8E\u8865\u7F34\u622A\u81F3\u6708!"); //补缴起始月不能晚于补缴截至月
	        dataset.setValue("START_MONTH",""); 
	        return false;
	     }
	}
	if(startMonth!="" && fundMonth!=""){
	     if(parseFloat(startMonth)>=parseFloat(fundMonth)){
	        alert("\u8865\u7F34\u8D77\u59CB\u6708\u5FC5\u987B\u5C0F\u4E8E\u62A5\u8868\u6708!");  //补缴起始月必须小于报表月
	        dataset.setValue("START_MONTH",""); 
	        return false;
	     }
	}
	
	if(fundMonth!="" && endMonth!=""){
	     if(parseFloat(endMonth)>parseFloat(fundMonth)){
	        alert("\u8865\u7F34\u622A\u81F3\u6708\u4E0D\u80FD\u665A\u4E8E\u62A5\u8868\u6708!"); //补缴截至月不能晚于报表月
	        dataset.setValue("END_MONTH","");
	        return false;
	     }
	}

}

/*北京养老滞纳金计算
 *parma@ base 基数
 *parma@ supplyMonth 补缴月
 *parma@ fundMonth 补缴资金发生月份
 *parma@ datasetLateFee 存放北京社保滞纳金计算方法
 */
function calInsurance_beijing_200(base,supplyMonth,fundMonth,datasetLateFee){
   var fundYear=fundMonth.substring(0,4);
   var supplyYear=supplyMonth.substring(0,4);
   var rcd=datasetLateFee.getFirstRecord();
   var money=0,eMoney=0,pMoney=0,eLateMoney=0,pLateMoney=0;
   var finded=0;maxYear=0;
   while (rcd){
      if (parseFloat(rcd.getString("FUND_YEAR"))>maxYear){
	   maxYear=parseFloat(rcd.getString("FUND_YEAR"));
      }
      if (rcd.getString("FUND_YEAR")==fundYear){
      	 if (rcd.getString("SUPPLY_YEAR")==supplyYear){
      	    money=base*(rcd.getValue("E_RATIO")+rcd.getValue("P_RATIO"))*rcd.getValue("THE_RATIO");
      	    pMoney=base*rcd.getValue("P_RATIO");
      	    eMoney=money-pMoney;
      	    eLateMoney=eMoney-base*rcd.getValue("E_RATIO");
            pLateMoney=pMoney-base*rcd.getValue("P_RATIO");
      	    finded=1;
      	    break;
      	 }
      }
      rcd=rcd.getNextRecord();	
   }
   if (finded==0){
   	rcd=datasetLateFee.getFirstRecord();
   	while (rcd){
	      if (rcd.getString("FUND_YEAR")==(maxYear+"")){
	      	 if (rcd.getString("SUPPLY_YEAR")==supplyYear){
	      	    money=base*(rcd.getValue("E_RATIO")+rcd.getValue("P_RATIO"))*rcd.getValue("THE_RATIO");
	      	    pMoney=base*rcd.getValue("P_RATIO");
	      	    eMoney=money-pMoney;
	      	    eLateMoney=eMoney-base*rcd.getValue("E_RATIO");
	            pLateMoney=pMoney-base*rcd.getValue("P_RATIO");
	      	    finded=1;
	      	    break;
	      	 }
	      }
	      rcd=rcd.getNextRecord();	
	}
   }
   var rtn=new Array();
   rtn[0]=floatRound(eMoney-eLateMoney,2);
   rtn[1]=floatRound(pMoney-pLateMoney,2);
   rtn[2]=floatRound(eLateMoney,2);
   rtn[3]=floatRound(pLateMoney,2);
   return rtn;
}

//修改了补缴明细后的自动计算(社保办理和修改界面调用)
function cal_supply_datail(dataset,record){
   var rcd = dataset.getFirstRecord();
    var sum=0,eSum=0,pSum=0,eLatefee=0,pLatefee=0,exactEMoney=0,exactPMoney=0;
    while (rcd) {
       sum+=rcd.getValue("MONEY");
       eSum+=rcd.getValue("E_MONEY");
       pSum+=rcd.getValue("P_MONEY");
       eLatefee+=rcd.getValue("E_LATEFEE");
       pLatefee+=rcd.getValue("P_LATEFEE");
       exactEMoney+=rcd.getValue("EXACT_E_MONEY");
       exactPMoney+=rcd.getValue("EXACT_P_MONEY");
       rcd = rcd.getNextRecord();
    }       
    datasetSocialSecuritySupply.disableEvents();
    try{
          var rcd1 = datasetSocialSecuritySupply.getFirstRecord();
          while (rcd1) {
             if (rcd1.getString("SOCIAL_SECURITY_SUPPLY_ID")==record.getString("SOCIAL_SECURITY_SUPPLY_ID")){
                rcd1.setValue("MONEY",sum);
                rcd1.setValue("E_MONEY",eSum);
                rcd1.setValue("P_MONEY",pSum);
                rcd1.setValue("E_LATEFEE",eLatefee);
                rcd1.setValue("P_LATEFEE",pLatefee);
                rcd1.setValue("EXACT_E_MONEY",exactEMoney);
                rcd1.setValue("EXACT_P_MONEY",exactPMoney);
                rcd1.setValue("MONTH_MONEY",floatRound(sum/month6Subtration(datasetSocialSecuritySupply.getString("START_MONTH"),datasetSocialSecuritySupply.getString("END_MONTH")),2));
                break;
             }
             rcd1 = rcd1.getNextRecord();
          } 
    }finally {    
          datasetSocialSecuritySupply.enableEvents();
    }                
}
//计算补缴(社保办理和修改界面调用)
function cal_supply(startMonth,endMonth,fundMonth){
    //alert(datasetLateFee);
    var base=datasetSocialSecuritySupply.getValue("BASE");    
    var rtn=null;
    if(startMonth!="" && endMonth!=""){
        var cityId=datasetGroupWithCity.getString("city_id");    
        var cityCode="0";  
        if (cityId==city_beijing){ //北京  
            cityCode="010";
        }   
        //开始计算子项金额
        datasetSocialSecuritySupplyItemEdit.disableEvents();
        try{
            var rcd = datasetSocialSecuritySupplyItemEdit.getFirstRecord();
            while (rcd) {
              rtn=calculatSupply(startMonth,endMonth,fundMonth,rcd.getString("PRODUCT_ID"),base,datasetRatio,cityCode,datasetLateFee);
              if (rtn!=null){
                 rcd.setValue("E_MONEY",rtn[0]);
                 rcd.setValue("P_MONEY",rtn[1]);
                 rcd.setValue("MONEY",rtn[0]+rtn[1]);
                 rcd.setValue("E_LATEFEE",rtn[2]);
                 rcd.setValue("P_LATEFEE",rtn[3]);
                 rcd.setValue("EXACT_E_MONEY",rtn[4]);
                 rcd.setValue("EXACT_P_MONEY",rtn[5]);
              }
              rcd = rcd.getNextRecord();
            }        
       }finally{
            datasetSocialSecuritySupplyItemEdit.enableEvents();
       }
       //计算完子项后置总补缴金额
       cal_supply_datail(datasetSocialSecuritySupplyItemEdit,datasetSocialSecuritySupplyItemEdit.getCurrent());
    }    
}

function getFloatFromDate(dateStr){
   if (dateStr==null || dateStr=="") return 99999999;
   var s=dateStr.substring(0,4)+dateStr.substring(5,7)+dateStr.substring(8);
   return parseFloat(s);
}