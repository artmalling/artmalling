package medi.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import medi.dao.MEdi106DAO;

import org.apache.log4j.Logger;
  
import kr.fujitsu.ffw.base.BaseProperty;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.util.String2;


import com.gauce.GauceDataSet;

import common.util.MailSender;
import common.vo.SessionInfo;

 
/**
 * <p></p>
 * 
 * @created  on 1.0, 2011/03/18
 * @created  by 오형규(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */


public class MEdi106Action extends DispatchAction {
	
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MEdi106Action.class);

	/**
	 * <p>메뉴를 보여준다.</p>
	 * 
	 */	
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		try {

			GauceHelper2.initialize(form, request, response);
			
			HttpSession session = request.getSession();
			//System.out.println(session.getAttribute("sessionInfo").getClass().getCanonicalName());
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
			
           
            if (sessionInfo != null) {
                System.out.println("USER : " + sessionInfo.getUSER_ID());
            } 
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("[list]", e);
		}

		return mapping.findForward("list");
	}
	
	/**
	 * <p>협력사 조회</p>
	 * 
	 */	 
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;		
		MEdi106DAO dao = null;
		
		String strGoTo = form.getParam("goTo");
		
		try{
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_MASTER");
			
			dao = new MEdi106DAO();
			
			list = dao.getMaster(form);
		
			helper.setListToDataset(list, dSet);
		
		}catch(Exception e){
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		}finally{
			helper.close(dSet);
		}
		
		return mapping.findForward(strGoTo);
	}
	 
	
	/**
	 * <p>
	 * 협력사 마스터, 점별 협력사, 협력사 담당자 저장/수정/삭제
	 * </p>
	 * 
	 */
	public ActionForward Email(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MEdi106DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[1];
			dSet[0] = helper.getDataSet("DS_IO_MASTER"); 
			helper.setDataSetHeader(dSet[0], "H_MASTER"); 

			MultiInput mi[] = new MultiInput[1];
			mi[0] = helper.getMutiInput(dSet[0]); 
			MultiInput mailMi = helper.getMutiInput(dSet[0]); 
			
			String strTitle = String2.nvl(form.getParam("strTitle"));			//제목
			String strList = String2.nvl(form.getParam("strList"));				//내용
			 
			dao = new MEdi106DAO();
 
			// 협력사 EDI 메일 발송
			sendMailVenEDI(form, mailMi, strTitle, strList); 
				
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, "처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * 협력사 EDI 담당자에게 메일 발송 합니다.
	 * @param form
	 * @param mi
	 * @throws Exception
	 */
	private void sendMailVenEDI( ActionForm form, MultiInput mi, String strTitle, String strList ) throws Exception{
		//System.out.println("+++== SEND MAIL START ==+++");		
		while(mi.next()){
			if(mi.IS_UPDATE()){				
			//	System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + mi.getString("CHK"));
				if(mi.getString("CHK").equals("T")){ 
					// 신규 입력에  협력사업무구분이 EDI담당자일 경우만 메일 전송
					if(!mi.getString("EMAIL").equals("")){ 
						String toUserEmail = mi.getString("EMAIL")+";";
						String fromEmail   = "partner@dcubecity.com";
						String fromName    = "디큐브시티";
						String title       = String2.nvl(form.getParam("strTitle"));
						String contents    = String2.nvl(form.getParam("strList"));  

						//@sbcho 주석처리
						//MailSender sender = new MailSender();						
						//boolean send =  sender.sendMails(fromName, fromEmail, toUserEmail, title, contents);

						//System.out.println("send T/F : " + send );
					}
					
				}
			}
		}

		//System.out.println("+++== SEND MAIL END ==+++");
	}
}
