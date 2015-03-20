package com.asus.action;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.asus.cmd.Command;
import com.asus.dao.BaseHibernateDAO;
import com.asus.dao.UserInfoAll;
import com.asus.dao.UserInfoAllDAO;
import com.asus.dao.UserInfoAllId;
import com.asus.model.BugTotal;
import com.asus.model.MessageStore;
import com.asus.model.UserInfo;
import com.asus.util.MyConstant;
import com.opensymphony.xwork2.ActionSupport;

public class MainTabAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private MessageStore messageStore;
	private UserInfo userInfo;
	private List<BugTotal> bugTotal;
	private String bugJson;
	private int bugTotalNum;

	UserInfoAll usercur;

	public synchronized String execute() throws Exception {
		/*
		 * Execute Perl Script
		 */
		String perl_script = MyConstant.BASE_PATH + "/tt_close_bug-hz.pl";
		String username = userInfo.getUsername();
		String password = userInfo.getPassword();
		String project = userInfo.getProject();
		String rd_manager = userInfo.getRd_manager();
		String developer = userInfo.getDeveloper();
		String operate = userInfo.getOperate();
		String[] param = { username, password, project, rd_manager, developer,
				operate };
		String msg = Command.execPerl(perl_script, param);

		/*
		 * Database operate
		 */
		if (msg.contains("Login Successfully")) {
			BaseHibernateDAO baseDao = new BaseHibernateDAO();
			Session session = baseDao.getSession();
			Transaction trans = session.beginTransaction();

			String sql_user = "INSERT INTO test_2.user_info_all VALUES (";
			sql_user += "'" + username + "', '";
			sql_user += password + "', '";
			sql_user += project + "', '";
			sql_user += rd_manager + "', '";
			sql_user += developer + "') ON DUPLICATE KEY UPDATE ";
			sql_user += "password = '" + password + "', ";
			sql_user += "rd_manager = '" + rd_manager + "', ";
			sql_user += "developer = '" + developer + "' ";
			session.createSQLQuery(sql_user).executeUpdate();
			msg += ", Insert your account info [" + username + " - " + project
					+ "] into database!";

			trans.commit();
			session.close();
			userInfo.setMsg(msg);

			// For Bug History
			UserInfoAllDAO uidao = new UserInfoAllDAO();
			usercur = uidao.findById(new UserInfoAllId(username, project));

			if (usercur.getUpdatedBugs().size() == 0
					&& usercur.getClosedBugs().size() == 0) {
				userInfo.setPrompt("No information yet!<br>Tools runs in 24:00 every day. Please check this page next time.");
			} else {
				userInfo.setPrompt("Updated & Verified Bug History");
			}
			return SUCCESS;
		} else {
			msg = "Login Error!";
			userInfo.setMsg(msg);

			return ERROR;
		}
	}

	// Getters and Setters
	public MessageStore getMessageStore() {
		return messageStore;
	}

	public void setMessageStore(MessageStore messageStore) {
		this.messageStore = messageStore;
	}

	public List<BugTotal> getBugTotal() {
		return bugTotal;
	}

	public void setBugTotal(List<BugTotal> bugTotal) {
		this.bugTotal = bugTotal;
	}

	public String getBugJson() {
		return bugJson;
	}

	public void setBugJson(String bugJson) {
		this.bugJson = bugJson;
	}

	public int getBugTotalNum() {
		return bugTotalNum;
	}

	public void setBugTotalNum(int bugTotalNum) {
		this.bugTotalNum = bugTotalNum;
	}

	public UserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	public UserInfoAll getUsercur() {
		return usercur;
	}

	public void setUsercur(UserInfoAll usercur) {
		this.usercur = usercur;
	}

}
