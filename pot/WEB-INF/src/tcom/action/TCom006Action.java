/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.fujitsu.ffw.base.BaseProperty;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.util.Date2;
import kr.fujitsu.ffw.util.FileHandler;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.util.MailSender;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * <p>
 * 건의사항 및 에러메일처리
 * </p>
 * 
 * @created on 1.0, 2010/02/12
 * @created by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class TCom006Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(TCom006Action.class);

	/**
	 * <p>
	 * 건의사항 화면로딩
	 * </p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		try {
			GauceHelper2.initialize(form, request, response);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[list]", e);
		}

		return mapping.findForward("list");
	}

	public ActionForward sendSuggestEmail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MultiInput mi = null;
		MailSender sender = null;
		boolean isSuccess = false;
		try {
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet();
			dSet = helper.getDataSet("DS_I_MAILFORM");
			mi = helper.getMutiInput(dSet);

			if (mi.next()) {
				sender = new MailSender();
				isSuccess = sender.sendMails(mi.getString("USER_NM"),
						mi.getString("USER_MAIL"), mi.getString("TITLE"),
						mi.getString("CONTENTS"));

			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[testMail]", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet, isSuccess ? "요청 처리 되었습니다."
					: "요청이 실패하였습니다[운영기].<br>나중에 시도해주세요.");
		}

		return mapping.findForward("save");
	}
	
	public ActionForward suggest(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet   = null;
		MultiInput mi       = null;
		MailSender sender   = null;
		boolean isSuccess   = false;
		String strUserInfo  = null;
		InputStream	is      = null;
		OutputStream fout   = null;
		String strFilePath  = null;
		String strFileName  = null; 
		int maxFileSize     = 5;
		try {
			strFilePath = BaseProperty.get("pot.upload.dir") + "tmp/";
			helper      = new GauceHelper2(request, response, form);
			dSet        = new GauceDataSet();
			dSet        = helper.getDataSet("DS_SUGGEST");
			mi          = helper.getMutiInput(dSet);
			strFileName = Date2.getDateWithMillisecond() + "_";
			mi.next();
			
			//파일업로드
			if(!"".equals(mi.getString("FILE_NAME"))){

				File filePath =  new File(strFilePath);
	        	if (!filePath.exists()) {
	        		filePath.mkdirs();
	        	}

	        	is = (InputStream)mi.get("FILE_PASS");
	        	strFileName += mi.getString("FILE_NAME");

	        	if(is.available() != 0){
	        		fout = new FileOutputStream(strFilePath + strFileName);

					int read;
					long longSize = 0;
					byte[] buf = new byte[512];

					while ((read = is.read(buf)) != -1) {
						fout.write(buf, 0, read);
						longSize += read;
						if (longSize >= 1024 * 1024 * maxFileSize) {
							throw new Exception(
									"업로드되는 파일의 사이즈는 "+maxFileSize+"메가를 넘길 수 없습니다.");
						}
					}

					fout.close();
	        	}
			}
			
			//메일보내기
			strUserInfo = "[부  서] : " + mi.getString("DEPT_NM") + "\n" 
				        + "[사  번] : " + mi.getString("USER_ID") + "\n"
			            + "[이  름] : " + mi.getString("USER_NM") + "\n"
			            + "[연락처] : " + mi.getString("PHONE_NO") + "\n";  
			sender = new MailSender();
            
			if(!"".equals(mi.getString("FILE_NAME"))){
				isSuccess = sender.sendMails(mi.getString("USER_NM"),
						mi.getString("E_MAIL"), "[건의사항] " + mi.getString("TITLE"),
						strUserInfo + "[내  용] :\n" + mi.getString("CONTENTS"), strFileName, strFilePath, mi.getString("FILE_NAME"));	
			} else {
				isSuccess = sender.sendMails(mi.getString("USER_NM"),
						mi.getString("E_MAIL"), "[건의사항] " + mi.getString("TITLE"),
						strUserInfo + "[내  용] :\n" + mi.getString("CONTENTS"));	
			}
			
			//파일삭제
			FileHandler.deleteFile(strFilePath + strFileName);
		} catch (Exception e) {
			//파일삭제
			FileHandler.deleteFile(strFilePath + strFileName);
			e.printStackTrace();
			logger.error("[testMail]", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet, isSuccess ? "요청 처리 되었습니다."
					: "요청이 실패하였습니다.<br>나중에 시도해주세요.");
		}

		return mapping.findForward("blank");
	}
}
