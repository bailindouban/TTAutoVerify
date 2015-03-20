package com.asus.dao;

/**
 * ParseTt entity. @author MyEclipse Persistence Tools
 */
public class ParseTt extends AbstractParseTt implements java.io.Serializable {

	// Constructors

	/** default constructor */
	public ParseTt() {
	}

	/** minimal constructor */
	public ParseTt(Integer id) {
		super(id);
	}

	/** full constructor */
	public ParseTt(Integer id, Integer bugId, String device) {
		super(id, bugId, device);
	}

}
