/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dctm.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/03/30
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * @caused   by 데이터변경이력조회
 * 
 * @modified on 
 * @modified by 
 */

public class DCtm435DAO extends AbstractDAO {
	/**
     * <p>데이터조회 이력 조회</p>
     * 
     */        
    public List searchMaster(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 0;
        Util util = new Util();
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");
        
        String strS_DT = String2.nvl(form.getParam("strS_DT"));
        String strE_DT = String2.nvl(form.getParam("strE_DT"));
        System.out.println(strS_DT);
        System.out.println(strE_DT);
        
        strQuery = svc.getQuery("SEL_MASTER") + "\n"; 
        
        sql.setString(++i, strS_DT);
        sql.setString(++i, strE_DT);
        
        sql.put(strQuery);
        ret = select2List(sql);
        System.out.println("333");
        return ret;
    }
    
    public List searchdetail(ActionForm form, MultiInput mi, HttpServletRequest request) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String  SEQ		= String2.nvl(form.getParam("strseq"));			

		
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		try{
			strQuery = svc.getQuery("SEL_DETAIL") + "\n";
				
			sql.setString(i++, SEQ);
				
			sql.put(strQuery);
			
			ret = select2List(sql);
			
			
		}catch(Exception e){
			e.printStackTrace();
		}

		return ret;
	}
    
    /**
	 * 수정  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param userId
	 * @return
	 * @throws Exception
	 */
    public int save(ActionForm form, MultiInput mi1,String userId, String org_flag)
	throws Exception {
		int ret 	= 0;
		int res 	= 0;
		int i   	= 1; 
		String strQuery = "";
		
		SqlWrapper sql = null;
		Service svc = null;
		Util util = new Util();
		
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			// 마스터
			
			while (mi1.next()) {
				sql.close();
				if (mi1.IS_INSERT()) { // 저장
					i = 1;	
					sql.put(svc.getQuery("INS_MASTER"));
				     
					sql.setString(i++, mi1.getString("GUBUN"));     
					sql.setString(i++, mi1.getString("SEND_DT"));
					sql.setString(i++, mi1.getString("TITLE"));
					sql.setString(i++, mi1.getString("CONTENTS"));       
					sql.setString(i++, mi1.getString("STAT_FLAG"));
					sql.setString(i++, userId);       
						
						
					
				}else if(mi1.IS_UPDATE()){// 수정 
					i = 1;
					// 1. 마스터테이블에 수정
					System.out.println("1");
					sql.put(svc.getQuery("UPD_MASTER")); 
					sql.setString(i++, mi1.getString("GUBUN"));
					sql.setString(i++, mi1.getString("SEND_DT"));
					sql.setString(i++, mi1.getString("TITLE"));
					sql.setString(i++, mi1.getString("CONTENTS"));
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("SEQ"));								
					
										
		
				}else if (mi1.IS_DELETE()) { // 삭제 
					i = 1;  
					// 1. 마스터테이블에 저장
					
					sql.put(svc.getQuery("DEL_MASTER")); 
					sql.setString(i++, mi1.getString("SEQ"));
					
				}
				res = update(sql);
		
				if (res <= 0) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				} 
				
				ret += res;
			}
		} catch (Exception e) { 
			e.printStackTrace();
		} finally { 
			end();
		}
		return ret;
	}
	
	public int savedetail(ActionForm form, MultiInput mi1,String userId, String org_flag)
			throws Exception {
				int ret 	= 0;
				int res 	= 0;
				int i   	= 1; 
				String strQuery = "";
				
				SqlWrapper sql = null;
				Service svc = null;
				Util util = new Util();
				
				System.out.println(mi1.getRowNum());
				try {
					connect("pot");
					begin();
					sql = new SqlWrapper();
					svc = (Service) form.getService();
					// 마스터
					
					while (mi1.next()) {
						sql.close();
						if (mi1.IS_INSERT()) { // 저장
							i = 1;							
							sql.put(svc.getQuery("INS_DETAIL"));
								
							sql.setString(i++, mi1.getString("SEQ"));
							sql.setString(i++, mi1.getString("SEQ"));
							sql.setString(i++, mi1.getString("SEQ_NO"));
							sql.setString(i++, mi1.getString("EMAIL"));
							sql.setString(i++, userId);       
								
								
							
						}else if(mi1.IS_UPDATE()){// 수정 
							i = 1;
							// 1. 마스터테이블에 수정
							
							sql.put(svc.getQuery("UPD_DETAIL")); 
								
							sql.setString(i++, mi1.getString("EMAIL"));					
							sql.setString(i++, userId);
							sql.setString(i++, mi1.getString("SEQ"));
							sql.setString(i++, mi1.getString("SEQ_NO"));
																			
				
						}else if (mi1.IS_DELETE()) { // 삭제 
							i = 1;  
							// 1. 마스터테이블에 저장
							
							sql.put(svc.getQuery("DEL_DETAIL")); 
							
							
							sql.setString(i++, mi1.getString("SEQ"));
							sql.setString(i++, mi1.getString("SEQ_NO"));
							
						}
						res = update(sql);
						
						//if (res <= 0) {
						//	throw new Exception("" + "데이터의 적합성 문제로 인하여"
						///			+ "데이터 입력을 하지 못했습니다.");
						//} 
						
						//ret += res;
					}
				} catch (Exception e) { 
					//e.printStackTrace();
				} finally { 
					end();
				}
				return ret;
			}
	
	public int delete(ActionForm form, MultiInput mi1,String userId, String org_flag)
	throws Exception {
		int ret 	= 0;
		int res 	= 0;
		int i   	= 1; 
		String strQuery = "";
		
		SqlWrapper sql = null;
		Service svc = null;
		Util util = new Util();
		
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			// 마스터
			while (mi1.next()) {
				//sql.close();
				if (mi1.IS_DELETE()) { // 삭제 
					i = 1;  
					// 1. 마스터테이블에 저장
					
					sql.put(svc.getQuery("DEL_MASTER"));
					
					sql.setString(i++, mi1.getString("SEQ"));
					//sql.setString(i++, util.encryptedStr(mi1.getString("RESI_NO")));
				}
				res = update(sql);
		
				if (res <= 0) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				} 
				
				ret += res;
			}
		} catch (Exception e) { 
			e.printStackTrace();
		} finally { 
			end();
		}
		return ret;
	}
	
	
	public int send(ActionForm form)
			throws Exception {
		
		List ret          = null;
		SqlWrapper sql    = null;
		Service svc       = null;
		String strLoc     = null;
		int i             = 1;
		int resp    		= 0;     //프로시저 리턴값
		String res			= "";
		//파라미터 변수선언
		String strStoreCd = null;
		String strStartDt = null;
		String strPosNo   = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함
		String strSEQ 		= String2.nvl(form.getParam("strSEQ"));
		
		try {
			
			connect("pot");
			begin();
			
			sql    = new SqlWrapper();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			
			psql.put("DCS.PR_SEND_MAIL", 1);
			psql.setString(i++, strSEQ);
			
			
			
			prs = updateProcedure(psql);
			
			
            
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return resp;
		
	}
}
