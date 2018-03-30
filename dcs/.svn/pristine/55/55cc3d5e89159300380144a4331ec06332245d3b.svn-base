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

import javax.servlet.http.HttpServletRequest;

import common.util.Util;
//import java.util.Map;

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
 * <p>포인트 양도 등록</p>
 * 
 * @created  on 1.0, 2010.03.21
 * @created  by jinjung.kim
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class DMbo609DAO extends AbstractDAO {

    public List searchCust(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        String BRCH_ID = String2.nvl(form.getParam("BRCH_ID"));
        String CUST_ID = String2.nvl(form.getParam("CUST_ID"));
        String SS_NO   = String2.nvl(form.getParam("SS_NO"));
        String CARD_NO = String2.nvl(form.getParam("CARD_NO"));
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        int i = 1;
        sql.setString(i++, BRCH_ID);
        sql.setString(i++, BRCH_ID); 

        strQuery = svc.getQuery("SEL_CUST") + "\n"; 
        
        if (!String2.isEmpty(String2.trim((SS_NO)))){
			strQuery += svc.getQuery("SEL_CUSTINFO_SS_NO") + "\n";
			sql.setString(i++, SS_NO);
		}
		
		if (!String2.isEmpty(String2.trim((CUST_ID)))){
			strQuery += svc.getQuery("SEL_CUSTINFO_CUST_ID") + "\n";
			sql.setString(i++, CUST_ID);
		}		

		if (!String2.isEmpty(String2.trim((CARD_NO)))){
			strQuery += svc.getQuery("SEL_CUSTINFO_CARD_NO") + "\n";
			sql.setString(i++, CARD_NO);
		}
		
		strQuery += svc.getQuery("SEL_CUSTINFO_ROWNUM");
        
        sql.put(strQuery);   
        ret = select2List(sql);  
        
      /*ret = util.decryptedStr(ret,2);    //집전화1
        ret = util.decryptedStr(ret,3);    //집전화2
        ret = util.decryptedStr(ret,4);    //집전화3
        ret = util.decryptedStr(ret,5);    //휴대전화1
        ret = util.decryptedStr(ret,6);    //휴대전화2
        ret = util.decryptedStr(ret,7);    //휴대전화3
        ret = util.decryptedStr(ret,8);    //주민번호
        ret = util.decryptedStr(ret,10);   //EMAIL1
        ret = util.decryptedStr(ret,11);   //EMAIL1 */
        
        return ret; 
    }
    
    public List searchMaster(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        Util       util = new Util();
        String strQuery = "";
        
        String CUST_ID = String2.nvl(form.getParam("CUST_ID"));
         
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        int i = 1;
        sql.setString(i++, CUST_ID); 
        sql.setString(i++, CUST_ID); 
        sql.setString(i++, CUST_ID); 
        sql.setString(i++, CUST_ID);
        sql.setString(i++, CUST_ID);

        strQuery = svc.getQuery("SEL_MASTER"); 
        sql.put(strQuery);   
        ret = select2List(sql);  
        
        //ret = util.decryptedStr(ret,5);    //양수자카드번호 
        //ret = util.decryptedStr(ret,8);    //양수자카드 pass
        
        return ret; 
    }
    
    /**
	 * 프로시져 호출
	 * @param form
	 * @param mi
	 * @return
	 */	
	public int sendData(String[] output, String Flag) throws Exception{
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
			
			if(Flag.equals("GRANTOR")){                      //포인트양도
				psql.setString(++i, output[10]);             //비밀번호
			}else{											 //포인트양수
				psql.setString(++i, "");                     //비밀번호
			}			
			
			psql.setString(++i, output[11]);                 //가맹점ID

			psql.setString(++i, output[12]);                  //결제수단코드1
			psql.setString(++i, "");                          //결제수단1상세
			psql.setDouble(++i, Integer.parseInt(output[14]));//결제수단금액1

			psql.setString(++i, "");                       //결제수단코드2
			psql.setString(++i, "");                       //결제수단2상세
			psql.setDouble(++i, 0);                  //결제수단금액2

			psql.setString(++i, "");                       //결제수단코드3
			psql.setString(++i, "");                       //결제수단3상세
			psql.setDouble(++i, 0);                  //결제수단금액3

			psql.setString(++i, "");                       //결제수단코드4
			psql.setString(++i, "");                       //결제수단4상세
			psql.setDouble(++i, 0);                  //결제수단금액4

			psql.setString(++i, "");                       //결제수단코드5
			psql.setString(++i, "");                       //결제수단5상세
			psql.setDouble(++i, 0);                  //결제수단금액5

			psql.setString(++i, "");                       //결제수단코드6
			psql.setString(++i, "");                       //결제수단6상세
			psql.setDouble(++i, 0);                  //결제수단금액6

			psql.setString(++i, "");                       //결제수단코드7
			psql.setString(++i, "");                       //결제수단7상세
			psql.setDouble(++i, 0);                  //결제수단금액7

			psql.setString(++i, "");                       //결제수단코드8
			psql.setString(++i, "");                       //결제수단8상세
			psql.setDouble(++i, 0);                  //결제수단금액8

			psql.setString(++i, output[36]);                 //결제수단건수
			psql.setString(++i, output[37]);                 //총거래금액

			psql.setDouble(++i, 0);                  //사용취소포인트
			psql.setString(++i, "");     //원거래영수증번호
			psql.setString(++i, "");        //원거래승인번호
			psql.setString(++i, output[41]);                 //적립/사용구분
			
//			psql.setString(++i, "");        //응답코드
//			psql.setString(++i, "");        //승인번호
			
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			
			psql.setString(++i, output[44]);//성명
//			psql.setString(++i, "");        //회원등급
//			psql.setString(++i, "");        //시스템일자
//			psql.setString(++i, "");        //시스템시간
			
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);  
			
//			psql.setDouble(++i, 0);                  //누적포인트
//			psql.setDouble(++i, 0);                  //가용포인트
			
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			
//			psql.setDouble(++i, 0);      //금회포인트
//			psql.setDouble(++i, 0);      //결제적립
//			psql.setString(++i, "");     //캠페인ID
//			psql.setDouble(++i, 0);      //캠페인적립
			
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			
			psql.setString(++i, ""); //이벤트ID
			psql.setDouble(++i, 0);  //이벤트적립
//			psql.setDouble(++i, 0);  //기타적립
//			psql.setString(++i, ""); //영수증출력메시지1
//			psql.setString(++i, ""); //영수증출력메시지2
			
			psql.registerOutParameter(++i, DataTypes.INTEGER);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			psql.registerOutParameter(++i, DataTypes.VARCHAR);
			
//			psql.setString(++i, ""); //회원ID
//			psql.setString(++i, ""); //공란
			
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
	            throw new Exception("[USER]" +res );
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
    
    public String saveData(ActionForm form, MultiInput mi,HttpServletRequest request) throws Exception {
        
        String      retCode = "0";
        SqlWrapper  sql = null;
        Service     svc = null;

        try {

            begin();
            
            connect("pot");
            
            svc  = (Service) form.getService();
            String strQuery = "";
            sql  = new SqlWrapper();
            
            int i=1;
                        
            sql.setString(i++, mi.getString("GRANTOR_CARD_NO"));
            sql.setString(i++, mi.getString("CARD_NO")); //GRANTEE`S
            sql.setString(i++, mi.getString("MOVE_POINT"));
            sql.setString(i++, mi.getString("GRANTOR_ID"));
            sql.setString(i++, mi.getString("MOVE_POINT"));
            sql.setString(i++, mi.getString("GRANTOR_ID"));
            sql.setString(i++, mi.getString("CUST_ID"));
            sql.setString(i++, mi.getString("MOVE_POINT"));
            sql.setString(i++, mi.getString("CUST_ID"));
            sql.setString(i++, mi.getString("USER_ID"));
            sql.setString(i++, mi.getString("GRANTOR_CARD_NO"));
            sql.setString(i++, mi.getString("CARD_NO"));//GRANTEE`S
            
            strQuery = svc.getQuery("saveData") + "\n";

            sql.put(strQuery);
            
            int result = update(sql);     
           
            if (1 != result) {
                throw new Exception("포인트 이력 등록시 장애가 발생하였습니다.");
            }
            
        } catch (Exception e) {
            retCode = "9999";
            rollback();
            throw e;
        } finally {
            end();
            
        }
        return retCode;
    }       
}
