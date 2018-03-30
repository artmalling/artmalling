package esal.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import ecom.util.Util;
import ecom.vo.SessionInfo2;
import esal.dao.Esal110DAO;

public class Esal110Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(Esal110Action.class);
	
	/**
	 * <p>메뉴를 보여준다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String strGoto = form.getParam("goTo");
		
		try {
			
			HttpSession session = request.getSession();
            SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
          
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
        
		return mapping.findForward(strGoto);
	}
	

	/**
	 * <p>브랜드별 고객 리스트를 조회한다.</p>
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward getList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String strGoto = form.getParam("goTo");
		Esal110DAO dao = null;
		//StringBuffer sb = new StringBuffer();
		String json = null;
		
		try {
			
			dao = new Esal110DAO();
			json = dao.getList(form);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Exception : " + e.toString());
		}
        
		ActionUtil.sendAjaxResponse(response, json);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>고객 상세 정보를 조회한다.</p>
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward getDetailList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String strGoto = form.getParam("goTo");
		Esal110DAO dao = null;
		//StringBuffer sb = new StringBuffer();
		String json = null;
		try {
			
			dao = new Esal110DAO();
			json = dao.getDetailList(form);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Exception : " + e.toString());
		}
        
		ActionUtil.sendAjaxResponse(response, json);
		return mapping.findForward(strGoto);
	}

	/**
	 * 매장별 고객 정보 등록
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward insert(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String strGoto 			= form.getParam("goTo");
		Esal110DAO dao 			= null;
		StringBuffer sb			= new StringBuffer();
		Util      util = new Util();
		 
		int			insertCnt1 	= 0;
		int			insertCnt2 	= 0;
		List 		list 		= null;
		String		reguCustId 	= null;
		String 		json 		= null;
		
		try {
			
			dao = new Esal110DAO();
			
			String mode   = String2.nvl(form.getParam("mode"));		//C-SEL_DM_CUSTOMER, N-SEL_PC_REGULIST
			if(mode.trim().equals("insert")){
				json = dao.chkcardno(form);
			}
			if(json.equals("Y")){
				//insert -> insReguCustDtl, insReguCustMst 등록
				//그외 -> insReguCustDtl에만 등록
				reguCustId = String2.nvl(form.getParam("IN_REGUCUST_ID"));
				
				if(reguCustId.equals("")) {
					//단골고객 등록번호 조회(신규)
					list = dao.getReguCustId(form);
					reguCustId = (String)((ArrayList)list.get(0)).get(0);
					for(int i=reguCustId.length();i<9;i++) {
						reguCustId = "0" + reguCustId;						//000000142
					}
				}
				insertCnt2 = dao.insReguCustMst(form, reguCustId);	//단골고객 정보 등록
				System.out.println("insertCnt2 : " + insertCnt2);
				if(insertCnt2>0) {
					insertCnt1 = dao.insReguCustDtl(form, reguCustId);	//브랜드별 단골고객 정보 등록
				}
				if( insertCnt1 > 0) {	//둘다 성공일때	
					sb.append("<?xml version='1.0' encoding='utf-8'?>");
					sb.append("<t>");
					sb.append("<r id='1'>");
					sb.append("<c1 id='INS1'>").append(insertCnt1).append("</c1>");
					sb.append("<c2 id='INS2'>").append(insertCnt2).append("</c2>");
					sb.append("<c3 id='RET'>").append("저장되었습니다.").append("</c3>");
					sb.append("</r>");
					sb.append("</t>");
				}else {
					sb.append("<?xml version='1.0' encoding='utf-8'?>");
					sb.append("<t>");
					sb.append("<r id='1'>");
					sb.append("<c1 id='INS1'>").append(insertCnt1).append("</c1>");
					sb.append("<c2 id='INS2'>").append(insertCnt2).append("</c2>");
					sb.append("<c3 id='RET'>").append("데이터의 적합성 문제로 인하여 \n데이터 입력을 하지 못했습니다.").append("</c3>");
					sb.append("</r>");
					sb.append("</t>");
				}	
			}else{
				sb.append("<?xml version='1.0' encoding='utf-8'?>");
				sb.append("<t>");
				sb.append("<r id='1'>");
				sb.append("<c1 id='INS1'>").append(insertCnt1).append("</c1>");
				sb.append("<c2 id='INS2'>").append(insertCnt2).append("</c2>");
				sb.append("<c3 id='RET'>").append("이미 등록된 회원입니다.").append("</c3>");
				sb.append("</r>");
				sb.append("</t>");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Exception : " + e.toString());
		}
        
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * 매장별 단골 고객 정보 삭제
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward delete(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String strGoto 			= form.getParam("goTo");
		Esal110DAO dao 			= null;
		StringBuffer sb			= new StringBuffer();
		
		int			deleteCnt 	= 0;
		
		try {
			
			dao = new Esal110DAO();
			deleteCnt = dao.delReguCustDtl(form);	//단골고객 정보 등록
			System.out.println("insertCnt2 : " + deleteCnt);
			
			if( deleteCnt > 0) {	//둘다 성공일때	
				sb.append("<?xml version='1.0' encoding='utf-8'?>");
				sb.append("<t>");
				sb.append("<r id='1'>");
				sb.append("<c1 id='DEL'>").append(deleteCnt).append("</c1>");
				sb.append("<c2 id='RET'>").append("삭제되었습니다.").append("</c2>");
				sb.append("</r>");
				sb.append("</t>");
			}else {
				sb.append("<?xml version='1.0' encoding='utf-8'?>");
				sb.append("<t>");
				sb.append("<r id='1'>");
				sb.append("<c1 id='DEL'>").append(deleteCnt).append("</c1>");
				sb.append("<c2 id='RET'>").append("삭제중 오류가 발생하였습니다.").append("</c2>");
				sb.append("</r>");
				sb.append("</t>");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Exception : " + e.toString());
		}
        
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * 메뉴를 보여준다.
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward getReguPop(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String goTo = form.getParam("goTo");
		try {
			HttpSession session = request.getSession();
            SessionInfo2 sessionInfo = (SessionInfo2)session.getAttribute("sessionInfo2");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		return mapping.findForward(goTo);
	}
	
	/**
	 * 고객 정보 조회
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward getReguListPop(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String strGoto = form.getParam("goTo");
		Esal110DAO dao = null;
		//StringBuffer sb = new StringBuffer();
		String json = null;
		
		try {
			
			dao = new Esal110DAO();
			json = dao.getReguListPop(form);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
        
		ActionUtil.sendAjaxResponse(response, json);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * 고객/단골고객 조회(화면 셋팅용)
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward getReguList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String strGoto = form.getParam("goTo");
		Esal110DAO dao = null;
		String json = null;
		
		try {
			
			dao = new Esal110DAO();
			json = dao.getReguList(form);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
        
		ActionUtil.sendAjaxResponse(response, json);
		return mapping.findForward(strGoto);
	}
}