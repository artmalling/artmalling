/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package psal.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by (FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PSal524DAO extends AbstractDAO {

	/**
     * <p>마스터 조회</p>
     * 
     */
    public List searchMaster(ActionForm form) throws Exception {
        List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        int i = 1;
        
        String strStrCd    = String2.nvl(form.getParam("strStrCd"));
        String strDeptCd    = String2.nvl(form.getParam("strDeptCd"));
        String strTeamCd    = String2.nvl(form.getParam("strTeamCd"));
        String strPcCd    = String2.nvl(form.getParam("strPcCd"));
        String strSaleDtS    = String2.nvl(form.getParam("strSaleDtS"));
        String strSaleDtE    = String2.nvl(form.getParam("strSaleDtE"));
        String strPumbunCd    = String2.nvl(form.getParam("strPumbunCd"));
        
         
        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        sql.put(svc.getQuery("SEL_MASTER"));
        
        sql.setString(i++, strStrCd); 
        sql.setString(i++, strDeptCd);
        sql.setString(i++, strTeamCd);
        sql.setString(i++, strPcCd); 
        sql.setString(i++, strSaleDtS);
        sql.setString(i++, strSaleDtE);
        sql.setString(i++, strPumbunCd);
        
        ret = select2List(sql);
        
		return ret;
        
         
    }

    public List searchMgRate(ActionForm form) throws Exception {
    	List       ret  = null;
        SqlWrapper sql  = null;
        Service    svc  = null;
        int i = 1;
        
        String strStrCd    = String2.nvl(form.getParam("strStrCd"));
        String strPumbunCd    = String2.nvl(form.getParam("strPumbunCd"));
        String strEventCd    = String2.nvl(form.getParam("strEventCd"));
        String strEventRate    = String2.nvl(form.getParam("strEventRate"));
        String strEventFlagN    = String2.nvl(form.getParam("strEventFlagN"));
        String strMgAppDt    = String2.nvl(form.getParam("strMgAppDt"));
        String strSkuFlag    = String2.nvl(form.getParam("strSkuFlag"));

        sql = new SqlWrapper();
        svc = (Service) form.getService(); 
 
        connect("pot");
        
        
        System.out.println(">>>>>>>>>>>>>>> strSkuFlag" + strSkuFlag);
        System.out.println(">>>>>>>>>>>>>>> strEventCd" + strEventCd);
        
        // 비단품이거나 정상판매인 경우
        if (strSkuFlag.equals("2") || strEventCd.equals("00000000000")) {
	        sql.put(svc.getQuery("SEL_MG_RATE"));
	        
	        sql.setString(i++, strStrCd); 
	        sql.setString(i++, strPumbunCd); 
	        sql.setString(i++, strEventFlagN);
	        sql.setString(i++, strEventRate);
	        sql.setString(i++, strEventCd);
	        sql.setString(i++, strMgAppDt);
        } else {
	        sql.put(svc.getQuery("SEL_MG_RATE_SKU"));
	        
	        sql.setString(i++, strStrCd); 
	        sql.setString(i++, strPumbunCd); 
	        sql.setString(i++, strEventFlagN);
	        sql.setString(i++, strEventRate);
	        sql.setString(i++, strMgAppDt);	
        }
        ret = select2List(sql);
        
		return ret;
    }
    
    public String setSeqNo(String strStrCd, 
    		               String strSaleDt,
    		               String strPosNo,
    		               String strPumbunCd,
    		               String strPummokCd,
    		               String strEventCd,
    		               String strEventFlag,
    		               String strEventRate,
                           String strMgRate) throws Exception {
        String ret = null;
        Map map    = null;
        SqlWrapper sql = null;
        Service svc = null;
        int i = 1;  

        sql = new SqlWrapper();
            
        connect("pot");
        sql.close();
        sql.put(svc.getQuery("SEL_SEQ"));
        sql.setString(i++,strStrCd);
        sql.setString(i++,strSaleDt);
        sql.setString(i++,strPosNo);
        sql.setString(i++,strPumbunCd);
        sql.setString(i++,strPummokCd);
        sql.setString(i++,strEventCd);
        sql.setString(i++,strEventFlag);
        sql.setString(i++,strEventRate);
        sql.setString(i++,strMgRate);
        map = selectMap(sql);
        String seq = map.get("MAX_SEQ").toString();
        
        ret = seq;
        return ret;
    }   
    
    public int save(ActionForm form, MultiInput mi, String strID)
			throws Exception {
       
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		ProcedureWrapper psql = null;
		Service svc = null;
        Map map    = null;
		String strSeq;

		int i;
		
		try {
			connect("pot");
			String flag;
			begin();
			sql = new SqlWrapper();
			psql = new ProcedureWrapper();
			svc = (Service) form.getService();
			ProcedureResultSet prs = null; 

			while (mi.next()) {

				if (mi.getString("CHECK_FLAG").equals("T")) {
					// MARIO OUTLET 2011.09.14
					sql.close();
					i = 0;
					sql.put(svc.getQuery("SEL_DCLOSE_CHECK"));
					sql.setString(++i, mi.getString("STR_CD"));   
					sql.setString(++i, mi.getString("SALE_DT"));
	
					List list = select2List( sql );
	
					if( list.size() > 0 ) {
						throw new Exception("[USER]" + "일 매출 마감이 완료 되었습니다."
								+ "일 매출 마감 상태인 경우 매출 정정 불가 합니다.");
					}
	
					sql.close();
					i = 0;
		            sql.put(svc.getQuery("SEL_SEQ"));
		            sql.setString(++i, mi.getString("STR_CD"));
		            sql.setString(++i, mi.getString("SALE_DT"));
		            sql.setString(++i, mi.getString("POS_NO"));
		            sql.setString(++i, mi.getString("PUMBUN_CD"));
		            sql.setString(++i, mi.getString("PUMMOK_CD"));
		            sql.setString(++i, mi.getString("EVENT_CD"));
		            sql.setString(++i, mi.getString("EVENT_FLAG"));
		            sql.setString(++i, mi.getString("EVENT_RATE"));
		            sql.setString(++i, mi.getString("MG_RATE"));
		            map = selectMap(sql);
		            strSeq = map.get("MAX_SEQ").toString();
	
					System.out.println(">>>>>>>>>>>>>> strSeq " + strSeq);
					
					
					if (mi.IS_UPDATE()) {
						flag = "I";
						i = 0;					
	
						sql.close();
						sql.put(svc.getQuery("INS_DETAIL"));					
						
						sql.setString(++i, strSeq);                       
						sql.setString(++i, mi.getString("OCCUR_FLAG_C")); 
						sql.setString(++i, mi.getString("SALE_DT"));       //MG_APP_DT 
						sql.setString(++i, mi.getString("EVENT_FLAG"));    //EVENT_FLAG
						sql.setString(++i, mi.getString("MG_RATE"));   
						sql.setString(++i, mi.getString("SALE_QTY"));      
						sql.setString(++i, mi.getString("TOT_SALE_AMT"));  
						sql.setString(++i, mi.getString("VAT_AMT"));
						sql.setString(++i, mi.getString("REDU_AMT"));     
						sql.setString(++i, mi.getString("DC_AMT"));      
						sql.setString(++i, mi.getString("NORM_SALE_AMT")); 
						sql.setString(++i, mi.getString("NET_SALE_AMT"));  
						sql.setString(++i, mi.getString("SALE_PROF_AMT"));
	
						sql.setString(++i, strID);                           
						sql.setString(++i, strID);                           
						
						sql.setString(++i, mi.getString("STR_CD"));          
						sql.setString(++i, mi.getString("SALE_DT"));         
						sql.setString(++i, mi.getString("POS_NO"));          
						sql.setString(++i, mi.getString("PUMBUN_CD"));       
						sql.setString(++i, mi.getString("PUMMOK_CD"));       
						sql.setString(++i, mi.getString("EVENT_CD"));        
						sql.setString(++i, mi.getString("EVENT_FLAG"));      
						sql.setString(++i, mi.getString("EVENT_RATE"));      
						sql.setString(++i, mi.getString("MG_RATE"));         
	
						
			            
						res = update(sql);
						
						sql.close();	
						
						i = 0;					
						
						sql.put(svc.getQuery("INS_DETAIL"));					
						
						sql.setString(++i, strSeq);                          
						sql.setString(++i, mi.getString("OCCUR_FLAG_N"));    
						sql.setString(++i, mi.getString("MG_APP_DT_N"));     
						sql.setString(++i, mi.getString("MOD_EVENT_FLAG_N"));
						sql.setString(++i, mi.getString("MOD_MG_RATE_N"));   
						sql.setString(++i, mi.getString("SALE_QTY_N"));      
						sql.setString(++i, mi.getString("TOT_SALE_AMT_N"));  
						
						sql.setString(++i, mi.getString("VAT_AMT_N"));
	 
						
						sql.setString(++i, mi.getString("REDU_AMT_N"));      
						sql.setString(++i, mi.getString("DC_AMT_N"));        
						sql.setString(++i, mi.getString("NORM_SALE_AMT_N")); 
						sql.setString(++i, mi.getString("NET_SALE_AMT_N"));  
						
						sql.setString(++i, mi.getString("SALE_PROF_AMT_N"));
	 
						
						sql.setString(++i, strID);                           
						sql.setString(++i, strID);   
						
						sql.setString(++i, mi.getString("STR_CD"));          
						sql.setString(++i, mi.getString("SALE_DT"));         
						sql.setString(++i, mi.getString("POS_NO"));          
						sql.setString(++i, mi.getString("PUMBUN_CD"));       
						sql.setString(++i, mi.getString("PUMMOK_CD"));       
						sql.setString(++i, mi.getString("EVENT_CD"));        
						sql.setString(++i, mi.getString("EVENT_FLAG"));      
						sql.setString(++i, mi.getString("EVENT_RATE"));      
						sql.setString(++i, mi.getString("MG_RATE"));         
			            
						res = update(sql);
						
						sql.close();	
						
						i = 0;					
						
						sql.put(svc.getQuery("INS_PS_DAYPBNPOSMODHIS"));					
						
						sql.setString(++i, strSeq);                          
						sql.setString(++i, mi.getString("STR_CD"));          
						sql.setString(++i, mi.getString("SALE_DT"));         
						sql.setString(++i, mi.getString("POS_NO"));          
						sql.setString(++i, mi.getString("PUMBUN_CD"));       
						sql.setString(++i, mi.getString("PUMMOK_CD"));       
						sql.setString(++i, mi.getString("EVENT_CD"));        
						sql.setString(++i, mi.getString("EVENT_FLAG"));      
						sql.setString(++i, mi.getString("EVENT_RATE"));      
						sql.setString(++i, mi.getString("MG_RATE"));         
			            
						res = update(sql);
						
						
						sql.close();
						
						i = 0;
						psql.put("DPS.PR_PSDAYPBNPOSMOD", 13);
						
						
						psql.setString(++i, mi.getString("STR_CD"));          
						psql.setString(++i, mi.getString("SALE_DT"));         
						psql.setString(++i, mi.getString("POS_NO"));          
						psql.setString(++i, mi.getString("PUMBUN_CD"));       
						psql.setString(++i, mi.getString("PUMMOK_CD"));       
						psql.setString(++i, mi.getString("EVENT_CD"));        
						psql.setString(++i, mi.getString("EVENT_FLAG"));      
						psql.setString(++i, mi.getString("EVENT_RATE"));      
						psql.setString(++i, mi.getString("MG_RATE"));
						psql.setString(++i, strSeq);
						psql.setString(++i, strID);
						psql.registerOutParameter(++i, DataTypes.INTEGER);
			            psql.registerOutParameter(++i, DataTypes.VARCHAR);
			            
			            /*
			            I_STR_CD             IN  VARCHAR2,  -- 점코드
			            I_SALE_DT            IN  VARCHAR2,  -- 매출일자
			            I_POS_NO             IN  VARCHAR2,  -- POS번호
			            I_PUMBUN_CD          IN  VARCHAR2,  -- 품번코드
			            I_PUMMOK_CD          IN  VARCHAR2,  -- 품목코드
			            I_EVENT_CD           IN  VARCHAR2,  -- EVENT_CD
			            I_EVENT_FLAG         IN  VARCHAR2,  -- EVENT_FLAG
			            I_EVENT_RATE         IN  VARCHAR2,  -- EVENT_RATE
			            I_MG_RATE            IN  VARCHAR2,    -- MG_RATE
			            I_SEQ                IN  VARCHAR2,    -- SEQ
			            I_USER_ID            IN  VARCHAR2,  -- USER_ID
			            O_RETURN             OUT NUMBER,    -- ERROR CODE
			            O_MESSAGE            OUT VARCHAR2
			            */
			            
			            prs = updateProcedure(psql);
			            
			            String prsRet = prs.getString(12);
			            
			            
			            if ( !prsRet.equals("0")) {
			            	throw new Exception("[USER]" + prs.getString(13) + " 데이터의 적합성 문제로 인하여"
									+ "데이터 입력을 하지 못했습니다.");
			            }
			            
					} 
					
					if (res != 1) {
						String msg = "데이터 입력을 하지 못했습니다.";
						
						throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
								+ msg);
						
					//데이터 신규 입력 및 수정 입력 시 
					}
					ret += res;
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


}
