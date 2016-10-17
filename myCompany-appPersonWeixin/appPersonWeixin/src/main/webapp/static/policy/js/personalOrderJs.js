
/**
 * 根据id获取一个对象
 * @param objId
 * @returns
 */
function objGet( objId ){
	return $id(objId).objects[0];
}

/**
 * 查询时，基础信息加载出来后的一些处理
 * @param orderRecId 订单履历头表id
 * @param step 节点:1，增员创建；2，增员完善；3，增员确认;4，变更；5，变更确认；6，撤销；7，撤销确认
 * @param parentOrderId 母订单id
 * @param orderTierId 订单表中保存的订单层级
 */
function orderBaseInfoLoad(orderRecId,step,parentOrderId,orderTierId){
	var current = objGet("dataSetBdEmpBaseInfo").getData('#') ;
	current.set('orderStep',step);
	window.orderStep = step;
	current.set('side',$.cookie('side'));//side，1：我是委托方，2：我是受托方
	if( orderRecId ){
		
		//页面加载（创建-修改）时的用户基础信息id
		window.firstLoadBaseInfoCardId = current.get('cardId');
		window.firstLoadBaseInfoCardType = current.get('cardType');
		var isCreateChildrenOrder = false;
		//订单状态
		var status = current.get('orderStatus');
		//记录页面刚进入时的订单状态
		//（如果保存后，状态发生变化，则status会被回填，所以，设置此全局变量记录第一次进入时的状态值）
		window.firstLoadOrderStatus = status;
		if( parentOrderId ){
			
			//转包订单，创建
			if( step == 1 ){
				isCreateChildrenOrder = true ;
				//是创建子订单
				current.set('isCreateChildrenOrder',isCreateChildrenOrder);
				
				//部分信息不可见
				objGet('autoFormPolicy').set('visible',false);
				objGet('toolBarNsb').set('visible',false);
				
				//母订单中除了受托供应商以外其他数据都不能编辑
				objGet('baseDataForm').set('readOnly',true);
				var policyDetailColumns = view.get('#policyDetailDataGrid').get('columns');
				for(var i=0;i<policyDetailColumns.size;i++){
					if( policyDetailColumns.items[i].get('name') != 'receiveOrgName'){
						policyDetailColumns.items[i].set('readOnly',true);
					}else{
						policyDetailColumns.items[i].set('readOnly',false);
					}
				}
				var nSbDatagridColumns = view.get('#nSbDatagrid').get('columns');
				for(var i=0;i<nSbDatagridColumns.size;i++){
					if( nSbDatagridColumns.items[i].get('name') != 'receiveOrgName'){
						nSbDatagridColumns.items[i].set('readOnly',true);
					}else{
						nSbDatagridColumns.items[i].set('readOnly',false);
					}
				}
			}
			//转包订单，完善
			if( step == 2 ){
				//除了社保的账单模板、账单月、企业基数、个人基数、企业比例、个人比例、企业金额、个人金额
				//自己的报价单数据可以修改，其他都不能改
				objGet('baseDataForm').set('readOnly',true);
				//部分信息不可见
				objGet('policyGroupElement').set('visible',false);
				objGet('sbGroupElement').set('visible',false);
				objGet('addNsb').set('visible',false);
			}
			
		}else{
			//判断是否禁用表单
			setDisableForm(status,step);
			
		}
		//设置订单层级
		if( orderTierId ){
			current.set('orderTierId',orderTierId);
		}
		
		if( step == 4){
			//变更时，只有头订单可以加产品
			if( parentOrderId == undefined ){
				view.get('#policyGroupElement').set('visible',true);
				view.get('#sbGroupElement').set('visible',true);
			}else{
				view.get('#policyGroupElement').set('visible',false);
				view.get('#sbGroupElement').set('visible',false);
			}
			
		}
		
				
		var isFirstChange = false ;
		var orderHasChanged = false;
		if( step == 4 && ( window.firstLoadOrderStatus == 4 || window.firstLoadOrderStatus == 7
				|| window.firstLoadOrderStatus == 10 )){
			isFirstChange = true ;
		}
		if( (step == 4 || step == 5) && 
				(window.firstLoadOrderStatus == 6 
						//|| window.firstLoadOrderStatus == 7
						) ){
			orderHasChanged = true ;
		}
		
		var toCancel = false ;
		if( (step == 6 && (status==2 ||status == 4 || status == 7)) ){
			toCancel = true ;
			isFirstChange = true;//第一次撤销
		}
		if( step == 7 ){
			toCancel = true ;
			var dataSetPolicyDetail2 = view.get('#dataSetPolicyDetail');
			//如果是交互订单，撤销确认，则非社保公积金的服务截至月可以手填
			//因为这个时候非社保公积金是子订单自己的，之前还没有录入过服务截至月
			if(window.orderMutualId != '999999999999999'){
				view.get('^paymentEndMonthNsb').set('readOnly',false);
				dataSetPolicyDetail2.set('dataProvider','personalOrderPR#queryMutualSbDetail');
				dataSetPolicyDetail2.set('parameter',{'orderMutualId':window.orderMutualId}).flush();
				
				current.set('orderMutualId',window.orderMutualId); 
			}else{
				dataSetPolicyDetail2.set('parameter',{'orderRecId':orderRecId,
					'paymentEndMonth':''}).flush();
			}
			
				
			var dataSetHsEmpOrdNsbDetailRec2 = view.get('#dataSetHsEmpOrdNsbDetailRec');
			dataSetHsEmpOrdNsbDetailRec2.set('parameter',{'orderRecId':orderRecId,
				'paymentEndMonth':''}).flush();
		}
		
		
		
		//撤销时先不查询
		if( !toCancel ){
			
			var queryAllSb = false ;
			//如果是变更确认（非交互），则应该把清零的明细也查出来，因为变更时有清零操作，在确认时要查询出来
			if( step == 5 ){
				queryAllSb = true ;
			}
			
			var dataSetPolicyDetail = objGet('dataSetPolicyDetail');
			//加载社保公积金列表
			dataSetPolicyDetail.set('parameter',{'orderRecId':orderRecId,'isFirstChange':isFirstChange,
				'paymentStartMonth':'','orderHasChanged':orderHasChanged,'queryAllSb':queryAllSb,
				'toCancel':toCancel,'isCreateChildrenOrder':isCreateChildrenOrder}).flush();
			
			//加载非社保公积金列表
			var dataSetHsEmpOrdNsbDetailRec = objGet('dataSetHsEmpOrdNsbDetailRec');
			dataSetHsEmpOrdNsbDetailRec.set('parameter',{'orderRecId':orderRecId,'isFirstChange':isFirstChange,
				'paymentStartMonth':'','orderHasChanged':orderHasChanged,'toCancel':toCancel}).flush();
		}
		current.set('isFirstChange',isFirstChange);
		window.isFirstChange=isFirstChange;
	}

}


/**
 * @param status订单状态
 * @param step 当前步骤
 * @param step 是否是创建子订单
 */
function setDisableForm(status,step){
	switch (step) {
		case 1: if( (",2,4,7,10,").indexOf(','+status+',') !=-1)disableForm(); break;//创建查询
		case 2: {//完善查询
			//完善时不管什么状态都不能修改订单基础信息
			objGet('baseDataForm').set('readOnly',true);
			if( status == '3' ){
				disableForm(); 
			}
			break;
		}
		case 3: {//增员确认，只能提交，不能修改任何内容
			disableForm(); 
			objGet('submitOrderBtn').set('disabled',false);
			break;
		}
		case 4: if( (",6,").indexOf(','+status+',') !=-1 )disableForm(); break;//变更查询
		case 5: if( status == '7' )disableForm(); break;//变更确认查询
		case 6: if( (",9,10,").indexOf(','+status+',') !=-1 )disableForm(); break;//撤销查询
		case 7: {
			//撤销确认查询
			if( status == '10' ){
				disableForm();
				objGet('submitOrderBtn').set('disabled',false);
			} 
			break;
		}
	} 
}

/**
 * 禁用表单
 */
function disableForm(){
	objGet('baseDataForm').set('readOnly',true);
	if( objGet('autoFormPolicy') ){
		objGet('autoFormPolicy').set('readOnly',true);
	}
	objGet('policyDetailDataGrid').set('readOnly',true);
	objGet('nSbDatagrid').set('readOnly',true);
	if( objGet('deleteItemMsg') ){
		objGet('deleteItemMsg').set('disabled',true);
	}
	if( objGet('selectQuotation') ){
		objGet('selectQuotation').set('disabled',true);
	}
	if( objGet('changeStartMonthBtn') ){
		objGet('changeStartMonthBtn').set('disabled',true);
	}
	if( objGet('addNsb') ){
		objGet('addNsb').set('disabled',true);
	}
	if( objGet('autoFormChangeMonth') ){
		objGet('autoFormChangeMonth').set('readOnly',true);
	}
	if( objGet('delNsb') ){
		objGet('delNsb').set('disabled',true);
	}
	if( objGet('saveOrderBtn') ){
		objGet('saveOrderBtn').set('disabled',true);
	}
	objGet('submitOrderBtn').set('disabled',true);
}



/**
 * 加载账单模板
 * @param dataSetBillTemplate 账单模板的dataSet
 * @param billTemplateName 账单模板名称
 * @param dataSetPrvdOrder 基础数据的dataSet
 */
function loadBillTemplate(dataSetBillTemplateName,billTemplateName,dataSetPrvdOrderName,type){	
	var baseInfo ;
	if( type && type == 'batAddProd'){
		baseInfo = view.get("#autoformCondition").get("entity");
	}else
	if( dataSetPrvdOrderName ){
		baseInfo = objGet(dataSetPrvdOrderName).getData('#') ; 
	}else{
		baseInfo = objGet("dataSetBdEmpBaseInfo").getData('#') ; 
	}
	var contractId = baseInfo.get('contractId');
	if( contractId ){
		var sendOrgId = baseInfo.get('sendOrgId');
		var receiveOrgId = baseInfo.get('receiveOrgId');
		objGet(dataSetBillTemplateName).set('parameter',
				{'receiveOrgId':receiveOrgId,'sendOrgId':sendOrgId,'billTemplateName':billTemplateName}).flushAsync();
	}else{
		new dorado.MessageBox.alert('请选择合同！');
	}

}

/**
 * 变更确认查询页面做批量确认时加载账单模板
 * @param dataGridOrderName
 * @param billTemplateName
 * @param dataSetBillTemplateName
 */
function loadBillTemplateWhenChangeConfirm(dataGridOrderName,billTemplateName,dataSetBillTemplateName){	
	var selection = view.get('#'+dataGridOrderName).get('selection');
	if( selection.length > 0 ){
		var order = selection[0];
		var sendOrgId = order.get('sendOrgId');
		var receiveOrgId = order.get('receiveOrgId');
		
		objGet(dataSetBillTemplateName).set('parameter',
				{'receiveOrgId':receiveOrgId,'sendOrgId':sendOrgId,'billTemplateName':billTemplateName}).flushAsync();
		
	}

}

/**
 * 根据第一行的值自动加载下一行
 * @param property
 * @param propertyName
 * @param dataSetName
 */
function setOrderSbNextLineValue(entity, property,dataSetName){
	
	var entityList = objGet('dataSetPolicyDetail').getData();
	//如果指定了dataSetName，则使用指定的
	if( dataSetName ){
		entityList = objGet(dataSetName).getData();
	}
	var firstEntity = entityList.getFirst();
	if( firstEntity ){
		var policyGroupId = firstEntity.get('policyGroupId');
		var itemId = firstEntity.get('itemId');
		var firstCity = firstEntity.get('policyCityCode');
		//如果当前行是第一行
		if( entity.entityId == firstEntity.entityId){
			entityList.each(function(data){
				//如果当前行不是第一行，则将第一行的值赋给它
				if(data.entityId!=firstEntity.entityId ){
					var itemType = data.get('itemType');
					var policyGroupId2 = data.get('policyGroupId');
					var itemId2 = data.get('itemId');
					var check = (policyGroupId==policyGroupId2 && itemId==itemId2);
					var check2 = (property=='paymentStartMonth' || property=='paymentEndMonth');
					var policyCityCode = data.get('policyCityCode');
					
					//如果在创建时指派了受托供应商，则相同城市的自动赋值
					if( property == 'receiveOrgId' || property == 'receiveOrgName' ){
						if( window.orderStep == 1 ){
							if( firstCity == policyCityCode){
								data.set(property,firstEntity.get(property));
							}
						}
					}else{
						//如果不是一次性,
						//政策包相同且产品也相同，服务起始月、服务结束月不自动赋值
						if( itemType != 1 && !(check&&check2) ){
							data.set(property,firstEntity.get(property));
						}
						//一次性产品的服务起始月、账单模板、账单起始月自动赋值
						if( itemType == 1 && (property == 'paymentStartMonth' || property == 'companyBillTemplateId'
							|| property == 'companyBillTemplateName'|| property == 'billStartMonth')){
							data.set(property,firstEntity.get(property));
						}
					}
					
				}
				
			});
		}
		
	}
}

/**
 * 根据第一行的值自动加载下一行
 * @param property
 * @param propertyName
 */
