package com.service.provider.entity;

public class ReturnS implements java.io.Serializable {
	
	private static final long serialVersionUID = 1L;

	private Boolean success=false;
	
	private String returnCode="200";
	
	private Object result;
	
	private String exception;
	
	private String msg="执行成功";
	
	public String getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
	}

	public Boolean isSuccess() {
		return success;
	}
	
	public Boolean getSuccess() {
		return success;
	}

	public void setSuccess(Boolean success) {
		this.success = success;
	}

	public Object getResult() {
		return result;
	}

	public void setResult(Object result) {
		this.result = result;
	}

	public String getException() {
		return exception;
	}

	public void setException(String exception) {
		this.exception = exception;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

}
