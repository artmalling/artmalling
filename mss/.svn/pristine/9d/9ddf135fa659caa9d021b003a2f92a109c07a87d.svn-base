/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mpro.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import common.util.Util;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MPro106DAO extends AbstractDAO {
	 
	public List getMaster(ActionForm form) throws Exception {

        List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;
        Util util = new Util();
        
        try {
            
        	connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0;

            String strStrCd		= String2.nvl(form.getParam("strCd"));	//점 코드
            String strSchFlag	= String2.nvl(form.getParam("strSchFlag"));	//조회구분
            String sDate	= String2.nvl(form.getParam("sDate"));	//기간(From)
            String eDate	= String2.nvl(form.getParam("eDate"));	//기간(To)
            String custNm	= URLDecoder.decode(String2.nvl(form.getParam("custNm")), "UTF-8");	//고객명            
            String promType	= String2.nvl(form.getParam("promType"));//약속유형

            if (strSchFlag.equals("01")) {			//접수일자
            	sql.put(svc.getQuery("SEL_TAKE_DT"));
            } else if (strSchFlag.equals("02")) {	//입고예정일
            	sql.put(svc.getQuery("SEL_IN_DELI_DT"));
            } else {								//약속일자
            	sql.put(svc.getQuery("SEL_FRST_PROM_DT"));
            }
            
            sql.setString(++i, promType);              
            sql.setString(++i, custNm);
            sql.setString(++i, strStrCd);        
            sql.setString(++i, sDate);   
            sql.setString(++i, eDate);   
             
            list = select2List(sql); 
            
          /*list = util.decryptedStr(list, 12);
            list = util.decryptedStr(list, 13);
            list = util.decryptedStr(list, 14);*/
            

        } catch (Exception e) {
            throw e;
        }
        return list;
    }
	
	/**
	 * <p>해피콜 관리/ 해피콜 상세 조회</p>
	 * 
	 * @created  on 1.0, 2010/12/14
	 * @created  by 정지인(FUJITSU KOREA LTD.)
	 * 
	 * @modified on 
	 * @modified by 
	 * @caused   by 
	 */
	
	
	public List getDetail(ActionForm form) throws Exception {

        List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;
        Util util = new Util();
        
        try {
        	connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0;
            String strTakeSeq		= String2.nvl(form.getParam("takeSeq"));	//접수순번
            String strCd         	= String2.nvl(form.getParam("strCd"));	//점코드
            String takeDt	        = String2.nvl(form.getParam("takeDt"));	//통화일자
            
            sql.put(svc.getQuery("SEL_HAPPYCALLMRG"));
            sql.setString(++i, strTakeSeq);
            sql.setString(++i, strCd);        
            sql.setString(++i, takeDt);        
            
            
            list = select2List(sql); 
           
        } catch (Exception e) {
            throw e;
        }
        return list;
    }
	
	/**
	 * <p>해피콜 관리/ 해피콜 상세 조회</p>
	 *  수정, 등록
	 * @created  on 1.0, 2010/12/14
	 * @created  by 정지인(FUJITSU KOREA LTD.)
	 * 
	 * @modified on 
	 * @modified by 
	 * @caused   by 
	 */
	
	public int save(ActionForm form, MultiInput mi, String userID)
    throws Exception {
        int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc = null;
        
        try {
            connect("pot");
            begin(); //DB트렌젝션 시작
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            
            String strTakeDt    = String2.nvl(form.getParam("strTakeDt"));	//접수일접수
            String strTakeSeq	= String2.nvl(form.getParam("strTakeSeq"));	//접수SEQ
            String strCd	= String2.nvl(form.getParam("strCd"));	//점 코드
            
            while (mi.next()) {  	
            
                if (mi.IS_INSERT()) {
            
                	int i = 0;
                	
					sql.put(svc.getQuery("SEL_SEQNO"));
					sql.setString(1, mi.getString("EM_CALL_DT"));
					Map mapSlipNo = (Map)selectMap(sql);
					mi.setString("CALLSEQ_NO", mapSlipNo.get("SEQ_NO").toString());
					sql.close();
                	
                	String strCallTime = String2.nvl(mi.getString("CALL_HH").toString()) + String2.nvl(mi.getString("CALL_MM").toString()); 
                	
                    sql.put(svc.getQuery("INT_CALLHAPPYMRG"));                    
                    
                    sql.setString(++i, mi.getString("CALLSEQ_NO"));
                    sql.setString(++i, mi.getString("EM_CALL_DT"));
                    sql.setString(++i, strTakeDt);
                    sql.setString(++i, strCd);
                    sql.setString(++i, strTakeSeq);
                    sql.setString(++i, strCallTime);
                    sql.setString(++i, mi.getString("EM_SEND_NM"));
                    sql.setString(++i, mi.getString("RECV_NM"));                    
                    sql.setString(++i, mi.getString("CALL_DESC"));
                    sql.setString(++i, mi.getString("RESERCH_ITEM"));
                    sql.setString(++i, mi.getString("RESERCH_SERVICE"));
                    sql.setString(++i, userID);
            
                   
                    res += update(sql);
                    sql.close();
                } else if (mi.IS_UPDATE()){
                   
                	
                	sql.put(svc.getQuery("UPD_CALLHAPPYMRG"));
                	
                	sql.setString(1, mi.getString("EM_SEND_NM"));
                	sql.setString(2, mi.getString("RECV_NM"));                	
                	sql.setString(3, mi.getString("CALL_DESC"));
                	sql.setString(4, mi.getString("RESERCH_ITEM"));
                	sql.setString(5, mi.getString("RESERCH_SERVICE"));
                	sql.setString(6, userID);
                	sql.setString(7, mi.getString("CALL_SEQ_NO"));
                	sql.setString(8, mi.getString("EM_CALL_DT"));
                	
                	res += update(sql);
                	sql.close();
                }
                
                if (res < 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}

                
            }

        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return res;
    }
	
	/**
	 * <p>해피콜 관리</p>
	 *  삭제
	 * @created  on 1.0, 2010/12/14
	 * @created  by 정지인(FUJITSU KOREA LTD.)
	 * 
	 * @modified on 
	 * @modified by 
	 * @caused   by 
	 */
	public int delete(ActionForm form, MultiInput mi)
	throws Exception {
		
		
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
		
			String strCalDt = String2.nvl(form.getParam("strCalDt"));
			String strSeqNo = String2.nvl(form.getParam("strSeqNo"));
			
			sql.close();
			
			sql.put(svc.getQuery("DEL_CALLHAPPYMRG")); //삭제
			sql.setString(1, strSeqNo);			
			sql.setString(2, strCalDt);
						
			res = update(sql);	
		
			if (res  < 1) {
				throw new Exception("" + "데이터의 적합성 문제로 인하여"
						+ "데이터 삭제를 하지 못했습니다.");
			}
		
			
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		
		return res;
	}
	

}
