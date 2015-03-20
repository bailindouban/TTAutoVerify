package com.asus.model;

public class BugInfo {
	private Integer bugId;
	private String tag;
	private String apkVersion;
	private String changeLink;
	private String device;
	private String branch;
	
	// Constructor 1
	public BugInfo() {
		
	}
	
	// Constructor 2
	public BugInfo(Integer bugId, String tag, String apkVersion,
			String changeLink, String device) {
		super();
		this.bugId = bugId;
		this.tag = tag;
		this.apkVersion = apkVersion;
		this.changeLink = changeLink;
		this.device = device;
	}
	
	
	
	// Getters and Setters
	public Integer getBugId() {
		return bugId;
	}

	public void setBugId(Integer bugId) {
		this.bugId = bugId;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getApkVersion() {
		return apkVersion;
	}

	public void setApkVersion(String apkVersion) {
		this.apkVersion = apkVersion;
	}

	public String getChangeLink() {
		return changeLink;
	}

	public void setChangeLink(String changeLink) {
		this.changeLink = changeLink;
	}

	public String getDevice() {
		return device;
	}

	public void setDevice(String device) {
		this.device = device;
	}	
		
}
