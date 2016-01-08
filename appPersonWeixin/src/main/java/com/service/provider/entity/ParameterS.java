package com.service.provider.entity;


public class ParameterS implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private String parameterKey;

    private String parameterValue;

    private String parameterDesc;

	public String getParameterKey() {
		return parameterKey;
	}

	public void setParameterKey(String parameterKey) {
		this.parameterKey = parameterKey;
	}

	public String getParameterValue() {
		return parameterValue;
	}

	public void setParameterValue(String parameterValue) {
		this.parameterValue = parameterValue;
	}

	public String getParameterDesc() {
		return parameterDesc;
	}

	public void setParameterDesc(String parameterDesc) {
		this.parameterDesc = parameterDesc;
	}

}