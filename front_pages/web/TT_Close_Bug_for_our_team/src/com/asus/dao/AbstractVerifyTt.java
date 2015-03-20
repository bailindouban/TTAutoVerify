package com.asus.dao;

/**
 * AbstractVerifyTt entity provides the base persistence definition of the
 * VerifyTt entity. @author MyEclipse Persistence Tools
 */

public abstract class AbstractVerifyTt implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer bugId;
	private String tag;
	private String apkVersion;
	private String changeLink;
	private String device;
	private String branch;

	// Constructors

	/** default constructor */
	public AbstractVerifyTt() {
	}

	/** minimal constructor */
	public AbstractVerifyTt(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public AbstractVerifyTt(Integer id, Integer bugId, String tag,
			String apkVersion, String changeLink, String device, String branch) {
		this.id = id;
		this.bugId = bugId;
		this.tag = tag;
		this.apkVersion = apkVersion;
		this.changeLink = changeLink;
		this.device = device;
		this.branch = branch;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getBugId() {
		return this.bugId;
	}

	public void setBugId(Integer bugId) {
		this.bugId = bugId;
	}

	public String getTag() {
		return this.tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getApkVersion() {
		return this.apkVersion;
	}

	public void setApkVersion(String apkVersion) {
		this.apkVersion = apkVersion;
	}

	public String getChangeLink() {
		return this.changeLink;
	}

	public void setChangeLink(String changeLink) {
		this.changeLink = changeLink;
	}

	public String getDevice() {
		return this.device;
	}

	public void setDevice(String device) {
		this.device = device;
	}

	public String getBranch() {
		return this.branch;
	}

	public void setBranch(String branch) {
		this.branch = branch;
	}

}