function setOrderNsbNextLineValue(entity, property, dataSetName){
	var entityList = '';
	if(dataSetName){
		entityList = dataSetName.getData();
	}else{
		entityList = view.get('#dataSetHsEmpOrdNsbDetailRec').getData();
	}
	var firstEntity = entityList.getFirst();
	if( firstEntity ){
		//如果当前行是第一行
		if( entity.entityId == firstEntity.entityId){
			entityList.each(function(data){
				//如果当前行不是第一行，则将第一行的值赋给它
				if(data.entityId!=firstEntity.entityId ){
					if( !(data.get('itemType') == 1 && property == 'paymentEndMonth') ){
						data.set(property,firstEntity.get(property));
					}
				}
			});
		}
	}
}

/**
 * 比例，输入小数，显示为百分比
 * @param property
 */
function renderCellRatio(ratioProperty,arg,ratio){
	//如果没有值，则获取
	if( ratio == undefined ){// !ratio 改为ratio == undefined；psl 2014-11-10
		ratio = arg.data.getText(ratioProperty);
	}
	if( ratio != undefined){
		ratio = ratio*100 ;
		var ratioStr = ratio+'';
		if(ratioStr.indexOf('.')!=-1 && ratioStr.split('.')[1].length > 4 ){
			ratio = ratio.toFixed(4);
		}
		arg.dom.innerHTML= parseFloat(ratio) + '%';
		arg.processDefault=false;
		
	}
}

/**
 * 订单编辑页面，加载合同时触发的事件
 */
function contractOnValueSelect(dataSetContract){
	//获取合同编号，
	//var dataSetContract = view.get('#${acomp.id("dsBigContract")}');
	var contract = dataSetContract.getData('#');
	var contractId = contract.get('contractId');
	var contractName = contract.get('contractName');
	
	var bdEmpBaseInfo = objGet('dataSetBdEmpBaseInfo').getData('#');
	bdEmpBaseInfo.set('contractId',contractId);
	bdEmpBaseInfo.set('contractName',contractName);
	
	//加载小合同列表
	var dataSetSmallContract = objGet('dataSetSmallContract');
	dataSetSmallContract.set('parameter',{'contractId':contractId}).flush();

	//设置合同类型
	var contractType = contract.get('contractType');
	bdEmpBaseInfo.set('contractType',contractType);
	
	//设置受托方
	bdEmpBaseInfo.set('receiveOrgId',contract.get('receiveOrgId'));
}

/**
 * companyRatio的onTriggerClick事件
 */
function companyRatioTrigger(){
	var current = objGet('dataSetPolicyDetail').getData('#');
	var ids = current.get('aviableCompanyRatio');
	var name = current.get('aviableCompanyRatioName');

	var nameArray = name.split(',');//可选择的比例
	var idArray = ids.split(',');//可选择的比例id
	var jsonArray = new Array();
	//遍历
	for(var i=0 ; i<nameArray.length ;i++){
		if( nameArray[i] ){
			var obj = new Object();
			var ratioAppendArray = nameArray[i].split('|');
			var ratio = ratioAppendArray[0]*1;//比例
			var addAmount = ratioAppendArray[1];//附加值
			obj.key =idArray[i]*1 ;
			obj.value = ratio;
			jsonArray.push(obj);
			window['policyRatioAppend'+idArray[i]]=addAmount;
		}
	}

	$id("viewMain").objects[0].get("@PolicyDetailDTO").getPropertyDef("companyRatioId").set("mapping", jsonArray);
}

/**
 * individualRatio的onTriggerClick事件
 */
function individualRatioTrigger(){
	var current = objGet('dataSetPolicyDetail').getData('#');
	var ids = current.get('aviableIndividualRatio');
	var name = current.get('aviableIndividualRatioName');

	var nameArray = name.split(',');//可选择的比例
	var idArray = ids.split(',');//可选择的比例id
	var jsonArray = new Array();
	//遍历
	for(var i=0 ; i<nameArray.length ;i++){
		if( nameArray[i] ){
			var obj = new Object();
			var ratioAppendArray = nameArray[i].split('|');
			var ratio = ratioAppendArray[0];//比例
			var addAmount = ratioAppendArray[1];//附加值
			obj.key =idArray[i]*1 ;
			obj.value = ratio ;
			jsonArray.push(obj);
			//放在全局变量里，在onValueSelect中调用
			window['policyRatioAppend'+idArray[i]]=addAmount;
		}
	}
	//设置mapping
	$id("viewMain").objects[0].get("@PolicyDetailDTO").getPropertyDef("individualRatioId").set("mapping", jsonArray);
}

/**
 * dataSetPolicyDetail 的onLoadData事件
 * @param parentOrderId
 */
function dataSetPolicyDetailLoad(parentOrderId){
	if( !window.isNotFirstLoad ){
		var dataSetPolicyDetail = objGet('dataSetPolicyDetail');
		var entityList = dataSetPolicyDetail.getData();
		entityList.each(function(current){			
			//如果是创建子订单,清除账单模板
			if( parentOrderId ){
				current.set('companyBillTemplateId',0);
				current.set('companyBillTemplateName','');
			}
			
		});
		//将值设为true
		window.isNotFirstLoad = true;
	}
}

/**
 * 判断是否已选择工作地
 */
function checkHasSelectWorkAddress(){
	var workAddressElement = view.get('#workAddressElement');
	var workAddress = workAddressElement.get('value');

	if( !workAddress ){
		dorado.MessageBox.alert('请选择工作地！',function(){
			workAddressElement.setFocus();
		});
	}
}

/**
 * 获取第一条账单模板(设置默认账单模板)
 */
function getFirstBillTemplate( baseInfo,dataSetBillTemplateName ){
	//设置默认账单模板
	var billTemplateId = null;
	var billTemplateName = null ;
	var sendOrgId = baseInfo.get('sendOrgId');
	var receiveOrgId = baseInfo.get('receiveOrgId');
	if( sendOrgId && receiveOrgId ){
		var dataSetBillTemplate = view.get(dataSetBillTemplateName);
		dataSetBillTemplate.set('parameter',{"sendOrgId":sendOrgId,"receiveOrgId":receiveOrgId}).flush();
		var firstBillTemplate = dataSetBillTemplate.getData().first();
		if( firstBillTemplate ){
			billTemplateId = firstBillTemplate.get('billTemplateId');
			billTemplateName = firstBillTemplate.get('billTemplateName');
		}
	}
	return {'billTemplateId':billTemplateId,'billTemplateName':billTemplateName};
}

/**
 * /根据入职日期设置默认服务起始月(>=16取下月，否则取本月)
 */
function setPaymentStartMonthByHireDate(){
	var baseInfo = objGet("dataSetBdEmpBaseInfo").getData('#') ; 
	var hireDate = baseInfo.get('hireDate');
	var defaultPaymentStartMonth = '';
	if( hireDate ){
		hireDate = hireDate.format('yyyyMMdd');
		defaultPaymentStartMonth = hireDate.substring(0,6);
		var day = parseInt( hireDate.substring(6,8) ) ;
		if( day >= 16 ){
			defaultPaymentStartMonth = calculateMonth(defaultPaymentStartMonth,1);
		}
	}
	return defaultPaymentStartMonth;
}

/**
 * 选择政策包时，加载政策详情
 */
function loadPolicyDetailBySb(dsBillTemplate,type){
	//获取选中的政策，加载政策详情
	var policyGroupId = objGet('dataSetPolicySetup').getData('#').get('id');

	//获取原始值
	var dataSetPolicyDetail = objGet('dataSetPolicyDetail');
	var orginalEntityList = dataSetPolicyDetail.getData();
	//初始化序号
	setFirstOrderIndex('sb');

	var billTemplateId = 0;
	var billTemplateName = '';
	var defaultPaymentStartMonth="";
	//批量时无需设置默认值
	if(!( type && type=='batAddProd') ){
		var baseInfo = objGet("dataSetBdEmpBaseInfo").getData('#') ; 
		//设置默认账单模板(如果有社保记录，帐套默认显示中的相同值，否则默认数据库查询出的第一个)
		if(orginalEntityList.entityCount > 0){
			var entity = loadDefaultTemplate(orginalEntityList);
			if(entity && entity.get('companyBillTemplateId') > 0
					&& entity.get('companyBillTemplateName')){
				billTemplateId = entity.get('companyBillTemplateId');
				billTemplateName = entity.get('companyBillTemplateName');
			}
		}else{
			var billTemplate = getFirstBillTemplate(baseInfo,'#dataSetBillTemplate');
			billTemplateId = billTemplate.billTemplateId;
			billTemplateName = billTemplate.billTemplateName;
		}
		
		defaultPaymentStartMonth = setPaymentStartMonthByHireDate();
	}
	
	/**
	 * 重新加载，获取新值
	 */
	dataSetPolicyDetail.set('dataProvider','personalOrderPR#queryPolicyDetail');
	dataSetPolicyDetail.set('parameter',{'policyGroupId':policyGroupId}).flush();
	var newEntityList = dataSetPolicyDetail.getData();
	//追加数据
	newEntityList.each(function(entity){
		window.orderIndexSb ++;
		entity.set('orderIndex',window.orderIndexSb);
		//非一次性社保
		entity.set('itemType',0);
		var dsTempRatio = objGet('dsTempRatio');
		dsTempRatio.clear();
		dsTempRatio.set('dataProvider','personalOrderPR#loadPolicyRatioByPolicyId');
		
		//设置默认比例、附加额
		if(entity.get('sbGroupId')){
			dsTempRatio.set('parameter',{'sbGroupId':entity.get('sbGroupId')}).flush();	
		}else{
			dsTempRatio.set('parameter',{'policyId':entity.get('policyGroupDetailId')}).flush();	
		}
		var dsTempaRatioEntity = dsTempRatio.getData().first();
		if(dsTempaRatioEntity){
			entity.set('companyAppend',dsTempaRatioEntity.get('companyAddAmount'));
			entity.set('companyRatioId',dsTempaRatioEntity.get('companyRatioId'));
			entity.set('individualAppend',dsTempaRatioEntity.get('individualAddAmount'));
			entity.set('individualRatioId',dsTempaRatioEntity.get('individualRatioId'));
			entity.set('companyRatio',dsTempaRatioEntity.get('companyRatio'));
			entity.set('individualRatio',dsTempaRatioEntity.get('individualRatio'));
			
			entity.set('payType',dsTempaRatioEntity.get('payType'));
			entity.set('payMonth',dsTempaRatioEntity.get('payMonth'));
			entity.set('monthCompanyAmount',dsTempaRatioEntity.get('monthCompanyAmount'));
			entity.set('monthIndividualAmount',dsTempaRatioEntity.get('monthIndividualAmount'));
		}
		
		entity.set('companyBillTemplateId',billTemplateId);
		entity.set('companyBillTemplateName',billTemplateName);
		entity.set('paymentStartMonth',defaultPaymentStartMonth);
		
		orginalEntityList.insert(entity);
	});
	dataSetPolicyDetail.setData(orginalEntityList);
	paySumTotal();
}

/**
 * 加载默认帐套
 */
function loadDefaultTemplate(orginalEntityList){
	var entityReturn = '';
	var i = 0;
	orginalEntityList.each(function(entity){
		var tempValue = entity.get('companyBillTemplateName');
		if(i == 0){
			entityReturn = entity;
		}
		if(entityReturn && entityReturn.get('companyBillTemplateName') != tempValue){
			entityReturn = '';
			return false;
		}
		i++;
	}); 
	return entityReturn;
}

/**
 * 选择政策组合包时，加载政策详情
 */
function loadPolicyDetailBySbGroup(){
	//获取选中的政策，加载政策详情
	var dataSetSbGroup = view.get('#dataSetSbGroup');
	var sbGroupId = dataSetSbGroup.getData('#').get('sbGroupId');
	
	//初始化序号(位置不能换到重新加载的代码之后，否则逻辑错误)
	setFirstOrderIndex('sb');

	//获取原始值
	var dataSetPolicyDetail = view.get('#dataSetPolicyDetail');
	var orginalEntityList = dataSetPolicyDetail.getData();

	//重新加载，获取新值
	dataSetPolicyDetail.set('dataProvider','personalOrderPR#querySbDetail');
	dataSetPolicyDetail.set('parameter',{'sbGroupId':sbGroupId}).flush();
	var newEntityList = dataSetPolicyDetail.getData();
	
	//追加数据
	newEntityList.each(function(entity){
		window.orderIndexSb ++;
		entity.set('orderIndex',window.orderIndexSb);
		//非一次性社保
		entity.set('itemType',0);
		
		//初始社保个人和单位比例
		var dsTempRatio = objGet('dsTempRatio');
		dsTempRatio.clear();
		dsTempRatio.set('dataProvider','personalOrderPR#loadPolicyRatioByPolicyId');
		if(entity.get('sbGroupDetailId')){
			dsTempRatio.set('parameter',{'sbGroupId':entity.get('sbGroupDetailId')}).flush();	
		}else{
			dsTempRatio.set('parameter',{'policyId':entity.get('policyGroupDetailId')}).flush();	
		}
		var dsTempaRatioEntity = dsTempRatio.getData().first();
		if(dsTempaRatioEntity){
			entity.set('companyAppend',dsTempaRatioEntity.get('companyAddAmount'));
			entity.set('companyRatioId',dsTempaRatioEntity.get('companyRatioId'));
			entity.set('individualAppend',dsTempaRatioEntity.get('individualAddAmount'));
			entity.set('individualRatioId',dsTempaRatioEntity.get('individualRatioId'));
			entity.set('companyRatio',dsTempaRatioEntity.get('companyRatio'));
			entity.set('individualRatio',dsTempaRatioEntity.get('individualRatio'));
			
			entity.set('payType',dsTempaRatioEntity.get('payType'));
			entity.set('payMonth',dsTempaRatioEntity.get('payMonth'));
			entity.set('monthCompanyAmount',dsTempaRatioEntity.get('monthCompanyAmount'));
			entity.set('monthIndividualAmount',dsTempaRatioEntity.get('monthIndividualAmount'));
		}
		
		//设置默认账单模板
		var billTemplateId = 0;
		var billTemplateName = '';
		if(orginalEntityList.entityCount > 0){
			var entityNew = loadDefaultTemplate(orginalEntityList);
			if(entityNew && entityNew.get('companyBillTemplateId') > 0
					&& entityNew.get('companyBillTemplateName')){
				billTemplateId = entityNew.get('companyBillTemplateId');
				billTemplateName = entityNew.get('companyBillTemplateName');
			}
		}else{
			var baseInfo = objGet("dataSetBdEmpBaseInfo").getData('#') ; 
			var billTemplate = getFirstBillTemplate(baseInfo,'#dataSetNsbBillTemplate');
			if( billTemplate ){
				billTemplateId = billTemplate.billTemplateId;
				billTemplateName = billTemplate.billTemplateName;
				
			}
		}
		entity.set('companyBillTemplateId',billTemplateId);
		entity.set('companyBillTemplateName',billTemplateName);
		var defaultPaymentStartMonth = setPaymentStartMonthByHireDate();
		entity.set('paymentStartMonth',defaultPaymentStartMonth);
		orginalEntityList.insert(entity);
		
	});
	dataSetPolicyDetail.setData(orginalEntityList);
}

