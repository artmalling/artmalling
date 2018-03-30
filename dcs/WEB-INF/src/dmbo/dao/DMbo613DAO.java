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
 * <p>포인트 강제적립 차감승인</p>
 * 
 * @created  on 1.0, 2010/03/08
 * @created  by 장형욱
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo613DAO extends AbstractDAO {
	
	/**
     * <p>포인트 강제 적립/차감 정보를 조회한다</p>
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
        
        String strSdt          = String2.nvl(form.getParam("strSdt"));
        String strEdt          = String2.nvl(form.getParam("strEdt")); 
        String strBrch_cd      = String2.nvl(form.getParam("strBrch_cd")); 
        String str_search_type = String2.nvl(form.getParam("str_search_type"));
        
        sql.setString(i++, strSdt);
        sql.setString(i++, strEdt);
        sql.setString(i++, strBrch_cd);
        
        strQuery = svc.getQuery("searchMaster") + "\n";
        
        if (!"0".equals(str_search_type)) {
            if ("1".equals(str_search_type))    // 활성
                strQuery += " AND A.CONF_DATE IS NULL -- 승인, NOT NULL 미승인 " + "\n";
            else if ("2".equals(str_search_type))    // 비활성
                strQuery += " AND A.CONF_DATE IS NOT NULL -- 승인,  미승인 " + "\n";
        } 
        
        strQuery += "ORDER BY A.PROC_DT" + "\n";
        
        sql.put(strQuery); 
        ret = select2List(sql);
        List itemList = new ArrayList();
        String item = "";
        for (int ii=0; ii<ret.size();ii++) {
        	itemList = (List) ret.get(ii);
        	for (int j=0; j<itemList.size(); j++) {
        		System.out.println("["+ j +"]:"+ (String) itemList.get(j));
        	}
        }
        return ret;
    }	
    
    /**
     * <p>포인트 강제 적립/차감 정보 상세 조회</p>
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
	 * 프로시져 호출
	 * @param form
	 * @param mi
	 * @return
	 */	
	public int sendData(String[] output) throws Exception{
		int ret  = 0;
		//int res  = 0;
		String res = "";
		int resp = 0;//프로시저 리턴값
		ProcedureWrapper psql = null;	//프로시저 사용위함
		SqlWrapper sql = null;
		int i = 0;
		try {
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			connect("pot");
			begin();
			
			sql = new SqlWrapper();	
			psql.put("DCS.PR_DMBO504", 63);    
			
			psql.setString(++i, output[ 0]);                 //전문 총길이
			psql.setString(++i, output[ 1]);                 //전문 구분
			psql.setString(++i, ""); //POS정보
			psql.setString(++i, output[ 3]);                 //거래구분코드
			psql.setString(++i, output[ 4]);                 //영업일자
			psql.setString(++i, output[ 5]);                 //거래시간
			psql.setString(++i, "");     //영수증번호
			psql.setString(++i, output[ 7]);                 //담당자사번
			psql.setString(++i, output[ 8]);                 //카드/주민번호구분
			psql.setString(++i, output[ 9]);                 //카드번호/주민번호
			psql.setString(++i, "");                     //비밀번호
			psql.setString(++i, output[11]);                 //가맹점ID 
			
			psql.setString(++i, output[12]);                 //결제수단코드1
			psql.setString(++i, "");                       //결제수단1상세
			psql.setDouble(++i, Integer.parseInt(output[14]));//결제수단금액1
			
			psql.setString(++i, "");                       //결제수단코드2
			psql.setString(++i, "");                       //결제수단2상세
			psql.setDouble(++i, 0);                  	   //결제수단금액2
			
			psql.setString(++i, "");                       //결제수단코드3
			psql.setString(++i, "");                       //결제수단3상세
			psql.setDouble(++i, 0);                  	   //결제수단금액3 
			
			psql.setString(++i, "");                       //결제수단코드4
			psql.setString(++i, "");                       //결제수단4상세
			psql.setDouble(++i, 0);                  	   //결제수단금액4

			psql.setString(++i, "");                       //결제수단코드5
			psql.setString(++i, "");                       //결제수단5상세
			psql.setDouble(++i, 0);                  	   //결제수단금액5

			psql.setString(++i, "");                       //결제수단코드6
			psql.setString(++i, "");                       //결제수단6상세
			psql.setDouble(++i, 0);                  	   //결제수단금액6

			psql.setString(++i, "");                       //결제수단코드7
			psql.setString(++i, "");                       //결제수단7상세
			psql.setDouble(++i, 0);                  	   //결제수단금액7

			psql.setString(++i, "");                       //결제수단코드8
			psql.setString(++i, "");                       //결제수단8상세
			psql.setDouble(++i, 0);                 	    //결제수단금액8

			psql.setDouble(++i, Integer.parseInt(output[36]));                 //결제수단건수
			psql.setDouble(++i, Integer.parseInt(output[37]));                //총거래금액
			
			psql.setDouble(++i, 0);                  //사용취소포인트
			psql.setString(++i, "");     			 //원거래영수증번호
			psql.setString(++i, "");         		 //원거래승인번호
			psql.setString(++i, output[41]);         //적립/사용구분
			
//			psql.setString(++i, "");                 //응답코드
//			psql.setString(++i, "");        		 //승인번호
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			
			psql.setString(++i, output[44]);         //성명
//			psql.setString(++i, "");                 //회원등급
//			psql.setString(++i, "");                 //시스템일자
//			psql.setString(++i, "");                 //시스템시간
			
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			
			
//			psql.setDouble(++i, 0);                  //누적포인트
//			psql.setDouble(++i, 0);                  //가용포인트
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			
//			psql.setString(++i, output[50]);         //금회포인트
//			psql.setDouble(++i, 0);                  //결제적립
//			psql.setString(++i, "");     			 //캠페인ID
//			psql.setDouble(++i, 0);                  //캠페인적립
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			
			
			psql.setString(++i, "");     		     //이벤트ID
			psql.setDouble(++i, 0);                  //이벤트적립
//			psql.setDouble(++i, 0);                  //기타적립
//			psql.setString(++i, ""); //영수증출력메시지1
//			psql.setString(++i, ""); //영수증출력메시지2


			psql.registerOutParameter(++i, DataTypes.INTEGER);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			
//			psql.setString(++i, ""); //회원ID
//			psql.setString(++i, "");           //공란
			 
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			
			psql.registerOutParameter(62, DataTypes.INTEGER);//8
			psql.registerOutParameter(63, DataTypes.VARCHAR);//9
		   	
		    prs = updateProcedure(psql);		            
		    System.out.println(prs.getInt(62));
			resp = prs.getInt(62);
			res = prs.getString(63);
						
			System.out.println("DCS.PR_DMBO504 프로시저 에러 내역:" + res);
			
	        if (resp != 0) {
	            throw new Exception("[USER]" +res + "포인트강제적립차감승인에 실패하였습니다");
	        }
				//ret += resp;


		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return resp;
	}
    
	/**
	 * <p>포인트 강제적립/차감 내역 저장</p>
	 * 
	 * @created  on 1.0, 2010/01/25
	 * @created  by 장형욱
	 * 
	 * @modified on 
	 * @modified by 
	 * @caused   by 
	 */
	
	public int saveData(ActionForm form, GauceDataSet dSet, HttpServletRequest request, MultiInput mi) throws Exception {
		int 		ret = 0;
        SqlWrapper  sql = null;
        Service     svc = null;

        try {
        	 
			begin();
            connect("pot");
            svc  = (Service)form.getService();
            String strQuery = "";
            sql  = new SqlWrapper();
			int res = 0;
			int i=1;
			
			HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
            
            String USER_ID = sessionInfo.getUSER_ID();
             
			sql.setString(i++, USER_ID);
			sql.setString(i++, form.getParam("PROC_DT"));
			sql.setString(i++, form.getParam("BRCH_ID"));
			sql.setString(i++, form.getParam("CARD_NO"));
			sql.setString(i++, form.getParam("SEQ_NO"));
				
			strQuery = svc.getQuery("saveData") + "\n";

			sql.put(strQuery);
			
			res = update(sql);	
			System.out.println("savedate" + res);
			if ( res != 1 ) {
                throw new Exception("" +
                        "데이터의 정합성 문제로 인하여 " +
                        "데이터 입력을 하지 못했습니다.");
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

}
