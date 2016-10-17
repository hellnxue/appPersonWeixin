/**
 * 社保模型
 */

/**
 * 根据id获取一个对象
 * @param objId
 * @returns
 */
function objGet( objId ){
	return $id(objId).objects[0];
}

function setSbNextLineValue(dateSetId,property,current){
	var entityList = objGet(dateSetId).getData();
	var firstEntity = entityList.getFirst();
	//如果当前行是第一行
	if( current.entityId == firstEntity.entityId){
		entityList.each(function(entity){
			if( entity.entityId != firstEntity.entityId ){
				//如果当前行的该属性没有值，则将第一行的值赋给它
				if( !entity.get(property) ){
					entity.set(property,firstEntity.get(property));
				}
			}
			
		});
	}
}

function selectRatio(){
	var dialogRatio = view.get('#dialogRatio');
	dialogRatio.set("caption","维护比例");
	view.get('#dsTempRatio').clear();
	view.get('#dataSetCompanyRatio').flush();
	view.get('#dataSetIndividualRatio').flush();

	var policyDetail = view.get('#dataSetGroupDetail').getData('#');
	
	if(policyDetail.get('companyRatioId') && policyDetail.get('companyRatio') 
		&& policyDetail.get('companyAddAmount') && policyDetail.get('individualRatioId') 
		&& policyDetail.get('individualRatio') && policyDetail.get('individualAddAmount')){
			
		var companyRatioIdArray = policyDetail.get('companyRatioId').split(',');
		var companyRatioArray = policyDetail.get('companyRatio').split(',');
		var companyAddAmountArray = policyDetail.get('companyAddAmount').split(',');
		var individualRatioIdArray = policyDetail.get('individualRatioId').split(',');
		var individualRatioArray = policyDetail.get('individualRatio').split(',');
		var individualAddAmountArray = policyDetail.get('individualAddAmount').split(',');
		for(var i = 0;i<companyRatioIdArray.length-1;i++){
			var  insertData =
			{"companyRatioId": companyRatioIdArray[i],
			 "companyRatio": companyRatioArray[i],
			 "companyAddAmount":companyAddAmountArray[i],
			 "individualRatioId": individualRatioIdArray[i],
			 "individualRatio": individualRatioArray[i],
			 "individualAddAmount":individualAddAmountArray[i]
			};
			view.get('#dsTempRatio').insert(insertData);	
		}
	}
	dialogRatio.show();
}

/**
 * 将比例用百分号的格式显示
 * @param ratioProperty
 * @param arg
 */
function renderRatio(ratioProperty,arg){
	var originalRatio = arg.data.getText(ratioProperty) +'';
	if( originalRatio ){
		var ratioArray = originalRatio.split(',');
		var ratioString = '';
		for(var i=0;i<ratioArray.length;i++){
			var ratio = ratioArray[i];
			if( ratio ){
				ratio = ratio*100 ;
				var ratioStr = ratio+'';
				if(ratioStr.indexOf('.')!=-1 && ratioStr.split('.')[1].length > 4 ){
					ratio = ratio.toFixed(4);
				}
				ratioString += parseFloat(ratio)+ '%';
				if( i< ratioArray.length-1){
					ratioString +=',';
				} 
			}
		}
//		ratioString +="</span>";
		arg.dom.innerHTML= ratioString ;
		arg.processDefault=false;
	}
}

/**
 * 删除政策包，同时删除下面的详情
 */
function delPolicyGroup(arg,self){
	var dataSetSbGroup = view.get('#dataSetSbGroup');
	var currentSbGroup = dataSetSbGroup.getData('#');
	if( !currentSbGroup ){
		sbGroupId = 0 ;
	}else{
		sbGroupId = currentSbGroup.get('id');
	}

	var policyGroupName= arg.tag ;
	var dataSetPolicyDetail = view.get('#dataSetPolicyDetail');
	//根据政策名称获取政策明细
	var entityList = dataSetPolicyDetail.queryData('[@.get("policySetup.policyGroupName")=="' +policyGroupName+ '"]');
	if( entityList.length > 0){
		dorado.MessageBox.confirm("该政策下有政策组合包详情信息，确认要删除吗？",function(){
			var hasLoadPolicyDetailId = window.hasLoadPolicyDetailId ;
			for(var i=0;i<entityList.length;i++){
				var entity = entityList[i];
				//移除entity
				entity.remove();
				//删除id
				var tmp = ','+entity.get('id')+',';
				hasLoadPolicyDetailId = hasLoadPolicyDetailId.replace(tmp,',' );
			}
			window.hasLoadPolicyDetailId = hasLoadPolicyDetailId;
		});
	}
	

}

/**
 * 删除城市，同时删除政策包和政策包详情
 * @param arg
 */
function delCity(arg){
	var dataSetCity = view.get('#dataSetCity');
	var currentCity = dataSetCity.getData('[@.get("cityName")=="' + arg.tag + '"]');
	var cityCode = currentCity.get('cityId');
	var dataSetPolicyDetail = view.get('#dataSetPolicyDetail');
	var tagEditorPolicyGroup = view.get('#tagEditorPolicyGroup');
				
	var entityList = dataSetPolicyDetail.queryData('[@.get("policySetup.cityCode")=="' +cityCode+ '"]');
	if( entityList.length > 0){
		dorado.MessageBox.confirm("该城市下有政策组合包详情信息，确认要删除吗？",function(){
			var hasLoadPolicyDetailId = window.hasLoadPolicyDetailId ;
			for(var i=0;i<entityList.length;i++){
				var entity = entityList[i];
				//移除entity
				entity.remove();
				//删除id
				var tmp = ','+entity.get('id')+',';
				hasLoadPolicyDetailId = hasLoadPolicyDetailId.replace(tmp,',' );
				
				//移除政策包
				var policyGroupName = entity.get('policySetup.policyGroupName');
				tagEditorPolicyGroup.removeTags([policyGroupName]);
			}
			window.hasLoadPolicyDetailId = hasLoadPolicyDetailId;
		});
	}
}
