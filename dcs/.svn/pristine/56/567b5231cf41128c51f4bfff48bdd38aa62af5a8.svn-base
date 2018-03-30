/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package dbri.dao;

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
 * <p>가맹점 코드 관리</p>
 * 
 * @created  on 1.0, 2010/02/10
 * @created  by 김영진
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class DBri101DAO extends AbstractDAO {
    
    /**
     * <p>가맹점 코드 마스터 조회</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List ret        = null;
        SqlWrapper sql  = null;
        Service svc     = null;
        String strQuery = "";
        int i = 1;
        
        String strBrchId   = String2.nvl(form.getParam("strBrchId"));
        String strCompNo   = String2.nvl(form.getParam("strCompNo"));
        String strBrchType = String2.nvl(form.getParam("strBrchType"));
        
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strBrchId);
        sql.setString(i++, strCompNo);
        sql.setString(i++, strBrchType);
        
        strQuery = svc.getQuery("SEL_MASTER"); // + "\n";
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
        
        String strBrchId   = String2.nvl(form.getParam("strBrchId"));

        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        sql.setString(i++, strBrchId);
        
        strQuery = svc.getQuery("SEL_DETAIL"); // + "\n";
        sql.put(strQuery);
        ret = select2List(sql);
        return ret;
    }
    
    /**
     *  가맹점 정보를  저장, 수정 처리한다.
     * 
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
    public String save(ActionForm form, MultiInput mi, String userId)
    throws Exception {
        
        String ret = null;
        //int ret = 0;
        int res = 0;
        SqlWrapper sql = null;
        Service svc    = null;
        Util util      = new Util();
        
        try {
            connect("pot");
            begin();
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            String aftData = ""; //log Data용
            
            while (mi.next()) {
                
                sql.close();
                if (mi.IS_INSERT()) { // 저장
                    int i=1;

                    sql.put(svc.getQuery("GET_BRANCHID"));
                    sql.setString(1, mi.getString("STR_CD"));            //점코드
                    Map map = selectMap(sql);
                    mi.setString("BRCH_ID", map.get("BRCH_ID").toString());
                    sql.close();
                    
                    sql.put(svc.getQuery("INS_BRANCH")); 
                    sql.setString(i++, mi.getString("BRCH_ID"));        //점코드
                    sql.setString(i++, mi.getString("BRCH_NAME"));      //가맹점명
                    sql.setString(i++, mi.getString("COMP_NO"));        //사업자번호
                    sql.setString(i++, mi.getString("STR_CD"));         //점코드
                    sql.setString(i++, mi.getString("SCOMP_YN"));       //계열사여부
                    sql.setString(i++, mi.getString("BRCH_TYPE"));      //가맹점유형
                    sql.setString(i++, mi.getString("SHORT_CD"));       //단축코드
                    sql.setString(i++, mi.getString("ZIP_CD1"));        //우편번호1
                    sql.setString(i++, mi.getString("ZIP_CD2"));        //우편번호2
                    sql.setString(i++, mi.getString("BRCH_ADDR1"));     //가맹점주소1
                    sql.setString(i++, mi.getString("BRCH_ADDR2"));     //가맹점주소2
                    sql.setString(i++, mi.getString("BRCH_PH1"));       //가맹점전화번호1 
                    sql.setString(i++, mi.getString("BRCH_PH2"));       //가맹점전화번호2 
                    sql.setString(i++, mi.getString("BRCH_PH3"));       //가맹점전화번호3 
                    sql.setString(i++, mi.getString("REP_SSNO"));       //대표자주민번호    
                    sql.setString(i++, mi.getString("REP_NAME"));       //대표자명
                    sql.setString(i++, mi.getString("REP_PUMMOK_NM"));  //대표품목명
                    sql.setString(i++, mi.getString("REP_BRAND_NM"));   //대표브랜드명
                    sql.setString(i++, mi.getString("BIZ_STAT"));       //업태
                    sql.setString(i++, mi.getString("BIZ_CAT"));        //종목
                    sql.setString(i++, mi.getString("OPEN_DT"));        //개업일자
                    sql.setString(i++, mi.getString("FINC_CD"));        //재무업체코드 
                    sql.setString(i++, mi.getString("CAN_DT"));         //해지일자
                    sql.setString(i++, mi.getString("CAN_REASON"));     //해지사유
                    sql.setString(i++, mi.getString("BRCH_PAY_DAY"));   //가맹점입금예정일
                    sql.setString(i++, mi.getString("CHAR_NAME"));      //담당자명
                    sql.setString(i++, mi.getString("CHAR_PH1"));       //담당자전화번호1
                    sql.setString(i++, mi.getString("CHAR_PH2"));       //담당자전화번호2 
                    sql.setString(i++, mi.getString("CHAR_PH3"));       //담당자전화번호3 
                    sql.setString(i++, mi.getString("CHAR_EMAIL1"));    //담당자이메일1   
                    sql.setString(i++, mi.getString("CHAR_EMAIL2"));    //담당자이메일2  
                    sql.setString(i++, userId);                         //로그인ID
                    sql.setString(i++, userId);                         //로그인ID
                    
                    aftData = "BRCH_ID=["       + mi.getString("BRCH_ID")       + "],"
                            + "BRCH_NAME=["     + mi.getString("BRCH_NAME")     + "],";
                    
                }else if(mi.IS_UPDATE()){// 수정
                    int i=1;
                    sql.put(svc.getQuery("UPD_BRANCH")); 
                    sql.setString(i++, mi.getString("BRCH_NAME"));      //가맹점명
                    sql.setString(i++, mi.getString("COMP_NO"));
                    sql.setString(i++, mi.getString("STR_CD"));
                    sql.setString(i++, mi.getString("SCOMP_YN"));
                    sql.setString(i++, mi.getString("BRCH_TYPE"));
                    sql.setString(i++, mi.getString("SHORT_CD"));       //단축코드
                    sql.setString(i++, mi.getString("ZIP_CD1"));
                    sql.setString(i++, mi.getString("ZIP_CD2"));
                    sql.setString(i++, mi.getString("BRCH_ADDR1"));
                    sql.setString(i++, mi.getString("BRCH_ADDR2"));
                    sql.setString(i++, mi.getString("BRCH_PH1"));
                    sql.setString(i++, mi.getString("BRCH_PH2"));
                    sql.setString(i++, mi.getString("BRCH_PH3"));
                    sql.setString(i++, mi.getString("REP_SSNO"));
                    sql.setString(i++, mi.getString("REP_NAME"));
                    sql.setString(i++, mi.getString("REP_PUMMOK_NM"));
                    sql.setString(i++, mi.getString("REP_BRAND_NM"));
                    sql.setString(i++, mi.getString("BIZ_STAT"));
                    sql.setString(i++, mi.getString("BIZ_CAT"));
                    sql.setString(i++, mi.getString("OPEN_DT"));
                    sql.setString(i++, mi.getString("FINC_CD"));
                    sql.setString(i++, mi.getString("CAN_DT"));
                    sql.setString(i++, mi.getString("CAN_REASON"));
                    sql.setString(i++, mi.getString("BRCH_PAY_DAY"));
                    sql.setString(i++, mi.getString("CHAR_NAME"));
                    sql.setString(i++, mi.getString("CHAR_PH1"));
                    sql.setString(i++, mi.getString("CHAR_PH2"));
                    sql.setString(i++, mi.getString("CHAR_PH3"));
                    sql.setString(i++, mi.getString("CHAR_EMAIL1"));
                    sql.setString(i++, mi.getString("CHAR_EMAIL2"));
                    sql.setString(i++, userId);
                    sql.setString(i++, mi.getString("BRCH_ID"));
                    
                }
                res = update(sql);
                ret =  mi.getString("BRCH_ID");
                
                if (res != 1) {
                	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
                            + "데이터 입력을 하지 못했습니다.");
                }else{
                	
                	aftData += "COMP_NO=["       + mi.getString("COMP_NO")       + "],"
                             + "STR_CD=["        + mi.getString("STR_CD")        + "],"
                             + "SCOMP_YN=["      + mi.getString("SCOMP_YN")      + "],"
                             + "BRCH_TYPE=["     + mi.getString("BRCH_TYPE")     + "],"
                             + "SHORT_CD=["      + mi.getString("SHORT_CD")      + "],"
                             + "ZIP_CD1=["       + mi.getString("ZIP_CD1")       + "],"
                             + "ZIP_CD2=["       + mi.getString("ZIP_CD2")       + "],"
                             + "BRCH_ADDR1=["    + mi.getString("BRCH_ADDR1")    + "],"
                             + "BRCH_ADDR2=["    + mi.getString("BRCH_ADDR2")    + "],"
                             + "BRCH_PH1=["      + mi.getString("BRCH_PH1")      + "],"
                             + "BRCH_PH2=["      + mi.getString("BRCH_PH2")      + "],"
                             + "BRCH_PH3=["      + mi.getString("BRCH_PH3")      + "],"
                             + "REP_SSNO=["      + mi.getString("REP_SSNO")      + "],"
                             + "REP_NAME=["      + mi.getString("REP_NAME")      + "],"
                             + "REP_PUMMOK_NM=[" + mi.getString("REP_PUMMOK_NM") + "],"
                             + "REP_BRAND_NM=["  + mi.getString("REP_BRAND_NM")  + "],"
                             + "BIZ_CAT=["       + mi.getString("BIZ_CAT")       + "],"
                             + "OPEN_DT=["       + mi.getString("OPEN_DT")       + "],"
                             + "FINC_CD=["       + mi.getString("FINC_CD")       + "],"
                             + "CAN_DT=["        + mi.getString("CAN_DT")        + "],"
                             + "CAN_REASON=["    + mi.getString("CAN_REASON")    + "],"
                             + "BRCH_PAY_DAY=["  + mi.getString("BRCH_PAY_DAY")  + "],"
                             + "CHAR_NAME=["     + mi.getString("CHAR_NAME")     + "],"
                             + "CHAR_PH1=["      + mi.getString("CHAR_PH1")      + "],"
                             + "CHAR_PH2=["      + mi.getString("CHAR_PH2")      + "],"
                             + "CHAR_PH3=["      + mi.getString("CHAR_PH3")      + "],"
                             + "CHAR_EMAIL1=["   + mi.getString("CHAR_EMAIL1")   + "],"
                             + "CHAR_EMAIL2=["   + mi.getString("CHAR_EMAIL2")   + "]";

                	//조회끝난후 로그 쌓기.
                    String logGubun = "I"; //S:조회 //I:입력
                    String log1 = "DB_BRANCH";                                    // P_TABLE_ID 테이블명.
                    String log2 = "DBRI101";                                      // P_PGM_ID 프로그램 ID
                    String log3 = "CUST_ID=["+mi.getString("BRCH_ID")+"]";        // P_PK_VAL 키값
                    String log4 = aftData;                                        // 입력시에는 P_AFT_DATA 데이터, 조회시에는 쿼리.
                    String log5 = userId;                                         // 등록자 ID
                    this.logSave(logGubun, log1, log2, log3, log4, log5);
                }
              
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
