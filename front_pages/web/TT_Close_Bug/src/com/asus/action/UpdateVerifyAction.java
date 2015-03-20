package com.asus.action;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.asus.cmd.Command;
import com.asus.dao.BaseHibernateDAO;
import com.asus.dao.UserInfoAll;
import com.asus.dao.UserInfoAllDAO;
import com.asus.util.MyConstant;
import com.opensymphony.xwork2.ActionSupport;

public class UpdateVerifyAction extends ActionSupport {
	private String operate = "-10";
	private String my_msg = "";
	private static final String UPDATE = "1";
	private static final String VERIFY = "3";

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private StringBuffer sql_submit = new StringBuffer();

	public synchronized String execute() throws Exception {
		System.out.println("Start.....");
		/*
		 * Database operate
		 */

		String perl_script = MyConstant.BASE_PATH + "/tt_close_bug-hz.pl";

		UserInfoAllDAO uidao = new UserInfoAllDAO();
		List<UserInfoAll> userlist = uidao.findAll();

		BaseHibernateDAO baseDao = new BaseHibernateDAO();
		Session session = baseDao.getSession();
		Transaction trans = session.beginTransaction();
		int i = 0;
		if (operate.equals(UPDATE) || operate.equals(VERIFY)) {
			for (UserInfoAll ui : userlist) {
				String[] param = { ui.getId().getUsername(), ui.getPassword(),
						ui.getId().getProject(), ui.getRdManager(),
						ui.getDeveloper(), operate };
				if(ui.getId().getProject().equals("ASUSAccount")) {
					continue;
				}
			
				my_msg = Command.execPerl(perl_script, param);
				i++;
				System.out.println(i + ". my_msg = " + my_msg);
				if (my_msg.contains("SF_Success")) {
					for (String row : my_msg.split("SF_Success")) {
						if (!row.isEmpty()) {
							sql_submit.setLength(0);
							sql_submit.append("INSERT INTO ");
							if (operate.equals(UPDATE)) {
								sql_submit.append("test_2.updated_bug");
							} else if (operate.equals(VERIFY)) {
								sql_submit.append("test_2.closed_bug");
							}
							sql_submit
									.append(" (username, project, tt_bug, tag, apk_version, change_link, device, branch) VALUES (");
							sql_submit.append("'" + ui.getId().getUsername()
									+ "'");
							sql_submit.append(", '" + ui.getId().getProject()
									+ "'");
							for (String field : row.split(" & ")) {
								sql_submit.append(", '" + field + "'");
							}
							sql_submit.append(")");

							session.createSQLQuery(sql_submit.toString())
									.executeUpdate();
						}
					}
				}
			}
		}
		System.out.println("Finished!");
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

	public String getMy_msg() {
		return my_msg;
	}

	public void setMy_msg(String my_msg) {
		this.my_msg = my_msg;
	}

}
