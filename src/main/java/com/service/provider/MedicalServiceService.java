package com.service.provider;

import java.util.List;
import java.util.Map;

import com.service.provider.entity.Area;
import com.service.provider.entity.HROFirstUserInfo;

public interface MedicalServiceService  {
	/**
	 * 根据用户信息查询所属体检劵列表
	 * 
	 * @param userId
	 *            用户id
	 * @return List
	 */
	public List<Map<String, Object>> getMedicalList(Long userId);

	/**
	 * 根据产品id和县级id查询体检门店信息
	 * 
	 * @param prod_id
	 *            产品id
	 * @param aere_id
	 *            县级id
	 * @param service_store_id
	 *            体检门店id（可选）
	 * @return List
	 */
	public List<Map<String, Object>> getServiceStoreList(Long prod_id,
			Long aere_id, Long service_store_id);
	
	/**
	 * 根据定位坐标查询距离该坐标由近及远的所有门店，切分页
	 * 
	 * @param prod_id
	 *            产品id
	 * @param city_id
	 *            城市id
	 * @param lat
	 *            维度
	 * @param lng
	 *            经度
	 * @param currentPage
	 *            如果为负数，则不做分页 分页参数
	 * @param pageSize
	 *            没有显示数据条数
	 * @param distance
	 *            距离范围（m）
	 * @return
	 */
	public List<Map<String, Object>> getMedicalListForLocaltion(Long prod_id,Long city_id, Double lat, Double lng, int currentPage,int pageSize, Long distance);

	/**
	 * 根据定位坐标查询距离该坐标由近及远的所有门店总数
	 * 
	 * @param prod_id
	 *            产品id
	 * @param city_id
	 *            城市id
	 * @return
	 */
	public int getMedicalListForLocaltionSize(Long prod_id, Long city_id);
	/**
	 * @param service_id
	 *            服务劵id
	 * @param service_store_id
	 *            体检门店id
	 * @param year
	 *            年
	 * @param month
	 *            月
	 * 
	 * @return Map
	 */
	public Map<String, Object> getServiceStoreScheduleByStoreId(
			Long service_id, Long service_store_id, int year, int month,Long userid);

	/**
	 * 根据体检劵id查询体检预约成功后详细信息
	 * 
	 * @param service_id
	 * @return Map
	 */
	public Map<String, Object> medicalDetail(Long service_id, Long user_id);
	
	/**
	 * 根据条件查询地址
	 * 
	 * @param sysArea
	 *            对象参数
	 * @return
	 */
	public List<Area> getSysAreaListByParam(Area sysArea);
	/**
	 * 提交体检预约
	 * 
	 * @param service_id
	 *            服务id
	 * @param service_store_id
	 *            服务门店
	 * @param year
	 *            年
	 * @param month
	 *            月
	 * @param day
	 *            日
	 * @param checked
	 *            是否参加妇科检查，1-是、2-否（默认）
	 * @param receivingAddrId
	 *            报告收取人地址id
	 * @param hroFirstUserInfo
	 *            session对象
	 * @return
	 */
	public boolean submitMedicalAppointment(Long service_id,Long service_store_id, int year, int month, int day, int checked,
			Long receivingAddrId, HROFirstUserInfo hroFirstUserInfo);
	
	/**
	 * 体检预约之前确认信息
	 * 
	 * @param service_id
	 *            服务id
	 * @param user_id
	 *            用户id
	 * @param service_store_id
	 *            服务门店id
	 * @return
	 */
	public Map<String, Object> medicalBeforeDetail(Long service_id,
			Long user_id, Long service_store_id);
	
	/**
	 * 体检实体卡激活
	 * 
	 * @param cardNum
	 *            卡号
	 * @param cardPwd
	 *            密码
	 * @param storeId
	 *            卡服务商id
	 * @return
	 */
	public String medicalCardActivation(String cardNum, String cardPwd,Long storeId,Long userId);
	
	
}
