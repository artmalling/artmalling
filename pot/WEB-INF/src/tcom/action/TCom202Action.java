/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.action;

import java.io.InputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;

import org.apache.log4j.Logger;

import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

import tcom.dao.TCom202DAO;

/**
 * <p>시스템메뉴-메뉴/프로그램 관리</p>
 * 
 * @created  on 1.0, 2010/12/12
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class TCom202Action extends DispatchAction {
	
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(TCom202Action.class);

	/**
	 * <p>페이지를 로드한다.</p>
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
	 * <p>선택된 분류에 해당하는 모든 프로그램을 보여준다.</p>
	 * 
	 */
	public ActionForward treeview(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		TCom202DAO dao 		= null; 
 
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			
			dao = new TCom202DAO();
			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_O_TREE_MAIN");
			helper.setDataSetHeader(dSet, "H_TREE_MAIN");
			list = dao.getTreeList(form); 

			helper.setListToDataset(list, dSet);  

		} catch (Exception e) { 
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward(strGoTo);
	}

	/**
	 * <p>선택된 분류에 해당하는 모든 프로그램을 보여준다.</p>
	 * 
	 */
	public ActionForward selectHelp(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List list 			= null;
		GauceHelper2 helper = null;
		GauceDataSet dSet 	= null;
		TCom202DAO dao 		= null; 
 
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			
			dao = new TCom202DAO();
			helper = new GauceHelper2(request, response, form);
			
			dSet = helper.getDataSet("DS_IO_MAIN");
			helper.setDataSetHeader(dSet, "H_IO_MAIN");
			list = dao.selectHelp(form); 
 
			helper.setListToDataset(list, dSet);   

		} catch (Exception e) { 
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}

		return mapping.findForward(strGoTo);
	}


	/**
	 * <p>도움말 등록/수정.</p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
	        HttpServletRequest request, HttpServletResponse response)
	        throws Exception {
		
	    List         	list   	= null;
        GauceHelper2 	helper 	= null;
        GauceDataSet 	dSet 	= null;
        TCom202DAO 		dao		= null;
        
        String ret          = "";
        String strGoTo 		= form.getParam("goTo"); 
        
        HttpSession session 	= request.getSession();
        String userId 			= null;
        String strCLOB_data[] = new String[2];
        
        try {
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();
            helper = new GauceHelper2(request, response, form);
            
            dSet = helper.getDataSet("DS_IO_MAIN"); 
            
            /***** ActiveSquar EDIT MIME 처리 시작 *****/
            int idxClob = dSet.indexOfColumn("URL");
            //System.out.println("==" + dSet.getDataRow(0).getColumnValue(idxClob).toString());
            
            InputStream	is      = null;
            GauceDataRow[] rows = dSet.getDataRows();
            
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


            }
            /***** ActiveSquar EDIT MIME 처리 종료 *****/
             
            MultiInput mi = helper.getMutiInput(dSet);
            helper.setDataSetHeader(dSet, "H_IO_MAIN");
            dao = new TCom202DAO();
            ret = dao.save(form, mi, userId, strCLOB_data);
            
        } catch (Exception e) {
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            helper.close("정상적으로 처리되었습니다");
        }
        
		return mapping.findForward(strGoTo);
    }  
	

  
}
