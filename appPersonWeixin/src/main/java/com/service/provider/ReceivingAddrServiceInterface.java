package com.service.provider;

import java.util.List;

import com.service.provider.entity.ReceivingAddrInfo;
/**
 * 收获地址管理
 *
 */
public interface ReceivingAddrServiceInterface {

	/**
	 * 添加地址信息
	 * <pre>
	 * @author dingtao  
	 * @date 2015年7月1日 上午11:35:20 
	 * </pre>
	 *
	 * @param receivingAddr
	 * @return
	 */
	public int addReceivingAddr(ReceivingAddrInfo receivingAddrInfo);
	
	/**
	 * 更新修改地址信息
	 * <pre>
	 * @author dingtao  
	 * @date 2015年7月1日 上午11:40:06 
	 * </pre>
	 *
	 * @param receivingAddr
	 * @return
	 */
	public int updateReceivingAddr(ReceivingAddrInfo receivingAddrInfo);
	
	
	
	
	/**
	 * 更新所有记录的isDefault字段值为0
	 * <pre>
	 * @author dingtao  
	 * @date 2015年7月3日 下午3:10:53 
	 * </pre>
	 *
	 * @param receivingAddr
	 * @return
	 */
	public int updateReceivingDefaultAddr(Long receivingAddrId);
	
	/**
	 * 更新所有记录的isDefault字段值为0(接口调用)
	 */
	
	public int updateDefaultStatus(Long userId);
	
	/*
	 * * 更新被点击收货地址为默认收货地址
	   */
	    
	public  int updateAddrToDefault(Long receivingAddrId);
	
	
	/**
	 * 删除地址信息
	 * <pre>
	 * @author dingtao  
	 * @date 2015年7月1日 上午11:40:54 
	 * </pre>
	 *
	 * @param receivingAddr
	 * @return
	 */
	public int deleteReceivingAddr(ReceivingAddrInfo receivingAddrInfo);
	
	
	
	/**
	 * 查询地址信息
	 * <pre>
	 * @author dingtao  
	 * @date 2015年7月1日 上午11:43:06 
	 * </pre>
	 *
	 * @param receivingAddr
	 * @return
	 */
	
	public ReceivingAddrInfo selectReceivingAddr(long receivingAddrId);
	/**
	 * 读取数据库中已存在收货地址信息
	 * <pre>
	 * @author dingtao  
	 * @date 2015年7月1日 下午4:44:23 
	 * </pre>
	 *
	 * @param receivingAddr
	 * @return
	 */
	public List<ReceivingAddrInfo> getReceivingAddr(ReceivingAddrInfo receivingAddrInfo);
	
	/**
	 * 查询某一用户账户下面设置的默认收货地址记录(接口调用)
	 */
	public ReceivingAddrInfo getDefaultAddr(Long userId);
}
