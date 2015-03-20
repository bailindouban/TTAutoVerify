package com.asus.cmd;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.hibernate.Session;

public class Command {
	
	public static String execPerl(String filename, String[] param) {
		StringBuffer cmd = new StringBuffer();
		cmd.append("perl " + filename);
		for(String p : param) {
			if(!p.equals("")) {
				cmd.append(" '");
				cmd.append(p);
				cmd.append("'");
			}
		}
		
		StringBuffer msg = new StringBuffer();		
		
		System.out.println(cmd.toString());

		try {
			Process pro = Runtime.getRuntime().exec(new String[] {"/bin/sh", "-c", cmd.toString()});
			InputStream is = pro.getInputStream();
			BufferedReader br = new BufferedReader(new InputStreamReader(is));
			String brs = "";
			while((brs = br.readLine()) != null) {
				msg.append(brs);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		return msg.toString();
	}
	
}
