package com.asus.dao;

/**
 * AbstractParseTt entity provides the base persistence definition of the
 * ParseTt entity. @author MyEclipse Persistence Tools
 */

public abstract class AbstractParseTt implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer bugId;
	private String device;

	// Constructors

	/** default constructor */
	public AbstractParseTt() {
	}

	/** minimal constructor */
	public AbstractParseTt(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public AbstractParseTt(Integer id, Integer bugId, String device) {
		this.id = id;
		this.bugId = bugId;
		this.device = device;
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

	public String getDevice() {
		return this.device;
	}

	public void setDevice(String device) {
		this.device = device;
	}

}