/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmbo.dao;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession; 

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>전자쿠폰발급</p>
 * 
 * @created  on 1.0, 2010/03/08
 * @created  by 장형욱
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo404DAO extends AbstractDAO {
	
	/**
     * <p>전자쿠폰  정보를 조회한다</p>
     * 
     */        
    public List searchMaster(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
               
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        
        String strStrCd      = String2.nvl(form.getParam("strStrCd"));
        String strCustId      = String2.nvl(form.getParam("strCustId"));
        String strSdt          = String2.nvl(form.getParam("strSdt"));
        String strEdt          = String2.nvl(form.getParam("strEdt")); 
        String strJehuOnlyYn      = String2.nvl(form.getParam("strJehuOnlyYn"));
        
        sql.setString(i++, strStrCd);        
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n";
        
        if( !strCustId.equals("")){
			sql.setString(i++, strCustId);
			strQuery += svc.getQuery("SEL_MASTER_WHERE_CUST_ID") + "\n";
		}
        if( !strSdt.equals("")){
			sql.setString(i++, strSdt);
			strQuery += svc.getQuery("SEL_MASTER_WHERE_START_DT") + "\n";
		}
        if( !strEdt.equals("")){
			sql.setString(i++, strEdt);
			strQuery += svc.getQuery("SEL_MASTER_WHERE_END_DT") + "\n";
		}
        if( !strJehuOnlyYn.equals("%")){
			sql.setString(i++, strJehuOnlyYn);
			strQuery += svc.getQuery("SEL_MASTER_WHERE_JEHU_ONLY_YN") + "\n";
		}
        
        strQuery += svc.getQuery("SEL_MASTER_ORDER");
        
        sql.put(strQuery); 
        ret = select2List(sql);
        
        return ret;
    }	
    
    /**
     * <p></p>
     * 
     */
    public List searchDetail(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        String     strQuery = "";
        int i = 1;
        
        String strProcDt  = String2.nvl(form.getParam("strProcDt"));
        String strBrchId  = String2.nvl(form.getParam("strBrchId"));
        
        String strCardNo  = String2.nvl(form.getParam("strCardNo"));
//        System.out.println("1:"+ strCardNo);
//        System.out.println("2:"+ URLDecoder.decode(strCardNo, "utf-8"));
        int strSeqNo      = Integer.parseInt(String2.nvl(form.getParam("strSeqNo")));        

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strProcDt);
        sql.setString(i++, strBrchId);
//        sql.setString(i++, strCardNo);
        sql.setInt(i++, strSeqNo);        
        
        strQuery = svc.getQuery("searchDetail"); // + "\n";
        
        sql.put(strQuery);
        ret = select2List(sql);
        
        
        return ret;
    }    
    
	/**
	 * <p>전자쿠폰발급Update</p>
	 * 
	 * @created  on 1.0, 2010/01/25
	 * @created  by 장형욱
	 * 
	 * @modified on 
	 * @modified by 
	 * @caused   by 
	 */
	
	public int save(ActionForm form, MultiInput mi, String UserId) throws Exception {
		int ret = 0;
		int res = 0;		
		SqlWrapper sql = null;
		Service svc = null;	
		String orgCdCnt = "";
		String strQuery = "";
		int i;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi.next()) {
				sql.close();
				
				if (mi.IS_UPDATE()) {
					i = 0;	
					String strDcRate       = null;
					String strDcAmt        = null;
					
					sql.put(svc.getQuery("UPD_E_COUPON"));	
										
					sql.setString(++i, mi.getString("CPN_NM"));
					sql.setString(++i, mi.getString("APP_FLAG"));
					
					if(mi.getString("DC_RATE").equals("0")){                // DC율
						strDcRate = null;
						sql.setString(++i, strDcRate);
					}else{
						sql.setInt(++i, mi.getInt("DC_RATE"));
					}
					if(mi.getString("DC_AMT").equals("0")){					// 금액
						strDcAmt = null;
						sql.setString(++i, strDcAmt);
					}else{
						sql.setInt(++i, mi.getInt("DC_AMT"));
					}
					sql.setString(++i, mi.getString("START_DT"));
					sql.setString(++i, mi.getString("END_DT"));
					sql.setString(++i, mi.getString("JEHU_ONLY_YN"));
					sql.setString(++i, mi.getString("CPN_TYPE"));
					sql.setString(++i, UserId);					
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("CUST_ID"));
					sql.setString(++i, mi.getString("CPN_ID"));
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
	 * <p>전자쿠폰발급 신규</p>
	 * 
	 * @created  on 1.0, 2010/01/25
	 * @created  by 장형욱
	 * 
	 * @modified on 
	 * @modified by 
	 * @caused   by 
	 */
	
	public int saveIssue(ActionForm form, MultiInput mi, String userId, String brchId) throws Exception {
		int resp    		= 0;     //프로시저 리턴값
		int i   			= 0;
		String strSysDate 	= "";    // DB날짜 가져오기
		
		SqlWrapper sql        = null;
		Service svc           = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함
		try {
	
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			
			// 현재날짜시간 구하기
			//sql.put(svc.getQuery("SEL_SYSDATE"));    
			//Map mapSysDate = (Map)selectMap(sql);
			//strSysDate = mapSysDate.get("TODAY").toString();

			// 마스터
			while (mi.next()) {
				if(mi.IS_INSERT()){// 저장
					String strCustGrade    = null;
					String strPocardPreFix = null;
					String strDcRate       = null;
					String strDcAmt        = null;
					String strIssuePath    = "02";
					
					if(!mi.getString("CUST_GRADE").equals("%")){
						strCustGrade = mi.getString("CUST_GRADE");
					}
					if(!mi.getString("POCARD_PREFIX").equals("%")){
						strPocardPreFix = mi.getString("POCARD_PREFIX");
					}	
					
					i = 1;            
					psql.put("DCS.PR_ISSUE_ECOUPON", 17);  
					
					psql.setString(i++, mi.getString("CUST_ID"));	 		// 회원ID					
			        psql.setString(i++, mi.getString("STR_CD"));       		// 점코드			        
			        psql.setString(i++, strCustGrade); 						// 회원등급			        
			        psql.setString(i++, strPocardPreFix); 					// 패밀리카드구분			        
			        psql.setString(i++, brchId);		                    // 가맹점번호			        
			        psql.setString(i++, mi.getString("APP_FLAG"));			// 적용방법			        
			        if(mi.getString("DC_RATE").equals("0")){                // DC율
						strDcRate = null;
						psql.setString(i++, strDcRate);
					}else{
						psql.setInt(i++, mi.getInt("DC_RATE"));
					}
					if(mi.getString("DC_AMT").equals("0")){					// 금액
						strDcAmt = null;
						psql.setString(i++, strDcAmt);
					}else{
						psql.setInt(i++, mi.getInt("DC_AMT"));
					}			        
			        psql.setString(i++, mi.getString("CPN_TYPE"));			// 전자쿠폰종류			        
			        psql.setString(i++, strIssuePath);						// 발급경로			        
			        psql.setInt(i++, mi.getInt("ISSUE_CNT"));				// 발급매수			        
			        psql.setString(i++, mi.getString("START_DT"));			// 적용시작일			        
			        psql.setString(i++, mi.getString("END_DT"));			// 적용종료일			        
			        psql.setString(i++, mi.getString("JEHU_ONLY_YN"));		// 제휴카드ONLY여부			        
			        psql.setString(i++, userId);							// 사용자ID			        
			            
			        psql.registerOutParameter(i++, DataTypes.INTEGER);//16
			        psql.registerOutParameter(i++, DataTypes.VARCHAR);//17

			        prs = updateProcedure(psql);
			        resp += prs.getInt(16);    
			        System.out.println(resp);
			        if (resp < 0) {
			            throw new Exception("[USER]"+ prs.getString(17));
			            }
					
				}
			}
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		
        return resp;
	}

}
