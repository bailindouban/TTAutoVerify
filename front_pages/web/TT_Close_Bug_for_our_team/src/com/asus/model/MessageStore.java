package com.asus.model;

import java.util.List;

import com.asus.dao.VerifyTt;

public class MessageStore {
	private String username;
	private String project;
	private List<VerifyTt> bugInfo;
	
	// Constructor 1
	public MessageStore() {
		
	}
	
	// Constructor 2
	public MessageStore(String username, String project, List<VerifyTt> bugInfo) {
		this.username = username;
		this.project = project;
		this.bugInfo = bugInfo;
	}
	
	// Getters and Setters
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getProject() {
		return project;
	}
	
	public void setProject(String project) {
		this.project = project;
	}

	public List<VerifyTt> getBugInfo() {
		return bugInfo;
	}

	public void setBugInfo(List<VerifyTt> bugInfo) {
		this.bugInfo = bugInfo;
	}
	
}
