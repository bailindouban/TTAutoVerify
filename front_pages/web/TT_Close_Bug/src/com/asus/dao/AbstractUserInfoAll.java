package com.asus.dao;

import java.util.HashSet;
import java.util.Set;

/**
 * AbstractUserInfoAll entity provides the base persistence definition of the
 * UserInfoAll entity. @author MyEclipse Persistence Tools
 */

public abstract class AbstractUserInfoAll implements java.io.Serializable {

	// Fields

	private UserInfoAllId id;
	private String password;
	private String rdManager;
	private String developer;
	private Set updatedBugs = new HashSet(0);
	private Set closedBugs = new HashSet(0);

	// Constructors

	/** default constructor */
	public AbstractUserInfoAll() {
	}

	/** minimal constructor */
	public AbstractUserInfoAll(UserInfoAllId id) {
		this.id = id;
	}

	/** full constructor */
	public AbstractUserInfoAll(UserInfoAllId id, String password,
			String rdManager, String developer, Set updatedBugs, Set closedBugs) {
		this.id = id;
		this.password = password;
		this.rdManager = rdManager;
		this.developer = developer;
		this.updatedBugs = updatedBugs;
		this.closedBugs = closedBugs;
	}

	// Property accessors

	public UserInfoAllId getId() {
		return this.id;
	}

	public void setId(UserInfoAllId id) {
		this.id = id;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRdManager() {
		return this.rdManager;
	}

	public void setRdManager(String rdManager) {
		this.rdManager = rdManager;
	}

	public String getDeveloper() {
		return this.developer;
	}

	public void setDeveloper(String developer) {
		this.developer = developer;
	}

	public Set getUpdatedBugs() {
		return this.updatedBugs;
	}

	public void setUpdatedBugs(Set updatedBugs) {
		this.updatedBugs = updatedBugs;
	}

	public Set getClosedBugs() {
		return this.closedBugs;
	}

	public void setClosedBugs(Set closedBugs) {
		this.closedBugs = closedBugs;
	}

}