/**
 * 选择政策包触发的事件
 */
function policySetupDropDownGridSelect(){
	//获取选中的政策，加载政策详情

	var dataSetPolicySetupGrid = view.get('#dataSetPolicySetupGrid');
	var entity = dataSetPolicySetupGrid.getData('#') ;
	var policyGroupId = entity.get('id');

	//获取原始值
	var dataSetPolicyDetail = view.get('#dataSetPolicyDetail');
	var current = dataSetPolicyDetail.getData('#');

	var itemId = current.get('itemId');


	//判断（政策包+产品）有没有重复，如果重复了，则清空
	var entityList = dataSetPolicyDetail.queryData('[@.get("policyGroupId")=='
		+policyGroupId+' && @.get("itemId")=="'+itemId+'"]');

	//如果重复
	if( entityList && entityList.length>0 ){
		new dorado.MessageBox.alert('该政策包和产品组合重复！');
		entity.set('id',null);
		entity.set('policyGroupName',null);
	}else{
		current.set('policyGroupId',policyGroupId);
		current.set('manageType',entity.get('manageType'));
		current.set('policyCityCode',entity.get('cityCode'));
		
	}
}

/**
 * 社保公积金明细onCurrentChange事件
 */
function sbDetailOnCurrentChange(parentOrderId){
	var dataSetPolicyDetail = view.get('#dataSetPolicyDetail');
	var policyDetail = dataSetPolicyDetail.getData('#');
	if( policyDetail ){
		var baseInfo = objGet("dataSetBdEmpBaseInfo").getData('#') ; 
		var orderStep = baseInfo.get('orderStep');
//		var orderMutualId = baseInfo.get('orderMutualId');
		//变更确认时由页面控制
		if( orderStep=='5'  ){
			
		}else{
			//如果不是转包订单，并且有值
			if(!parentOrderId ){
				var itemType = policyDetail.get('itemType');
				//一次性产品,一些字段只读
				if( itemType == 1 ){
					view.get('^policyGroupName').set('readOnly',false);
					view.get('^paymentEndMonth').set('readOnly',true);
					view.get('^billEndMonth').set('readOnly',true);
					view.get('^companyBase').set('readOnly',true);
					view.get('^individualBase').set('readOnly',true);
					view.get('^companyRatio').set('readOnly',true);
					view.get('^individualRatio').set('readOnly',true);
					view.get('^companyAppend').set('readOnly',true);
					view.get('^individualAppend').set('readOnly',true);
				}else{
					view.get('^policyGroupName').set('readOnly',true);
					view.get('^paymentEndMonth').set('readOnly',false);
					view.get('^billEndMonth').set('readOnly',false);
					view.get('^companyBase').set('readOnly',false);
					view.get('^individualBase').set('readOnly',false);
					view.get('^companyRatio').set('readOnly',false);
					view.get('^individualRatio').set('readOnly',false);
					view.get('^companyAppend').set('readOnly',false);
					view.get('^individualAppend').set('readOnly',false);
					view.get('^paySum').set('readOnly',true);
				}
				
//			个人缴交额、企业缴交额可以改动，所以注释掉下列代码 --psl 2014-12-34
				var payType = policyDetail.get('payType');
				//如果是年缴，则缴费金额自动算出，只读
				if( payType == 3 || payType==4 ){
					view.get('^companySum').set('readOnly',true);
					view.get('^individualSum').set('readOnly',true);
					view.get('^paySum').set('readOnly',true);
				}else{
					view.get('^companySum').set('readOnly',false);
					view.get('^individualSum').set('readOnly',false);
					view.get('^paySum').set('readOnly',true);
				}
				
			}else{
				//转包订单
				view.get('^paymentStartMonth').set('readOnly',true);
				
				var itemType = policyDetail.get('itemType');
				//一次性产品,一些字段只读
				if( itemType == 1 ){
					view.get('^policyGroupName').set('readOnly',false);
					view.get('^paymentEndMonth').set('readOnly',true);
					view.get('^companyBase').set('readOnly',true);
					view.get('^individualBase').set('readOnly',true);
					view.get('^companyRatio').set('readOnly',true);
					view.get('^individualRatio').set('readOnly',true);
				}else{
					view.get('^policyGroupName').set('readOnly',true);
					//转包订单，母订单的信息除了受托供应商外，其他都不能改
//				view.get('^paymentEndMonth').set('readOnly',false);
//				view.get('^companyBase').set('readOnly',false);
//				view.get('^individualBase').set('readOnly',false);
//				view.get('^companyRatio').set('readOnly',false);
//				view.get('^individualRatio').set('readOnly',false);
					
				}
			}
			
			//如果已清零，则不允许修改服务月
			//因为清零状态的明细的起始月和结束月是一个完整的缴费年度段，不能随便改
			if( policyDetail.get('hasClear') == 1){
				view.get('^paymentStartMonth').set('readOnly',true);
				view.get('^paymentEndMonth').set('readOnly',true);
			}else{
				view.get('^paymentStartMonth').set('readOnly',false);
				view.get('^paymentEndMonth').set('readOnly',false);
			}
			
		}
		
	}
	
}

function checkBillMonth(entity,billTemplateIdProperty,billMonthProperty){
	var billStartMonth = entity.get(billMonthProperty);
	var billTemplateId = entity.get(billTemplateIdProperty);
	var result = {};
	var checkResult = true ;
	var msg = "";
	if( !billTemplateId ){
		entity.setMessages(billMonthProperty,{
			text: "请选择账单模板！",
			state: "error"
		});
		checkResult = false ;
		msg = "请选择账单模板！";
	}else
		if( !billStartMonth ){
			entity.setMessages(billMonthProperty,{
				text: "请录入账单月！",
				state: "error"
		});
		checkResult = false ;
		msg = "请录入账单月！";
	}else{
		if( !window.queryCloseMonthAjaxAction ){
			window.queryCloseMonthAjaxAction = new dorado.widget.AjaxAction({
				'id':'queryCloseMonthAjaxAction',
				'modal':false,
				'async':false,
				'service':'personalOrderPR#queryCloseMonth'
			});
		}
		window.queryCloseMonthAjaxAction.set('parameter',{'billTemplateId':billTemplateId})
		.execute(function(closeMonth){
			if(!closeMonth){
				entity.setMessages(billMonthProperty,{
					text: "不存在账单月结状态，请检查！",
					state: "error"
				});
				checkResult = false ;
				msg = "不存在账单月结状态，请检查！";
			}else
				if(billStartMonth<closeMonth){
					var firstMonth = closeMonth;
					entity.setMessages(billMonthProperty,{
						text: "最小账单月为"+firstMonth,
						state: "error"
					});
					checkResult = false ;
					msg = "最小账单月为"+firstMonth;
				}
		});
		
	}
	if( checkResult ){
		entity.setMessages(billMonthProperty,{
			state: "ok"
		});
	}
	result.checkResult  = checkResult;
	result.msg = msg ;
	return result;
}

/**
 * 校验（相同政策包、相同产品的服务月不能交叉）
 */
function checkSbPaymentMonth(arg){
	var entity = arg.entity;
	var property = arg.property;
	var policyGroupId = entity.get('policyGroupId');
	var itemId = entity.get('itemId');
	var orderIndex = entity.get('orderIndex');
	var paymentStartMonth = entity.get('paymentStartMonth');
	var paymentEndMonth = entity.get('paymentEndMonth');
	var entity2 = null;
	
	if( paymentStartMonth && paymentEndMonth){
		if( parseInt(paymentStartMonth)> parseInt(paymentEndMonth) ){
			arg.result={
				text: "服务起始月应小于或等于服务结束月！",
				state: "error"
			};
			return ;
		}
	}
	
	var checkResult = true ;
	//服务起始月必填，填了后再校验
	if( paymentStartMonth ){
		var dataSetPolicyDetail = view.get('#dataSetPolicyDetail');
		var queryData = dataSetPolicyDetail.queryData('[@.get("policyGroupId")=='+policyGroupId
				+'&&@.get("itemId")=='+itemId+'&&@.get("orderIndex")!='+orderIndex+']');
		if( queryData && queryData.length >0 ){
			entity2 = queryData[0];
			if( queryData[0].get('paymentStartMonth') ){
				var startMonth = parseInt(queryData[0].get('paymentStartMonth')) ;
				var endMonth = queryData[0].get('paymentEndMonth');
				if( !endMonth ){
					endMonth = 999999;
				}
				if( !paymentEndMonth ){
					paymentEndMonth = 999999;
				}						
				if( property == 'paymentStartMonth'){
					if( (parseInt(paymentStartMonth)  >= startMonth && parseInt(paymentStartMonth)  <= endMonth) ||
						(parseInt(paymentStartMonth)  <= startMonth && parseInt(paymentEndMonth)  >= endMonth)){
						checkResult = false ;
					}
				}else
					if( property == 'paymentEndMonth'){
						if( (parseInt(paymentEndMonth)  >= startMonth && parseInt(paymentEndMonth)  <= endMonth) ||
							(parseInt(paymentStartMonth)  <= startMonth && parseInt(paymentEndMonth)  >= endMonth) ){
							checkResult = false ;
						}
					}
				
				//校验不通过
				if( !checkResult ){
					arg.result={
						text: "相同政策包和产品的服务月不能交叉！",
						state: "error"
					};
				}
			}
		}
		if(checkResult){
			entity.setMessages('paymentStartMonth',{
				state: "ok"
			});
			entity.setMessages('paymentEndMonth',{
				state: "ok"
			});
			if( entity2 ){
				entity2.setMessages('paymentStartMonth',{
					state: "ok"
				});
				entity2.setMessages('paymentEndMonth',{
					state: "ok"
				});
			}
		}
	}	
}


/**
 * 校验非社保的服务月（相同产品的服务月不能交叉）
 */
function checkNsbPaymentMonth(arg){
	var entity = arg.entity;
	var property = arg.property;
	var itemId = entity.get('itemId');//产品id
	var paymentStartMonth = entity.get('paymentStartMonth');
	var paymentEndMonth = entity.get('paymentEndMonth');
	var orderIndex = entity.get('orderIndex');
	var entity2 = null;
	
	var checkResult = true ;
	//服务起始月必填，填了后再校验
	if( paymentStartMonth ){
		if( paymentStartMonth && paymentEndMonth){
			if( parseInt(paymentStartMonth)> parseInt(paymentEndMonth) ){
				arg.result={
					text: "服务起始月应小于或等于服务结束月！",
					state: "error"
				};
				return ;
			}
		}
		
		var dataSetNsb = view.get('#dataSetHsEmpOrdNsbDetailRec');
		var queryData = dataSetNsb.queryData('[@.get("itemId")=='+itemId+'&&@.get("orderIndex")!='+orderIndex+']');
		if( queryData && queryData.length >0){
			entity2 = queryData[0];
			if( queryData[0].get('paymentStartMonth') ){
				var startMonth = parseInt(queryData[0].get('paymentStartMonth')) ;
				var endMonth = queryData[0].get('paymentEndMonth');
				if( !endMonth ){
					endMonth = 999999;
				}
				if( !paymentEndMonth ){
					paymentEndMonth = 999999;
				}
				if( property == 'paymentStartMonth'){
					if( (parseInt(paymentStartMonth)  >= startMonth && parseInt(paymentStartMonth)  <= endMonth) ||
						(parseInt(paymentStartMonth)  <= startMonth && parseInt(paymentEndMonth)  >= endMonth)){
						checkResult = false ;
					}
				}else
					if( property == 'paymentEndMonth'){
						if( (parseInt(paymentEndMonth)  >= startMonth && parseInt(paymentEndMonth)  <= endMonth) ||
							(parseInt(paymentStartMonth)  <= startMonth && parseInt(paymentEndMonth)  >= endMonth) ){
							checkResult = false ;
						}
					}
				
				//校验不通过
				if( !checkResult ){
					arg.result={
						text: "相同产品的服务月不能交叉！",
						state: "error"
					};
				}
			}
		}
		if(checkResult){
			entity.setMessages('paymentStartMonth',{
				state: "ok"
			});
			entity.setMessages('paymentEndMonth',{
				state: "ok"
			});
			
			if( entity2 ){
				entity2.setMessages('paymentStartMonth',{
					state: "ok"
				});
				entity2.setMessages('paymentEndMonth',{
					state: "ok"
				});
			}
		}
	}	
	
}

