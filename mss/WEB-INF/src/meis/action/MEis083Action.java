/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package meis.action;

import java.net.InetAddress;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;

import org.apache.log4j.Logger;

import meis.dao.MEis083DAO;

import com.gauce.GauceDataSet;
import common.util.Util;

/**
 * <p>고객 현황</p>
 * 
 * @created on 1.0, 2011/06/30
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis083Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MEis083Action.class);

	/** 
	 * <p>고객 현황  화면로딩</p>
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
	 * <p>등급별 고객현황 차트 로딩</p>
	 */
	public ActionForward chart1(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		String strGoTo      = form.getParam("goTo"); // 분기할곳
		MEis083DAO dao      = null;
		String strErrorMsg  = null;
		String strRtn       = null;
		String strUserId    = null;
		try {
			
			//차트키세팅
			this.setFXChartKey(request);
			
			GauceHelper2.initialize(form, request, response);
			strUserId   = Util.getUsrCd(request);
			dao         = new MEis083DAO();
			strRtn      = dao.searchCustPie(form, strUserId);
			strErrorMsg = "";
		} catch (Exception e) {
			strErrorMsg = e.toString();
			logger.error("", e);
		} finally {
			request.setAttribute("error",   strErrorMsg);
			request.setAttribute("xmlData", strRtn);
		}

		return mapping.findForward(strGoTo);
	}
	
	/** 
	 * <p>고객 등급 현황월별 추이 차트 로딩</p>
	 */
	public ActionForward chart2(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception { 

		String strGoTo      = form.getParam("goTo"); // 분기할곳
		MEis083DAO dao      = null;
		String strErrorMsg  = null;
		String strRtn       = null;
		String strUserId    = null;
		try {
			
			//차트키세팅
			this.setFXChartKey(request);
			
			GauceHelper2.initialize(form, request, response);
			strUserId   = Util.getUsrCd(request);
			dao         = new MEis083DAO();
			strRtn      = dao.searchCustGrid(form, strUserId);
			strErrorMsg = "";
		} catch (Exception e) {
			strErrorMsg = e.toString();
			logger.error("", e);
		} finally {
			request.setAttribute("error",   strErrorMsg);
			request.setAttribute("xmlData", strRtn);
		}

		return mapping.findForward(strGoTo);
	}
	
	/** 
	 * <p>고객등급현황조회</p>
	 */
	public ActionForward searchCustGrade(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis083DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		String strUserId    = null;
		
		try {
			dao     = new MEis083DAO();
			dSet    = new GauceDataSet();
			strUserId = Util.getUserId(request);
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.searchCustInfo(form, strUserId, "SEL_CUST1");
			helper.setDataSetHeader(dSet, "H_SEL_CUST");
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}
	
	/** 
	 * <p>고객등급매출현황조회</p>
	 */
	public ActionForward searchCustSale(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis083DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		String strUserId    = null;
		
		try {
			dao     = new MEis083DAO();
			dSet    = new GauceDataSet();
			strUserId = Util.getUserId(request);
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.searchCustInfo(form, strUserId, "SEL_CUST2");
			helper.setDataSetHeader(dSet, "H_SEL_CUST");
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}
	
	/** 
	 * <p>엑셀데이터조회</p>
	 */
	public ActionForward getExcelData(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis083DAO dao      = null;
		List list           = null;
		String strGoTo      = null;
		String strUserId    = null;
		
		try {
			dao     = new MEis083DAO();
			dSet    = new GauceDataSet();
			strUserId = Util.getUserId(request);
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.getExcelData(form, strUserId);
			helper.setDataSetHeader(dSet, "H_SEL_EXCEL");
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}
	
	private void setFXChartKey(HttpServletRequest request) throws Exception {
		/************ fujitsu.config파일을 읽어들임 ******************************/

		Properties fujitsuDeptProps = Util.getFujitsudeptProperties();
		String serverName = fujitsuDeptProps.getProperty("server.name");
		 
		/************ Chart FX의 운영기처리 **************************************/
		if (serverName.equals(request.getServerName())){
		    // Server

		    String myServer1 = "10.1.100.26";
		    String myServer2 = "10.1.100.28";

		    // IP Check
		    InetAddress Address = InetAddress.getLocalHost();
		    String ipCheck = Address.getHostAddress();  
		    if (ipCheck.equals(myServer1))                                                       
		    {                                                          
		          System.out.println(myServer1);                        
		          com.softwarefx.chartfx.server.Chart.setLicenseString("Ck4o2ftbAQCl942vct3jQEEBAAABAAAABUNGSjcwC1NGWERPV05MT0FERk5TPTE7TWFwcz1QLDMyMSxDRko3MCwxO1N0YXRpc3RpY2FsPVAsMzIxLENGSjcwLDE7R2F1Z2VzPVAsMzIxLENGSjcwLDEBAAAAAVIAAUSHAXVzZXIubmFtZT1qZXVzCmphdmEudmVyc2lvbj0xLjUuMC4xMQp1c2VyLmhvbWU9L2pldXMKaG9zdD1kY3d3MDEKamF2YS5ob21lPS9vcHQvamF2YTEuNS9qcmUKb3MubmFtZT1IUC1VWAppcD0xMC4xLjEwMC4yNgpvcy5hcmNoPUlBNjROCgAAAAABIA==*&VaqX89ojq8EhmT1sny7X3kA4ww35vFL0Y3RhkyGuQG1IN/vLUOHoHpz58B/ncSbnPzVkROKAZxL72nwkc6X+1hNaKgH1em5rhD3LCViNbW/1p0WxJ4lFA8Fs5REmPCoI0yGuoKDWjebPFLyaCTGV1P74/RfYb0bUBB0d1ZdQ9Ow=");  
		    }                                                          
		    else if (ipCheck.equals(myServer2))
		    { 
		          System.out.println(myServer2); 
		          com.softwarefx.chartfx.server.Chart.setLicenseString("HyTrXftbAADEvO9Pc93jQAMBAAABAAAAB0NGSjcwQVALU0ZYRE9XTkxPQURMTlM9MTtNYXBzPVAsMjU5LENGSjcwQVAsMTtTdGF0aXN0aWNhbD1QLDI1OSxDRko3MEFQLDE7R2F1Z2VzPVAsMjU5LENGSjcwQVAsMQEAAAABUgABRIcBdXNlci5uYW1lPWpldXMKamF2YS52ZXJzaW9uPTEuNS4wLjExCnVzZXIuaG9tZT0vamV1cwpob3N0PWRjd3cwMgpqYXZhLmhvbWU9L29wdC9qYXZhMS41L2pyZQpvcy5uYW1lPUhQLVVYCmlwPTEwLjEuMTAwLjI4Cm9zLmFyY2g9SUE2NE4KAAAAAA==*&xnud56E5jC1x+mNS7hs+3N1npFDpQdYOK3QO3BdCwtZiMVmdV434Qhaj4nTkPpFIO3R7inWvd1EzpCTllJRBRFYdBW8N135CGwlTAcx66JpiBzLsWKIqHPLXI3E0r7zRxJDxBsb9sg/toi0FYHNjzgEBH5j7oSxC313FVllyGnk=");  
		    }
		}
	}
	
}
