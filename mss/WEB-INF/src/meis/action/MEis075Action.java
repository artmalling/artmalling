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
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import meis.dao.MEis075DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;
import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;

/**
 * <p>월별조직별판관비실적조회</p>
 * 
 * @created on 1.0, 2011/07/15
 * @created by 최재형
 * 
 * @modified on
 * @modified by
 * @caused by
 */
public class MEis075Action extends DispatchAction {

	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MEis075Action.class);
	
	/** 
	 * <p>월별조직별판관비실적조회 화면로딩</p>
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
									HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
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
	 * <p>판관비실적조회</p>
	 */
	public ActionForward searchSaleAndManageRslt(ActionMapping mapping, ActionForm form,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		GauceDataSet dSet   = null;
		GauceHelper2 helper = null;
		MEis075DAO dao      = null;
		List<Map> list           = null;
		String strGoTo      = null;
		
		try {
			dao     = new MEis075DAO();
			dSet    = new GauceDataSet();
			helper  = new GauceHelper2(request, response, form);
			strGoTo = form.getParam("goTo");
			
			list    = dao.searchSaleAndManageRslt(form, false);
			helper.setDataSetHeader(dSet, "H_SEL_SALE_AND_MANAGE_RSLT");
			
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
			helper.writeException("GAUCE", "002", e.toString());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward("blank");
	}
	
	/** 
	 * <p>차트 호출</p>
	 */
	public ActionForward chartCall(ActionMapping mapping, ActionForm form,
									HttpServletRequest request, HttpServletResponse response) throws Exception { 
		
		String strGoTo = form.getParam("goTo"); // 분기할곳
		MEis075DAO dao      = null;
		List list           = null;
		
		try {
			
			//차트키세팅
			this.setFXChartKey(request);
			
			String CHART_GB = form.getParam("CHART_GB");

			if(CHART_GB.equals("IFRAME_SALE_AND_MANAGE_CHART")) {
				dao     = new MEis075DAO();
				list    = dao.searchSaleAndManageRslt(form, true);
				
				request.setAttribute("list", list);
			}
			
			request.setAttribute("form", form);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(strGoTo, e);
		}
		
		return mapping.findForward(strGoTo);
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