/**
 * Set日期格式为yyyymm
 * @param arg
 */
function onSetDate(arg){
	var value = arg.value;
	if( value ){
		if(value.length >= 6){
			var newValue = value.substring(0, 6);
			arg.value = newValue;
		}else if(value.length == 5){
			var year = value.substring(0, 4);
			var month = value.substring(4, 5);
			
			if(Number(month) >= 1 && Number(month) <= 9){
				var newDate = year + '0' + month;
				arg.value = newDate;
			}
		}
	}
}

/**
 * Check日期是否合法
 * @param arg
 */
function checkDateLegal(arg){
	var dateValue = arg.data;
	if(dateValue){
		if(dateValue.length < 4){
			arg.result={
					text: "请输入正确年份月份！",
					state: "error"
				};
		}else if(dateValue.length == 4){
			arg.result={
					text: "请输入正确月份！",
					state: "error"
				};
		}else{
			var monthInt = Number(dateValue.substring(4, 6));
			if(monthInt < 1 || monthInt > 12 ){
				arg.result={
						text: "请输入正确月份！",
						state: "error"
					};
			}
		}
	}else{
		var current = objGet("dataSetBdEmpBaseInfo").getData('#') ;
		var orderStatus = current.get('orderStatus');
		if( orderStatus == '10'){
			arg.result={
					text: "撤销过的订单服务结束月必填！",
					state: "error"
				};
		}
	}
}


//对六位的数月份增加一个月
function addMonth(curMonth){
  var y=curMonth.substring(0,4);
  var m=curMonth.substring(4,6);
  if(m=="12"){
     m="1";
     y=parseFloat(y)+1+"";
  }else{
     m=parseFloat(m)+1+"";
  }
  if(m.length==1) m="0"+m;
  return y+""+m;  
}

/**
 * 根据报价单获取产品(非社保公积金)
 * @param orderStrp 订单环节
 */
function addProdBySlQuot(isDoubleClick){
	//获取选中的报价单
	var quotIds = "";
	if( isDoubleClick ){
		var currentEntity = view.get('#dataSetQuotation').getData('#');
		quotIds = currentEntity.get('quotId') + ',';
	}else{
		var dataGridQuotation = view.get('#dataGridQuotation');
		var selection = dataGridQuotation.get('selection');
		
		if( selection ){
			for(var i=0 ; i<selection.length ; i++ ){
				var quotId = selection[i].get('quotId');
				quotIds += quotId + ",";
			}
		}
	}
	quotIds = quotIds.substr(0,quotIds.length-1);

	//根据报价单获取产品
	var dataSetProdByQuot = view.get('#dataSetProdByQuot');
	dataSetProdByQuot.set('parameter',{'quotIds':quotIds}).flush();
	var entityList = dataSetProdByQuot.getData();

	var dataSetHsEmpOrdNsbDetailRec = view.get('#dataSetHsEmpOrdNsbDetailRec');
	var hasSbServiceProd = false ;
	var hasGjjServiceProd = false ;
	
	//初始化序号
	setFirstOrderIndex('nsb');
	
	if(entityList.entityCount>0){
		entityList.each(function(entity){
			var offerId = entity.get('quotId');
			var quotName = entity.get('summary');
			var prodId = entity.get('prodId');
			var prodName = entity.get('prodName');
			var priceConfirm= entity.get('priceConfirm');
			var isOneOff = entity.get('isOneOff');
			
			//设置默认账单模板
			var billTemplateId = 0;
			var billTemplateName = '';
			var dataSetPolicyDetail= view.get('#dataSetPolicyDetail');
			if( dataSetPolicyDetail ){
				var policyDetailList = dataSetPolicyDetail.getData();
				
				if(policyDetailList.entityCount > 0){
					var entityReturn = loadDefaultTemplate(policyDetailList);
					if(entityReturn && entityReturn.get('companyBillTemplateId') > 0
							&& entityReturn.get('companyBillTemplateName')){
						billTemplateId = entityReturn.get('companyBillTemplateId');
						billTemplateName = entityReturn.get('companyBillTemplateName');
					}
				}else{
					var baseInfo = window.orderType == 'childOrder'?objGet("dataSetPrvdOrder").getData('#'):objGet("dataSetBdEmpBaseInfo").getData('#') ; 
					var billTemplate = getFirstBillTemplate(baseInfo,'#dataSetNsbBillTemplate');
					billTemplateId = billTemplate.billTemplateId;
					billTemplateName = billTemplate.billTemplateName;
				}
			}
			
			window.orderIndexNsb++;
			//如果是子订单
			if(window.orderType == 'childOrder'){
				var dataSetNsbDetailRecDelegate = view.get('#dataSetNsbDetailRecDelegate');
//				var queryData = dataSetNsbDetailRecDelegate.queryData('[@.get("offerId")=='+offerId+']');
				//如果是明细报价，则全部插入，否则，报价单不能重复
//				if(quotType == 1 || !queryData || queryData.length == 0){
//					//相同报价单，相同产品的不能重复
//					var queryData2 = dataSetNsbDetailRecDelegate.queryData('[@.get("offerId")=='+offerId+'&& @.get("itemId")=='+prodId+']');
//					if( !queryData2 || queryData2.length == 0 ){
//						dataSetNsbDetailRecDelegate
//						.insert({'offerId':offerId,'itemId':prodId,'itemName':prodName,'itemType':isOneOff,
//							'quotName':quotName,'sum':priceConfirm,'orderIndex':window.orderIndexNsb,
//							'receiveOrgId':window.receiveOrgId,'receiveOrgName':window.receiveOrgName,'delegateSlFlag':1,
//							'billTemplateId':billTemplateId,'billTemplateName':billTemplateName});
//					}
//				}
				//去掉判断，直接插入（20141127，相同的产品只要时间段不重复就行）
				
				
				var childBillTemplateId = "";
				var childBillTemplateName ="";
				if( view.get('#dataSetPolicyDetailDelegate') ){
					var policyDetailDelegateList = view.get('#dataSetPolicyDetailDelegate').getData();
					var childEntityReturn = loadDefaultTemplate(policyDetailDelegateList);
					if(childEntityReturn && childEntityReturn.get('companyBillTemplateId') > 0
							&& childEntityReturn.get('companyBillTemplateName')){
						childBillTemplateId = childEntityReturn.get('companyBillTemplateId');
						childBillTemplateName = childEntityReturn.get('companyBillTemplateName');
					}
				}
				
				dataSetNsbDetailRecDelegate
				.insert({'offerId':offerId,'itemId':prodId,'itemName':prodName,'itemType':isOneOff,
					'quotName':quotName,'sum':priceConfirm,'orderIndex':window.orderIndexNsb,
					'receiveOrgId':window.receiveOrgId,'receiveOrgName':window.receiveOrgName,
					'delegateSlFlag':1,'billTemplateId':childBillTemplateId,'billTemplateName':childBillTemplateName});
			}else{
				var defaultPaymentStartMonth = setPaymentStartMonthByHireDate();
				
				var queryData = dataSetHsEmpOrdNsbDetailRec.queryData('[@.get("itemId")=='+prodId+']');
				
				//如果是一次性产品，则服务结束月等于服务起始月
				var paymentEndMonth = "";
				if( isOneOff == 1 ){
					paymentEndMonth = defaultPaymentStartMonth;
				}
				
				//如果是订单变更则不管什么情况都可以重复选
				//否则，相同产品只能填入一条
				//if( orderStep==4 || !queryData || queryData.length == 0){//去掉判断（20141127，只要时间段不重复就行）
					dataSetHsEmpOrdNsbDetailRec
					.insert({'offerId':offerId,'itemId':prodId,'itemName':prodName,'itemType':isOneOff,
						'quotName':quotName,'sum':priceConfirm,'orderIndex':window.orderIndexNsb,
						'billTemplateId':billTemplateId,'billTemplateName':billTemplateName,
						'paymentStartMonth':defaultPaymentStartMonth,'paymentEndMonth':paymentEndMonth});
				//}
			}
			
			var quotType = entity.get('quotType');
			var prodType = entity.get('prodType');
			var prodProperty = entity.get('prodProperty');
			//如果是明细报价，
			if(quotType == 1 && prodType==1 && prodProperty==1){
				hasSbServiceProd = true ;
			}
			if(quotType == 1 && prodType==2 && prodProperty==1){
				hasGjjServiceProd = true ;
			}
		});
		
		//批量转包订单不需要判断
		if( !window.batDelegateOrder ){
			//获取社保公积金中选中的产品ID
			var dataSetPolicyDetail= view.get('#dataSetPolicyDetail');
			if( window.orderType == 'childOrder' ){
				dataSetPolicyDetail = view.get('#dataSetPolicyDetailDelegate');
			}
			var policyDetailList = dataSetPolicyDetail.getData();
			var prodIds = '';
			policyDetailList.each(function(entity){
				prodIds += entity.get('itemId') + ',';
			});
			
			if( !window.checkDetailQuotAjaxAction ){
				window.checkDetailQuotAjaxAction = new dorado.widget.AjaxAction({
					'id':'checkDetailQuotAjaxAction',
					//'modal':false,
					'service':'personalOrderPR#checkDetailQuot'
				});
			}
			window.checkDetailQuotAjaxAction
			.set('parameter',{'prodIds':prodIds,'hasSbServiceProd':hasSbServiceProd,
				'hasGjjServiceProd':hasGjjServiceProd})
				.execute(function(result){
					if(!result){
						new dorado.MessageBox.alert('你享受的产品 与报价单中的该类服务费不符！');
					}
				});
			
		}
		
		
		var dialogAddQuotation = view.get('#dialogAddQuotation');
		dialogAddQuotation.close();
		
		paySumTotal();
	}else{
		dorado.MessageBox.alert('选择的报价单无对应产品！');
	}
}


/**
 * 根据报价单获取产品(非社保公积金)
 * @param isDoubleClick 是否是双击触发
 */
function addProdBySlQuot1(isDoubleClick){
	//获取选中的报价单
	var quotIds = "";
	if( isDoubleClick ){
		var currentEntity = view.get('#dataSetQuotation').getData('#');
		quotIds = currentEntity.get('quotId') + ',';
	}else{
		var dataGridQuotation = view.get('#dataGridQuotation');
		var selection = dataGridQuotation.get('selection');
		
		if( selection ){
			for(var i=0 ; i<selection.length ; i++ ){
				var quotId = selection[i].get('quotId');
				quotIds += quotId + ",";
			}
		}
	}
	quotIds = quotIds.substr(0,quotIds.length-1);

	//根据报价单获取产品
	var dataSetProdByQuot = view.get('#dataSetProdByQuot');
	dataSetProdByQuot.set('parameter',{'quotIds':quotIds}).flush();
	var entityList = dataSetProdByQuot.getData();

	var dataSetHsEmpOrdNsbDetailRec = view.get('#dataSetHsEmpOrdNsbDetailRec');
	
	//初始化序号
	setFirstOrderIndex('nsb');
	
	if(entityList.entityCount>0){
		entityList.each(function(entity){
			var offerId = entity.get('quotId');
			var quotName = entity.get('summary');
			var prodId = entity.get('prodId');
			var prodName = entity.get('prodName');
			var priceConfirm= entity.get('priceConfirm');
			var isOneOff = entity.get('isOneOff');
			var quotType = entity.get('quotType');
			
			//设置默认账单模板
			var baseInfo = window.orderType == 'childOrder'?objGet("dataSetPrvdOrder").getData('#'):objGet("dataSetBdEmpBaseInfo").getData('#') ; 
			var billTemplate = getFirstBillTemplate(baseInfo,'#dataSetNsbBillTemplate');
			var billTemplateId = billTemplate.billTemplateId;
			var billTemplateName = billTemplate.billTemplateName;
			
			window.orderIndexNsb++;
			//如果是子订单
			if(window.orderType == 'childOrder'){
				var dataSetNsbDetailRecDelegate = view.get('#dataSetNsbDetailRecDelegate');
//				var queryData = dataSetNsbDetailRecDelegate.queryData('[@.get("offerId")=='+offerId+']');
				//如果是明细报价，则全部插入，否则，报价单不能重复
//				if(quotType == 1 || !queryData || queryData.length == 0){
//					//相同报价单，相同产品的不能重复
//					var queryData2 = dataSetNsbDetailRecDelegate.queryData('[@.get("offerId")=='+offerId+'&& @.get("itemId")=='+prodId+']');
//					if( !queryData2 || queryData2.length == 0 ){
						dataSetNsbDetailRecDelegate
						.insert({'offerId':offerId,'itemId':prodId,'itemName':prodName,'itemType':isOneOff,
							'quotName':quotName,'sum':priceConfirm,'orderIndex':window.orderIndexNsb,
							'receiveOrgId':window.receiveOrgId,'receiveOrgName':window.receiveOrgName,'delegateSlFlag':1,
							'billTemplateId':billTemplateId,'billTemplateName':billTemplateName});
//					}
//				}
			}else{
				var queryData = dataSetHsEmpOrdNsbDetailRec.queryData('[@.get("itemId")=='+prodId+']');
				//如果是订单变更则不管什么情况都可以重复选
				//否则，相同产品只能填入一条
//				if( orderStep==4 || !queryData || queryData.length == 0){
					dataSetHsEmpOrdNsbDetailRec
					.insert({'offerId':offerId,'itemId':prodId,'itemName':prodName,'itemType':isOneOff,
						'quotName':quotName,'sum':priceConfirm,'orderIndex':window.orderIndexNsb,
						'billTemplateId':billTemplateId,'billTemplateName':billTemplateName});
//				}
			}
			
			var quotType = entity.get('quotType');
			var prodType = entity.get('prodType');
			var prodProperty = entity.get('prodProperty');
			//如果是明细报价，
			if(quotType == 1 && prodType==1 && prodProperty==1){
				hasSbServiceProd = true ;
			}
			if(quotType == 1 && prodType==2 && prodProperty==1){
				hasGjjServiceProd = true ;
			}
		});
		
		var dialogAddQuotation = view.get('#dialogAddQuotation');
		dialogAddQuotation.close();
		
	}else{
		dorado.MessageBox.alert('选择的报价单无对应产品！');
	}
}

