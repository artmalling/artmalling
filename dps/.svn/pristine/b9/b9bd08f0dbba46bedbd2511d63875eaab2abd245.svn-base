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

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


/**
 * <p> 규격단품 매입발주 등록  DAO </p>
 * 
 * @created  on 1.0, 2010/02/16
 * @created  by  
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class POrd207DAO extends AbstractDAO {
    	 
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
		String strGJdateType = String2.nvl(form.getParam("strGJdateType"));
		String strStartDt    = String2.nvl(form.getParam("strStartDt"));
		String strEndDt      = String2.nvl(form.getParam("strEndDt"));    
		String strProcStat   = String2.nvl(form.getParam("strProcStat")); 
		String strPumbun     = String2.nvl(form.getParam("strPumbun"));   
		String strBizType    = String2.nvl(form.getParam("strBizType"));
		String strVen        = String2.nvl(form.getParam("strVen"));     
		String strSlipNo     = String2.nvl(form.getParam("strSlipNo"));      
		// String strSlip_flag  = String2.nvl(form.getParam("strSlip_flag"));
		String slipFlagList   = String2.nvl(form.getParam("slipFlagList")); 
		String strSkuFlag    = "1";	// 단품
		String strSkuType    = "1"; // 규격단품

		System.out.println("slipFlagList = " + slipFlagList);
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");

		//넘어온 문자열을 쿼리 조건에 맞게 정한다.
		slipFlagList = "AND " + slipFlagList.substring(0, 11) + ' ' + slipFlagList.substring(11, slipFlagList.length());

		if("".equals(strSlipNo)){
			/* System.out.println("slipFlagList = " + slipFlagList); */   
			sql.put(svc.getQuery("SEL_LIST"));   
			sql.setString(i++, strProcStat);      
			sql.setString(i++, strProcStat);   
			sql.setString(i++, strSkuFlag);
			/*sql.setString(i++, strSkuType);   */ 
			sql.setString(i++, strPumbun);
			sql.setString(i++, strVen);                    
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
				//sql.setString(i++, '01');
			}
			
			if("0".equals(strGJdateType)){					// 발주일
				sql.put(svc.getQuery("SEL_ORD_DT"));
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);
			} else if("1".equals(strGJdateType)){			// 발주확정일
				sql.put(svc.getQuery("SEL_ORD_CONF"));    
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);		              
			} else if("2".equals(strGJdateType)){			// 납품예정일
				sql.put(svc.getQuery("SEL_DELI_DT"));
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);			
			} else if("3".equals(strGJdateType)){			// 검품확정일
				sql.put(svc.getQuery("SEL_CHK_DT"));
				sql.setString(i++, strStartDt);
				sql.setString(i++, strEndDt);		
			}
			sql.put(slipFlagList);		//전표구분
			sql.put(svc.getQuery("SEL_ORDERBY"));  
			sql.setString(i++, strStrCd);				
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
	 * 규격단품 매입발주  상세 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getDetail(ActionForm form) throws Exception {
		
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd   = String2.nvl(form.getParam("strStrCd"));			// 점
		String strSlipNo  = String2.nvl(form.getParam("strSlipNo"));		// 대입전표번호

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		
		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.put(strQuery); 
		ret[0] = select2List(sql);

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		
		ret[1] = select2List(sql);

		return ret;
	}
	/**
	 * 규격단품 대출입발주  상세 내역 조회                                                                       
	 * 
	 * @param form                     
	 * @return
	 * @throws Exception
	 */
	public List[] getDetail1(ActionForm form) throws Exception {
		
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		try{
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));			// 점
		String strSlipNo   = String2.nvl(form.getParam("strSlipNo"));		// 대입전표번호
		String strPSlipNo  = String2.nvl(form.getParam("strPSlipNo"));		// 대출전표번호
		String strSlipFlag = String2.nvl(form.getParam("strSlipFlag"));		// 대출전표번호

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[3];
		
		connect("pot");

		sql.setString(i++, strStrCd);
		if("C".equals(strSlipFlag))
			sql.setString(i++, strSlipNo);
		else
			sql.setString(i++, strPSlipNo);
		
		strQuery = svc.getQuery("SEL_MASTER1") + "\n";
		sql.put(strQuery); 
		ret[0] = select2List(sql);

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL1") + "\n";
		sql.put(strQuery);   
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo); 
		ret[1] = select2List(sql);                                       

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL1") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strPSlipNo);
		ret[2] = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return ret;
	}
	/**
	 * 의류단품 점출입발주  상세 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getDetail3(ActionForm form) throws Exception {
		
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strSlipFlag= String2.nvl(form.getParam("strSlipFlag"));		// 점출점
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));			// 점출점
		// String strPStrCd  = String2.nvl(form.getParam("strPStrCd"));	  // 접입점
		String strSlipNo  = String2.nvl(form.getParam("strSlipNo"));		// 점출전표번호
		// String strPSlipNo = String2.nvl(form.getParam("strPSlipNo"));	// 점입전표번호 */

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		
		connect("pot");
		// 1. 마스터
		if("E".equals(strSlipFlag))
			sql.setString(i++, strStrCd);
				
		sql.setString(i++, strSlipNo);
		strQuery = svc.getQuery("SEL_MASTER3") + "\n";
		sql.put(strQuery);
		ret[0] = select2List(sql);

		sql.close();
		i= 1;
		// 3. 점출상세
		strQuery = svc.getQuery("SEL_DETAIL3") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);            
		ret[1] = select2List(sql);
		
		return ret;
	}
	
	/**
	 * 의류단품 매가인상하  상세 내역 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getDetail4(ActionForm form) throws Exception {
		
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd   = String2.nvl(form.getParam("strStrCd"));			// 점
		String strSlipNo  = String2.nvl(form.getParam("strSlipNo"));		// 대입전표번호

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		
		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		strQuery = svc.getQuery("SEL_MASTER4") + "\n";
		sql.put(strQuery); 
		ret[0] = select2List(sql);

		sql.close();
		i= 1;
		strQuery = svc.getQuery("SEL_DETAIL4") + "\n";
		sql.put(strQuery);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		
		ret[1] = select2List(sql);

		return ret;
	}
	
	/**
	 * INVOICE 등록  마스터 내역 조회
	 *  
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster5(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSlipNo = String2.nvl(form.getParam("strSlipNo"));
				
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		sql.setString(i++, strStrCd);      
		sql.setString(i++, strSlipNo);     
		
		strQuery = svc.getQuery("SEL_MASTER5") + "\n";  

		sql.put(strQuery);
		ret = select2List(sql); 
		return ret;
	} 
	
	/**  
	 * INVOICE 등록  상세 내역 조회
	 * 
	 * @param form
	 * @return 
	 * @throws Exception
	 */
	public List getDetail5(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = ""; 
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strInvoiceYm = String2.nvl(form.getParam("strInvoiceYm"));
		String strInvoiceSeqNo = String2.nvl(form.getParam("strInvoiceSeqNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);     
		sql.setString(i++, strInvoiceYm);     
		sql.setString(i++, strInvoiceSeqNo);  
		strQuery = svc.getQuery("SEL_DETAIL5") + "\n";

		sql.put(strQuery);

//		System.out.println("Why?");
		ret = select2List(sql);
//		System.out.println("ret.size() " + ret.size());

		return ret;
	}
	/**
	*  단품전표를  SM확정한다
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
		
	    String strSlipProcStat  = "";		// 전표flag
		String strConfStat = "";            // 확정 및 확정취소 전표상태
		String strSlipFlag = ""; 
		String strPStrCd = ""; 
		String strPSlipNo = ""; 
		String strBizType = ""; 
		
		String strStrCd = "";
		String strSlipNo = "";
		String stConfSlipProcStat = "";
		String sendFlag = "";
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			strSlipProcStat = form.getParam("strSlipProcStat");		// 바이어,SM 여부
			strSlipFlag = form.getParam("strSlipFlag");			
			strBizType = form.getParam("strBizType");
			
			strStrCd = form.getParam("strStrCd");
			strSlipNo = form.getParam("strSlipNo");
			sendFlag = form.getParam("sendFlag");	
			
			sql.close();		 
		 
			if("06".equals(strSlipProcStat)){
				sql.put(svc.getQuery("UPD_MASTER_CONF1"));
				sql.setString(1, "        ");
				sql.setString(2, null);
				sql.setString(3, "        ");
				sql.setString(4, null);
				sql.setString(5, "        ");
				sql.setString(6, null);  
				sql.setString(7, "        ");
				sql.setString(8, null);
				sql.setString(9, "        ");
				sql.setString(10, null);
				sql.setString(11, "00"); 

				sql.setString(12, "06"); 
				sql.setString(13, "        "); 
				
				sql.setString(14, userId);
				sql.setString(15, form.getParam("strStrCd"));
				sql.setString(16, form.getParam("strSlipNo"));
				strConfStat = "00";
			}else{
				sql.put(svc.getQuery("UPD_MASTER_CONF"));
				sql.setString(1, form.getParam("strToday"));
				sql.setString(2, userId);
				sql.setString(3, "06");  		
				
				sql.setString(4, form.getParam("strBizType"));  
				sql.setString(5, form.getParam("strSlipFlag"));  
				sql.setString(6, form.getParam("strToday")); 
				
				sql.setString(7, userId);
				sql.setString(8, form.getParam("strStrCd"));
				sql.setString(9, form.getParam("strSlipNo"));
				strConfStat = "06";
		    }  
			res = update(sql);
			sql.close();
			
			sql.put(svc.getQuery("UPD_SLPMSTLG_CONF")); 
			sql.setString(1, strConfStat);  
			sql.setString(2, form.getParam("strStrCd"));
			sql.setString(3, form.getParam("strSlipNo"));
			res = update(sql); 

			/*
			if("0".equals(sendFlag)){		//승인
				stConfSlipProcStat = "06";
			}else{
				stConfSlipProcStat = strOrgSlipProcStat;
			}
			*/
			
			stConfSlipProcStat = "06";
			
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
			
			if("C".equals(strSlipFlag)|| "E".equals(strSlipFlag) ){ 
				sql.close();
			    if("06".equals(strSlipProcStat)){
			       sql.put(svc.getQuery("UPD_MASTER_CONF1"));
			       sql.setString(1, "        ");
				   sql.setString(2, null);
				   sql.setString(3, "        ");
				   sql.setString(4, null);
				   sql.setString(5, "        ");
				   sql.setString(6, null);			   
				   sql.setString(7, "        ");
				   sql.setString(8, null);
				   sql.setString(9, "        ");
				   sql.setString(10, null);
				   sql.setString(11, "00"); 

				   sql.setString(12, "06"); 
				   sql.setString(13, "        "); 
				   
				   sql.setString(14, userId);
				   sql.setString(15, form.getParam("strPStrCd"));
				   sql.setString(16, form.getParam("strPSlipNo"));
				   strConfStat = "00";
			    }else{
				   sql.put(svc.getQuery("UPD_MASTER_CONF"));
				   sql.setString(1, form.getParam("strToday"));
				   sql.setString(2, userId);
				   sql.setString(3, "06"); 

					sql.setString(4, form.getParam("strBizType"));  
					sql.setString(5, form.getParam("strSlipFlag"));  
					sql.setString(6, form.getParam("strToday")); 
					
				   sql.setString(7, userId);
				   sql.setString(8, form.getParam("strPStrCd"));
				   sql.setString(9, form.getParam("strPSlipNo"));
				   strConfStat = "06";
		        } 
		        res = update(sql);
		    
		        sql.close();
			    sql.put(svc.getQuery("UPD_SLPMSTLG_CONF")); 
			
			    sql.setString(1, strConfStat);  
			    sql.setString(2, form.getParam("strPStrCd"));
			    sql.setString(3, form.getParam("strPSlipNo"));
			    res = update(sql); 
			}
			
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
