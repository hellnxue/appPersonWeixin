package com.hrofirst.util;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hrofirst.controller.JsonController;
import com.wondertek.esmp.esms.empp.EMPPConnectResp;
import com.wondertek.esmp.esms.empp.EMPPData;
import com.wondertek.esmp.esms.empp.EMPPObject;
import com.wondertek.esmp.esms.empp.EMPPShortMsg;
import com.wondertek.esmp.esms.empp.EMPPSubmitSM;
import com.wondertek.esmp.esms.empp.EmppApi;


/**
 * 短信发送工具类
 * 
 * @author chingsung
 * 
 */
public class MobileValidHelp {
	
	private static final Logger LOG = LoggerFactory
			.getLogger(MobileValidHelp.class);
	private static EMPPConnectResp responseConnect = null;

	private static EmppApi emppApi = null;

	private static final String mhost = Config.getMhost();
	private static final String mport = Config.getMport();
	private static final String maccountId = Config.getMaccountId();
	private static final String mpassword = Config.getMpassword();
	private static final String mserviceId =Config.getMserviceId();
	private static MobileRecvListener listener;

	static {
		
		emppApi = new EmppApi();
		listener = new MobileRecvListener(emppApi);
		try {
			// 建立同服务器的连接
			String host = mhost;
			int port = Integer.valueOf(mport);
			String accountId = maccountId;
			String password = mpassword;
			// String serviceId = mserviceId;
			EMPPConnectResp response = emppApi.connect(host, port, accountId,
					password, listener);
			System.out.println(response);
			if (response == null) {
				System.out.println("连接超时失败");
				LOG.info("连接超时失败");
			}
			if (!emppApi.isConnected()) {
				System.out.println("连接失败:响应包状态位=" + response.getStatus());
				LOG.info("连接失败:响应包状态位=" + response.getStatus());
			}
			if (response != null && emppApi.isConnected()) {
				responseConnect = response;
			}
		} catch (Exception e) {
			System.out.println("发生异常，导致连接失败");
			LOG.info("发生异常，导致连接失败");
			e.printStackTrace();
		}
	}

	/**
	 * 发送手机短信
	 * 
	 * @param mobile
	 *            手机号码
	 * @param content
	 *            发送内容
	 * @return
	 */
	public static Boolean sendMsg(String mobile, String content) {
		LOG.info("执行发送短信方法："+mobile);
		try {
			emppApi.sendActiveTestAsync();
		} catch (Exception e1) {
			try {
				emppApi.reConnect(listener);
			} catch (Exception e) {
				e.printStackTrace();
			}
			e1.printStackTrace();
		}
		if (emppApi.isSubmitable()) {
			System.out.println("ready to send");
			LOG.info("发送手机号码："+mobile);
			// 详细设置短信的各个属性,不支持长短信
			EMPPSubmitSM msg = (EMPPSubmitSM) EMPPObject
					.createEMPP(EMPPData.EMPP_SUBMIT);
			List<String> dstId = new ArrayList<String>();
			dstId.add(mobile);
			msg.setDstTermId(dstId);
			msg.setSrcTermId(maccountId);
			msg.setServiceId(mserviceId);

			EMPPShortMsg msgContent = new EMPPShortMsg(
					EMPPShortMsg.EMPP_MSG_CONTENT_MAXLEN);
			try {
				msgContent.setMessage(content.getBytes("GBK"));
				msg.setShortMessage(msgContent);
				msg.assignSequenceNumber();
				emppApi.submitMsgAsync(msg);
				LOG.info("发送完毕："+mobile);
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
			// finally{
			// emppApi.stopWorkThread();
			// }
		} else {
			return false;
		}
		return true;
	}
}