/**
 * 加载代收代付或一次性产品
 */
function loadHelpOrOnceProd(receiveOrgId){
	if( !receiveOrgId ){
		//加载代收代付或一次性产品
		var baseInfo = objGet("dataSetBdEmpBaseInfo").getData('#') ; 
		receiveOrgId = baseInfo.get('receiveOrgId');
	}
	var queryProductId = view.get('#queryProductId').get('value');
	var dataSetHelpOnceProduct = view.get('#dataSetHelpOnceProduct');
	dataSetHelpOnceProduct.set('parameter',{'orgId':receiveOrgId,'prodName':queryProductId}).flush();
}

/**
 * 选中代收代付或一次性产品，并加载(非社保公积金)
 */
function addHelpOrOnceProd(type){
	var dataGridHelpOnceProduct = view.get('#dataGridHelpOnceProduct');
	var selection = dataGridHelpOnceProduct.get('selection');

	var dataSetHsEmpOrdNsbDetailRec = view.get('#dataSetHsEmpOrdNsbDetailRec');
	if( selection.length>0 ){
		setFirstOrderIndex("nsb");
		
		var dataSetPolicyDetail= view.get('#dataSetPolicyDetail');
		var policyDetailList = null;
		if( dataSetPolicyDetail ){
			policyDetailList = dataSetPolicyDetail.getData();
			
		}
		//设置默认账单模板
		var billTemplateId = 0;
		var billTemplateName = '';
		var defaultPaymentStartMonth ="";
		if( !(type && type == 'batAddProd') ){
			if(policyDetailList && policyDetailList.entityCount > 0){
				var entityReturn = loadDefaultTemplate(policyDetailList);
				if(entityReturn && entityReturn.get('companyBillTemplateId') > 0
						&& entityReturn.get('companyBillTemplateName')){
					billTemplateId = entityReturn.get('companyBillTemplateId');
					billTemplateName = entityReturn.get('companyBillTemplateName');
				}
			}else{
				var baseInfo = view.get("#dataSetBdEmpBaseInfo").getData('#') ; 
				var billTemplate = getFirstBillTemplate(baseInfo,'#dataSetNsbBillTemplate');
				billTemplateId = billTemplate.billTemplateId;
				billTemplateName = billTemplate.billTemplateName;
			}
			
			defaultPaymentStartMonth = setPaymentStartMonthByHireDate();
		}
		
		for(var i=0 ; i<selection.length ; i++ ){
			var prodId = selection[i].get('prodId');
			var prodName = selection[i].get('prodName');
			var isOneOff = selection[i].get('isOneOff');
			
			//如果列表中没有这条数据(或非一次性产品)，则插入
			var queryData = dataSetHsEmpOrdNsbDetailRec.queryData('[@.get("itemId")=='+prodId+']');
			if(!queryData || queryData.length == 0 || isOneOff == 0 ){
				window.orderIndexNsb++;
				
				//如果是一次性产品，则服务结束月等于服务起始月
				var paymentEndMonth = "";
				if( isOneOff == 1 ){
					paymentEndMonth = defaultPaymentStartMonth;
				}
				dataSetHsEmpOrdNsbDetailRec.insert({'itemId':prodId,'itemName':prodName,'itemType':isOneOff,
					'orderIndex':window.orderIndexNsb,'billTemplateId':billTemplateId,
					'billTemplateName':billTemplateName,'paymentStartMonth':defaultPaymentStartMonth,'paymentEndMonth':paymentEndMonth});
			}
		}
		var dialogAddHelpOnceProduct = view.get('#dialogAddHelpOnceProduct');
		dialogAddHelpOnceProduct.close();
	}else{
		dorado.MessageBox.alert('请选择数据！');
	}
}

/**
 * 订单变更确认页面，突出显示变更过的数据
 */
function rendCompareColor(arg){
	arg.processDefault = true;
	var dom = $(arg.dom);
	var column = arg.column;
	var columnName = column.get('name');
	try {
		if(columnName != 'rowSelector'){
			var currentEntity = arg.data;
			var newPropertyValue = currentEntity.get(columnName);
			var orderIndex = currentEntity.get('orderIndex');
			
			var dataSetPolicyDetailAddConfirm = view.get('#dataSetPolicyDetailAddConfirm');
			var selectEntity = dataSetPolicyDetailAddConfirm.getData('[@.get("orderIndex")==' + orderIndex + ']');
			var oldPropertyValue = selectEntity.get(columnName);
			
			if (oldPropertyValue != newPropertyValue) {
				dom.css('background-color','rgba(252, 231, 183, 1)');
			}
		}
	}catch(err)
	{
		console.log(err.message );
	}
}

/**
 * 查询页面，提交订单
 * @param step
 */
function submitOrderWhenQuery(canSubmitStatus,newStatus){
	var dataSetHsEmpOrd = objGet('dataSetHsEmpOrd');
	var current = dataSetHsEmpOrd.getData('#');
	var orderRecId = current.get('orderRecId');
	var orderStatus = current.get('orderStatus');
	
	var orderStep = current.get('orderStep');
	var receiveOrgId = current.get('receiveOrgId');
	var sendOrgId = current.get('sendOrgId');
	var orderMutualId = current.get('orderMutualId');
	
	if( orderStatus != canSubmitStatus ){
		dorado.MessageBox.alert('该状态下的订单不能提交！');
	}else{
		dorado.MessageBox.confirm("确认要提交该订单吗？",function(){	
			//提交,将状态设置为增员已确认
			var ajaxActionOrderSubmit = objGet('ajaxActionOrderSubmit');
			ajaxActionOrderSubmit.set('parameter',{'orderRecId':orderRecId,'status':newStatus,
				'orderStep':orderStep,'receiveOrgId':receiveOrgId,'sendOrgId':sendOrgId,
				'orderMutualId':orderMutualId});
			ajaxActionOrderSubmit.execute(function(result){
				if( result == true ){
					dorado.MessageBox.alert('提交订单成功！');
					dataSetHsEmpOrd.flush();
				}
			});
		});
	}
}

/**
 * 证件校验
 * 
 * @param arg
 */
function validIdCard(arg) {
	var entity = arg.entity;
	var isCreateChildrenOrder = entity.get('isCreateChildrenOrder');
	//只有创建,并且不是创建子订单时才校验
	if( window.orderStep == 1 && !isCreateChildrenOrder){
		var validResult = true;
		var property = arg.property;
		var cardType = entity.get('cardType');
		var cardId = entity.get('cardId');
		var contractId = entity.get('contractId');
		
		var msg = '';
		
		if (!cardType && property == 'cardId') {
			msg = '请先录入证件类型';
			validResult = false;
		} else if (cardId && cardType) {
			// 身份证校验
			if (cardType == '1' && !checkID(cardId)) {
				msg = '身份证格式不正确！';
				validResult = false;
			} else {
				//如果不为undefined，表明是修改,如果证件类型、证件id和页面加载时一样，则直接校验通过
				if( window.firstLoadBaseInfoCardId && window.firstLoadBaseInfoCardId == cardId 
						&& window.firstLoadBaseInfoCardType == cardType){
					validResult = true;
				}else{
					// 执行后台Ajax验证证件号
					var checkCardIdAjaxAction = view.get('#checkCardIdAjaxAction');
					checkCardIdAjaxAction.set('parameter', {
						'cardType' : cardType,
						'cardId' : cardId
					}).execute();
					var autoformEntity = view.get("#baseDataForm").get("entity");
					var empBaseInfoDTO = checkCardIdAjaxAction.get('returnValue');
					
					//没有查出来，表明该员工没有添加过
					if(null != empBaseInfoDTO){
						//如果订单状态不为10，表明没有离职，并且合同相同，则不能创建订单
						if ( empBaseInfoDTO.orderStatus != 10 && contractId &&
								contractId == empBaseInfoDTO.contractId) {
							msg = "持有该证件的用户在该大合同下已创建订单!";
							validResult = false;
						} else {
							// 已有该员工,将员工信息填充到页面中
							fillDataForPage(empBaseInfoDTO, autoformEntity);
							validResult = true;
						}
					}else{
						// 没有该员工,可继续添加
						validResult = true;
						autoformEntity.set("id", "");
					}
				}
			}
		}
		
		// 如果校验通过，则将校验状态设为正常
		if (validResult) {
			entity.setMessages('cardId', {
				state : "ok"
			});
		} else {
			var result = {
					text : msg,
					state : "error"
			};
			if (property != 'cardId') {
				entity.setMessages('cardId', result);
			} else {
				arg.result = result;
			}
		}
		
	}
}

/**
 * 填充数据到订单基本信息
 * @param empBaseInfoDTO
 * @param autoformEntity
 */
function fillDataForPage(empBaseInfoDTO, autoformEntity) {
	// 已有该员工,将员工信息填充到页面中
	var workAddressId = empBaseInfoDTO.workAddress;
	var dataSetWorkAddress = view.get('#dataSetWorkAddress');
	//清空模糊查询条件，重新查询
	dataSetWorkAddress.set('parameter',{'cityName':''}).flush();	
	var selectCity = dataSetWorkAddress.getData('[@.get("cityId")=='
			+ workAddressId + ']');
	var workAddressName = selectCity.get('cityName');
	dataSetWorkAddress.getData().setCurrent(selectCity);

	autoformEntity.set({
		"id" : empBaseInfoDTO.id,
		"employeeName" : empBaseInfoDTO.employeeName,
		"registeredAddress" : empBaseInfoDTO.registeredAddress,
		"residenceAddress" : empBaseInfoDTO.residenceAddress,
		"mobile" : empBaseInfoDTO.mobile,
		"phone" : empBaseInfoDTO.phone,
		"employeeClientId" : empBaseInfoDTO.employeeClientId,
//		"hireRemark" : empBaseInfoDTO.hireRemark,
//		"orderCreateRemark" : empBaseInfoDTO.orderCreateRemark,
		"workAddress" : workAddressId,
		"workAddressName" : workAddressName
	});
}

/**
 * 获取精度
 */
function getPrecise(precise){
	var newPrecise = 0;
	switch (precise) {
		case '1':	newPrecise=0;break;
		case '2':	newPrecise=1;break;
		case '3':	newPrecise=2;break;
	}
	return newPrecise;
}

/**
 * 社保公积金详情onDataChange事件
 * @param arg
 */
