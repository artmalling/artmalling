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
import javax.servlet.http.HttpSession;

import common.vo.SessionInfo;

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
 * <p>제휴카드사 비용분담율 관리</p>
 * 
 * @created  on 1.0, 2010/05/19
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DMbo204DAO extends AbstractDAO {

	/**
     * <p>비용분담율 조회</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strBrchId   = String2.nvl(form.getParam("strBrchId"));
        String strAppSDt   = String2.nvl(form.getParam("strAppSDt"));
        String strPayType  = String2.nvl(form.getParam("strPayType"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strBrchId);
        sql.setString(i++, strPayType);
        sql.setString(i++, strAppSDt);
 
        strQuery = svc.getQuery("SEL_MASTER"); 
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }

    /**
     * <p>비용분담율 등록</p>
     * 
     */
    public int save(ActionForm form, MultiInput mi, HttpServletRequest request) throws Exception {
    	
        int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null; 
        
        try {
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();

            
        	HttpSession session = request.getSession();
            SessionInfo sessionInfo = (SessionInfo)session.getAttribute("sessionInfo");
            String strUserId = sessionInfo.getUSER_ID();

            while (mi.next()) {
            	
                String log3Data   = "";
                String aftData    = ""; //log Data용
            	sql.close();
                
           	    log3Data += "BRCH_ID=["      + mi.getString("BRCH_ID")      + "],"
                         +  "PAY_TYPE_DTL=[" + mi.getString("PAY_TYPE_DTL") + "],"
                         +  "APP_S_DT=["     + mi.getString("APP_S_DT")     + "]";

                if (mi.getString("IN_UP_CODE").equals("U")) { // 저장
                    int i=1;   
                     
                    sql.put(svc.getQuery("UPD_JCOMP_RULE"));
                    sql.setString(i++, mi.getString("ADD_RATE"));         //적립율
                    sql.setString(i++, mi.getString("DCUBE_RATE"));       //포인트적립율
                    sql.setString(i++, mi.getString("JCOMP_RATE"));       //카드사적립율
                    sql.setString(i++, mi.getString("ADD_FEE_RATE"));     //적립수수료율  
                    sql.setString(i++, strUserId);                        //로그인ID
                    sql.setString(i++, mi.getString("BRCH_ID"));          //가맹점ID
                    sql.setString(i++, mi.getString("PAY_TYPE_DTL"));     //카드사코드
                    sql.setString(i++, mi.getString("APP_S_DT"));         //적용시작일자
                     
                } else if (mi.getString("IN_UP_CODE").equals("I")) {       //INSERT
                    int i=1;   

                    sql.put(svc.getQuery("INS_JCOMP_RULE"));
                    sql.setString(i++, mi.getString("BRCH_ID"));          //가맹점ID
                    sql.setString(i++, mi.getString("PAY_TYPE_DTL"));     //카드사코드
                    sql.setString(i++, mi.getString("APP_S_DT") );        //적용시작일자
                    sql.setString(i++, mi.getString("ADD_RATE"));         //적립율
                    sql.setString(i++, mi.getString("DCUBE_RATE"));       //포인트적립율 
                    sql.setString(i++, mi.getString("JCOMP_RATE"));       //카드사적립율
                    sql.setString(i++, mi.getString("ADD_FEE_RATE"));     //적립수수료율 
                    sql.setString(i++, strUserId);                        //로그인ID
                    sql.setString(i++, strUserId);                        //로그인ID
                }
                res = update(sql);  

                if (res != 1) {
                    throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                            + "데이터 입력을 하지 못했습니다.");
                }else{
               	    aftData  = log3Data+",";
                	aftData += "ADD_RATE=["     + mi.getString("ADD_RATE")     + "],"
                            +  "DCUBE_ATE=["    + mi.getString("DCUBE_RATE")   + "],"
                            +  "JCOMP_RATE=["   + mi.getString("JCOMP_RATE")   + "],"
                            +  "ADD_FEE_RATE=[" + mi.getString("ADD_FEE_RATE") + "]";
                          

                	//조회끝난후 로그 쌓기.
                    String logGubun = "I"; //S:조회 //I:입력
                    String log1 = "DA_JCOMP_RULE";                                // P_TABLE_ID 테이블명.
                    String log2 = "DMBO204";                                      // P_PGM_ID 프로그램 ID
                    String log3 = log3Data;                                       // P_PK_VAL 키값
                    String log4 = aftData;                                        // 입력시에는 P_AFT_DATA 데이터, 조회시에는 쿼리.
                    String log5 = strUserId;                                      // 등록자 ID
                    this.logSave(logGubun, log1, log2, log3, log4, log5);
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
     * <p>적립월 콤보 처리</p>
     * 
     */
    public List getEtcCode(ActionForm form, MultiInput mi) throws Exception {
        List list = null;
        SqlWrapper sql = null;
        Service svc = null;
        String      getSql = "";

        try {
            connect("pot");
            svc = (Service) form.getService();
            sql = new SqlWrapper();
        
            mi.next();
            String allGb   = mi.getString("ALL_GB");
            String nulGb   = mi.getString("NUL_GB");
            String strCommPart = mi.getString("COMM_PART"); 
  
            if(strCommPart.equals("PAY_TYPE")){          //제휴신용카드사
                if(mi.getString("ALL_GB").equals("Y")) { // 전체 포함
                	getSql += svc.getQuery("SEL_ALLGB")+ "\n ";
          	    }
                getSql = getSql + svc.getQuery("SEL_ETC_CODE2");
            }else if(strCommPart.equals("APP_DT")){     //기준일자
                getSql = getSql + svc.getQuery("SEL_ETC_CODE");
            }
      
            sql.put(getSql);

            list = select2List(sql);

        } catch (Exception e) {
            throw e;
        }
        return list;
    }        

    /**
	 * <p>로그 쌓이기</p>
	 * 
	 * @created  on 1.0, 2010/01/25
	 * @created  by 남형석
	 * 
	 * @modified on 
	 * @modified by 
	 * @caused   by 
	 */
	
	public ProcedureResultSet logSave (String logGubun, String para1,String para2,String para3,String para4,String para5) throws Exception {
		
		int 		ret = 0;
        SqlWrapper  sql = null;
        ProcedureWrapper psql = null;
        Service     svc = null;
        ProcedureResultSet proset = null; 

        try {
        	if( getTrConnection() == null){
                connect("pot");
        	    begin();
        	}
            sql  = new   SqlWrapper();
            psql = new ProcedureWrapper();
			int i=1;
			if(logGubun.equals("S")){
			    psql.put("DCS.PR_TBL_SHIST_INSERT", 7);
			}else{
				psql.put("DCS.PR_TBL_UHIST_INSERT", 7);
			}
			
			psql.setString(i++, para1);
			psql.setString(i++, para2);
			psql.setString(i++, para3);
			psql.setString(i++, para4);
			psql.setString(i++, para5);
			
			psql.registerOutParameter(i++, DataTypes.INTEGER);
			psql.registerOutParameter(i++, DataTypes.VARCHAR);
			proset = updateProcedure(psql);

			return proset;
			
			
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			if( getTrConnection() == null || logGubun.equals("S"))
				end();
		}
	}
}
