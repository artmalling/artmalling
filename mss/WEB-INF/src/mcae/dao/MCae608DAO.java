/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Hashtable;
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


import common.util.Util;
import common.vo.SessionInfo;

/**
 * <p>OKCASHBAG상품권 교환</p>
 * 
 * @created  on 1.0, 2010/03/02
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class MCae608DAO extends AbstractDAO {

    /**
     * 상품권 교환 정보를  저장, 수정 처리한다.
     * 
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
    public int save(ActionForm form, MultiInput mi[], HttpServletRequest request) throws Exception {
		int 	   ret   = 0;
		MultiInput mi1   = mi[0];
		MultiInput mi2   = mi[1];
    	SqlWrapper sql   = null;
        Service    svc   = null;
        
        

        
        int result = 0;
        String retMsg = "";
        int intConvPoint = 0;
        int intConvGiftAmt = 0;
        		
        String strCardNo = form.getParam("strCardNo"); // 카드번호

        
        try {
        	
        	sql  = new SqlWrapper();
            svc  = (Service)form.getService();
            connect("pot");
			begin();
            
            mi2.next();
            
            intConvPoint 	= Integer.parseInt(mi2.getString("CONV_POINT"));
            intConvGiftAmt 	= Integer.parseInt(mi2.getString("CONV_GIFT_AMT"));
            
            
            ret = this.saveData(form, mi, request, "","");
            
            if(ret > 0){
				retMsg = this.proCall(form, mi, request);
			} else {
                throw new Exception("[USER]"+"시스템 장애가 발생하였습니다. 에러코드 [9999]");
            }

		} catch (Exception e) {
			//
			// 에러 발생시 포인트 사용 취소 전문 전송한다.
			// OCBNet 전송을 위한 맵핑

			
			rollback();
			throw e;
		} finally {
			end();
		}
		
        return ret;
	}
    
    /**
     * 상품권 교환 정보를  저장, 수정 처리한다.
     * 
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
    public int saveData(ActionForm form, MultiInput mi[], HttpServletRequest request, String Authdate, String UniqNum) throws Exception {
		int 	   ret   = 0;
        SqlWrapper sql   = null;
        Service    svc   = null;
		MultiInput mi2   = mi[1];  
        
        try {

            svc  = (Service)form.getService();
            String strQuery = "";
            sql  = new SqlWrapper();
			int res = 0;
		    	
	    	HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");

            sql.put(svc.getQuery("GET_SQ_GIFTCD"));  //상품권SEQ
            Map map = selectMap(sql);
            mi2.setInt("SEQ_NO", Integer.parseInt(map.get("SQ_GIFTCD").toString()));

            sql.close();     
            
            
            
            sql  = new SqlWrapper();
			int i=1;
			sql.put(svc.getQuery("INS_GIFTCD"));
            //sql.setString(i++, util.encryptedStr(mi2.getString("CARD_NO")));
            sql.setString(i++, mi2.getString("CARD_NO"));
            sql.setString(i++, String.valueOf(Integer.parseInt(mi2.getString("SEQ_NO"))));
	    	sql.setString(i++, String.valueOf(Integer.parseInt(mi2.getString("CONV_POINT"))));
	    	sql.setString(i++, String.valueOf(Integer.parseInt(mi2.getString("CONV_GIFT_AMT"))));
	    	sql.setString(i++, sessionInfo.getBRCH_ID());
	    	sql.setString(i++, sessionInfo.getUSER_ID());
	    	sql.setString(i++, "");	// 수신일시
	    	sql.setString(i++, "");	// 전문일련번호
	    	
	    	res = update(sql);
	    	
	    	if ( res != 1 ) {
	    		throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                        + "데이터 입력을 하지 못했습니다.");
	    	}
	    	
	    	ret += res;
	    	
		} catch (Exception e) {
			throw e;
		} finally {
		}
		
        return ret;
	}	
    
    
    /**
     * <p>상품권 교환  - 프로시져 콜</p>
     * 
     */
    public String proCall(ActionForm form, MultiInput mi[], HttpServletRequest request) throws Exception {
        ProcedureWrapper psql = null;
        SqlWrapper sql        = null;
        Service svc           = null;
        Util util             = new Util();
        int ret = 0;
        int res = 0;
        String retMsg = "";
        
		MultiInput mi1       = mi[0];
		MultiInput mi2       = mi[1];
		
        try {

            psql = new ProcedureWrapper();
            sql  = new SqlWrapper();
            svc = (Service) form.getService();
            
            ProcedureResultSet prs = null;
            
			HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
            
            // 전표번호생성
            Map map = this.getSaleSlipNo(form);
            
            mi2.next();          
            mi2.setString("SALE_SLIP_NO", map.get("SALE_SLIP_NO").toString());               
            System.out.println("11111111111111");
            while (mi1.next()) {
                psql.close();
                sql.close();
                
                int i=1;
                int j=1;
                /*
                psql.put("MSS.PR_MGPOSTRCREATE", 10); 
                psql.setString(i++, sessionInfo.getSTR_CD());         //1:점
                psql.setString(i++, mi1.getString("PROC_DT"));        //2:일자
                psql.setString(i++, util.jLpad(mi2.getString("SALE_SLIP_NO") ,  6));   //3:전표번호 ==> 시퀀스 오브젝트(MSS.SQ_MG_SALEMST)6자리 0으로
                psql.setString(i++, sessionInfo.getDEPT_CD());        //4:판매부서
                //psql.setString(i++, "04");                            //5:판매구분04:카드포인트판매
                psql.setString(i++, "05");                            //5:판매구분05:OKCASHBAG판매
                psql.setString(i++, mi1.getString("GIFTCARD_NO"));    //6:상품권번호
                psql.setString(i++, "1");                             //7:판매수량
                psql.setString(i++, sessionInfo.getUSER_ID());        //8:세션정보 사용자ID
                
                psql.registerOutParameter(i++, DataTypes.VARCHAR);    //9
                psql.registerOutParameter(i++, DataTypes.VARCHAR);    //10
                prs = updateProcedure(psql);
                
                retMsg = prs.getString(9);   
                
		        if(!retMsg.equals("0")){
		        	 throw new Exception("[USER]"+prs.getString(10));	
		        }
				*/
                // 상품권 번호 상세 저장
    		    sql.put(svc.getQuery("INS_GIFTCD_DTL"));
    		    //sql.setString(j++,  util.encryptedStr(mi2.getString("CARD_NO")));
    		    sql.setString(j++,  mi2.getString("CARD_NO"));
    		    sql.setString(j++,  mi2.getString("SEQ_NO"));
    		    sql.setString(j++,  mi1.getString("GIFTCARD_NO"));
    		    sql.setString(j++,  "Y");
    		     
    		    res = update(sql);
		    }
            System.out.println("2222222222222222");
            
            
            	sql.close();
            	int j=1;
            	System.out.println(j);
                /** 포인트 전환내역 저장**/
    		    sql.put(svc.getQuery("INS_GIFTCD_CONV"));
    		    //sql.setString(j++,  util.encryptedStr(mi2.getString("CARD_NO")));
    		    sql.setString(j++,  mi2.getString("CARD_NO"));
    		    sql.setString(j++,  mi2.getString("SEQ_NO"));
    		    sql.setString(j++,  "0");
    		    sql.setString(j++,  "1");
    		    sql.setString(j++,  mi2.getString("CONV_GIFT_AMT"));
    		    sql.setString(j++,  sessionInfo.getBRCH_ID());
    		     
    		    res = update(sql);             	
            
            System.out.println("3333333333333");
            ret = mi2.getRowNum();  
        } catch (Exception e) {
            throw e;
        } finally {
        }
        return retMsg;
    }

    /**
     * <p>상품권 교환  마스터, 상품권 교환기준 마스터 조회</p>
     * 
     */
    public List[] searchMaster(ActionForm form) throws Exception {
    	List ret[] 		= null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery  = "";
        
        String strCardNo = String2.nvl(form.getParam("strCardNo"));
        System.out.println(strCardNo);
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
        
        try{       
	        connect("pot");
	        System.out.println("11111");
	        strQuery = svc.getQuery("SEL_MASTER"); 
	        sql.put(strQuery);
	        sql.setString(1,strCardNo);
			ret[0] = select2List(sql);     
			sql.close();
			System.out.println("222222");
			strQuery = svc.getQuery("SEL_CUSTINFO"); 
	        sql.put(strQuery);
	        sql.setString(1,"P");
	        sql.setString(2,strCardNo);
			ret[1] = select2List(sql);     
			sql.close();
			
			
		}catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
    
    /**
     * <p>상품권 교환  금액 조회</p>
     * 
     */
	public List searchAmt(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strGiftCardNo   = String2.nvl(form.getParam("strGiftCardNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strGiftCardNo);

		strQuery = svc.getQuery("SEL_AMT") + "\n";

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}    

	/**
	 * <p>전문번호 생성 조회</p>
	 * 
	 */
	public Map getOCBTranNo(ActionForm form) throws Exception {
		SqlWrapper sql = null;
		Service svc = null;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
		sql.put(svc.getQuery("GET_OCB_TRAN_NO"));  //전문번호생성
		
		return selectMap(sql);
	}

	/**
	 * <p>전표번호 생성 조회</p>
	 * 
	 */
	private Map getSaleSlipNo(ActionForm form) throws Exception {
		SqlWrapper sql = null;
		Service svc = null;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		connect("pot");
		
    	sql.put(svc.getQuery("GET_SALE_SLIP_NO"));  //전문번호생성
		
		return selectMap(sql);
	}

}