function policyDetailDataChange(arg){
	var property = arg.property ;
	var entity = arg.entity;
	var itemType = entity.get('itemType');
	if( property != 'isDeleted' && property != 'hasChanged' && property != 'isChecked'){
		/**
		 * 1、金额计算
		 */
		//非一次性社保，基数或比例变动
		var item1 = itemType==0 &&( property=='companyBase' ||  property=='companyRatio'
			|| property=='individualBase' ||  property=='individualRatio'
				|| property=='companyAppend' ||  property=='individualAppend');
		
		//企业金额或个人金额变动
		var item2 = (property=='companySum' ||  property=='individualSum');
		
		if( item1 || item2 ){
			
			var companySum = 0;
			if( entity.get('companySum') ){
				companySum = parseFloat( entity.get('companySum') );
			}
			var individualSum = 0;
			if( entity.get('individualSum') ){
				individualSum = parseFloat( entity.get('individualSum') );
			}
			var paySum = 0;
			if( entity.get('paySum') ){
				paySum = parseFloat( entity.get('paySum') );
			}
			
			var companyAppend = entity.get('companyAppend');//附加额
			var individualAppend = entity.get('individualAppend');
			
			var companyPrecise = entity.get('companyPrecise');//精度
			var individualPrecise = entity.get('individualPrecise');
			var companyCalculateType = entity.get('companyCalculateType');//计算方式
			var individualCalculateType = entity.get('individualCalculateType');
			
			var calculateCompnaySum =  0;//基数和比例计算出的值
			var calculateIndividualSum = 0;		
			
			var newCompanySum = 0;//最终计算出的值
			var newIndividualSum = 0;
			
			//根据比例、基数、附加额、精度、计算方式计算金额(非一次性社保)
			if( item1 ){
				var companyBase = entity.get('companyBase');//基数
				var companyRatio = entity.get('companyRatio');//比例
				
				var individualBase = entity.get('individualBase');
				var individualRatio = entity.get('individualRatio');
				
				if( companyBase && companyRatio ){
					calculateCompnaySum = parseFloat(companyBase*companyRatio);
				}
				
				if( individualBase && individualRatio ){
					calculateIndividualSum = parseFloat(individualBase*individualRatio);
				}
				newCompanySum = calculateCompnaySum;
				newIndividualSum = calculateIndividualSum;
				newCompanySum = calSbCp(newCompanySum,companyAppend,
						getPrecise(companyPrecise),companyCalculateType);
				newIndividualSum = calSbCp(newIndividualSum,individualAppend,
						getPrecise(individualPrecise),individualCalculateType);
			}
			if( item2 ){
				newCompanySum = companySum;
				newIndividualSum = individualSum;
			}
			
			
			//只有计算后的值发生变化后才赋值（否则死循环）
			if(	companySum!=newCompanySum  ){
				entity.set('companySum',newCompanySum);
			}
			if( individualSum!=newIndividualSum){
				entity.set('individualSum',newIndividualSum);
			}
			var newPaySum = newCompanySum + newIndividualSum ;
			if( newPaySum ){
				newPaySum = parseFloat( newPaySum.toFixed(4) );
			}else{
				newPaySum = 0;
			}
			if( paySum != newPaySum ){
				entity.set('paySum',newPaySum);
			}
		}
		
		/**
		 * 2、第一行赋值后，下面的行如果没有值，则设置为第一行的值
		 */
		if(property != 'companySum' &&property != 'individualSum'&&property != 'paySum'
			&& property!='companyRatioId' &&property!='companyRatio'
			&& property!='individualRatioId' &&property!='individualRatio'
			&& property!='companyBase' &&property!='individualBase'
			&& property!='policyGroupId' &&property!='policyGroupName'){
			//如果是订单变更，则不需要
			if( window.orderStep != 4 ){
				setOrderSbNextLineValue(arg.entity, property);
			}
		}
		
		/**
		 * 3、如果本行对应创建了子订单，则本行数据改变时自动修改子订单的值(除了账单模板和账单月)
		 */
		var dataSetPolicyDetailDelegate = view.get('#dataSetPolicyDetailDelegate');
		if( dataSetPolicyDetailDelegate ){
			if(property != 'companyBillTemplateId' && property != 'companyBillTemplateName' 
				&&property != 'billStartMonth' && property != 'receiveOrgId'&& property != 'receiveOrgName'){
				var id = entity.get('id');
				var queryData = "";
				//如果没有id（创建时），则使用orderIndex来过滤
				if( id ){
					queryData = dataSetPolicyDetailDelegate.queryData('[@.get("id")=='+id+']');
				}else{
					var orderIndex = entity.get('orderIndex');
					queryData = dataSetPolicyDetailDelegate.queryData('[@.get("orderIndex")=='+orderIndex+']');
				}
				if(queryData && queryData.length != 0){
					queryData[0].set(property,entity.get(property));
					arg.processDefault=false;
				}
			}
		}
		
		/**
		 * 4、录入了服务起始（结束）月，设置社保起始（结束）月
		 */
		if( property == 'paymentStartMonth'){
			var value = arg.newValue ;
			if( value ){
				var manageType = entity.get('manageType');
				if( manageType == 1 ){
					entity.set('sbStartMonth',value);
				}else
					if( manageType == 2){
						entity.set('sbStartMonth',addMonth(value) );
					}
				
				//一次性产品服务起始月和服务结束月相同
				if( entity.get('itemType') == 1){
					entity.set('paymentEndMonth',value);
					if( manageType == 1 ){
						entity.set('sbEndMonth',value);
					}else
						if( manageType == 2){
							entity.set('sbEndMonth',addMonth(value) );
						}
				}
			}
		}
		if( property == 'paymentEndMonth'){
			var value = arg.newValue ;
			if( value ){
				var year = value.substring(0,4);
				var month = value.substring(5,6);
				var manageType = entity.get('manageType');
				if( manageType == 1 ){
					entity.set('sbEndMonth',value);
				}else
				if( manageType == 2){
					entity.set('sbEndMonth',addMonth(value) );
				}
			}
		}
		
		/**
		 * 5、设置了受托供应商后，加载受托供应商订单
		 */
		if( arg.property == 'receiveOrgId'){
			var receiveOrgId = arg.newValue ;
			delegateNextOrg(receiveOrgId,'sb',entity);
		}
		
		/**
		 * 6、如果相同的政策包，企业级次、个人级次一样，则企业基数、个人基数保持一致
		 */
		if( arg.property == 'companyBase' || arg.property == 'individualBase' ){
			var enterValue = 0;
			var baseGrade = 0.0;//级次
			if(arg.property == 'companyBase'){
				baseGrade = entity.get('companyBaseGrade');
				enterValue = entity.get('companyBase');
			}else
			if(arg.property == 'individualBase'){
				baseGrade = entity.get('individualBaseGrade');
				enterValue = entity.get('individualBase');
			}

			var policyGroupName = entity.get('policyGroupName');// 要改变的政策包名称
			var datasetPolicyDetail = view.get('#dataSetPolicyDetail');
			var policyList = new Array();
			
			//变更订单时，只更改同一行的（只判断横向，不判断纵向）
			if(window.orderStep == 4 ){
				var entity = datasetPolicyDetail.queryData('#');
				policyList.push( entity );
			}else{
				policyList = datasetPolicyDetail.queryData();//社保公积金数据集
			}
			
			
			for(var i = 0; i< policyList.length; i++){
				var policyDetail = policyList[i];
				if(policyGroupName == policyDetail.get('policyGroupName')){
					var oldCompanyBase = policyDetail.get('companyBase');
					var oldInividualdBase = policyDetail.get('individualBase');
					// 企业基数
					if(baseGrade == policyDetail.get('companyBaseGrade') 
							&& enterValue != oldCompanyBase){
						policyDetail.set('companyBase' , enterValue);
					}
					// 个人基数
					if(baseGrade == policyDetail.get('individualBaseGrade')
							&& enterValue != oldInividualdBase){
						policyDetail.set('individualBase' , enterValue);
					}
				}
			}
		}
		
		/**
		 * 7、如果设置了账单模板，则获取新建状态的账单月设置为默认账单起始月
		 */
		if( property == 'companyBillTemplateId'){
			queryCloseMonth(entity.get('companyBillTemplateId'),entity);
			checkBillMonth(entity,'companyBillTemplateId','billStartMonth');
		}
		/**
		 * 8、如果缴交金额发生了变化，重新计算总金额
		 */
		if( property == 'paySum'){
			paySumTotal();
		}
	}
}

function loadPolicyDetail(dataSetName){
	var dataSetBdEmpBaseInfo = view.get('#dataSetBdEmpBaseInfo');
	var	cityId = dataSetBdEmpBaseInfo.getData('#').get('workAddress');
	if( !cityId ){
		cityId = 0;
	}
	var dataSetPolicySetup = view.get(dataSetName);
	dataSetPolicySetup.set('parameter',{'cityId':cityId}).flush();

}

/**
 * 根据账单模板查询新建状态的账单月
 * @param billTemplateId
 */
function queryCloseMonth(billTemplateId,entity){
	if( billTemplateId ){
		if( !window.queryCloseMonthAjaxAction ){
			window.queryCloseMonthAjaxAction = new dorado.widget.AjaxAction({
				'id':'queryCloseMonthAjaxAction',
				'modal':false,
				'async':false,
				'service':'personalOrderPR#queryCloseMonth'
			});
		}
		window.queryCloseMonthAjaxAction.set('parameter',{'billTemplateId':billTemplateId})
		.execute(function(result){
			entity.set('billStartMonth',result);
		});
	}
}


/**
 * 委托给下一级供应商（创建子订单
 * 在社保公积金中选择受托供应商触发的事件
 * @param receiveOrgName 受托供应商名称
 * @param type 类别：社保或非社保
 */
function delegateNextOrg(receiveOrgId,type,currentEntity){
	var dataSetPrvdOrder = view.get('#dataSetPrvdOrder');
	var receiveOrgName = "";
	if( receiveOrgId ){
		
		//判断母订单是否有产品已经被转包给了该供应商
		var hasProdDelegate = false ;
		var delegateMsg = {};
		var baseInfo = objGet("dataSetBdEmpBaseInfo").getData('#') ;
		var parentOrderId = baseInfo.get('orderId');
		//在转包页面需要判断
		if( parentOrderId ){
			if( !window.checkHasDelegateAjaxAction ){
				window.checkHasDelegateAjaxAction = new dorado.widget.AjaxAction({
					'id':'checkHasDelagateAjaxAction',
					'modal':false,
					'async':false,
					'service':'personalOrderPR#checkHasDelagateToTheReceiveOrg'
				});
			}
			window.checkHasDelegateAjaxAction.set('parameter',{'sendOrgId':window.loginUserOrgId,'receiveOrgId':receiveOrgId,'parentOrderId':parentOrderId})
			.execute(function(result){
				if( result ){
					hasProdDelegate = true ;
					delegateMsg = result;
					var dataSetContractDelegate = view.get('#dataSetContractDelegate');
					dataSetContractDelegate.insert({'contractId':delegateMsg.contractId,'sendOrgId':window.loginUserOrgId,'receiveOrgId':receiveOrgId});
				}
			});
			
		}
		
		//在社保公积金中添加一行数据
		if( type == 'sb'){
			var org = view.get('#dataSetPrvd').queryData('[@.get("orgId")=="'+receiveOrgId+'"]');
			receiveOrgName = org[0].get('orgChineseName');
			var id = currentEntity.get('id');
			var dataSetPolicyDetailDelegate = view.get('#dataSetPolicyDetailDelegate');
			var queryData ;
			if( id ){
				queryData = dataSetPolicyDetailDelegate.queryData('[@.get("id")=='+id+']');
			}else{
				var orderIndex = currentEntity.get('orderIndex');
				queryData = dataSetPolicyDetailDelegate.queryData('[@.get("orderIndex")=='+orderIndex+']');
			}
			//如果这一行在子订单中没有添加过，则添加
			if( !queryData || queryData.length == 0 ){
				var insertData = currentEntity.toJSON();
				insertData.receiveOrgId = receiveOrgId;
				insertData.receiveOrgName = receiveOrgName;							
				insertData.companyBillTemplateName = null;//清空账单模板
				insertData.billStartMonth = null;//清空账单起始月
				dataSetPolicyDetailDelegate.insert(insertData);
			}else{//如果有，则修改
				var entityList = dataSetPolicyDetailDelegate.getData();
				entityList.each(function(entity){
					if(entity.get('id') == id ){
						entity.set('receiveOrgId',receiveOrgId);
						entity.set('receiveOrgName',receiveOrgName);
					}
				});
			}
		}
		
		//如果供应商订单信息没有显示，则显示出来
		var sectionDelegateOrder = view.get('#sectionDelegateOrder');
		var visible = sectionDelegateOrder.get('visible');
		if(visible == false){
			sectionDelegateOrder.set('visible',true);
		}
		
		//查找社保中指定了受托供应商的，全部加载到受托供应商信息列表中
		//再遍历已有的受托供应商信息列表，删除社保中没有指定受托供应商的
		var policyDetailEntityList = view.get('#dataSetPolicyDetail').queryData('[@.get("receiveOrgId")!=null]');
		var receiveOrgIdString = ',';
		
		for(var i=0 ; i<policyDetailEntityList.length ;i++){
			receiveOrgId = policyDetailEntityList[i].get('receiveOrgId');
			//指定了受托供应商时才添加(防止id为0的情况)
			if( receiveOrgId && receiveOrgId!=0 ){
				var orderIndex2 = policyDetailEntityList[i].get('orderIndex');
				var result = dataSetPrvdOrder.queryData('[@.get("receiveOrgId")=='+receiveOrgId+']');
				receiveOrgIdString += receiveOrgId +',';
				//如果没有加载过，则加载
				if( !result || result.length==0){
					dataSetPrvdOrder.insert({'receiveOrgId':receiveOrgId,'receiveOrgName':receiveOrgName,
						'orderIndex':orderIndex2,'type':type,'hasProdDelegate':hasProdDelegate,
						'contractId':delegateMsg.contractId,'contractName':delegateMsg.contractName,
						'smallContractId':delegateMsg.smallContractId,
						'sendCsId':delegateMsg.sendCsId,'sendCsName':delegateMsg.sendCsName,
						'receiveCsId':delegateMsg.receiveCsId,'receiveCsName':delegateMsg.receiveCsName,
						'sendOrgId':window.loginUserOrgId,'receiveOrgId':receiveOrgId,
						'loginCsId':window.loginCsId,'loginCsName':window.loginCsName});
				}
			}
		}
		var prvdOrderEntityList = dataSetPrvdOrder.queryData();
		for(var i=0 ;i<prvdOrderEntityList.length ; i++){
			var tmp = prvdOrderEntityList[i].get('receiveOrgId');
			if( receiveOrgIdString.indexOf(tmp) == -1){
				prvdOrderEntityList[i].remove();
			}
		}
	}
}

