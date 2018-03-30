/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dmtc.dao;

import java.net.URLDecoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
 * <p>기부기획등록</p>
 * 
 * @created  on 1.1, 2010/02/21
 * @created  by 장형욱(FUJITSU KOREA LTD.)
 * @caused   by 기부기획 등록
 *
 */

public class DMtc701DAO extends AbstractDAO {

    /**
     * <p>기부기획등록 조회</p>
     * 
     */        
    public List searchList(ActionForm form, HttpServletRequest request) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strSdt       = String2.nvl(form.getParam("strSdt"));
        String strEdt       = String2.nvl(form.getParam("strEdt"));
        String strSdt2      = String2.nvl(form.getParam("strSdt"));
        String strEdt2      = String2.nvl(form.getParam("strEdt"));        
        String strDonNm     = String2.nvl(form.getParam("strDonNm"));
        String strDonId     = String2.nvl(form.getParam("strDonId"));
        String strStatus    = String2.nvl(form.getParam("strStatus"));
        
        String toDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date()); 
             
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strSdt);
        sql.setString(i++, strEdt);
        sql.setString(i++, strSdt2);
        sql.setString(i++, strEdt2);    
        sql.setString(i++, strDonId);        
        //sql.setString(i++, strDonNm);
        
        strQuery = svc.getQuery("SEL_DC_DON_PLAN") + "\n";
         
        if (!"".equals(strStatus)) {
            if ("0".equals(strStatus))    // 활성
                strQuery += " AND A.E_DT >= " + toDate + "\n";
            else if ("1".equals(strStatus))    // 비활성
                strQuery += " AND A.E_DT < " + toDate + "\n";
        }        
        
        strQuery += "ORDER BY A.DON_ID" + "\n";
        
        sql.put(strQuery);
        ret = select2List(sql);
               
        return ret;
    }
    
    /**
     * <p>가맹점 코드 상세 조회</p>
     * 
     */
    public List searchDetail(ActionForm form) throws Exception {
        List       ret      = null;
        SqlWrapper sql      = null;
        Service    svc      = null;
        String     strQuery = "";
        int i = 1;
        
        String strDonId   = String2.nvl(form.getParam("strDonId"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strDonId);
        
        strQuery = svc.getQuery("SEL_DETAIL"); // + "\n";
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }    
    
    /**
     * <p>기부기획등록 팝업 조회</p>
     * 
     */        
    public List searchPopMaster(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strDonTarget = URLDecoder.decode(String2.nvl(form.getParam("strDonTarget")), "UTF-8");
        String strDonNm     = URLDecoder.decode(String2.nvl(form.getParam("strDonNm")), "UTF-8");
         
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strDonTarget);
        sql.setString(i++, strDonNm);
        
        strQuery = svc.getQuery("POP_SEL_DC_DON_PLAN"); // + "\n";
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }    
    
    /**
     * 팝업 없이 조회하기
     * 
     * @param svc
     * @return List
     * @throws Exception
     */
    public List getOneWithoutPop(ActionForm form) throws Exception {

        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strDonId = String2.nvl(form.getParam("strDonId"));
         
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strDonId);
        
        strQuery = svc.getQuery("POP_SEL_DC_DON_PLAN_ONE"); // + "\n";
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }    
    
    /**
     * <p>기부기획 등록</p>
     * 
     * @created  on 1.0, 2010/02/16
     * @created  by 장형욱
     * 
     * @modified on 
     * @modified by 
     * @caused   by 
     */
    
    public int saveData(ActionForm form, MultiInput mi, String userId) throws Exception {
        int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null;
        String don_id  = null;
        Util util      = new Util();
      
        try {
        	
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            sql.close();
            
            sql.put("SELECT DCS.F_GET_SQ_DON AS DON_ID FROM DUAL");

            Map map = selectMap(sql);            
            don_id = (String)map.get("DON_ID");   
            
            sql.close();
            while (mi.next()) {
                if (mi.IS_INSERT()) { // 저장
                    int i=1;
                    sql.put(svc.getQuery("INS_DC_DON_PLAN")); 
                       
                    sql.setString(i++, don_id);        //기부명
                    sql.setString(i++, mi.getString("DON_NAME"));        //기부명
                    sql.setString(i++, mi.getString("S_DT"));            //시작일자
                    sql.setString(i++, mi.getString("E_DT"));            //종료일자
                    sql.setString(i++, mi.getString("DON_TARGET"));        //기부처
                    sql.setString(i++, mi.getString("MEMO"));            //메모
                    sql.setString(i++, userId);            //등록자ID
                    sql.setString(i++, userId);            //등록자ID
                    
                     
                }else if(mi.IS_UPDATE()){// 수정
                    int i=1;
                    sql.put(svc.getQuery("UPD_DC_DON_PLAN")); 
                    
                    sql.setString(i++, mi.getString("DON_NAME"));        //기부명
                    sql.setString(i++, mi.getString("S_DT"));            //시작일자
                    sql.setString(i++, mi.getString("E_DT"));            //종료일자
                    sql.setString(i++, mi.getString("DON_TARGET"));        //기부처
                    sql.setString(i++, mi.getString("MEMO"));            //메모
                    sql.setString(i++, userId);                            //수정자ID
                    sql.setString(i++, mi.getString("DON_ID"));            //기부ID
                }
                res = update(sql);
                
                //--감사로그 
                if (mi.IS_INSERT()) { // 저장                    
                    String logGubun = "I"; //S:조회 //I:입력
                    String log1 = "DC_DON_PLAN";                      // P_TABLE_ID 테이블명.
                    String log2 = "DMTC701";                          // P_PGM_ID 프로그램 ID
                    String log3 = "DON_ID=["+ don_id +"]";            // P_PK_VAL 키값
                    String log4 = "DON_NAME=["+mi.getString("DON_NAME") + "],"
                                + "S_DT=["+mi.getString("S_DT") + "],"
                                + "E_DT=["+mi.getString("E_DT") + "],"
                                + "DON_TARGET=["+mi.getString("DON_TARGET") + "],"
                                + "MEMO=["+mi.getString("MEMO") + "]";
                    String log5 = userId;
                    this.logSave(logGubun, log1, log2, log3, log4, log5);                       
                    
                }else if(mi.IS_UPDATE()){// 수정
                    String logGubun = "U"; //S:조회 //I:입력
                    String log1 = "DC_DON_PLAN";                      // P_TABLE_ID 테이블명.
                    String log2 = "DMTC701";                          // P_PGM_ID 프로그램 ID
                    String log3 = "DON_ID=["+mi.getString("DON_ID")+"]";            // P_PK_VAL 키값
                    String log4 = "DON_NAME=["+mi.getString("DON_NAME") + "],"
                                + "S_DT=["+mi.getString("S_DT") + "],"
                                + "E_DT=["+mi.getString("E_DT") + "],"
                                + "DON_TARGET=["+mi.getString("DON_TARGET") + "],"
                                + "MEMO=["+mi.getString("MEMO") + "]";
                    String log5 = userId;
                    this.logSave(logGubun, log1, log2, log3, log4, log5);                       
                }     
                
                if (res != 1) {
                    throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
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
