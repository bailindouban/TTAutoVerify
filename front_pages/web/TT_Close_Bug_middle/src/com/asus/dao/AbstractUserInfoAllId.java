package com.asus.dao;

/**
 * AbstractUserInfoAllId entity provides the base persistence definition of the
 * UserInfoAllId entity. @author MyEclipse Persistence Tools
 */

public abstract class AbstractUserInfoAllId implements java.io.Serializable {

	// Fields

	private String username;
	private String project;

	// Constructors

	/** default constructor */
	public AbstractUserInfoAllId() {
	}

	/** full constructor */
	public AbstractUserInfoAllId(String username, String project) {
		this.username = username;
		this.project = project;
	}

	// Property accessors

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getProject() {
		return this.project;
	}

	public void setProject(String project) {
		this.project = project;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof AbstractUserInfoAllId))
			return false;
		AbstractUserInfoAllId castOther = (AbstractUserInfoAllId) other;

		return ((this.getUsername() == castOther.getUsername()) || (this
				.getUsername() != null && castOther.getUsername() != null && this
				.getUsername().equals(castOther.getUsername())))
				&& ((this.getProject() == castOther.getProject()) || (this
						.getProject() != null && castOther.getProject() != null && this
						.getProject().equals(castOther.getProject())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getUsername() == null ? 0 : this.getUsername().hashCode());
		result = 37 * result
				+ (getProject() == null ? 0 : this.getProject().hashCode());
		return result;
	}

}