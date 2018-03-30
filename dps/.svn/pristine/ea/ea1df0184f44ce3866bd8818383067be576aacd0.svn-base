/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.util;

import java.util.Properties;
import java.util.StringTokenizer;

import javax.mail.Session;

import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.MultiPartEmail;
import org.apache.log4j.Logger;

import java.io.*;

/**
 * @created on 1.0, 06/07/27
 * @created by FUJITSU KOREA LTD.
 * 
 * @modified on 1.1, 11/03/10
 * @modified by 정지인(FUJITSU KOREA LTD.)
 * @caused by
 */

public class MailSender {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private static Logger logger = Logger.getLogger("common.util.MailSender");

	// 유니코드를 한글로 변환
	public String uni2ksc(String Unicodestr)
			throws UnsupportedEncodingException {
		return new String(Unicodestr.getBytes("8859_1"), "KSC5601");
	}

	// 한글코드를 유니코드로 변환
	public String ksc2uni(String str) throws UnsupportedEncodingException {
		return new String(str.getBytes("KSC5601"), "8859_1");
	}

	public boolean sendMails(String nameFrom, String emailFrom, String subject,
			String msgText, String filenames, String filepath, String realName) throws Exception {

		boolean sended = true;// 전송결과
		boolean debug = false;// 차후 이 변수로 디버깅 처리를 할 수 있도록 구현가능

		Properties centralProps = Util.getFujitsudeptProperties();

		String emailsTo = centralProps.getProperty("error.email.receiver");
		String host = centralProps.getProperty("mail.smtp.host");
		
		Properties prop = new Properties();
		prop.put("mail.smtp.host", host);

		Session msgSession = Session.getDefaultInstance(prop, null);
		msgSession.setDebug(debug);

		StringTokenizer str = new StringTokenizer(emailsTo, ";");

		String strFullPath = filepath + filenames;

		// 파일 첨부 .
		filenames = ksc2uni(realName);

		while (str.hasMoreTokens()) {
			String emailTo = str.nextToken().trim();
			try {
				MultiPartEmail email = new MultiPartEmail();
				email.setCharset("KSC5601");
				email.setHostName(host);
				email.addTo(emailTo);
				email.setFrom(emailFrom, nameFrom);
				email.setSubject(subject);
				email.setMsg(msgText);

				if (filenames.length() > 0) {
					EmailAttachment attachment = new EmailAttachment();
					attachment.setPath(strFullPath); // 전체 경로
					attachment.setDisposition(EmailAttachment.ATTACHMENT);
					attachment.setDescription("commons-email api");
					attachment.setName(filenames); // 파일의 이름을 지정

					email.attach(attachment);
				}
				email.send();

			} catch (Exception e) {
				logger.info("", e);
				sended = false;
			}
		}// while end
		return sended;
	}

	// 파일첨부없이
	public boolean sendMails(String nameFrom, String emailFrom, String subject,
			String msgText) throws Exception {

		boolean sended = true;// 전송결과
		boolean debug = false;// 차후 이 변수로 디버깅 처리를 할 수 있도록 구현가능

		Properties centralProps = Util.getFujitsudeptProperties();

		String emailsTo = centralProps.getProperty("error.email.receiver");
		String host = centralProps.getProperty("mail.smtp.host");

		Properties prop = new Properties();
		prop.put("mail.smtp.host", host);

		Session msgSession = Session.getDefaultInstance(prop, null);
		msgSession.setDebug(debug);

		StringTokenizer str = new StringTokenizer(emailsTo, ";");
		while (str.hasMoreTokens()) {
			String emailTo = str.nextToken().trim();
			try {
				MultiPartEmail email = new MultiPartEmail();
				email.setCharset("KSC5601");
				email.setHostName(host);
				email.addTo(emailTo);
				email.setFrom(emailFrom, nameFrom);
				email.setSubject(subject);
				email.setMsg(msgText);
				email.send();

			} catch (Exception e) {
				logger.info("", e);
				sended = false;
			}
		}
		return sended;
	}

	/**
	 * 받는 사람 지정 메일 발송 ( 파일 첨부 없음)
	 * 받는 사람 메일 주소는 ";" 로 구분하며 복수로 발송.
	 * @param nameFrom
	 * @param emailFrom
	 * @param emailsTo
	 * @param subject
	 * @param msgText
	 * @return
	 * @throws Exception
	 */
	public boolean sendMails(String nameFrom, String emailFrom, String emailsTo, String subject,
			String msgText) throws Exception {

		boolean sended = true;// 전송결과
		boolean debug = false;// 차후 이 변수로 디버깅 처리를 할 수 있도록 구현가능

		Properties centralProps = Util.getFujitsudeptProperties();

		String host = centralProps.getProperty("mail.smtp.host");

		Properties prop = new Properties();
		prop.put("mail.smtp.host", host);

		Session msgSession = Session.getDefaultInstance(prop, null);
		msgSession.setDebug(debug);

		StringTokenizer str = new StringTokenizer(emailsTo, ";");
		while (str.hasMoreTokens()) {
			String emailTo = str.nextToken().trim();
			try {
				HtmlEmail email = new HtmlEmail();
				email.setCharset("KSC5601");
				email.setHostName(host);
				email.addTo(emailTo);
				email.setFrom(emailFrom, nameFrom);
				email.setSubject(subject);
				email.setMsg(msgText);
				email.send();

			} catch (Exception e) {
				e.printStackTrace();
				logger.info("", e);
				sended = false;
			}
		}
		return sended;
	}

	/**	 * 
	 * 받는 사람 지정 메일 발송 ( 파일 첨부 )
	 * 받는 사람 메일 주소는 ";" 로 구분하며 복수로 발송.
	 * 
	 * @param nameFrom
	 * @param emailFrom
	 * @param emailTo
	 * @param subject
	 * @param msgText
	 * @param filenames
	 * @param filepath
	 * @param realName
	 * @return
	 * @throws Exception
	 */
	public boolean sendMails(String nameFrom, String emailFrom, String emailsTo, String subject,
			String msgText, String filenames, String filepath, String realName) throws Exception {

		boolean sended = true;// 전송결과
		boolean debug = false;// 차후 이 변수로 디버깅 처리를 할 수 있도록 구현가능

		Properties centralProps = Util.getFujitsudeptProperties();

		String host = centralProps.getProperty("mail.smtp.host");
		
		Properties prop = new Properties();
		prop.put("mail.smtp.host", host);

		Session msgSession = Session.getDefaultInstance(prop, null);
		msgSession.setDebug(debug);

		StringTokenizer str = new StringTokenizer(emailsTo, ";");

		String strFullPath = filepath + filenames;

		// 파일 첨부 .
		filenames = ksc2uni(realName);

		while (str.hasMoreTokens()) {
			String emailTo = str.nextToken().trim();
			try {
				MultiPartEmail email = new MultiPartEmail();
				email.setCharset("KSC5601");
				email.setHostName(host);
				email.addTo(emailTo);
				email.setFrom(emailFrom, nameFrom);
				email.setSubject(subject);
				email.setMsg(msgText);

				if (filenames.length() > 0) {
					EmailAttachment attachment = new EmailAttachment();
					attachment.setPath(strFullPath); // 전체 경로
					attachment.setDisposition(EmailAttachment.ATTACHMENT);
					attachment.setDescription("commons-email api");
					attachment.setName(filenames); // 파일의 이름을 지정

					email.attach(attachment);
				}
				email.send();

			} catch (Exception e) {
				logger.info("", e);
				sended = false;
			}
		}// while end
		return sended;
	}
}
