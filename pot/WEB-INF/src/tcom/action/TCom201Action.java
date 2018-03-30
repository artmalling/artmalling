/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

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
import kr.fujitsu.ffw.util.Date2;
import kr.fujitsu.ffw.util.FileHandler;
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;
 
import tcom.dao.TCom201DAO;  

import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;

import common.util.MailSender;
import common.vo.SessionInfo;


/**
 * <p></p>
 * 
 * @created  on 1.0, 2010/06/09
 * @created  by (FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class TCom201Action extends DispatchAction {
	private static final MultiInput MultiInput = null;
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(TCom201Action.class);

	/**
	 * <p>메뉴를 보여준다.</p>
	 * 
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 
 
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			GauceHelper2.initialize(form, request, response);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		} 
		return mapping.findForward(strGoTo);
	} 

	/**
	 * <p>
	 * 공지사항관리페이지 : 조회
	 * </p>
	 * 
	 */
	public ActionForward selectNotiList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		TCom201DAO dao = null;
 
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {  
			helper = new GauceHelper2(request, response, form);

			dSet = helper.getDataSet("DS_O_NOTI_LIST");
			helper.setDataSetHeader(dSet, "H_NOTI_LIST");
 
			dao = new TCom201DAO();
			list = dao.selectNotiList(form);
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
	 * 공지사항-삭제
	 * </p>
	 * 
	 */ 
	public ActionForward deleteNotiList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		TCom201DAO	 dao 	= null;
		int ret = 0;
		HttpSession session = request.getSession(); 
		String userId  		= null;  

		String strGoTo = form.getParam("goTo"); // 분기할곳 

		try { 
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID(); 
			
			helper = new GauceHelper2(request, response, form); 
			dSet = helper.getDataSet("DS_O_NOTI_LIST");
			helper.setDataSetHeader(dSet, "H_NOTI_LIST"); 

			MultiInput mi = helper.getMutiInput(dSet);
			dao = new TCom201DAO(); 
			ret = dao.deleteNotiList(form, mi);  
			
		} catch (Exception e) {
		   logger.error("", e); 
		   helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet,ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	 
	/**
	 * <p> 글쓰기팝업을 보여준다.</p>
	 * 
	 */
	public ActionForward writePop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
    	List list 			 = null;
    	GauceHelper2  helper = null;
		TCom201DAO dao 		 = null;
		GauceDataSet dSet 	 = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
    	try {

			GauceHelper2.initialize(form, request, response); 
        
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(strGoTo, e);
            helper.writeException("GAUCE","002",e.getMessage());
        }
		return mapping.findForward(strGoTo);
	}

	/**
	 * <p>
	 * 팝업 : 상세내역 조회
	 * </p>
	 * 
	 */
	public ActionForward selectNotice(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet[] dSet = null;
		TCom201DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {  
			dao = new TCom201DAO();
			helper = new GauceHelper2(request, response, form);

			dSet = new GauceDataSet[2];  

			// 부문정보조회
			dSet[0]= helper.getDataSet("DS_IO_DEPT_CD");
			helper.setDataSetHeader(dSet[0],"H_NOTICE_DEPT");
			
			list = dao.selectNoticeDept(form);
			helper.setListToDataset(list, dSet[0]); 
			
			
			dSet[1]= helper.getDataSet("DS_IO_NOTICE");
			helper.setDataSetHeader(dSet[1], "H_NOTICE");
			
			//NOTI_CONTENT 가져와서 리스트에 삽입하고 전달
			list = dao.selectNotice(form);
			
			/**
			 * @sbcho
			 * NOTI_CONTENT 데이터 교체(ActiveX 제거)
			 */
			List tempList = (List)list.get(0);
			tempList.set(2, dao.selectNoticeContent(form.getParam("strNoti")).toString());
			list.set(0, tempList);
			
			helper.setListToDataset(list, dSet[1]);
			

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo); 
	}
	
	/**
	 * <p> 조직팝업을 보여준다. : TCOM2012</p>
	 * 
	 */
	public ActionForward orgPop(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
    	List list 			 = null;
    	GauceHelper2  helper = null;
		TCom201DAO dao 		 = null;
		GauceDataSet dSet 	 = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳
    	try {

			GauceHelper2.initialize(form, request, response);  
        
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(strGoTo, e);
            helper.writeException("GAUCE","002",e.getMessage());
        }
         
		return mapping.findForward(strGoTo);
	}
	/**
	 * <p>
	 * 공지구분 -> 부문공지  :: 점 정보조회 TCOM2012
	 * </p>
	 * 
	 */
	public ActionForward selectStrCd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		TCom201DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {  
			dao = new TCom201DAO();
			helper = new GauceHelper2(request, response, form);

			dSet = helper.getDataSet("DS_O_STR_CD");
			helper.setDataSetHeader(dSet, "H_STR_CD");
			
			list = dao.selectStrCd(form);
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
	 * 공지구분 -> 부문공지  :: 점 정보  -> 부문정보조회
	 * </p>
	 * 
	 */
	public ActionForward selectDeptCd(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		TCom201DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {  
			dao = new TCom201DAO();
			helper = new GauceHelper2(request, response, form);

			dSet = helper.getDataSet("DS_O_DEPT_CD");
			helper.setDataSetHeader(dSet, "H_DEPT_CD");
			
			list = dao.selectDeptCd(form);
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
	 * 공지구분 -> 저장
	 * </p>
	 * 
	 */ 
	public ActionForward saveNoti(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		TCom201DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession(); 
		String userId  = null; 
		String strNoti = null;
		List list 	   = null;

        String strCLOB_data[] = new String[2];
		String strGoTo = form.getParam("goTo"); // 분기할곳 

		try { 
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID(); 
			
			helper = new GauceHelper2(request, response, form);
			dSet = new GauceDataSet[3];

			dSet[0] = helper.getDataSet("DS_IO_NOTICE");
			helper.setDataSetHeader(dSet[0], "H_NOTICE");

			dSet[1] = helper.getDataSet("DS_IO_DEPT_CD"); 
			helper.setDataSetHeader(dSet[1], "H_NOTICE_DEPT"); 
			
			dSet[2] = helper.getDataSet("DS_O_NOTI_ID"); 
			helper.setDataSetHeader(dSet[2], "H_NOTI_ID"); 	  
			
			//System.out.println("DS_IO_NOTICE - NOTI_CONTENT : " + dSet[0].getDataRow(0).getColumnValue(dSet[0].indexOfColumn("NOTI_CONTENT")).toString());

			MultiInput mi[] = new MultiInput[2];
			mi[0] = helper.getMutiInput(dSet[0]);
			mi[1] = helper.getMutiInput(dSet[1]);  
            
            /***** ActiveSquar EDIT MIME 처리 시작 *****/
			/*
			int idxClob = dSet[0].indexOfColumn("URL");
            
            //System.out.println("==" + dSet[0].getDataRow(0).getColumnValue(idxClob).toString());
            
            InputStream	is      = null;
            GauceDataRow[] rows = dSet[0].getDataRows();
            
            for (int i=0; i < rows.length; i++) {
            	is = (InputStream) rows[i].getInputStream(idxClob);
            	int j = 0;
				StringBuffer buff2 = new StringBuffer();
				byte[] buf = new byte[1024];
                while (true) {
                    int bread = is.read(buf);
                    if (bread == -1) break;
                    buff2.append(new String(buf)); 
                    j++;
                }
				strCLOB_data[i] = buff2.toString();
				System.out.println("strCLOB_data["+i+"] : " + strCLOB_data[i]);
            }
            */
			
            /***** ActiveSquar EDIT MIME 처리 종료 *****/
			dao = new TCom201DAO(); 
			
			list = dao.save(form, mi, userId, strCLOB_data);  

			helper.setListToDataset(list, dSet[2]);  
			 
		} catch (Exception e) {
		   logger.error("", e); 
		   helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet[2]);
		}
		return mapping.findForward(strGoTo);
	}


	/**
	 * <p>
	 * 삭제 
	 * </p>
	 * 
	 */
	public ActionForward delNoti(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		TCom201DAO dao = null;
		int ret = 0;
		HttpSession session = request.getSession();
		String userId = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		//System.out.println("A 1------------------- "  ); 
		
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");

			userId = sessionInfo.getUSER_ID();

			helper = new GauceHelper2(request, response, form); 
			dSet = helper.getDataSet("DS_IO_NOTICE"); 
			helper.setDataSetHeader(dSet, "H_NOTICE");  
			//System.out.println("A 2------------------- "  ); 
			
			MultiInput mi = helper.getMutiInput(dSet);	 
			dao = new TCom201DAO();

			ret = dao.delete(form, mi);  
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			// 저장, 삭제, 수정의 경우 아래의 메시지를 사용
			helper.close(dSet,ret + "건 처리되었습니다");
		}
		return mapping.findForward(strGoTo);
	}
	

}
