package com.asus.action;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.asus.cmd.Command;
import com.asus.dao.BaseHibernateDAO;
import com.asus.dao.VerifyTt;
import com.asus.dao.VerifyTtDAO;
import com.asus.model.BugTotal;
import com.asus.model.MessageStore;
import com.asus.model.UserInfo;
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
	private String table_parse = "test_2.parse_tt";
	private String table_verify = "test_2.verify_tt";

	public synchronized String execute() throws Exception {

		String basefile = "/home/junzheng_zhang/Desktop/kim/close_tt_bug";

		/*
		 * Execute Perl Script
		 */
		String filename = basefile + "/tt_close_bug-web.pl";
		String username = userInfo.getUsername();
		String password = userInfo.getPassword();
		String project = userInfo.getProject();
		String rd_manager = userInfo.getRd_manager();
		String developer = userInfo.getDeveloper();
		String operate = userInfo.getOperate();
		String param_bugIds = userInfo.getParam_bugIds();
		String param_cl_apk = userInfo.getParam_cl_apk();
		String param_tag = userInfo.getParam_tag();
		String[] param = { username, password, project, rd_manager, developer,
				operate, param_bugIds, param_cl_apk, param_tag };
		userInfo.setMsg(Command.execPerl(filename, param));

		/*
		 * For All Bug Figure
		 */
		BaseHibernateDAO baseDao = new BaseHibernateDAO();
		Session session = baseDao.getSession();
		Transaction trans = session.beginTransaction();

		truncTable(session, table_parse);

		loadTable(session, basefile + "/path/parse_tt.csv", table_parse,
				" (parse_tt.bug_id, parse_tt.device)");

		String sql_all_bug = "SELECT device, COUNT(*) FROM test_2.parse_tt WHERE device NOT LIKE 'AMAX_4.4%' GROUP BY device ORDER BY COUNT(*) DESC, device";
		SQLQuery query = session.createSQLQuery(sql_all_bug);
		List<Object[]> list = query.list();

		int sizeTotal = list.size();
		bugTotal = new ArrayList<BugTotal>();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < sizeTotal; i++) {
			bugTotal.add(new BugTotal(list.get(i)[0].toString(), Integer
					.valueOf(list.get(i)[1].toString())));
			sb.append("{y : " + list.get(sizeTotal - 1 - i)[1] + ", label : '"
					+ list.get(sizeTotal - 1 - i)[0] + "'}, ");
			bugTotalNum += Integer.valueOf(list.get(i)[1].toString());
		}

		bugJson = sb.toString();

		/*
		 * For Close Bug
		 */
		// Truncate Table
		VerifyTtDAO vdao2 = new VerifyTtDAO();
		List<VerifyTt> verify2 = vdao2.findAll();
		for (VerifyTt vt : verify2) {
			vdao2.delete(vt);
		}

		// Load Table
		loadTable(session, basefile + "/path/verify_tt.csv", table_verify,
				" (bug_id, tag, apk_version, change_link, device, branch)");
		// Select Table
		VerifyTtDAO vdao = new VerifyTtDAO();
		List<VerifyTt> verify = vdao.findAll();
		messageStore = new MessageStore(username, project, verify);

		trans.commit();
		session.close();

		return SUCCESS;
	}

	/**
	 * 
	 * @param session
	 * @param filepath
	 * @param table
	 */
	private void loadTable(Session session, String filepath, String table,
			String field) {

		File file = new File(filepath);
		if (file.exists()) {
			String sql_load = "LOAD DATA LOCAL INFILE '" + filepath
					+ "' INTO TABLE " + table + " FIELDS TERMINATED BY ','"
					+ field;
			session.createSQLQuery(sql_load).executeUpdate();
		}
	}

	private void truncTable(Session session, String table) {
		String sql_trunc = "TRUNCATE TABLE " + table;
		session.createSQLQuery(sql_trunc).executeUpdate();
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

}
