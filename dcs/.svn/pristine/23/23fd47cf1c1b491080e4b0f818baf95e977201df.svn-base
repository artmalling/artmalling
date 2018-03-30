/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import common.vo.SessionInfo;

/**
 * <p>
 * 예제 DAO
 * </p>
 * 
 * @created on 1.0, 2010/05/23
 * @created by 조형욱
 * 
 * @modified on
 * @modified by fkss(2010.07.19)
 * @caused by
 */

public class DMbo101DAO extends AbstractDAO {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(DMbo101DAO.class);

	/**
	 * <p>
	 * 클럽회원 마스터 조회
	 * </p>
	 * 
	 */
	public List searchMaster(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";

		int i = 1;
		 String strBrchId           = String2.nvl(form.getParam("strBrchId"));
	     //String strPocardPrefix     = String2.nvl(form.getParam("strPocardPrefix"));
	     String strCustGrade     = String2.nvl(form.getParam("strCustGrade"));
	     String strPocardType       = String2.nvl(form.getParam("strPocardType"));
	     String strDcGb             = String2.nvl(form.getParam("strDcGb"));
	     String strFromPivotDt        = String2.nvl(form.getParam("strFromPivotDt"));
	     String strToPivotDt        = String2.nvl(form.getParam("strToPivotDt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		query = svc.getQuery("SEL_MASTER"); // + "\n";
	    sql.setString(i++, strBrchId);
        //sql.setString(i++, strPocardPrefix);
        sql.setString(i++, strCustGrade);
        sql.setString(i++, strPocardType);
        sql.setString(i++, strDcGb);
        sql.setString(i++, strFromPivotDt);
        sql.setString(i++, strToPivotDt);
		sql.put(query);
		ret = select2List(sql);

		return ret;
	}

	/**
	 * <p>
	 * 클럽회원 마스터 조회
	 * </p>
	 * 
	 */
	public List searchDetail(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String query = "";

		int i = 1;
		String strBrchId        = String2.nvl(form.getParam("strBrchId"));
	    //String strPocardPrefix     = String2.nvl(form.getParam("strPocardPrefix"));
	    String strCustGrade     = String2.nvl(form.getParam("strCustGrade"));
	    String strStartDt     	= String2.nvl(form.getParam("strStartDt"));
	
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		query = svc.getQuery("SEL_DETAIL"); // + "\n";
		sql.setString(i++, strBrchId);
		sql.setString(i++, strCustGrade);
		sql.setString(i++, strStartDt);

		sql.put(query);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * <p>
	 * 클럽목록 조회
	 * </p>
	 * 
	 */
	public List getStrmstCode(ActionForm form, MultiInput mi) throws Exception {
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String getSql = "";
		try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();

			mi.next();
			String allGb = mi.getString("ALL_GB");
			String nulGb = mi.getString("NUL_GB");

			if ((allGb.equals("Y")) || (allGb.equals("y"))) {
				getSql = ("SELECT '%' AS CODE , '전체' AS NAME , '0'  AS SORT FROM DUAL   ")
						+ ("\n UNION \n");
			}

			if ((nulGb.equals("Y")) || (nulGb.equals("y"))) {
				// getSql =
				// ("SELECT '' AS CODE , '' AS NAME , 0  AS SORT FROM DUAL   ")
				// + ("\n UNION \n");
			}

			getSql = getSql + svc.getQuery("SEL_STRMST_CODE");

			sql.put(getSql);

			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	/**
	 * <p>
	 * 클럽회원 마스터 조회
	 * </p>
	 * 
	 */
	public List getCardcompCode(ActionForm form, MultiInput mi)
			throws Exception {
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String getSql = "";
		try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();

			mi.next();
			String allGb = mi.getString("ALL_GB");
			String nulGb = mi.getString("NUL_GB");

			if ((allGb.equals("Y")) || (allGb.equals("y"))) {
				getSql = ("SELECT '%' AS CODE , '전체' AS NAME , '0'  AS SORT FROM DUAL   ")
						+ ("\n UNION \n");
			}

			if ((nulGb.equals("Y")) || (nulGb.equals("y"))) {
				// getSql =
				// ("SELECT '' AS CODE , '' AS NAME , 0  AS SORT FROM DUAL   ")
				// + ("\n UNION \n");
			}

			getSql = getSql + svc.getQuery("SEL_CARDCOMP_CODE");

			sql.put(getSql);

			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	/**
	 * <p>
	 * 비용분담율 등록
	 * </p>
	 * 
	 */
	public int saveDetail(ActionForm form, MultiInput mi,
			HttpServletRequest request) throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		String orgCdCnt = "";

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			HttpSession session = request.getSession();
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			String strUserId = sessionInfo.getUSER_ID();
            
			String strChk      = String2.nvl(form.getParam("strChk"));
			System.out.println(strChk);
			logger.debug("mi TotalRowNum: " + mi.getTotalRowNum());

			while (mi.next()) {
				sql.close();
 				if (!strChk.equals("I")){ // 저장
 					System.out.println(strChk);
					int i = 1;
					sql.put(svc.getQuery("UPD_PADD_RULE"));
					
					sql.setString(i++,mi.getString("CUST_GRADE"));
					sql.setString(i++,mi.getString("START_DT"));
					sql.setString(i++,mi.getString("END_DT"));
					sql.setString(i++,mi.getString("POINT_RATE"));
					sql.setString(i++,mi.getString("HANDO_CHK"));
					sql.setString(i++,mi.getString("MARGIN_A"));
					sql.setString(i++,mi.getString("DC_A"));
					sql.setString(i++,mi.getString("MARGIN_B"));
					sql.setString(i++,mi.getString("DC_B"));
					sql.setString(i++,mi.getString("MARGIN_C"));
					sql.setString(i++,mi.getString("DC_C"));
					sql.setString(i++,mi.getString("CASH_RATE"));
					sql.setString(i++,mi.getString("JEHU_CARD_RATE"));
					sql.setString(i++,mi.getString("JASA_CARD_RATE"));
					sql.setString(i++,mi.getString("JASA_TICKET_RATE"));
					sql.setString(i++,mi.getString("TASA_CARD_RATE"));
					sql.setString(i++,mi.getString("TASA_TICKET_RATE"));
					sql.setString(i++,mi.getString("JASA_DVD_RATE"));
					sql.setString(i++,mi.getString("BRCH_DVD_RATE"));
					sql.setString(i++,strUserId);//로그인ID
					sql.setString(i++,mi.getString("BRCH_ID"));
					//sql.setString(i++,mi.getString("POCARD_PREFIX"));
					sql.setString(i++,mi.getString("CUST_GRADE"));					
					sql.setString(i++,mi.getString("START_DT"));
				
				} else { //if (mi.getString("IN_UP_TYPE").equals("I")) { // INSERT
					int i = 1;					
/*					
					sql.put(svc.getQuery("SEL_PADD_RULE_COUNT"));							
					sql.setString(i++, mi.getString("BRCH_ID"));
					sql.setString(i++, mi.getString("POCARD_PREFIX"));
					Map map = selectMap( sql );							
					orgCdCnt = String2.nvl((String)map.get("CNT"));
					System.out.println(orgCdCnt);
					
					if( !orgCdCnt.equals("0")) {
						throw new Exception("[USER]"+"중복된 데이터가 있습니다.");
					}
					sql.close();
					
					i = 1;
*/					
					sql.put(svc.getQuery("INS_PADD_RULE"));
					
					sql.setString(i++,mi.getString("CUST_GRADE"));
			        sql.setString(i++,mi.getString("BRCH_ID"));
					sql.setString(i++,mi.getString("POCARD_PREFIX"));
					sql.setString(i++,mi.getString("POCARD_TYPE"));
					sql.setString(i++,mi.getString("DC_GB"));
					sql.setString(i++,mi.getString("START_DT"));
					sql.setString(i++,mi.getString("END_DT"));
					sql.setString(i++,mi.getString("POINT_RATE"));
					sql.setString(i++,mi.getString("HANDO_CHK"));
					sql.setString(i++,mi.getString("MARGIN_A"));
					sql.setString(i++,mi.getString("DC_A"));
					sql.setString(i++,mi.getString("MARGIN_B"));
					sql.setString(i++,mi.getString("DC_B"));
					sql.setString(i++,mi.getString("MARGIN_C"));
					sql.setString(i++,mi.getString("DC_C"));
					sql.setString(i++,mi.getString("CASH_RATE"));
					sql.setString(i++,mi.getString("JEHU_CARD_RATE"));
					sql.setString(i++,mi.getString("JASA_CARD_RATE"));
					sql.setString(i++,mi.getString("JASA_TICKET_RATE"));
					sql.setString(i++,mi.getString("TASA_CARD_RATE"));
					sql.setString(i++,mi.getString("TASA_TICKET_RATE"));
					sql.setString(i++,mi.getString("JASA_DVD_RATE"));
					sql.setString(i++,mi.getString("BRCH_DVD_RATE"));
					sql.setString(i++,strUserId);//로그인ID
					sql.setString(i++,strUserId);//로그인ID
				}
				res = update(sql);

				//
				if (res < 1) {
					// throw new Exception("데이타 처리중 오류가 발생하였습니다.");
				}
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end(); // commit()과 동일
		}

		return ret;
	}
	
	/**
	 * <p>
	 * 비용분담율 등록
	 * </p>
	 * 
	 
	public int deleteMaster(ActionForm form, MultiInput mi,
			HttpServletRequest request) throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			HttpSession session = request.getSession();
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			String strUserId = sessionInfo.getUSER_ID();

			logger.debug("mi TotalRowNum: " + mi.getTotalRowNum());

			while (mi.next()) {
				sql.close();
				int i = 1;
				sql.put(svc.getQuery("DEL_BRANCH"));
				sql.setString(i++, mi.getString("DEL_YN"));
				sql.setString(i++, strUserId); // 로그인ID
				sql.setString(i++, mi.getString("STR_CD")); //
				sql.setString(i++, mi.getString("BCOMP_CD"));
				sql.setString(i++, mi.getString("JBRCH_ID"));

				res = update(sql);

				//
				if (res < 1) {
					// throw new Exception("데이타 처리중 오류가 발생하였습니다.");
				}
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end(); // commit()과 동일
		}

		return ret;
	}*/
	
    /**
     * <p>적립율 등록 OPEN POPUP시 적립율(월별) 중복체크</p>
     * 
     */
    public int searchTermChk(ActionForm form) throws Exception {
    	int ret 		= 0;
        SqlWrapper sql  = null;
        Service svc     = null;

        sql = new SqlWrapper();
        svc = (Service) form.getService();
        
        String strBrchId  	= String2.nvl(form.getParam("strBrchId"));
        String strCustGrade = String2.nvl(form.getParam("strCustGrade"));
        String strStartDt 	= String2.nvl(form.getParam("strStartDt"));
        String strEndDt   	= String2.nvl(form.getParam("strEndDt"));
        
        connect("pot");
        
        sql.put(svc.getQuery("SEL_PADD_RULE_CNT"));
        sql.setString(1, strBrchId);
        sql.setString(2, strCustGrade);
        sql.setString(3, strEndDt);
        sql.setString(4, strStartDt);
        
        Map map = selectMap( sql );
    	int dupCnt = Integer.parseInt(map.get("CNT").toString());
    	
    	String strChk      = String2.nvl(form.getParam("strChk"));
    	if (strChk.equals("I")) {//insert일때
    		if( dupCnt > 0) {
        		throw new Exception("[USER]"+"기간을 확인하세요.");
        	}
    	}else{
    		if( dupCnt > 1) {
        		throw new Exception("[USER]"+"기간을 확인하세요.");
        	}    		
    	}
    	
        return ret;
    }
}