/**
 * 非社保详情onDataChange
 * @param arg
 * @returns
 */
function nsbDetailDataChange(arg){
	var property = arg.property ;
	var entity = arg.entity;
		
	/**
	 * 1、如果本行对应创建了子订单，则本行数据改变时自动修改子订单的值(除了账单模板、账单月，供应商id和供应商name)
	 */
	if(property != 'billTemplateId' && property != 'billTemplateName' &&property != 'billStartMonth'
		&& property != 'receiveOrgId'&& property != 'receiveOrgName'){
		var orderIndex = entity.get('orderIndex');
		var dataSetNsbDetailRecDelegate = view.get('#dataSetNsbDetailRecDelegate');
		if( dataSetNsbDetailRecDelegate ){
			var queryData = dataSetNsbDetailRecDelegate.queryData('[@.get("orderIndex")=='+orderIndex+']');
			if(queryData && queryData.length != 0){
				queryData[0].set(property,entity.get(property));
			}
		}
	}
	
	/**
	 * 2、第一行赋值后，下面的行设置为第一行的值
	 */
	if(property != 'itemId' && property != 'quotName' && property != 'sum'){
		//设置
		
		//如果是订单变更，则不需要
		if( window.orderStep != 4 ){
			setOrderNsbNextLineValue(arg.entity, property);
		}
	}
	
	/**
	 * 3、设置了受托供应商后，加载受托供应商信息
	 */
	if( property == 'receiveOrgId'){
		var receiveOrgName = arg.newValue;
		delegateNextOrg(receiveOrgName,'nsb',entity);
	}
	
	/**
	 * 4、如果设置了账单模板，则获取新建状态的账单月设置为默认账单起始月
	 */
	if( property == 'billTemplateId'){
		queryCloseMonth(entity.get('billTemplateId'),entity);
	}
	
	/**
	 * 5、计算总金额
	 */
	if( property == 'sum'){
		paySumTotal();
	}
	 
	 /**
		 * 4、录入了服务起始（结束）月，如果是一次性社保，则自动设置服务结束月
		 */
	var itemType = entity.get('itemType');
	if( property == 'paymentStartMonth' && itemType == 1){
		var value = arg.newValue ;
		entity.set('paymentEndMonth',value);
	}
}

/**
 * 初始化序号
 * @param type
 * @param dataSetName
 */
function setFirstOrderIndex(type){
	if(type == 'sb'){
		if(window.orderIndexSb == undefined){
			var tmp = 0;			
			//如果dataSet中已经添加了详情信息，则获取orderIndex最大的
			var dataSet = view.get('#dataSetPolicyDetail');
			var entityList = dataSet.getData();
			entityList.each(function(entity){
				if( entity.get('orderIndex') > tmp ){
					tmp = entity.get('orderIndex');
				}
			});
			window.orderIndexSb = tmp;
		}
	}else
		if( type == 'nsb' ){
			if(window.orderIndexNsb == undefined){
				var tmp = 0;			
				//如果dataSet中已经添加了详情信息，则获取orderIndex最大的
				var dataSet = view.get('#dataSetHsEmpOrdNsbDetailRec');
				if( window.orderType == 'childOrder' ){
					dataSet = view.get('#dataSetNsbDetailRecDelegate');
				}
				var entityList = dataSet.getData();
				entityList.each(function(entity){
					if( entity.get('orderIndex') > tmp ){
						tmp = entity.get('orderIndex');
					}
				});
				window.orderIndexNsb = tmp;
			}	
	}
}

/**
 * 变更订单时，社保或非社保dataChange事件
 */
function changeOrderDataChange( arg ){
	var entity = arg.entity;
	var oldDataJson = entity.getOldData();
	if( oldDataJson ){
		oldDataJson.isChecked = false;
		delete oldDataJson.$dataType;
		var newDataJson = entity.toJSON();
		newDataJson.isChecked = false;
		var oldData = dorado.JSON.stringify( oldDataJson ) ;
		var newData = dorado.JSON.stringify( newDataJson );
		//如果数据发生变化，则勾选
		if( oldData != newData ){
			if( entity.get('isChecked') != true ){
				entity.set('isChecked',true);
			}
		}else{
			if( entity.get('isChecked') != false ){
				entity.set('isChecked',false);
			}
		}
	}
}

/**
 * 查询社保的一次性产品
 */
function queryOnceSbProduct(){
	var dataSetBdProd = view.get('#dataSetBdProd');
	dataSetBdProd.flush();
}

/**
 * 将一次性社保产品加载到社保公积金明细列表中
 */
function insertOnceSbProduct( type ){
	var bdProd = view.get('#dataSetBdProd').getData('#');
	var prodId = bdProd.get('prodId');
	var prodName = bdProd.get('prodName');

	var dataSetPolicyDetail = view.get('#dataSetPolicyDetail');
	
	var billTemplateId = 0;
	var billTemplateName = '';
	var defaultPaymentStartMonth = '';
	//设置默认账单模板
	if(!( type && type=='batAddProd') ){
		defaultPaymentStartMonth = setPaymentStartMonthByHireDate();
		var orginalEntityList = dataSetPolicyDetail.getData();
		if(orginalEntityList.entityCount > 0){
			var entityNew = loadDefaultTemplate(orginalEntityList);
			if(entityNew && entityNew.get('companyBillTemplateId') > 0
					&& entityNew.get('companyBillTemplateName')){
				billTemplateId = entityNew.get('companyBillTemplateId');
				billTemplateName = entityNew.get('companyBillTemplateName');
			}
		}else{
			var baseInfo = objGet("dataSetBdEmpBaseInfo").getData('#') ; 
			
			var billTemplate = getFirstBillTemplate(baseInfo,'#dataSetBillTemplate');
			billTemplateId = billTemplate.billTemplateId;
			billTemplateName = billTemplate.billTemplateName;
		}
	}
	
	//添加一条一次性社保
	var entity = dataSetPolicyDetail.getData('[@.get("itemType")==1 && @.get("itemId")=="'+prodId+'"]');
	if( !entity ){
		//初始化序号
		setFirstOrderIndex('sb');
		window.orderIndexSb++;
		dataSetPolicyDetail.insert({'itemType':1,'itemId':prodId,'serviceName':prodName,
			'orderIndex':window.orderIndexSb,'companyBillTemplateId':billTemplateId,
			'companyBillTemplateName':billTemplateName,'paymentStartMonth':defaultPaymentStartMonth,
			'paymentEndMonth':defaultPaymentStartMonth});
	}else{
		new dorado.MessageBox.alert('已添加该一次性社保');
	}

}

/**
 * 加载政策包
 */
function loadPolicySetup(arg,dataSetName){
	var dataSetBdEmpBaseInfo = view.get('#dataSetBdEmpBaseInfo');
	var	cityId = 0 ;
	if( dataSetBdEmpBaseInfo ){
		cityId = dataSetBdEmpBaseInfo.getData('#').get('workAddress');
	}
	if( !cityId ){
		cityId = 0;
	}
	var dataSetPolicySetup = view.get('#dataSetPolicySetup');
	if( dataSetName ){
		dataSetPolicySetup = view.get(dataSetName);
	}
	dataSetPolicySetup.set('parameter',
		{'cityId':cityId,'policyGroupName':arg.filterValue }).flushAsync();
}

/**
 * 加载政策包组合
 * @param arg
 */
function loadSbGroup(arg){
	var dataSetBdEmpBaseInfo = view.get('#dataSetBdEmpBaseInfo');
	var	cityId = dataSetBdEmpBaseInfo.getData('#').get('workAddress');
	if( !cityId ){
		cityId = 0;
	}
	var dataSetSbGroup = view.get('#dataSetSbGroup');
	dataSetSbGroup.set('parameter',{'cityId':cityId,'sbGroupName':arg.filterValue }).flushAsync();
	paySumTotal();
}

/**
 * 显示企业或个人基数范围
 * @param arg
 * @param type 公司、个人
 */
function showBaseTip(arg,type){
	var entity = arg.data;
	var scopeProperty = '';
	var baseProperty = '';
	if( type == 'company'){
		scopeProperty = "aviableCompanyBase";
		baseProperty = "companyBase";
	}else{
		scopeProperty = "aviableIndividualBase";
		baseProperty = "individualBase";
	}
	
	var aviableCompanyBase = entity.get(scopeProperty);
	var companyBase = entity.get(baseProperty);
	if( aviableCompanyBase != undefined ){
		arg.dom.title='基数范围为：'+aviableCompanyBase;
	}
	if( companyBase != undefined ){
		arg.dom.innerHTML=companyBase;
	}
}

/**
 * 双击跳转其他页面,查看详细信息
 * @param moudleType
 */
function doubleClickToOtherTab(moudleType){
	var current  = view.get('#dataSetHsEmpOrd').getData('#');
	if(current){
		var orderRecId =current.get('orderRecId');
		var orderMutualId = current.get('orderMutualId');
		switch(moudleType){
			case 1:
				break;
			case 2:
			    // 完善订单双击跳转
				top.openUrlInFrameTab("com.hrhelper.hro.view.order.create.improveOrder.d?orderRecId="
						+orderRecId,'完善订单--查看');
				break;
			case 3:
				// 订单确认双击跳转
				top.openUrlInFrameTab("com.hrhelper.hro.view.order.create.createOrderConfirm.d?orderRecId="
						+orderRecId,'订单确认--查看');
				break;
			case 4:
				// 变更订单双击跳转
				top.openUrlInFrameTab("com.hrhelper.hro.view.order.change.changeOrder.d?orderRecId="
						+orderRecId,'变更订单--查看');
				break;
			case 5:
				// 变更订单确认双击跳转
				top.openUrlInFrameTab("com.hrhelper.hro.view.order.change.changeOrderConfirm.d?orderRecId="
						+orderRecId,'变更确认--查看');
				break;
			case 6:
				// 撤销订单双击跳转
				top.openUrlInFrameTab("com.hrhelper.hro.view.order.cancel.cancelOrder.d?orderRecId="
						+ orderRecId,"撤销订单--查看",null,null);
				break;
			case 7:
				// 撤销确认双击跳转
				top.openUrlInFrameTab("com.hrhelper.hro.view.order.cancel.cancelOrderConfirm.d?orderRecId="+
					orderRecId+"&orderMutualId="+orderMutualId,'撤销确认--查看');
				break;
			default:
				break;
		}
	}
}

/**
 * 非社保，选择报价单
 */
function selectQuotation(){
	var baseInfo = objGet("dataSetBdEmpBaseInfo").getData('#') ; 
	var contractId = baseInfo.get('contractId');

	if( !contractId ) {
		dorado.MessageBox.alert('请选择合同！');
	}else{
		var dialogAddQuotation = view.get('#dialogAddQuotation');
		dialogAddQuotation.show();
		window.orderType = 'parentOrder';
		var sendOrgId = baseInfo.get('sendOrgId');
		var receiveOrgId = baseInfo.get('receiveOrgId');
		//加载报价单
		var dataSetQuotation = view.get('#dataSetQuotation');
		dataSetQuotation.set('parameter',{'vendorId':receiveOrgId,'custId':sendOrgId,'summary':''}).flush();

	}
}

/**
 * 导出文件Excel
 * @param exportOrderToExcelAction
 */
function exportRecordToExcel(exportOrderToExcelAction, dataGridOrder){
	var maxSize = exportOrderToExcelAction.get('maxSize');

	var dataSetOrder = dataGridOrder.get('dataSet').getData();
	if(dataSetOrder.entityCount > 0){
		dorado.MessageBox.show({
			message : '最多导出' + maxSize + '条记录, 是否继续?',
			buttons : ['是' , '否'],
			detailCallback : function(buttonId){
				if(buttonId == '是'){
					exportOrderToExcelAction.execute();
				}
			}
		});
	} else {
		dorado.MessageBox.alert('没有要导出的数据');
	}
	
}

/**
 * 完善订单驳回
 */
function rejectOrderWhenImprove( type ){
	dorado.MessageBox.confirm("确认要驳回该订单吗？",function(){
		//获取订单履历ID
		var dataSetHsEmpOrd = view.get('#dataSetHsEmpOrd');
		if( dataSetHsEmpOrd == undefined ){
			dataSetHsEmpOrd = view.get('#dataSetBdEmpBaseInfo');
		}
		var current = dataSetHsEmpOrd.getData('#');
		var orderRecId = current.get('orderRecId');
		var orderId = current.get('orderId');
		
		//提交,将状态设置为增员未提交
		var ajaxActionOrderReject = view.get('#ajaxActionOrderReject');
		ajaxActionOrderReject.set('parameter',{'orderRecId':orderRecId,'orderId':orderId});
		ajaxActionOrderReject.execute(function(result){
			if( result == true ){
				dorado.MessageBox.alert('驳回该订单成功！',function(){
					if( type == 'edit'){
						parent.RemoveCrentDiv();
					}else{
						var dataSetHsEmpOrd = view.get('#dataSetHsEmpOrd');
						dataSetHsEmpOrd.flush();
					}
				});
				
			}
		});
		
	});
}

