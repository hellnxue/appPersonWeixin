package com.hrofirst.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Created by qixb.fnst on 2014/10/24.
 */
public class Config {
	private static Properties pps = new Properties();
	static {
		try {
			InputStream in = Thread.currentThread().getContextClassLoader()
					.getResourceAsStream("resources.properties");
			// "E:\\git\\appPersonWeixin\\src\\main\\resources\\resources.properties"
			System.out.println(in);
			pps.load(in);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static boolean isCheckGps() {
		return Boolean.parseBoolean(pps.getProperty("checkGps"));
	}

	public static String getIosPushPassword() {
		return pps.getProperty("ios_push_password");
	}

	public static String getIosPushSound() {
		return pps.getProperty("ios_push_sound");
	}

	public static String getUploadDir() {
		return pps.getProperty("uploadDir");
	}

	public static String getOpenOfficeInstall() {
		return pps.getProperty("openOfficeInstall");
	}

	public static int getThreadSize() {
		return Integer.parseInt(pps.getProperty("threadSize"));
	}

	public static String getPdf2htmlEXInstall() {
		return pps.getProperty("pdf2htmlEXInstall");
	}

	public static int getForbidSign() {
		return Integer.parseInt(pps.getProperty("forbidSign"));
	}

	public static long getFileMaxSize() {
		return Long.parseLong(pps.getProperty("file_max"));
	}

	public static String getAk() {
		return pps.getProperty("lbs_ak");
	}

	public static String getBaeApiKey() {
		return pps.getProperty("bae_api_key");
	}

	public static String getBaeSecretKey() {
		return pps.getProperty("bae_secret_key");
	}

	public static String getIosDownloadPath() {
		return pps.getProperty("ios_download_path");
	}

	public static boolean isDebug() {
		return Boolean.parseBoolean(pps.getProperty("debug"));
	}

	public static String getIosPushPath() {
		return pps.getProperty("ios_push_path");
	}

	public static String getUploadRoot() {
		return pps.getProperty("file.upload.root");
	}

	public static Double getAllowRadius() {
		return Double.parseDouble(pps.getProperty("allow_radius"));
	}

	public static int getScheduleAllow() {
		return Integer.parseInt(pps.getProperty("schedule_allow"));
	}

	public static int getScheduleUpdateAllow() {
		return Integer.parseInt(pps.getProperty("schedule_update_allow"));
	}

	public static int getNotLateSignIn() {
		return Integer.parseInt(pps.getProperty("schedule_not_late_sign_in"));
	}

	public static int getNotEarlySignOut() {
		return Integer.parseInt(pps.getProperty("schedule_not_early_sign_out"));
	}

	public static String getApiSuffix() {
		return pps.getProperty("api_suffix");
	}

	public static String getMessageTitle() {
		return pps.getProperty("message_title");
	}

	public static int getBaiduPushType() {
		return Integer.parseInt(pps.getProperty("baidu_push_type"));
	}

	public static int getIosDeployStatus() {
		return Integer.parseInt(pps.getProperty("ios_deploy_status"));
	}

	public static int getIosExpireMinute() {
		return Integer.parseInt(pps.getProperty("expire_ios_minute"));
	}

	public static String getWechatToken() {
		return pps.getProperty("wechat_token");
	}

	public static String getWechatMenuDesc() {
		return pps.getProperty("wechat_menu_des");
	}

	public static String getWechatMenuKey() {
		return pps.getProperty("menu");
	}

	public static String getWechatBackKey() {
		return pps.getProperty("back");
	}

	public static String getWechatErrorMenu() {
		return pps.getProperty("error_menu");
	}

	public static String getWechatErrorInput() {
		return pps.getProperty("error_input");
	}

	public static String getNationGuardUrl() {
		return pps.getProperty("national_url");
	}

	public static String getShenpiloginUrl() {
		return pps.getProperty("shenpilogin_url");
	}

	public static String getShenpilistUrl() {
		return pps.getProperty("shenpilist_url");
	}

	public static String getShenpidetailUrl() {
		return pps.getProperty("shenpidetail_url");
	}

	public static String getShenpiCommitUrl() {
		return pps.getProperty("shenpiCommit_url");
	}

	public static String getShenpiRejectUrl() {
		return pps.getProperty("shenpiReject_url");
	}

	public static String getDatacenterUrl() {
		return pps.getProperty("datacenter_url");
	}

	public static String getSalaryApiUrl() {
		return pps.getProperty("salaryApi_url");
	}

	public static String getCasservice() {
		return pps.getProperty("casservice");
	}
	
	public static String getBaobeikejiUrl() {
		return pps.getProperty("baobeikeji_url");
	}
	
	
	public static String getHroUrl() {
		return pps.getProperty("hroUrl");
	}
	
	public static String getKaoqinUrl() {
		return pps.getProperty("kaoqin_url");
	}

	public static String getCascookiedomain() {
		return pps.getProperty("cascookiedomain");
	}

	public static String getWallet_url() {
		return pps.getProperty("wallet_url");
	}

	public static String getPersonappid() {
		return pps.getProperty("personappid");
	}

	public static String getPersonappsecret() {
		return pps.getProperty("personappsecret");
	}

	public static String getWechatPersonSubscribe() {
		return pps.getProperty("wechat_personsubscribe");
	}

	public static void main(String[] args) {
		System.out.println(Config.getAk());
	}
}
