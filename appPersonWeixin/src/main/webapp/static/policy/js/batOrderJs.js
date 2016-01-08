/**
 * 根据id获取一个对象
 * @param objId
 * @returns
 */
function objGet( objId ){
	return $id(objId).objects[0];
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
	}
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
		}
		orginalEntityList.insert(entity);
	});
	dataSetPolicyDetail.setData(orginalEntityList);
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
			|| property=='individualBase' ||  property=='individualRatio');
		
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
			&& property!='companyBase' &&property!='individualBase'){
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
				var queryData = dataSetPolicyDetailDelegate.queryData('[@.get("id")=='+id+']');
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
				var year = value.substring(0,4);
				var month = value.substring(5,6);
				var manageType = entity.get('manageType');
				if( manageType == 1 ){
					entity.set('sbStartMonth',value);
				}else
					if( manageType == 2){
						entity.set('sbStartMonth',addOneMonth(year,month) );
					}
				
				//一次性产品服务起始月和服务结束月相同
				if( entity.get('itemType') == 1){
					entity.set('paymentEndMonth',value);
					if( manageType == 1 ){
						entity.set('sbEndMonth',value);
					}else
						if( manageType == 2){
							entity.set('sbEndMonth',addOneMonth(year,month) );
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
					entity.set('sbEndMonth',addOneMonth(year,month) );
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
			
		}
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

