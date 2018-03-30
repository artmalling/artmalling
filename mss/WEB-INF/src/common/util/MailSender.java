/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package common.util;

/**
 * @created  on 1.0, 06/07/27
 * @created  by 최경진(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MailSender {
//	/*
//	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
//	 */
//	private static Logger logger = Logger
//			.getLogger("common.util.MailSender");
//
//	
////	 유니코드를 한글로 변환
//	public String uni2ksc (String Unicodestr) throws UnsupportedEncodingException {
//	return new String (Unicodestr.getBytes("8859_1"),"KSC5601");
//	}
//
//    //한글코드를 유니코드로 변환
//	public String ksc2uni(String str) throws UnsupportedEncodingException {
//	    return new String( str.getBytes("KSC5601"), "8859_1");
//	}
//
//
//	public boolean sendMails( String nameFrom, String emailFrom, String msgText, 
//			String subject, String filenames, String filepath ) throws Exception {
//		
//		boolean sended = true;//전송결과
//		boolean debug = false;//차후 이 변수로 디버깅 처리를 할 수 있도록 구현가능
//
//		Properties lotteProps = Util.getLotteProperties();
//		
//	    String emailsTo = lotteProps.getProperty("error.email.receiver");  
//	    String host = lotteProps.getProperty("mail.smtp.host");
//	    Properties prop = new Properties();
//		prop.put("mail.smtp.host", host);
//		
//		Session msgSession = Session.getDefaultInstance(prop, null);
//		msgSession.setDebug(debug);
//
//		StringTokenizer str = new StringTokenizer( emailsTo, ";" );
//		
//		String strFullPath = filepath + filenames;
//		
//		// 파일 첨부 .
//		filenames = ksc2uni( filenames);
//		
//		while( str.hasMoreTokens() ) {
//			String emailTo = str.nextToken().trim();
//			try {
//				
//				
//				MultiPartEmail email = new MultiPartEmail();
//				email.setCharset("KSC5601");
//				email.setHostName(host);				// "mail.somehost.com"??? (SMTP 서버 지정 )
//				email.addTo(emailTo);					// "madvirus@empal.com", "최범균" 	//수신자 
//				email.setFrom(emailFrom, nameFrom); 	//"madvirus@madvirus.net", "범균" 	// 보내는 사람 
//				email.setSubject(subject); 				//"첨부 파일 테스트 메일입니다."  		// 제목
//				email.setMsg(msgText);					// "이건 내용입니다."
//				
//				if(filenames.length() > 0)
//				{
//					EmailAttachment attachment = new EmailAttachment();
//					attachment.setPath(strFullPath); //전체 경로 
//					attachment.setDisposition(EmailAttachment.ATTACHMENT);
//					attachment.setDescription("commons-email api");
//					attachment.setName(filenames); // 파일의 이름을 지정
//				
//					email.attach(attachment);
//				}
//				
//				email.send();
//
//
//			}catch( Exception e ) {
//				e.printStackTrace();
//				logger.info("[sendMails2]", e);
//				sended = false;
//			}
//		}//while end
//		File file = new File(strFullPath);
//		if(file != null )
//		{
//			file.delete();
//		}
//		
//		return sended;
//	}
//
//	/**
//	 * 
//	 * @param nameFrom    	송신자
//	 * @param emailFrom   
//	 * @param subject		제목
//	 * @param msgText		내용
//	 * @param filepath		파일경로
//	 * @param filenames		파일명
//	 * @return
//	 * @throws Exception 
//	 */
//	public boolean _sendMails( String nameFrom, String emailFrom, String subject, 
//			String msgText, String filepath, String filenames ) throws Exception {
//		
//		boolean sended = true;//전송결과
//		boolean debug = false;//차후 이 변수로 디버깅 처리를 할 수 있도록 구현가능
//
//		Properties lotteProps = Util.getLotteProperties();
//		
//	    String emailsTo = lotteProps.getProperty("error.email.receiver");  
//	    String host = lotteProps.getProperty("mail.smtp.host");
//	    Properties prop = new Properties();
//		prop.put("mail.smtp.host", host);
//		
//		Session msgSession = Session.getDefaultInstance(prop, null);
//		msgSession.setDebug(debug);
//
//		StringTokenizer str = new StringTokenizer( emailsTo, ";" );
//		
//		String strTemppath = filenames + filepath;
//		while( str.hasMoreTokens() ) {
//			String emailTo = str.nextToken().trim();
//			try {
//				MimeMessage mm = new MimeMessage( msgSession );
//
//				InternetAddress[] iaddr = { new InternetAddress(emailTo) };
//				// 수신자/////////////////////////////////////////////////////////
//				mm.setRecipients( Message.RecipientType.TO, iaddr ) ;
//				// 송신자/////////////////////////////////////////////////////////
//				mm.setFrom( new InternetAddress( "\""+String2.toEng(nameFrom)+"\" <"+emailFrom+">" ) );
//				// 제목///////////////////////////////////////////////////////////
//				mm.setSubject( subject );
//				// 내용///////////////////////////////////////////////////////////
//				MimeMultipart mp = new MimeMultipart();
//				//**메시지**
//				MimeBodyPart mbp = new MimeBodyPart();
//				mbp.setContent( msgText, "text/html;charset=euc-kr" );
//				mp.addBodyPart( mbp );
//				mm.setContent(mp);
//				//mbp = null;
//				//**파일첨부**
//			
//				System.out.println("파일 nameFrom  : " + nameFrom);
//				System.out.println("파일 emailTo  : " + emailTo);
//				System.out.println("파일 emailFrom  : " + emailFrom);
//				System.out.println("파일 subject  : " + subject);
//				System.out.println("파일 msgText  : " + msgText);
//				System.out.println("파일 filepath  : " + filepath);
//				System.out.println("파일 filenames  : " + filenames  );
//				
//				if( strTemppath != null ) {
//					//strTemppath = "c:\\바탕아이콘.bmp";
//                    //한글파일일 경우를 대비해서 디코드를 해줍니다.
//					strTemppath = java.net.URLDecoder.decode( strTemppath, "KSC5601"); 
//					filepath = java.net.URLDecoder.decode( filepath, "KSC5601");
//			        BodyPart fileBodyPart = new MimeBodyPart(); 
//			        
//			        //	 파일 첨부 설정
//			        DataSource source = new FileDataSource( strTemppath); 
//			        fileBodyPart.setDataHandler(new DataHandler(source)); 
//			        fileBodyPart.setFileName(filepath); 
//			        mp.addBodyPart(fileBodyPart); 
//					
//				}
//			
//				mm.setContent(mp);
//				// 전송날짜////////////////////////////////////////////////////////
//				mm.setSentDate( new Date() );
//				// 메일전송////////////////////////////////////////////////////////
//				Transport.send( mm );
//				System.out.println(emailTo + "님께 메일을 전송 하였습니다."); 
//
//			}catch( MessagingException e ) {
//				e.printStackTrace();
//				logger.error("[sendMails2]", e);
//				sended = false;
//			}
//		}//while end
//		
//		
//		
//		return sended;
//	}
//
//	//파일첨부없이
//	public boolean sendMails( String nameFrom, String emailFrom, String subject, String msgText ) throws Exception{
//		
//		boolean sended = true;//전송결과
//		boolean debug = false;//차후 이 변수로 디버깅 처리를 할 수 있도록 구현가능
//		
//		Properties lotteProps = Util.getLotteProperties();
//		
//	    String emailsTo = lotteProps.getProperty("error.email.receiver");  
//	    String host = lotteProps.getProperty("mail.smtp.host");
//
//		Properties prop = new Properties();
//		prop.put("mail.smtp.host", host);
//		
//		Session msgSession = Session.getDefaultInstance(prop, null);
//		msgSession.setDebug(debug); 
//
//		StringTokenizer str = new StringTokenizer( emailsTo, ";" );
//		while( str.hasMoreTokens() ) {
//			String emailTo = str.nextToken().trim();
//			try {
//				MimeMessage mm = new MimeMessage( msgSession );
//
//				InternetAddress[] iaddr = { new InternetAddress(emailTo) };
//				// 수신자/////////////////////////////////////////////////////////
//				mm.setRecipients( Message.RecipientType.TO, iaddr ) ;
//				// 송신자/////////////////////////////////////////////////////////
//				mm.setFrom( new InternetAddress( "\""+String2.toEng(nameFrom)+"\" <"+emailFrom+">" ) );
//				// 제목///////////////////////////////////////////////////////////
//				mm.setSubject( subject );
//				// 내용///////////////////////////////////////////////////////////
//				Multipart mp = new MimeMultipart();
//				//**메시지**
//				MimeBodyPart mbp = new MimeBodyPart();
//				mbp.setContent( msgText, "text/html;charset=euc-kr" );
//				mp.addBodyPart( mbp );
//				mm.setContent(mp);
//				// 전송날짜////////////////////////////////////////////////////////
//				mm.setSentDate( new Date() );
//				// 메일전송////////////////////////////////////////////////////////
//				Transport.send( mm );
//				
//			}catch( MessagingException e ) {
//				e.printStackTrace();
//				logger.error("[sendMails3]", e);
//				sended = false;
//			}
//		}//while end
//
//		return sended;
//	}
//	
//
//	
//	//파일첨부없이
///*	public boolean sendMails(String subject, String msgText ) {
//		
//		boolean sended = true;//전송결과
//		boolean debug = false;//차후 이 변수로 디버깅 처리를 할 수 있도록 구현가능
//
//		Properties prop = new Properties();
//		prop.put("mail.smtp.host", "203.227.209.1" );
//		
//		Session msgSession = Session.getDefaultInstance(prop, null);
//		msgSession.setDebug(debug);
//
//			try {
//				MimeMessage mm = new MimeMessage( msgSession );
//
//				//InternetAddress[] iaddr = { new InternetAddress(emailTo) };
//				// 송신자/////////////////////////////////////////////////////////
//				
//				InternetAddress fromAddr = new InternetAddress("");
//				mm.setFrom( fromAddr);
//				
//				// 수신자/////////////////////////////////////////////////////////
//				InternetAddress[] toAddr = new InternetAddress[3];

//				
//				mm.setRecipients( Message.RecipientType.TO, toAddr ) ;
//				// 제목///////////////////////////////////////////////////////////
//				mm.setSubject( subject );
//				// 내용///////////////////////////////////////////////////////////
//				Multipart mp = new MimeMultipart();
//				//**메시지**
//				MimeBodyPart mbp = new MimeBodyPart();
//				mbp.setContent( msgText, "text/html;charset=euc-kr" );
//				mp.addBodyPart( mbp );
//				mm.setContent(mp);
//				// 전송날짜////////////////////////////////////////////////////////
//				mm.setSentDate( new Date() );
//				// 메일전송////////////////////////////////////////////////////////
//				Transport.send( mm );
//
//			}catch( MessagingException e ) {
//				e.printStackTrace();
//				logger.error("[sendMails3]", e);
//				sended = false;
//			}
//
//		return sended;
//	}*/
}
