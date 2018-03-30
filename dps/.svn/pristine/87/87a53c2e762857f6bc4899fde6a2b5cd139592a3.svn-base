/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.base.BaseProperty;
import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

import org.apache.log4j.Logger;

import pcod.dao.PCod121DAO;
import pcod.dao.PCod201DAO;

import com.gauce.GauceDataSet;

import common.util.MailSender;
import common.vo.SessionInfo;


/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on  1.1, 2010/02/14
 * @modified by  박종은(FUJITSU KOREA LTD.)
 * @caused   by 
 */

public class PCod121Action extends DispatchAction {
	
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(PCod803Action.class);

	/**
	 * <p>페이지를 로드한다.</p>
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


	/** 
	 * <p>
	 * 협력사 마스터를 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCod121DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PCod121DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_MASTER");
			helper.setDataSetHeader(dSet, "H_SEL_MASTER");
			list = dao.searchMaster(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}

	/**
	 * <p>
	 * 점별 협력사를 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchDetail(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCod121DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PCod121DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_DETAIL");
			helper.setDataSetHeader(dSet, "H_SEL_DETAIL");
			list = dao.searchDetail(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);

	}

	/**
	 * <p>
	 * 협력사 담당자를 조회 한다.
	 * </p>
	 * 
	 */
	public ActionForward searchDetail2(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCod121DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PCod121DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_DETAIL2");
			helper.setDataSetHeader(dSet, "H_SEL_DETAIL2");
			list = dao.searchDetail2(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
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
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		PCod121DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

			userId = sessionInfo.getUSER_ID();

			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[3];
			dSet[0] = helper.getDataSet("DS_IO_MASTER");
			dSet[1] = helper.getDataSet("DS_O_DETAIL");
			dSet[2] = helper.getDataSet("DS_IO_DETAIL2");
			helper.setDataSetHeader(dSet[0], "H_SEL_MASTER");
			helper.setDataSetHeader(dSet[1], "H_SEL_DETAIL");
			helper.setDataSetHeader(dSet[2], "H_SEL_DETAIL2");
			
			MultiInput mi[] = new MultiInput[3];
			mi[0] = helper.getMutiInput(dSet[0]);
			mi[1] = helper.getMutiInput(dSet[1]);
			mi[2] = helper.getMutiInput(dSet[2]);
			MultiInput mailMi = helper.getMutiInput(dSet[2]);
			
			dao = new PCod121DAO();
			// 협력사 EDI 담당자 수 및 EDI 사용여부 조회
			Map map = dao.getRegVenEDICharCnt(form);

			int venEdiCharCnt = 1;
			String venEdiYn   = "N";
			if(map != null){
				venEdiCharCnt = Integer.valueOf((String)map.get("CNT"));
				 venEdiYn   = (String)map.get("EDI_YN");
			}
			
			// 저장
			ret = dao.save(form, mi, userId);
			
			// 협력사 EDI 담당자가 1명 이상 이거나 점별협력사의 EDI 사용여부에 'Y'가 1개 라도 없을 시  메일 발송 하지 않음 
			if( venEdiCharCnt == 0 && venEdiYn.equals("Y")){
				// 협력사 EDI 메일 발송
				sendMailVenEDI(form, mailMi);
			}
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet, ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * 협력사 EDI 담당자에게 메일 발송 합니다.
	 * @param form
	 * @param mi
	 * @throws Exception
	 */
	private void sendMailVenEDI( ActionForm form, MultiInput mi ) throws Exception{
		//System.out.println("+++== SEND MAIL START ==+++");		
		while(mi.next()){
			if(mi.IS_INSERT()){				
				if(mi.getString("VEN_TASK_FLAG").equals("1")){
					// 신규 입력에  협력사업무구분이 EDI담당자일 경우만 메일 전송
					if(!mi.getString("EMAIL").equals("")){
						String venCd       = mi.getString("VEN_CD");
						String venName     = mi.getString("VEN_NAME");
						String toUserNm    = mi.getString("CHAR_NAME");
						String toUserEmail = mi.getString("EMAIL");
						String fromEmail   = "";
						String fromName    = "아트몰링";
						String title       = "아트몰링 협력사 EDI 접속안내";
						String contents    = getVenEDISendMailStr(toUserNm, venCd, venName, fromEmail );

						MailSender sender = new MailSender();						
						boolean send =  sender.sendMails(fromName, fromEmail, toUserEmail, title, contents);

						//System.out.println("send T/F : " + send );
					}
					
				}
			}
		}

		//System.out.println("+++== SEND MAIL END ==+++");
	}
	/**
	 * 메일 내용을 작성 한다.
	 * 
	 * @param venRepName
	 * @param venCd
	 * @param fromMailAddr
	 * @return
	 */
	private String getVenEDISendMailStr( String venCharName, String venCd, String venName, String fromMailAddr ){
		
		StringBuffer sb = new StringBuffer();
		// 이미지 위치 URL 지정
		String imgUrl = BaseProperty.get("dps.upload.http")+"mail/ven/";
		
		sb.append("		<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">");
		sb.append("		<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"ko\" xml:lang=\"ko\">");
		sb.append("		<head>");
		sb.append("			<title></title>");
		sb.append("		    <style type=\"text/css\">");
		sb.append("			body, * {font-size:12px;color:#7b7b7b;font-family:Dotum, sans-serif;margin:0;padding:0;}");
		sb.append("			table {border-collapse : collapse;border-spacing : 0;}");
		sb.append("			th, td {font-size:100%;color:#696969;line-height:18px;}");
		sb.append("			img {border:none;}");
		sb.append("		    </style>");
		sb.append("		</head>");
		sb.append("		<body>");
		sb.append("		<table width=\"700\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
		sb.append("		  <tr>");
		sb.append("		    <td height=\"69\" background=\""+imgUrl+"bg_mailform_top.gif\">");
		sb.append("		        <table width=\"700\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
		sb.append("		          <tr>");
		sb.append("		            <td height=\"69\" valign=\"top\"><img src=\""+imgUrl+"logo_mail_form.gif\" width=\"193\" height=\"65\" /></td>");
		sb.append("		            <td width=\"197\" height=\"69\" valign=\"top\"></td>");
		sb.append("		            <td height=\"38\" valign=\"top\">");
		sb.append("		             <table width=\"309\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
		sb.append("		             <tr>");
		sb.append("		            	<td colspan=\"6\" height=\"38\"></td>");
		sb.append("		           	 </tr>");
		sb.append("		              <tr>");
		sb.append("		                <td width=\"57\"></td>");
		sb.append("		                <td width=\"64\"><a href=\"http://www.cetralsquare.com\" target=\"blank\"><img src=\""+imgUrl+"txt_mailform_msg_02.gif\" width=\"61\" height=\"11\" /></a></td>");
		sb.append("		                <td width=\"61\"><a href=\"http://www.cetralsquare.com\"><img src=\""+imgUrl+"txt_mailform_msg_03.gif\" width=\"58\" height=\"11\" /></a></td>");
		sb.append("		                <td width=\"60\"><a href=\"http://www.art.co.kr\"><img src=\""+imgUrl+"txt_mailform_msg_04.gif\" width=\"57\" height=\"11\" /></a></td>");
		sb.append("		                <td width=\"37\"><a href=\"http://www.cetralsquare.com/buying\"><img src=\""+imgUrl+"txt_mailform_msg_05.gif\" width=\"37\" height=\"11\" /></a></td>");
		sb.append("		                <td width=\"30\"></td>");
		sb.append("		              </tr>");
		sb.append("		            </table></td>");
		sb.append("		          </tr>");
		sb.append("		      </table>    </td>");
		sb.append("		  </tr>");
		sb.append("		  <tr>");
		sb.append("		    <td><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
		sb.append("		      <tr>");
		sb.append("		        <td width=\"30\" background=\""+imgUrl+"bg_mailform_body_left.gif\"></td>");
		sb.append("		        <td><table width=\"640\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
		sb.append("		          <tr>");
		sb.append("		            <td height=\"28\"></td>");
		sb.append("		          </tr>");
		sb.append("				  <tr>");
		sb.append("					<td><img src=\""+imgUrl+"tit_mailpwinfo.gif\" /></td>");
		sb.append("				  </tr>");
		sb.append("		          <tr>");
		sb.append("		            <td height=\"10\"></td>");
		sb.append("		          </tr>");
		sb.append("		          <tr>");
		sb.append("		            <td>");
		sb.append("		            ");
		sb.append("						<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"border:1px solid #dedede; background: #f8f8f8;\">");
		sb.append("		                <tr>");
		sb.append("		                  <td width=\"30\" rowspan=\"2\">&nbsp;</td>");
		sb.append("		                  <td>");
		sb.append("						  <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"margin: 0 0 5px 0;\">");
		sb.append("		                      <tr>");
		sb.append("		                        <td height=\"30\">&nbsp;</td>");
		sb.append("		                      </tr>");
		sb.append("		                      <tr>");
		sb.append("		                        <td height=\"36\" style=\"color: #7b7b7b;\"><strong style=\"color:#7b7b7b; font-size:14px;\">안녕하세요. 협력사&nbsp;<span style=\"color:#3b6eb6; font-weight:bold; font-size:14px;\">"+venCharName+"</span>님.</strong><br />");
		sb.append("		                          협력사 ID와 EDI 업무 시스템 접속정보를 알려드립니다.</td>");
		sb.append("		                      </tr>");
		sb.append("		                  </table>");
		sb.append("						  </td>");
		sb.append("		                  <td width=\"30\" rowspan=\"2\">&nbsp;</td>");
		sb.append("		                </tr>");
		sb.append("		                <tr>");
		sb.append("		                  <td style=\"padding: 0 0 20px 0;\">");
		sb.append("							  <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"border:1px solid #dedede; background: #fff;\">");
		sb.append("								  <tr>");
		sb.append("									<td height=\"10\"></td>");
		sb.append("								  </tr>");
		sb.append("								  <tr>");
		sb.append("									<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong style=\"color: #363636;\">협력사 ID 정보</strong></td>");
		sb.append("								  </tr>");
		sb.append("								  <tr>");
		sb.append("									<td style=\"padding: 0 0 3px 0;\">");
		sb.append("										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src=\""+imgUrl+"bull_square.gif\" style=\"vertical-align: middle;\" /> 협력사 ID : <strong style=\"color: #7b7b7b;\">").append(venCd).append("(").append(venName).append(")</strong>");
		sb.append("									</td>");
		sb.append("								  </tr>");
		sb.append("								  <tr>");
		sb.append("									<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong style=\"color: #363636;\">협력사 접속 정보</strong></td>");
		sb.append("								  </tr>");
		sb.append("								  <tr>");
		sb.append("									<td style=\"padding: 0 0 3px 0;\">");
		sb.append("										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src=\""+imgUrl+"bull_square.gif\" style=\"vertical-align: middle;\" /> 협력사EDI URL : <strong style=\"color: #7b7b7b;\"><a href=\"http://edi.cetralsquare.com\" target=\"blank\">http://edi.cetralsquar.com</a></strong>");
		sb.append("									</td>");
		sb.append("								  </tr>");
		sb.append("								  <tr>");
		sb.append("									<td height=\"10\"></td>");
		sb.append("								  </tr>");
		sb.append("								  </tr>");
		sb.append("								  <tr>");
		sb.append("									<td style=\"padding: 0 0 3px 0;\">");
		sb.append("										&nbsp;&nbsp;&nbsp;&nbsp;<strong style=\"color: #7b7b7b;\">※ 최초 로그인시 패스워드는 ID와 동일하며 비밀번호 변경을 하셔야 합니다. </strong>");
		sb.append("									</td>");
		sb.append("								  </tr>");
		sb.append("							  </table>");
		sb.append("							  <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
		sb.append("								  <tr>");
		sb.append("									<td height=\"10\"></td>");
		sb.append("								  </tr>");
		sb.append("								  <tr>");
		sb.append("									<td height=\"10\"></td>");
		sb.append("								  </tr>");
		sb.append("							  </table>");
		sb.append("						  </td>");
		sb.append("		                </tr>");
		sb.append("		            </table>");
		sb.append("				</td>");
		sb.append("		          </tr>");
		sb.append("		          <tr>");
		sb.append("		            <td><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
		sb.append("		                <tr>");
		sb.append("		                  <td height=\"10\" colspan=\"5\"></td>");
		sb.append("		                </tr>");
		sb.append("		                <tr>");
		sb.append("		                  <td height=\"20\" colspan=\"5\"></td>");
		sb.append("		                </tr>");
		sb.append("		                <tr>");
		sb.append("		                  <td height=\"10\" colspan=\"5\" style=\"color: #888;\">");
		sb.append("											문의사항은 "+fromMailAddr+"으로 문의 하십시오.");
		sb.append("							</td>");
		sb.append("		                </tr>");
		sb.append("		                <tr>");
		sb.append("		                  <td height=\"35\" colspan=\"5\"></td>");
		sb.append("		                </tr>");
		sb.append("		            </table></td>");
		sb.append("		          </tr>");
		sb.append("		        </table></td>");
		sb.append("		        <td width=\"30\" background=\""+imgUrl+"bg_mailform_body_right.gif\"></td>");
		sb.append("		      </tr>");
		sb.append("		      <tr>");
		sb.append("		        <td height=\"64\" colspan=\"3\" align=\"center\" background=\""+imgUrl+"bg_mailform_bottom.gif\"><img src=\""+imgUrl+"txt_address.gif\" width=\"638\" height=\"11\" /></td>");
		sb.append("		        </tr>");
		sb.append("		    </table></td>");
		sb.append("		  </tr>");
		sb.append("		  <tr>");
		sb.append("		    <td></td>");
		sb.append("		  </tr>");
		sb.append("		</table>");
		sb.append("		</body>");
		sb.append("		</html>");
		
		return sb.toString();
	}
	
	/* CENTRAL SUARE START */
	/**
	 * <p>
	 * 사업자 정보를 조회 한다.(MARIO OUTLET)
	 * </p>
	 * 
	 */
	public ActionForward searchCompinfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		PCod121DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new PCod121DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_COMP_INFO");
			helper.setDataSetHeader(dSet, "H_SEL_COMPINFO");
			list = dao.searchCompinfo(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);

	}
	/* CENTRAL SUARE END */
	

	/**
	 * <p> 전송처리 </p> 
	 * 
	 */
	public ActionForward sendvenemg(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

        int rst = 0;
        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        PCod121DAO dao = null;
        HttpSession session = request.getSession();
        String userId = null;        

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {
        	SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();
          
            dao = new PCod121DAO();
            helper = new GauceHelper2(request, response, form);
           
            rst = dao.sendvenemg(form, userId);
            
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close("처리되었습니다.");
        }
        return mapping.findForward(strGoTo);
	}    	
	
}
