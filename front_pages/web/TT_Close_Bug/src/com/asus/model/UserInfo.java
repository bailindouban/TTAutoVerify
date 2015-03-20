package com.asus.model;

public class UserInfo {
	String username = "";
	String password = "";
	String project = "";
	String rd_manager = "";
	String developer = "";
	String operate = "-9";
	String param_bugIds = "all";
	String param_cl_apk = "";
	String param_tag = "";
	String msg = "";
	String prompt = "";
	
	// Getters and Setters
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getProject() {
		return project;
	}
	public void setProject(String project) {
		this.project = project;
	}
	public String getRd_manager() {
		return rd_manager;
	}
	public void setRd_manager(String rd_manager) {
		this.rd_manager = rd_manager;
	}
	public String getDeveloper() {
		return developer;
	}
	public void setDeveloper(String developer) {
		this.developer = developer;
	}
	public String getOperate() {
		return operate;
	}
	public void setOperate(String operate) {
		this.operate = operate;
	}
	public String getParam_bugIds() {
		return param_bugIds;
	}
	public void setParam_bugIds(String param_bugIds) {
		this.param_bugIds = param_bugIds;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getParam_cl_apk() {
		return param_cl_apk;
	}
	public void setParam_cl_apk(String param_cl_apk) {
		this.param_cl_apk = param_cl_apk;
	}
	public String getParam_tag() {
		return param_tag;
	}
	public void setParam_tag(String param_tag) {
		this.param_tag = param_tag;
	}
	public String getPrompt() {
		return prompt;
	}
	public void setPrompt(String prompt) {
		this.prompt = prompt;
	}
	
}
