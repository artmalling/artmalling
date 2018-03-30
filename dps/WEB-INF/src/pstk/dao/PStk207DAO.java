/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pstk.dao;

import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>실사재고등록(비단품)</p>
 * 
 * @created  on 1.0, 2010/04/12
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PStk207DAO extends AbstractDAO {


	/**
	 * 실사재고 마스터정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strStkYm      = String2.nvl(form.getParam("strStkYm"));
		String strStkDt      = String2.nvl(form.getParam("strStkDt"));
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));
		String strDeptCd     = String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd     = String2.nvl(form.getParam("strTeamCd"));
		String strPcCd       = String2.nvl(form.getParam("strPcCd"));
		String strCornerCd   = String2.nvl(form.getParam("strCornerCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		/*
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStkDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStkDt);
		*/
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);		
		
		strQuery = svc.getQuery("SEL_STKPUMBUN") + "\n";
		
		if(!strDeptCd.equals("") && !strDeptCd.equals("%")){
			strQuery += svc.getQuery("SEL_STKPUMBUN_WHERE_DEPT_CD") + "\n";
			sql.setString(i++, strDeptCd);
		}
		if(!strTeamCd.equals("") && !strTeamCd.equals("%")){
			strQuery += svc.getQuery("SEL_STKPUMBUN_WHERE_TEAM_CD") + "\n";
			sql.setString(i++, strTeamCd);
		}
		if(!strPcCd.equals("") && !strPcCd.equals("%")){
			strQuery += svc.getQuery("SEL_STKPUMBUN_WHERE_PC_CD") + "\n";
			sql.setString(i++, strPcCd);
		}
		if(!strCornerCd.equals("") && !strCornerCd.equals("%")){
			strQuery += svc.getQuery("SEL_STKPUMBUN_WHERE_CORNER_CD") + "\n";
			sql.setString(i++, strCornerCd);
		}
		
		if(!strPumbunCd.equals("")){
			strQuery += svc.getQuery("SEL_STKPUMBUN_WHERE_PUMBUN_CD") + "\n";
			sql.setString(i++, strPumbunCd);
		}
		
		strQuery += svc.getQuery("SEL_STKPUMBUN_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 실사재고 마스터정보를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMasterExcel(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strStkYm      = String2.nvl(form.getParam("strStkYm"));
		String strStkDt      = String2.nvl(form.getParam("strStkDt"));
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));
		String strDeptCd     = String2.nvl(form.getParam("strDeptCd"));
		String strTeamCd     = String2.nvl(form.getParam("strTeamCd"));
		String strPcCd       = String2.nvl(form.getParam("strPcCd"));
		String strCornerCd   = String2.nvl(form.getParam("strCornerCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		/*
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStkDt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStkDt);
		*/
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);		
		
		strQuery = svc.getQuery("SEL_STKPUMBUN_EXCEL") + "\n";
		
		if(!strDeptCd.equals("") && !strDeptCd.equals("%")){
			strQuery += svc.getQuery("SEL_STKPUMBUN_WHERE_DEPT_CD") + "\n";
			sql.setString(i++, strDeptCd);
		}
		if(!strTeamCd.equals("") && !strTeamCd.equals("%")){
			strQuery += svc.getQuery("SEL_STKPUMBUN_WHERE_TEAM_CD") + "\n";
			sql.setString(i++, strTeamCd);
		}
		if(!strPcCd.equals("") && !strPcCd.equals("%")){
			strQuery += svc.getQuery("SEL_STKPUMBUN_WHERE_PC_CD") + "\n";
			sql.setString(i++, strPcCd);
		}
		if(!strCornerCd.equals("") && !strCornerCd.equals("%")){
			strQuery += svc.getQuery("SEL_STKPUMBUN_WHERE_CORNER_CD") + "\n";
			sql.setString(i++, strCornerCd);
		}
		
		if(!strPumbunCd.equals("")){
			strQuery += svc.getQuery("SEL_STKPUMBUN_WHERE_PUMBUN_CD") + "\n";
			sql.setString(i++, strPumbunCd);
		}
		
		strQuery += svc.getQuery("SEL_STKPUMBUN_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 품번에따른 재고실사 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPbnStk(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));	
		String strStkYm      = String2.nvl(form.getParam("strStkYm"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);		
		sql.setString(i++, strStkYm);
		
		strQuery = svc.getQuery("SEL_PBNSTK");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 행사구분을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchFlag(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));		
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));		

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);	
		
		strQuery = svc.getQuery("SEL_EVENT_FLAG");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 행사율을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchRate(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));		
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));		

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);	
		
		strQuery = svc.getQuery("SEL_EVENT_RATE");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 마진율을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMg(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));		
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));
		String strEventFlag  = String2.nvl(form.getParam("strEventFlag"));		
		String strEventRate  = String2.nvl(form.getParam("strEventRate"));	

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventFlag);
		sql.setString(i++, strEventRate);
		sql.setString(i++, strPumbunCd);	
		
		strQuery = svc.getQuery("SEL_EVENT_MG");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 장부재고를 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchJb(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd     = String2.nvl(form.getParam("strStrCd"));		
		String strStkYm     = String2.nvl(form.getParam("strStkYm"));
		String strStkDt     = String2.nvl(form.getParam("strStkDt"));		
		String strPumbunCd  = String2.nvl(form.getParam("strPumbunCd"));	
		String strEventRate = String2.nvl(form.getParam("strEventRate"));		
		String strEventFlag = String2.nvl(form.getParam("strEventFlag"));
		String strMgRate    = String2.nvl(form.getParam("strMgRate"));		
		String strPummokCd  = String2.nvl(form.getParam("strPummokCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStkDt);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strEventFlag);
		sql.setString(i++, strEventRate);
		sql.setString(i++, strMgRate);
		sql.setString(i++, strPummokCd);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStkDt);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strEventFlag);
		sql.setString(i++, strEventRate);		
		sql.setString(i++, strMgRate);
		sql.setString(i++, strPummokCd);
		
		strQuery = svc.getQuery("SEL_JB");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 마감 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCloseDt(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strStkYm      = String2.nvl(form.getParam("strStkYm"));
				
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStkYm);
		
		strQuery = svc.getQuery("SEL_CLOSE");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 품번 품목 유요성 체크.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchCheck(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));		
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));
		String strPummokCd   = String2.nvl(form.getParam("strPummokCd"));
		
		String strEventFlag      = String2.nvl(form.getParam("strEventFlag"));		
		String strEventRate   = String2.nvl(form.getParam("strEventRate"));
		String strMgRate   = String2.nvl(form.getParam("strMgRate"));
		
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strPummokCd);
		
		sql.setString(i++, strEventFlag);
		sql.setString(i++, strEventRate);
		sql.setString(i++, strMgRate);
		
		strQuery = svc.getQuery("SEL_SKU_EXCEL");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 실사재고를 저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String userId)
			throws Exception {

		int ret = 0;
		int res = 0;		
		SqlWrapper sql = null;
		Service svc = null;	
		String orgCdCnt = "";
		//String strQuery = "";
		int i;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strStrCd        = String2.nvl(form.getParam("strStrCd"));
			String strStkYm        = String2.nvl(form.getParam("strStkYm"));	
			
			while (mi.next()) {
				sql.close();
				
				if (mi.IS_INSERT()) {					
                    i = 0;
					
                    System.out.println(strStrCd +"strStrCd");
					System.out.println(strStkYm +"strStkYm");
					System.out.println(mi.getString("PUMBUN_CD") +"PUMBUN_CD");
					System.out.println(mi.getString("EVENT_FLAG") +"EVENT_FLAG");
					System.out.println(mi.getString("EVENT_RATE") +"EVENT_RATE");
					System.out.println(mi.getString("MG_RATE") +"MG_RATE");
					System.out.println(mi.getString("SRVY_QTY") +"SRVY_QTY");
					System.out.println(mi.getString("PUMBUN_CD") +"PUMBUN_CD");
					System.out.println(mi.getString("MG_RATE") +"MG_RATE");
					System.out.println(mi.getString("SRVY_QTY") +"SRVY_QTY");
					System.out.println(mi.getString("SRVY_AMT") +"SRVY_AMT");
					System.out.println(mi.getString("SRVY_SALE_PRC") +"SRVY_SALE_PRC");
					System.out.println(mi.getString("SRVY_COST_AMT") +"SRVY_COST_AMT");
					
					sql.put(svc.getQuery("SEL_STKPUMBUN_INS_CNT"));							
					sql.setString(++i, strStrCd);
					sql.setString(++i, strStkYm);
					sql.setString(++i, mi.getString("PUMBUN_CD"));
					sql.setString(++i, mi.getString("EVENT_FLAG"));
					sql.setString(++i, mi.getString("EVENT_RATE"));
					sql.setString(++i, mi.getString("MG_RATE"));
					sql.setString(++i, mi.getString("PUMMOK_CD"));
					
					Map map = selectMap( sql );							
					orgCdCnt = String2.nvl((String)map.get("CNT"));
					if( !orgCdCnt.equals("0")) {
						throw new Exception("[USER]"+"중복된 데이터가 있습니다.");
					}
					sql.close();
					
					i = 0;	
					
					
					
					
					sql.put(svc.getQuery("INS_STKPUMBUN"));
					sql.setString(++i, strStrCd);
					sql.setString(++i, strStkYm);
					sql.setString(++i, mi.getString("PUMBUN_CD"));
					sql.setString(++i, "0");
					sql.setString(++i, mi.getString("PUMMOK_CD"));
                    sql.setString(++i, mi.getString("EVENT_FLAG"));
                    sql.setString(++i, mi.getString("EVENT_RATE"));
                    sql.setString(++i, mi.getString("MG_RATE"));
                    sql.setString(++i, mi.getString("SRVY_QTY"));
                    //sql.setString(++i, strSrvyCostPrc);
                    sql.setString(++i, mi.getString("PUMBUN_CD"));
                    sql.setString(++i, mi.getString("MG_RATE"));
                    sql.setString(++i, mi.getString("SRVY_QTY"));
                    sql.setString(++i, mi.getString("SRVY_AMT"));
                    sql.setString(++i, mi.getString("SRVY_SALE_PRC"));
                    sql.setString(++i, mi.getString("SRVY_COST_AMT"));
                    sql.setString(++i, mi.getString("SRVY_AMT"));
                    sql.setString(++i, mi.getString("SRVY_QTY"));
                    sql.setString(++i, mi.getString("SRVY_AMT"));
					sql.setString(++i, userId);
					sql.setString(++i, userId);
					
				} else if (mi.IS_UPDATE()) {
					i = 0;					
					
					
					
					sql.put(svc.getQuery("UPD_STKPUMBUN"));	
					
					sql.setString(++i, mi.getString("SRVY_QTY"));
					sql.setString(++i, mi.getString("SRVY_AMT"));
					sql.setString(++i, mi.getString("SRVY_QTY"));
					sql.setString(++i, mi.getString("PUMBUN_CD"));
                    sql.setString(++i, mi.getString("MG_RATE"));
                    sql.setString(++i, mi.getString("SRVY_QTY"));
                    sql.setString(++i, mi.getString("SRVY_AMT"));
                    sql.setString(++i, mi.getString("SRVY_SALE_PRC"));
                    sql.setString(++i, mi.getString("SRVY_COST_AMT"));
                    sql.setString(++i, mi.getString("SRVY_AMT"));
					sql.setString(++i, userId);
					sql.setString(++i, strStrCd);					
					sql.setString(++i, strStkYm);
					sql.setString(++i, mi.getString("PUMBUN_CD"));
					sql.setString(++i, mi.getString("PUMMOK_CD"));
                    sql.setString(++i, mi.getString("EVENT_FLAG"));
                    sql.setString(++i, mi.getString("EVENT_RATE"));
                    sql.setString(++i, mi.getString("MG_RATE"));
				} 
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += res;
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
	/**
	 *  <p>
	 *  실사재고(비단품)을 삭제한다.
	 *  
	 *  </p>
	 * @param form
	 * @param mi
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form, MultiInput mi) 
						throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		String strUserId        = String2.nvl(form.getParam("strUserId"));
		int i;
		try {
			connect("pot");
			begin();	
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi.next()) {
				res = 0;
				sql.close();
				if ( mi.IS_DELETE()){
					i = 0;	
					
					sql.put(svc.getQuery("DEL_STKPUMBUN"));
					sql.setString(++i, mi.getString("STR_CD"));					
					sql.setString(++i, mi.getString("STK_YM"));					
					sql.setString(++i, mi.getString("PUMBUN_CD"));					
					sql.setString(++i, mi.getString("PUMMOK_CD"));	
					sql.setString(++i, mi.getString("EVENT_FLAG"));					
					sql.setString(++i, mi.getString("EVENT_RATE"));
					sql.setString(++i, mi.getString("MG_RATE"));
					
					
					
					res = update(sql);
					/*
					sql.close();
					i = 0;
					
					sql.put(svc.getQuery("UPD_TOTALPBN"));
					sql.setString(++i, strUserId);		
					sql.setString(++i, mi.getString("STR_CD"));					
					sql.setString(++i, mi.getString("STK_YM"));					
					sql.setString(++i, mi.getString("PUMBUN_CD"));					
					sql.setString(++i, mi.getString("PUMMOK_CD"));	
					sql.setString(++i, mi.getString("EVENT_FLAG"));					
					sql.setString(++i, mi.getString("EVENT_RATE"));
					sql.setString(++i, mi.getString("MG_RATE"));
					
					res = update(sql);
					*/
					
				}else{
					continue;
				} 

				if (res != 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터를 처리 하지 못했습니다.");
				}
				
				ret += res;
			}

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
	/**
	 * 품번에따른 재고실사 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPbnInf(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		
		strQuery = svc.getQuery("SEL_PBNINF");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
}
