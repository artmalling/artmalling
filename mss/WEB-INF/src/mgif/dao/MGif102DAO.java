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
import kr.fujitsu.ffw.util.String2;
/**
 * <p>제휴/브랜드 상품권(쿠폰)마스터 등록</p>
 * 
 * @created  on 1.0, 2011/03/28
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif102DAO extends AbstractDAO {
	/**
	 * 상품권 공통코드 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getGiftCommCode(ActionForm form) throws Exception {

		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		if(form.getParam("strFlag").equals("s_flag")){
			strQuery = svc.getQuery("SEL_COMBO_ALL") + "\n";
			strQuery = strQuery + svc.getQuery("SEL_GIFT_TYPE_FLAG") + "\n";
		}
		if(form.getParam("strFlag").equals("flag")){
			strQuery = svc.getQuery("SEL_GIFT_TYPE_FLAG") + "\n";
		}
		if(form.getParam("strFlag").equals("payrec")){
			strQuery = svc.getQuery("SEL_PAYREC_FLAG") + "\n";
		}
		if(form.getParam("strFlag").equals("issue")){
			strQuery = svc.getQuery("SEL_ISSUE_TYPE") + "\n";
		}
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 상품권종류 정보 목록 조회
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
		sql.setString(i++, form.getParam("strGiftTypeFlag"));
		sql.setString(i++, form.getParam("strGiftTypeCd"));
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 금종  정보 목록 조회
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
		sql.setString(i++, form.getParam("strGiftTypeFlag"));
		sql.put(strQuery);
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 자사상품권 종류 마스터를 저장한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput[] mi, String userId)
			throws Exception {
		int ret = 0;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
        List	list 	 = null; 
		ProcedureWrapper psql = null;
		ProcedureResultSet prs = null;
		Service svc = null;
		String strSeq = "";
		String strGiftAmtType = "";
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			psql = new ProcedureWrapper();
			svc = (Service) form.getService();
			
			String StrGiftType = null;
			String strGiftTypeCd     = String2.nvl(form.getParam("strGiftTypeCd"));
			String strGiftFlag     	 = String2.nvl(form.getParam("strGiftFlag"));
			
			
			if(strGiftTypeCd.equals("")){
				sql.put(svc.getQuery("SEL_GIFT_TYPE_CD2"));
				sql.setString(1, strGiftFlag);				 	// 상품권 종류 구분
				sql.setString(2, strGiftFlag);				 	// 상품권 종류 구분
				
				list = select2List(sql);
	            List rowList = (List) list.get(0);
	               strSeq = rowList.get(0).toString();   
	               sql.close();
	               
	               StrGiftType = strSeq; 
			}
			else {
				StrGiftType = strGiftTypeCd;
			}
			 
               
			
			while(mi[0].next()){
				sql.close();
				i = 1;
				if(mi[0].IS_INSERT()){
					
				//	sql.setString(1, mi[0].getString("GIFT_TYPE_CD2"));
				//	Map map = (Map) selectMap(sql);
					//strCnt = map.get("CNT").toString();
					
					/*// 상품권 종류 코드가 999  인경우  발번 금지 
					if(strCnt.equals("1")) {
						throw new Exception("[USER]"+"이미 등록된 상품권 종류 정보 입니다.");
					} 
					*/
					sql.close();
					// 상품권종류 정보 저장
					sql.put(svc.getQuery("INS_GIFTTPMST")); 
					sql.setString(i++, StrGiftType); 											// 등록자
					sql.setString(i++, mi[0].getString("GIFT_TYPE_NAME")); 					// 상품권종류명
					sql.setString(i++, mi[0].getString("GIFT_TYPE_FLAG"));				 	// 상품권 종류 구분
					sql.setString(i++, mi[0].getString("USE_S_DT"));				 		// 사용기간종류
					sql.setString(i++, mi[0].getString("USE_E_DT"));				 		// 사용기간종류
					sql.setString(i++, mi[0].getString("PAYREC_FLAG")); 					// 지금/수취구분
					sql.setString(i++, mi[0].getString("VEN_CD"));				 			// 협력사코드
					sql.setString(i++, mi[0].getString("GROUP_CD")); 						// 그룹 코드
					sql.setString(i++, mi[0].getString("USE_YN").equals("T")?"Y":"N"); 		// 사용여부
					sql.setString(i++, userId); 											// 등록자
					sql.setString(i++, userId); 											// 수정자
					res = update(sql);
					
					
				}else if(mi[0].IS_UPDATE()){
					// 사은품 지급 등록
					sql.put(svc.getQuery("UPD_GIFTTPMST"));
					sql.setString(i++, mi[0].getString("GIFT_TYPE_NAME")); 					// 상품권종류명
					sql.setString(i++, mi[0].getString("GIFT_TYPE_FLAG"));				 	// 상품권 종류 구분
					sql.setString(i++, mi[0].getString("USE_S_DT")); 						// 사용기간시작
					sql.setString(i++, mi[0].getString("USE_E_DT"));				 		// 사용기간종류
					sql.setString(i++, mi[0].getString("PAYREC_FLAG")); 					// 지금/수취구분
					sql.setString(i++, mi[0].getString("VEN_CD"));				 			// 협력사코드
					sql.setString(i++, mi[0].getString("GROUP_CD")); 						// 그룹 코드
					sql.setString(i++, mi[0].getString("USE_YN").equals("T")?"Y":"N"); 		// 사용여부
					sql.setString(i++, userId); 								// 수정자
					sql.setString(i++, StrGiftType);				 	// 상품권 종류 코드
					res = update(sql);
				}
				
				if (res != 1) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
				sql.close();
		/*		sql.put(svc.getQuery("SEL_GIFT_TYPE_CD"));
				sql.setString(1, mi[0].getString("GIFT_TYPE_FLAG"));
				Map map = (Map) selectMap(sql);
				strGiftTpCd = map.get("GIFT_TYPE_CD").toString();
				*/
				// 상품권 종류 코드가 999  인경우  발번 금지 
				if(StrGiftType.equals("")) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				} 
				
				/*
				psql.put("MSS.PR_MGPOSGIFTCREATE", 7);  
				psql.setString(1, "1");    // 옵션(1:상품권종류/2:금종정보)
				if(mi[0].IS_INSERT()){
					psql.setString(2, "I");    // 생성구분(I:신규/U:수정)
				}else if(mi[0].IS_UPDATE()){
					psql.setString(2, "U");    // 생성구분(I:신규/U:수정)
				}
				psql.setString(3, StrGiftType);    // 상품권 종류
				psql.setString(4, "");    // 상품권 발행형태(有:발행형태/無:'')
				psql.setString(5, "");    // 상품권 금종코드(有:금종코드/無:'')
				psql.registerOutParameter(6, DataTypes.VARCHAR);
				psql.registerOutParameter(7, DataTypes.VARCHAR);  
				
				prs = updateProcedure(psql);

	            if (!prs.getString(6).equals("0")) {
	            	 throw new Exception("[USER]" + prs.getString(7));
	            }*/
			}
			// 상품권종류별 금종관리 수정/등록
			while (mi[1].next()) {
				i = 1;
				sql.close();
				System.out.println((mi[1].IS_INSERT()));
				if(mi[1].getString("GIFT_AMT_TYPE").equals("")){
					sql.put(svc.getQuery("SEL_NEW_GIFT_AMT_TYPE"));
					sql.setString(1, StrGiftType); 									// 상품권 종류 코드
					sql.setString(2, mi[1].getString("ISSUE_TYPE")); 					// 발행형태
					Map map = (Map) selectMap(sql);
					strGiftAmtType = map.get("GIFT_AMT_TYPE").toString();
					
					sql.close();
					sql.put(svc.getQuery("INS_GIFTAMTMST"));
					sql.setString(i++, StrGiftType); 				// 상품권 종류 코드
					sql.setString(i++, mi[1].getString("ISSUE_TYPE")); 					// 발행형태
					sql.setString(i++, strGiftAmtType); 								// 금종
					sql.setString(i++, mi[1].getString("GIFT_AMT_NAME")); 				// 금종명
					sql.setString(i++, mi[1].getString("GIFTCERT_AMT")); 				// 상품권금액
					sql.setString(i++, mi[1].getString("RFD_PERMIT_RATE")); 			// 환불허용율
					sql.setString(i++, mi[1].getString("USE_YN").equals("T")?"Y":"N"); 	// 사용여부
					sql.setString(i++, userId); 										// 등록자
					sql.setString(i++, userId); 										// 수정자
					res = update(sql);
				}else {
					sql.put(svc.getQuery("UPD_GIFTAMTMST"));
					sql.setString(i++, mi[1].getString("GIFT_AMT_NAME")); 				// 금종명
					sql.setString(i++, mi[1].getString("GIFTCERT_AMT")); 				// 상품권금액
					sql.setString(i++, mi[1].getString("RFD_PERMIT_RATE")); 			// 환불허용율
					sql.setString(i++, mi[1].getString("USE_YN").equals("T")?"Y":"N"); 	// 사용여부
					sql.setString(i++, userId); 										// 수정자
					sql.setString(i++, StrGiftType); 				// 상품권 종류 코드
					sql.setString(i++, mi[1].getString("ISSUE_TYPE")); 					// 발행형태
					sql.setString(i++, mi[1].getString("GIFT_AMT_TYPE")); 				// 금종
					res = update(sql);
				}
				
				if (res != 1) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
				/*
				psql.clearParameter();
				psql.put("MSS.PR_MGPOSGIFTCREATE", 7);  
				psql.setString(1, "2");    // 옵션(1:상품권종류/2:금종정보)
				if(mi[1].IS_INSERT()){
					psql.setString(2, "I");    // 생성구분(I:신규/U:수정)
				}else if(mi[1].IS_UPDATE()){
					psql.setString(2, "U");    // 생성구분(I:신규/U:수정)
				}
				psql.setString(3, StrGiftType);    // 상품권 종류
				psql.setString(4, mi[1].getString("ISSUE_TYPE"));    // 상품권 발행형태(有:발행형태/無:'')
				psql.setString(5, strGiftAmtType.equals("")?mi[1].getString("GIFT_AMT_TYPE"):strGiftAmtType);    // 상품권 금종코드(有:금종코드/無:'')
				psql.registerOutParameter(6, DataTypes.VARCHAR);
				psql.registerOutParameter(7, DataTypes.VARCHAR);  
				
				prs = updateProcedure(psql);
				
	            if (!prs.getString(6).equals("0")) {
	            	 throw new Exception("[USER]" + prs.getString(7));
	            }
	            */
	            
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
}
