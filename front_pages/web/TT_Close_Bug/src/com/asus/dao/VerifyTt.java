package com.asus.dao;

/**
 * VerifyTt entity. @author MyEclipse Persistence Tools
 */
public class VerifyTt extends AbstractVerifyTt implements java.io.Serializable {

	// Constructors

	/** default constructor */
	public VerifyTt() {
	}

	/** full constructor */
	public VerifyTt(Integer bugId, String tag, String apkVersion,
			String changeLink, String device, String branch) {
		super(bugId, tag, apkVersion, changeLink, device, branch);
	}

}
