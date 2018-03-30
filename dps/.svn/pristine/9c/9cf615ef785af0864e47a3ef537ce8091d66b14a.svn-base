/*
 * Copyright (c) 2010 한국후지쯔 All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package ppay.dao;

import java.util.List;
import java.util.Map;
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
 * <p>발행대상전표 매입 세금계산서 생성</p>
 * 
 * @created  on 1.0, 2010/04/11
 * @created  by 김경은
 *            
 * @modified on 
 * @modified by                    
 * @caused   by 
 */

public class PPay102DAO extends AbstractDAO {

	/**
	 * 매입세금계산서 마스터 데이터 조회
	 *       
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form, String userId, String org_flag) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		int i = 1;          
		
		String strStrCd     = String2.nvl(form.getParam("strStrCd"));
		String strYyyymm    = String2.nvl(form.getParam("strYyyymm"));
		String strPayCyc    = String2.nvl(form.getParam("strPayCyc")); 
		String strPayCnt    = String2.nvl(form.getParam("strPayCnt"));
		String strVenCd     = String2.nvl(form.getParam("strVenCd"));
		String strBizType   = String2.nvl(form.getParam("strBizType"));
		String strTaxFlag   = String2.nvl(form.getParam("strTaxFlag"));
		String strSaleSdt   = String2.nvl(form.getParam("strSaleSdt"));
		String strSaleEdt   = String2.nvl(form.getParam("strSaleEdt"));
		String strIssueFlag = String2.nvl(form.getParam("strIssueFlag")); 
	
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
	
		sql.put(svc.getQuery("SEL_MASTER"));
		sql.setString(i++, strYyyymm);
		sql.setString(i++, strPayCyc);           
		sql.setString(i++, strPayCnt);
		sql.setString(i++, strSaleSdt);
		sql.setString(i++, strSaleEdt);
		
		sql.setString(i++, strYyyymm);
		sql.setString(i++, strPayCyc);          
		sql.setString(i++, strPayCnt);
		sql.setString(i++, strSaleSdt);
		sql.setString(i++, strSaleEdt);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strVenCd);       
		sql.setString(i++, strBizType);     
		sql.setString(i++, strTaxFlag);
		sql.setString(i++, strSaleSdt);
		sql.setString(i++, strSaleEdt); 
		sql.setString(i++, strIssueFlag);
		sql.setString(i++, strPayCyc);  
		
		sql.setString(i++, strStrCd);
		sql.setString(i++, strVenCd); 
		sql.setString(i++, strBizType);
		sql.setString(i++, strTaxFlag);
		sql.setString(i++, strSaleSdt);
		sql.setString(i++, strSaleSdt); 
		sql.setString(i++, strIssueFlag);
		sql.setString(i++, strPayCyc);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 매입세금계산서 상세 데이터 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getDetail(ActionForm form) throws Exception {
		                         
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd         = String2.nvl(form.getParam("strStrCd"));
		String strVenCd         = String2.nvl(form.getParam("strVenCd"));
		String strBizType       = String2.nvl(form.getParam("strBizType"));
		String strTaxFlag       = String2.nvl(form.getParam("strTaxFlag"));
		String strSaleSdt       = String2.nvl(form.getParam("strSaleSdt"));
		String strSaleEdt       = String2.nvl(form.getParam("strSaleEdt"));
		String strTaxIssueDt    = String2.nvl(form.getParam("strTaxIssueDt"));
		String strTaxIssueSeqNo = String2.nvl(form.getParam("strTaxIssueSeqNo"));
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[1];
		
		connect("pot");
		sql.setString(i++, strStrCd);
		sql.setString(i++, strVenCd);  
		sql.setString(i++, strBizType);
		sql.setString(i++, strTaxFlag);
		sql.setString(i++, strSaleSdt);
		sql.setString(i++, strSaleEdt);
		sql.setString(i++, strTaxIssueDt);
		sql.setString(i++, strTaxIssueSeqNo);
		sql.setString(i++, strPumbunCd);
		
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.put(strQuery); 
		ret[0] = select2List(sql);

		return ret;
	}
	
	/**
	 *  매입세금계산서 생성(저장)한다.
	 * 
	 * @param form
	 * @param mi1
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi1, String userId, String org_flag)
			throws Exception {

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
			sql.put(svc.getQuery("SEL_SYSDATE"));    
			Map mapSysDate = (Map)selectMap(sql);
			strSysDate = mapSysDate.get("TODAY").toString();

			// 마스터
			while (mi1.next()) {
				if(mi1.IS_UPDATE()){// 저장
					if("T".equals(mi1.getString("SEL"))){

						i = 1;            
						psql.put("DPS.PR_PPTAXCRT", 19);  
						     
						psql.setString(i++, strSysDate);					// 등록일시
			            psql.setString(i++, userId);       					// 등록자
			            psql.setString(i++, mi1.getString("STR_CD")); 		// 점코드
			            psql.setString(i++, mi1.getString("PAY_YM")); 		// 지불년월
			            psql.setString(i++, mi1.getString("PAY_CYC"));		// 지불주기
			            psql.setString(i++, mi1.getString("PAY_CNT"));		// 지불회차
			            psql.setString(i++, mi1.getString("BIZ_TYPE"));		// 거래형태
			            psql.setString(i++, mi1.getString("TAX_FLAG"));		// 과세구분
			            psql.setString(i++, "1");							// 세금계산서구분(1:매입/2:매출)
			            psql.setString(i++, "N");							// 공제여부(Y:공제/N:공제아님)
			            psql.setString(i++, mi1.getString("VEN_CD"));		//
			            psql.setString(i++, mi1.getString("PUMBUN_CD"));		// 
			            psql.setString(i++, mi1.getString("TERM_S_DT"));
			            psql.setString(i++, mi1.getString("TERM_E_DT"));
			            
			            psql.setString(i++, mi1.getString("S_PAY_YM")); 	// 조회지불년월
			            psql.setString(i++, mi1.getString("S_PAY_CYC"));	// 조회지불주기
			            psql.setString(i++, mi1.getString("S_PAY_CNT"));	// 조회지불회차
			            
			            psql.registerOutParameter(i++, DataTypes.INTEGER);//18
			            psql.registerOutParameter(i++, DataTypes.VARCHAR);//19

			            prs = updateProcedure(psql);
			            resp += prs.getInt(18);    

			            if (resp <= 0) {
			                throw new Exception("[USER]"+ prs.getString(19));
			            }
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
