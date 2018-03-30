/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mgif.dao;

import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
/**
 * <p>상품권입고등록</p>
 * 
 * @created  on 1.0, 2011/04/08
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif116DAO extends AbstractDAO {
	/**
	 * 상품권종류 콤보
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftTypeCd(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_COMBO") + "\n";
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 상품권입고등록 마스터 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		sql.setString(i++, form.getParam("strStrCd"));
		sql.setString(i++, form.getParam("strSdt"));
		sql.setString(i++, form.getParam("strEdt"));;
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 상품권입고등록 상세조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getDetail(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";
		sql.setString(i++, form.getParam("strInDt"));
		sql.setString(i++, form.getParam("strStrCd"));
		sql.setString(i++, form.getParam("strInSlipNo"));
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 상품권입고등록 금종 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getNewDetail(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_NEW_DETAIL") + "\n";
		sql.setString(i++, form.getParam("strIN_DT"));
		sql.setString(i++, form.getParam("strGiftTypeCd"));
		
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	

	
	/**
	 * 상품권입고등록 마스터 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMasterChk(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		strQuery = svc.getQuery("SEL_CHECKLIST") + "\n";
		sql.setString(i++, form.getParam("strStrCd"));
		sql.setString(i++, form.getParam("strGift_S_No"));
		sql.setString(i++, form.getParam("strGift_E_No"));;
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	
	/**
	 * 상품권입고등록  저장&수정
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String userId)
			throws Exception {
		int ret = 0;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		ProcedureWrapper psql = null;
		Service svc = null;
		ProcedureResultSet prs = null;
		
		String strSlipNo = "";
		int    iSeqNo = 1;
		String strInDt = "";
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			psql = new ProcedureWrapper();
			svc = (Service) form.getService();
			while(mi.next()){
				i=1;
				sql.close();
				
				
				// 신규 등록
				if(!mi.getString("GIFT_S_NO").equals("") 
						&& !mi.getString("GIFT_E_NO").equals("") 
						&& !mi.getString("IN_QTY").equals("0")){ 
					
					//if(strSlipNo.equals("") || !strInDt.equals(mi.getString("IN_DT"))){
					
					if(strSlipNo.equals("") ){
						sql.put(svc.getQuery("SEL_SLIP_NO"));
						Map map = (Map) selectMap(sql);
						strSlipNo = map.get("SLIP_NO").toString();

		                //System.out.println(" strSlipNo --- "  + strSlipNo);		                
		                
						sql.close();
					}
					// 발행입고 등록
	                
					sql.put(svc.getQuery("INS_GIFTISSUEIN"));
					
					sql.setString(i++, form.getParam("strRegDt"));			    // IN_DT 입고일
					sql.setString(i++, form.getParam("strStrCd"));		    	// STR_CD 입고점
					sql.setString(i++, strSlipNo); 								// IN_SLIP_NO 입고전표번호
					sql.setInt(i++, iSeqNo); 					     			// IN_SEQ_NO  입고순번
					sql.setString(i++, mi.getString("GIFT_TYPE_CD"));			// GIFT_TYPE_CD 상품권종류코드
					sql.setString(i++, mi.getString("ISSUE_TYPE"));				// ISSUE_TYPE 발행형태
					sql.setString(i++, mi.getString("GIFT_AMT_TYPE")); 			// GIFT_AMT_TYPE 금종
					sql.setString(i++, mi.getString("IN_QTY"));					// IN_QTY 입고수량
					sql.setString(i++, mi.getString("GIFT_S_NO"));		    	// GIFT_S_NO 상품권시작번호
					sql.setString(i++, mi.getString("GIFT_E_NO"));			    // GIFT_E_NO 상품권 종료번호
					sql.setString(i++, form.getParam("strRegDt"));				// REQ_DT 신청일자
					sql.setString(i++, strSlipNo);		                        // REQ_SLIP_NO 신청번호
					sql.setInt(i++, iSeqNo);	                     			// REQ_SEQ_NO 신청순번
					sql.setString(i++, userId);									// IN_EMP_ID 입고자사번
					sql.setString(i++, userId); 
					sql.setString(i++, userId); 
				
					res = update(sql);
					
					if (res != 1) {
						throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}					
					psql.put("MSS.PR_MGGIFTISSUEIN_NEW", 9);  
		            psql.setString(1, mi.getString("STAT_FLAG"));       //상태구분(01:신청, 02:발행의뢰 , 03:입고, 09: 취소)

		            if(mi.IS_DELETE()){
		            	psql.setString(2, "T");    	//삭제 구분 여부
		            }else{
			            psql.setString(2, "F");    	//삭제 구분 여부
		            }
		            psql.setString(3, form.getParam("strInDt")); 			//신청일자
		            psql.setString(4, form.getParam("strStrCd"));       	//신청점 
		            psql.setString(5, strSlipNo);                        //신청번호
		            psql.setInt(6, iSeqNo);                              //신청순번
		            psql.setString(7, userId);     						 //등록자
		            psql.setString(8, form.getParam("strRegDt"));     	//마스터등록일자.

		            psql.registerOutParameter(9, DataTypes.VARCHAR);	 //8 ERROR_CODE
		            prs = updateProcedure(psql);
		            

	                //System.out.println(" prs --- "  + prs.getString(8));		

		            if (!prs.getString(9).equals("0")) {
		            	 //throw new Exception("[USER]" + "상품권입고등록중 오류가 발생했습니다.");		            	 

		             	throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
		 						+ "데이터 입력을 하지 못했습니다.1");
		             	
		            }

		            iSeqNo  += 1;
					ret += 1;
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
