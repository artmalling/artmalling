/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import common.util.Util;
/**
 * <p>물품 입고/반품 등록</p>
 * 
 * @created  on 1.0, 2010/01/26
 * @created  by 박래형(FUJITSU KOREA LTD.)
 * 
 * @modified on  
 * @modified by 
 * @caused   by 
 */ 

public class POrd202DAO extends AbstractDAO {    	
	/** 
	 * 규격단품 매입발주 리스트 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getList(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strBumun      = String2.nvl(form.getParam("strBumun"));
		String strTeam       = String2.nvl(form.getParam("strTeam"));
		String strPc         = String2.nvl(form.getParam("strPc"));
		String strOrgCd      = String2.nvl(form.getParam("strOrgCd"));
		String strGiJunDtType= String2.nvl(form.getParam("strGiJunDtType"));
		String strStartDt    = String2.nvl(form.getParam("strStartDt"));
		String strEndDt      = String2.nvl(form.getParam("strEndDt"));    
		String strProcStat   = String2.nvl(form.getParam("strProcStat")); 
		String strPumbun     = String2.nvl(form.getParam("strPumbun"));   
		String strVen        = String2.nvl(form.getParam("strVen"));       
		String strSlip_flag  = String2.nvl(form.getParam("strSlip_flag"));
		String strSlipNo     = String2.nvl(form.getParam("strSlipNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");

		if("".equals(strSlipNo)){
			sql.put(svc.getQuery("SEL_LIST"));
			sql.setString(i++, strProcStat);
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);                    
			sql.setString(i++, strSlip_flag);
			sql.setString(i++, userId);
			sql.setString(i++, org_flag); 
			
			if("1".equals(org_flag)){						// 판매
				sql.put(svc.getQuery("SEL_SALE_ORG_CD"));
				sql.setString(i++, strOrgCd);
			}else if("2".equals(org_flag)){					// 매입
				sql.put(svc.getQuery("SEL_BUY_ORG_CD"));
				sql.setString(i++, strOrgCd);          
			}
			if("N".equals(strProcStat)){						//미확정
				sql.put(svc.getQuery("SEL_NON_CONF"));
				//sql.setString(i++, '04');
			}
			if("0".equals(strGiJunDtType)){					// 발주일
				sql.put(svc.getQuery("SEL_ORD_DT"));
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);
			} else if("1".equals(strGiJunDtType)){			// 발주확정일
				sql.put(svc.getQuery("SEL_ORD_CONF"));    
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);		             
			} else if("2".equals(strGiJunDtType)){			// 납품예정일
				sql.put(svc.getQuery("SEL_DELI_DT"));
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);			 
			} else if("3".equals(strGiJunDtType)){			// 검품확정일
				sql.put(svc.getQuery("SEL_CHK_DT"));
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);		
			}
			sql.setString(i++, strStrCd);		
			sql.put(svc.getQuery("SEL_ORDERBY"));			
		}else{
			System.out.println("strSlipNo = " + strSlipNo);
			sql.put(svc.getQuery("SEL_SLIP_NO"));
			sql.setString(i++, strStrCd);	   
			sql.setString(i++, strSlipNo);	
			sql.setString(i++, userId);
			sql.setString(i++, org_flag); 			
		}

		ret = select2List(sql);
		return ret;
	}

	/**
	 * 품목 매입발주 매입/반품  내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	
	public List getMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strSlipNo     = String2.nvl(form.getParam("strSlipNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);

		strQuery = svc.getQuery("SEL_MASTER") + "\n";
//		System.out.println("strquery : "+ strQuery);
		sql.put(strQuery);
		ret = select2List(sql);
		//System.out.println("ret.size()= " + ret.size());
		return ret;
	}
	
	/**
	 * 품목 매입발주 매입/반품  상세 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strSlipNo     = String2.nvl(form.getParam("strSlipNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);

//		System.out.println("디테일조회안타나");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
//		System.out.println("strquery : "+ strQuery);
		sql.put(strQuery);
		ret = select2List(sql);
		//System.out.println("Mret.size()= " + ret.size());
		return ret;

	}
	
	/**
	 * 행사구분 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMarginFlag(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd			= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd		= String2.nvl(form.getParam("strPumbunCd"));
		String strMarginAppDt	= String2.nvl(form.getParam("strMarginAppDt"));

//		System.out.println(strStrCd);
//		System.out.println(strPumbunCd);
//		System.out.println(strMarginAppDt);
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strMarginAppDt);

		strQuery = svc.getQuery("SEL_MARGIN_FLAG") + "\n";
//		System.out.println("strquery : "+ strQuery);
//		System.out.println("행사구분타나!!!!");
		sql.put(strQuery);
		ret = select2List(sql);
		//System.out.println("Mret.size()= " + ret.size());
		return ret;
	}
	
	/**
	 * 행사율 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMarginRate(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd			= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd		= String2.nvl(form.getParam("strPumbunCd"));
		String strMarginAppDt	= String2.nvl(form.getParam("strMarginAppDt"));
		String strMarginGbn	    = String2.nvl(form.getParam("strMarginGbn"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strMarginAppDt);
		sql.setString(i++, strMarginGbn);

//		System.out.println("마진율타나");
		strQuery = svc.getQuery("SEL_MARGIN_RATE") + "\n";
//		System.out.println("strquery : "+ strQuery);
		sql.put(strQuery);
		ret = select2List(sql);
		//System.out.println("Mret.size()= " + ret.size());
		return ret;

	}
	
	/**
	*  비단품(품목) 매입/반품 등록전표를  바이어확정한다
	* 
	* @param form
	* @param 
	* @param userId, org_flag
	* @return
	* @throws Exception
	*/
	public int conf(ActionForm form, String userId, String org_flag)
		throws Exception {

		HashMap<String, String> map = null;
		
		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		

		String strBuyerYN = "";		        // 바이어,SM 여부
	    String strSlipProcStat  = "";		// 전표flag
	    String strSlipFlag  = "";		    // 전표구분
		String strConfStat = "";            // 확정 및 확정취소 전표상태

		String strStrCd = "";
		String strSlipNo = "";
		String stConfSlipProcStat = "";
		String sendFlag = "";
		String strOrgSlipProcStat = "";
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
            
			
			strBuyerYN = form.getParam("strBuyerYN");		// 바이어,SM 여부
			strSlipProcStat = form.getParam("strSlipProcStat");		// 바이어,SM 여부
			strSlipFlag = form.getParam("strSlipFlag");		// 바이어,SM 여부

			strStrCd = form.getParam("strStrCd");
			strSlipNo = form.getParam("strSlipNo");
			sendFlag = form.getParam("sendFlag");
			strOrgSlipProcStat = form.getParam("strOrgSlipProcStat");
			
			sql.close();
			 
			 
			// 로그인아이디가 바이어, SM일 경우 확정처리한다.
			//if("Y".equals(strBuyerYN) && "1".equals(org_flag)){			// 로그인사번이 판매조직일 경우 SM확정
				if("04".equals(strSlipProcStat)){
					sql.put(svc.getQuery("UPD_MASTER_CONF1"));
					sql.setString(1, "        ");
					sql.setString(2, null);
					sql.setString(3, "00"); 
					sql.setString(4, "01");			//반려취소상태	
					sql.setString(5, "        ");
					sql.setString(6, null);
					sql.setString(7, userId); 
					sql.setString(8, form.getParam("strStrCd"));
					sql.setString(9, form.getParam("strSlipNo"));
					strConfStat = "00";
				}else{
					sql.put(svc.getQuery("UPD_MASTER_CONF"));
					sql.setString(1, form.getParam("strToday"));
					sql.setString(2, userId);
					sql.setString(3, "04"); 
					sql.setString(4, strSlipFlag); //발주확정일자에 필요한 전표구분
					sql.setString(5, form.getParam("strToday"));
					sql.setString(6, userId); 
					sql.setString(7, form.getParam("strStrCd"));
					sql.setString(8, form.getParam("strSlipNo"));
					strConfStat = "04";
			    } 
			 /*}else{
				 throw new Exception("" + "권한대상자가 아닙니다"
							+ "데이터 업데이트를  하지 못했습니다.");	 
			 } */
				 
			res = update(sql);
			
			sql.close();
			sql.put(svc.getQuery("UPD_SLPMSTLG_CONF")); 
			
			sql.setString(1, strConfStat);  
			sql.setString(2, form.getParam("strStrCd"));
			sql.setString(3, form.getParam("strSlipNo"));
			res = update(sql); 			

			/*
			if("0".equals(sendFlag)){		//승인
				stConfSlipProcStat = "04";
			}else{
				stConfSlipProcStat = strOrgSlipProcStat;
			}
			*/

			stConfSlipProcStat = "04";
			
			System.out.println("++++++++++++++++++++++++++++++++++++++++++");
			System.out.println("++++++++++++++++++++++++++++++++++++++++++");
			System.out.println("++++++++++++++++++++++++++++++++++++++++++");
			System.out.println("strStrCd = " + strStrCd);
			System.out.println("strSlipNo = " + strSlipNo);
			System.out.println("stConfSlipProcStat = " + stConfSlipProcStat);
			System.out.println("sendFlag = " + sendFlag);
			System.out.println("++++++++++++++++++++++++++++++++++++++++++");
			System.out.println("++++++++++++++++++++++++++++++++++++++++++");
			System.out.println("++++++++++++++++++++++++++++++++++++++++++");			

			// SMS전송
			map = new HashMap<String, String>();
			map.put("strStrCd",         strStrCd);
			map.put("strSlipNo",        strSlipNo);
			map.put("stConfSlipProcStat",  stConfSlipProcStat);    
			
			sendSMS(form, map, userId, org_flag, sendFlag);
			
					
			if (res  < 0) {
				throw new Exception("" + "데이터의 적합성 문제로 인하여"
						+ "데이터 업데이트를  하지 못했습니다.");
			}
		
			ret += res;
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
	
	/**
	 * 품목코드 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getPummokInfo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strPumbunCd	= String2.nvl(form.getParam("strPumbunCd"));
		String strPummokCd	= String2.nvl(form.getParam("strPummokCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strPummokCd);

//		System.out.println("마진율타나");
		strQuery = svc.getQuery("SEL_PUMMOK_INFO") + "\n";
//		System.out.println("strquery : "+ strQuery);
		sql.put(strQuery);
		ret = select2List(sql);
		//System.out.println("Mret.size()= " + ret.size());
		return ret;
	}
	
	/**
	 *  <p>
	 *  SMS발송
	 *  
	 *  </p>
	 * @param form
	 * @param mi1
	 * @param userId
	 * @param org_flag
	 * @return
	 * @throws Exception
	 */
	public int sendSMS(ActionForm form, HashMap map, String userId, String org_flag, String sendFlag) 
						throws Exception {

		int ret  = 0;
		int res  = 0;
		int resp = 0;     //프로시저 리턴값
		SqlWrapper sql = null;
		Service svc = null;
		int i;		
		
		String strStrCd		    = "";		// 점
		String strSlipNo		= "";		// 전표번호
		String stConfSlipProcStat = "";	

		
		ProcedureWrapper psql = null;	//프로시저 사용위함
		try {
			if( getTrConnection() == null){
				connect("pot");
				begin();
			}

			strStrCd		 = (String)map.get("strStrCd");
			strSlipNo		 = (String)map.get("strSlipNo");
			stConfSlipProcStat  = (String)map.get("stConfSlipProcStat");
			
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			
			psql.put("DPS.PR_POSLPSMS_IFS", 8);  
		    
			i = 1;
            psql.setString(i++, strStrCd); 				// 점코드
            psql.setString(i++, strSlipNo); 	        // 전표번호
            psql.setString(i++, stConfSlipProcStat);		// 전표상태
            psql.setString(i++, userId);				// 처리자
            psql.setString(i++, org_flag);				// 조직구분
            psql.setString(i++, sendFlag);				// 처리구분(0:승인, 1:반려, 2:검품취소)   

            psql.registerOutParameter(i++, DataTypes.INTEGER);//7
            psql.registerOutParameter(i++, DataTypes.VARCHAR);//8


            prs = updateProcedure(psql);             
            
            resp += prs.getInt(7);                         
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null)
				end();
		}
		return ret;
	}

	/**
	 * <p>승인,반려,취소시 현재전표상태값 체크</p>
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	
	public List chkStrProStat(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd      = String2.nvl(form.getParam("strStrCd"));
		String strSlipNo     = String2.nvl(form.getParam("strSlipNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);

		strQuery = svc.getQuery("SEL_CHK_STRPROCSTAT") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
}
