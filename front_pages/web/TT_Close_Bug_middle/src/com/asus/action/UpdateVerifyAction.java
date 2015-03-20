package com.asus.action;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.asus.cmd.Command;
import com.asus.dao.BaseHibernateDAO;
import com.asus.dao.UserInfoAll;
import com.asus.dao.UserInfoAllDAO;
import com.opensymphony.xwork2.ActionSupport;

public class UpdateVerifyAction extends ActionSupport {
	private String operate = "-9";
	private String msg = "";
	private static final String UPDATE = "1";
	private static final String VERIFY = "-3";

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public String execute() throws Exception {
		/*
		 * Database operate
		 */
		String basefile = "/home/junzheng_zhang/Desktop/kim";
		String perl_script = basefile
				+ "/close_tt_bug/perl_hz/tt_close_bug-hz.pl";

		UserInfoAllDAO uidao = new UserInfoAllDAO();
		List<UserInfoAll> userlist = uidao.findAll();

		BaseHibernateDAO baseDao = new BaseHibernateDAO();
		Session session = baseDao.getSession();
		Transaction trans = session.beginTransaction();

		Pattern pattern = Pattern.compile("[0-9][0-9]+");
		if (operate.equals(UPDATE) || operate.equals(VERIFY)) {
			for (UserInfoAll ui : userlist) {
				String[] param = { ui.getId().getUsername(), ui.getPassword(),
						ui.getId().getProject(), ui.getRdManager(),
						ui.getDeveloper(), operate };
				msg = Command.execPerl(perl_script, param);
				Matcher m = pattern.matcher(msg);

				if (msg.contains("Submit Form")) {
					while (m.find()) {
						String sql_submit = "INSERT INTO ";
						if (operate.equals(UPDATE)) {
							sql_submit += "test_2.updated_bug (username, project, updated_bug) VALUES (";
						} else if (operate.equals(VERIFY)) {
							sql_submit += "test_2.closed_bug (username, project, closed_bug) VALUES (";
						}
						sql_submit += "'" + ui.getId().getUsername() + "', '";
						sql_submit += ui.getId().getProject() + "', '";
						sql_submit += m.group() + "')";

						session.createSQLQuery(sql_submit).executeUpdate();
					}
				}
			}
		}

		trans.commit();
		session.close();
		return SUCCESS;
	}

	public String getOperate() {
		return operate;
	}

	public void setOperate(String operate) {
		this.operate = operate;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

}
