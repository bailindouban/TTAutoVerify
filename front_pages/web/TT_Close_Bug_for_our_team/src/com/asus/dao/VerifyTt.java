package com.asus.dao;

/**
 * VerifyTt entity. @author MyEclipse Persistence Tools
 */
public class VerifyTt extends AbstractVerifyTt implements java.io.Serializable {

	// Constructors

	/** default constructor */
	public VerifyTt() {
	}

	/** minimal constructor */
	public VerifyTt(Integer id) {
		super(id);
	}

	/** full constructor */
	public VerifyTt(Integer id, Integer bugId, String tag, String apkVersion,
			String changeLink, String device, String branch) {
		super(id, bugId, tag, apkVersion, changeLink, device, branch);
	}

}