function nsbDetialOnCurrentChange( parentOrderId ){
	var dataSetHsEmpOrdNsbDetailRec = view.get('#dataSetHsEmpOrdNsbDetailRec');
	var detail = dataSetHsEmpOrdNsbDetailRec.getData('#');
	if( detail && window.orderStep != 3 ){
		//不是转包订单
		if( !parentOrderId ){
			var itemType = detail.get('itemType');
			//一次性产品,一些字段只读
			if( itemType == 1 ){
				view.get('^paymentEndMonthNsb').set('readOnly',true);
				view.get('^billEndMonthNsb').set('readOnly',true);
			}else{
				view.get('^paymentEndMonthNsb').set('readOnly',false);
				view.get('^billEndMonthNsb').set('readOnly',false);
			}
			
			//有报价单id，表明从通过选择报价单加载的产品，则使用报价单中的金额，且不可修改
			if(detail.get('offerId') ){
				view.get('^sum').set('readOnly',true);
			}else{
				view.get('^sum').set('readOnly',false);
			}
		}else{
			//有报价单id，不能选择委托供应商
			if(detail.get('offerId') ){
				view.get('^sum').set('readOnly',true);
			}else{
				view.get('^sum').set('readOnly',false);
				
				//如果是转包完善,
				if( window.orderStep == 2){
					view.get('^paymentStartMonth').set('readOnly',true);
					view.get('^paymentEndMonth').set('readOnly',true);
				}
				
			}
		}
		
	}
}

/**
 * 渲染社保明细的操作链接
 */
function sbDetailOperateLink(arg){
	var dom = $(arg.dom);
	dom.empty();

	var dataSet = view.get('#dataSetPolicyDetail');
	var itemType = arg.data.get('itemType');
	if( itemType == 0 ){
		dom.xCreate({
			tagName: "a",
			href:"#",
			content: '添加',
			onclick: function(){
				var policyDetail = dataSet.getData('#');
				var entityJson = policyDetail.toJSON();
				entityJson.paymentStartMonth = '';
				entityJson.paymentEndMonth = '';
				var entityList = dataSet.getData();
				entityList.insert(entityJson,'after',policyDetail);
			}
		});
	}
	dom.append('&nbsp;&nbsp;&nbsp;');
	dom.xCreate({
		tagName: "a",
		href:"#",
		content: '清零',
		onclick: function(){
			var policyDetail = dataSet.getData('#');
			policyDetail.set('companySum',0);
			policyDetail.set('individualSum',0);
			policyDetail.set('paySum',0);
			dorado.MessageBox.alert('该社保明细的金额已被清零');
		}
	});
	arg.processDefault=false;
}

/**
 * 完善、变更时保存
 * @param orderStatus 订单要改成的状态
 * @param parentOrderId 母订单
 */
function mutualSaveAll(orderStatus){
	//完善时报价单必选，变更时不管(去掉，可以不填)
	/*
	if( orderStatus == '3' ){
		//是否有报价单
		var hasQuot = false ;
		var nsbEntityList = view.get('#dataSetHsEmpOrdNsbDetailRec').getData();
		nsbEntityList.each(function(entity){
			var offerId = entity.get('offerId');
			if( offerId ){
				hasQuot = true ;
				return;
			}
		});
		if( hasQuot == false ){
			dorado.MessageBox.alert('请选择报价单');
			return ;
		}
	}
	*/
	
	var dataSetBdEmpBaseInfo = view.get('#dataSetBdEmpBaseInfo');
	var baseInfo = dataSetBdEmpBaseInfo.getData('#');
	baseInfo.set('orderStatus',orderStatus);

	var dataSetPolicyDetail = view.get('#dataSetPolicyDetail');
	var newSbList = dataSetPolicyDetail.queryData('[#new]');
	var modifiedSbList = dataSetPolicyDetail.queryData('[#modified]');

	var allSbList = view.get('#allSbDetailRec');
	var changedList = new dorado.EntityList() ;
	for(var i=0;i<newSbList.length;i++){
		var entity = newSbList[i];
		entity.set('hasChanged',1);
		var policyGroupId = entity.get('policyGroupId');
		var itemId = entity.get('itemId');
		//查询新增的数据在已有的数据中是否存在（相同的政策包和产品）
		var entityList = allSbList.queryData('[@.get("policyGroupId")=='
				+policyGroupId+' && @.get("itemId")=="'+itemId+'"]');
		//如果存在,表明是修改服务段，否则是新增产品
		if( entityList.length >0 ){
			var json = entity.toJSON();
			json.dataStatus =3;
			var firstEntity = entityList[0];
			var receiveOrgId = firstEntity.get('receiveOrgId');
			var childOrderRecId = firstEntity.get('childOrderRecId');
			json.receiveOrgId = receiveOrgId;
			json.childOrderRecId = childOrderRecId;
			changedList.insert(json);
		}else{
			var json = entity.toJSON();
			json.dataStatus = 1;
			changedList.insert(json);
		}
	}

	var hasOnlyChangedBillTemp = false ;
	var hasChangedBillTemp = false ;
	//改了除账单模板、账单月之外的数据时，才记录到已变更列表中
	//（因为账单模板和账单月变更不会影响到子或母订单）
	for(var i=0;i<modifiedSbList.length;i++){
		var entity = modifiedSbList[i];
		entity.set('hasChanged',1);
		var oldDataJson = entity.getOldData();
		delete oldDataJson.$dataType;
		var oldDataJsonTmp = oldDataJson;
		delete oldDataJson.companyBillTemplateId;
		delete oldDataJson.companyBillTemplateName;
		delete oldDataJson.billStartMonth;
		delete oldDataJson.isChecked;
		var newDataJson = entity.toJSON();
		var newDataJsonTmp = newDataJson;
		delete newDataJson.companyBillTemplateId;
		delete newDataJson.companyBillTemplateName;
		delete newDataJson.billStartMonth;
		delete newDataJson.isChecked;
		
		var oldData = dorado.JSON.stringify( oldDataJson ) ;
		var newData = dorado.JSON.stringify( newDataJson );
		//如果数据发生变化
		if( oldData != newData ){
			var oldPaySum = oldDataJson.paySum;
			var newPaySum = newDataJson.paySum;
			
			var json = entity.toJSON();
			//清零的情况
			if( oldPaySum != newPaySum && newPaySum == 0 ){
				json.dataStatus =2;
				changedList.insert(json);
			}else{
				json.dataStatus =3;
				changedList.insert(json);
			}
		}
		//是否只改了账单模板或账单月
		if( oldDataJsonTmp != newDataJsonTmp && oldData == newData ){
			hasChangedBillTemp = true ;
		}
	}
	//判断是否是子订单只改了账单模板或账单月
	var parentOrderId = baseInfo.get('parentOrderId');
	if(hasChangedBillTemp && parentOrderId && changedList.entityCount == 0){
		hasOnlyChangedBillTemp = true ;	
	}
	baseInfo.set('hasOnlyChangedBillTemp',hasOnlyChangedBillTemp);

	var dataSetChangedList = view.get('#dataSetChangedList');
	dataSetChangedList.setData(changedList);

	var updateActionSaveAll = view.get('#updateActionSaveAll');
	updateActionSaveAll.execute(function(result){
		if(	result && result != 0 ){
			dorado.MessageBox.alert('提交成功',function(){
				parent.RemoveCrentDiv();
			});
		}
	});

}

/**
 * 计算社保和非社保消费总和
 * @param arg
 */
function paySumTotal(){
	// 计算社保，非社保总计
	var costTotalView = view.get('#costTotal');
	if( costTotalView ){
		var costTotal = 0, detailCost = 0, nsbDetailCost =0;
		if(view.get('#dataSetPolicyDetail')){
			var entityListPolicyDetail = view.get('#dataSetPolicyDetail').getData();
			entityListPolicyDetail.each(function(entity){
				var cost = Number(entity.get('paySum'));
				if(cost > 0){
					detailCost += cost;
				}
			});
		}
		
		if(view.get('#dataSetHsEmpOrdNsbDetailRec')){
			var entityListHsEmpOrdNsbDetailRec = view.get('#dataSetHsEmpOrdNsbDetailRec').getData();
			entityListHsEmpOrdNsbDetailRec.each(function(nsbEntity){
				var nsbCost = Number(nsbEntity.get('sum'));
				if(nsbCost > 0){
					nsbDetailCost += nsbCost;
				}
			});
		}
		
		costTotal = detailCost + nsbDetailCost;
		costTotalView.set('value', costTotal.toFixed(2));
	}
}

/**
 * 查看报价单链接
 * @param arg
 */
function queryQuot(arg){
	var dom = $(arg.dom);
	dom.empty();
	var data = arg.data;
	dom.xCreate({
		tagName: "a",
		href:"#",
		content: data.get('quotName'),
		onclick: function(){
			var offerId = data.get('offerId');
			var side = $.cookie('side');
			if( side == 2 ){
				var url = "com.hrhelper.hro.view.quotation.VendorQuotDetail.d?type=observe";
				url+= "&businessId="+offerId;
				parent.openUrlInFrameTab(url,"查看报价单-受托方",null,null);
			}else
				if( side == 1 ){
				var url = "com.hrhelper.hro.view.quotation.CustQuotDetail.d?type=observe";
				url+= "&businessId="+offerId;
				parent.openUrlInFrameTab(url,"查看报价单-委托方",null,null);
			}
			
			
		}
	});
	arg.processDefault=false;
}

/**
 * 大病医保服务结束月校验
 * 只能录入年缴月份的前一月
 */
function checkSeriousIllness(arg){
	if( objGet("dataSetBdEmpBaseInfo") ){
		var current = objGet("dataSetBdEmpBaseInfo").getData('#') ;
		var step = current.get('orderStep');
		if( step == 2 || step == 4 || step == 6 ){
			var entity = arg.entity;
			var payType = entity.get('payType');
			
			if(payType == 3 || payType == 4){
				var payMonth = entity.get('payMonth');
				if( !payMonth ){
					arg.result={
						text: "请到政策包中设置该产品的年缴月份",
						state: "error"
					};
				}else{
					var paymentEndMonth = entity.get('paymentEndMonth');
					//如果服务结束月有值，则校验
					if( paymentEndMonth ){
						payMonth = parseInt(payMonth);
						var preMonth = '';
						if( payMonth == 1 ){
							preMonth = 12 +'';
						}else{
							preMonth = payMonth-1 +'';
						}
						if(preMonth.length == 1){
							preMonth = '0'+ preMonth;
						}
						
						var paymentEndMonthMonth = paymentEndMonth.substring(4,6);
						if( paymentEndMonthMonth != preMonth){
							arg.result={
								text: "服务结束月月份只能是"+preMonth+"月",
								state: "error"
							};
						}
					}
				}
			}
		}
	}
	
}

/**
 * 订单基础数据onDataChange事件
 * @param arg
 */
function baseInfoOnDataChange(arg){
	var property = arg.property;
	if( property == 'dimissionDate'){
		var dimissionDate = arg.newValue;
		if( dimissionDate ){
			dimissionDate = dimissionDate.format('yyyyMMdd');
			var yearMonth = dimissionDate.substring(0,6);
			var day = parseInt( dimissionDate.substring(6,8) ) ;
			if( day < 16 ){
				yearMonth = calculateMonth(yearMonth,-1);
			}
			view.get('#changePaymentStartMonth').set('value',yearMonth);
		}
	}
}

/**
 * 离职后变更，社保、非社保服务结束月要做必填校验
 * @param arg
 */
function checkPaymentEndMonthWhenCancel(arg){
	if( objGet("dataSetBdEmpBaseInfo") ){
		var current = objGet("dataSetBdEmpBaseInfo").getData('#') ;
		var orderStatus = current.get('orderStatus');
		if( orderStatus=="10" || orderStatus=="11" ){
			if( !arg.data ){
				arg.result={
					text: "撤销后变更，服务结束月必填",
					state: "error"
				};
			}
		}
	}
}

/**
 * 对金额统计进行精度计算
 */
function sumFootRender(arg){
	var columnId = arg.column.get('property');
	var data = arg.data._data;
	var companySum = data.companySum;
	var individualSum = data.individualSum;
	var paySum = data.paySum;
	if(columnId == 'companySum'){
		if( companySum ){
			companySum = formatMoney(companySum+'',2);
			arg.dom.innerHTML = companySum;
		}
	}else
		if(columnId == 'individualSum'){
			if( individualSum ){
				individualSum = formatMoney(individualSum+'',2);
				arg.dom.innerHTML = individualSum;
		}
	}else
		if(columnId == 'paySum'){
			if( paySum ){
				paySum = formatMoney(paySum+'',2);
				arg.dom.innerHTML = paySum;
			}
	}

}

/**
 * 完善时批量提交
 * @param submitOrReject 提交或驳回 
 */
function batSubmit( submitOrReject ){
	var dataGridOrder = view.get('#dataGridOrder');
	var selection = dataGridOrder.get('selection');
	if( selection.length > 0 ){
		view.get('#dataSetSubmitOrder').setData(selection);
		var updateActionSubmit = view.get('#updateActionSubmit');
		if( submitOrReject == 'submit' ){
			updateActionSubmit.set('dataResolver','personalOrderPR#changeOrderStatusBat');
		}else
			if( submitOrReject == 'reject' ){
			updateActionSubmit.set('dataResolver','personalOrderPR#batRejectOrderWhenImprove');
		}
		updateActionSubmit.execute(function(result){
			if(result){
				dorado.MessageBox.alert('提交成功');
				view.get('#dataSetHsEmpOrd').flush();
			}
		});
	}else{
		dorado.MessageBox.alert('请选择需要处理的订单!');
	}

}