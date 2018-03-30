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
 * <p>좌측 프레임 구성</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 정지인(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MGif215DAO extends AbstractDAO {
	/**
	 * 위탁출고 등록 마스터  조회
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
		
		String strOutGb = null;
		String strOutGb1 = null;

		if (form.getParam("strOutGb").equals("%")) {
			strOutGb = "03";
			strOutGb1 = "04";
		} else {
			strOutGb = form.getParam("strOutGb");
			strOutGb1 = form.getParam("strOutGb");
		}
		
		strQuery = svc.getQuery("SEL_MASTER") + "\n";
		
		sql.setString(i++, strOutGb);
		sql.setString(i++, strOutGb1);
		
		sql.setString(i++, form.getParam("strStrCd"));
		sql.setString(i++, form.getParam("strOutDtFrom"));
		sql.setString(i++, form.getParam("strOutDtTo"));
		sql.setString(i++, form.getParam("strVenCd")); 
		sql.put(strQuery);
		
		ret = select2List(sql);
		
		return ret;
	}
	
	/**
	 * 위탁출고 등록 디테일  조회
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
		
		sql.setString(i++, form.getParam("strStatFlag"));
		sql.setString(i++, form.getParam("strStrCd"));
		sql.setString(i++, form.getParam("strOutDt"));
		sql.setString(i++, form.getParam("strOutSlipNo"));
		sql.put(strQuery);
		
		ret = select2List(sql);
		
		return ret;
	}
	
	/**
	 * 위탁출고 상품권 등록 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getConf(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strGiftNo = String2.nvl(form.getParam("strGiftNo"));		//상품권 번호
		String strStrCd = String2.nvl(form.getParam("strStrCd"));		//상품권 번호
		String strOutGb = String2.nvl(form.getParam("strOutGb"));		//출고 구분
		String strVenCd = String2.nvl(form.getParam("strVenCd"));		//협력사
		String strOutDt = String2.nvl(form.getParam("strOutDt"));		//협력사
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_GIFT_INSERT") + "\n";
		sql.setString(i++, strGiftNo);
		sql.setString(i++, strStrCd);
		
		if(strOutGb.equals("04")) {
			strQuery += svc.getQuery("WHERE_SELRFD") + "\n";
			sql.setString(i++, strVenCd);
			sql.setString(i++, strOutDt);
		}
		else
		{
			strQuery += svc.getQuery("WHERE_SELOUT") + "\n";
			sql.setString(i++, strOutDt);
		}
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
		
		
	}
	
	/**
	 * 유효 상품권 개수 조회
	 * 
	 * @param form 
	 * @return
	 * @throws Exception
	 */
	public List getCnt(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		
		String strOutGb = String2.nvl(form.getParam("strOutGb"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		connect("pot");
		
		if(strOutGb.equals("03")) {
			strQuery = svc.getQuery("OUTSEL_CNT") + "\n";
			sql.setString(1, String2.nvl(form.getParam("strSGiftNo")));
			sql.setString(2, String2.nvl(form.getParam("strEGiftNo")));
			sql.setString(3, String2.nvl(form.getParam("strStrCd")));
			sql.setString(4, String2.nvl(form.getParam("strOutDt")));
			sql.setString(5, String2.nvl(form.getParam("strSGiftNo")));
			sql.setString(6, String2.nvl(form.getParam("strEGiftNo")));
			sql.setString(7, String2.nvl(form.getParam("strStrCd")));
			sql.setString(8, String2.nvl(form.getParam("strOutDt")));
		}
		else
		{
			strQuery = svc.getQuery("RFDSEL_CNT") + "\n";
			sql.setString(1, String2.nvl(form.getParam("strSGiftNo")));
			sql.setString(2, String2.nvl(form.getParam("strEGiftNo")));
			sql.setString(3, String2.nvl(form.getParam("strSGiftNo")));
			sql.setString(4, String2.nvl(form.getParam("strEGiftNo")));
			sql.setString(5, String2.nvl(form.getParam("strVenCd")));
			sql.setString(6, String2.nvl(form.getParam("strOutDt")));
		}


		sql.put(strQuery);
		ret = select2List(sql);
		
		return ret;
	}
	
	/**
	 * 위탁출고 저장
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String userId,String orgCd)
			throws Exception {
		int ret = 0;
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		Service svc = null;
		String strSlipNo = "";
		String strSaleSlipNo = "";
		ProcedureWrapper psql = null;
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			String strOutGb = String2.nvl(form.getParam("strOutGb"));
			
			//위탁출고 상품권 판매로 생성한다.(상품권판매M)
			/*로직 변경으로  주석처리*/
			String strStrCd = String2.nvl(form.getParam("strStrCd"));
			String strOutDt = String2.nvl(form.getParam("strOutDt"));
			String strTotalAmt = String2.nvl(form.getParam("strTotalAmt"));
			/*
			i=1;
			sql.close();
			 
			//판매전표 번호 생성
			sql.put(svc.getQuery("SEL_SALE_SLIP_NO"));
			Map map1 = (Map) selectMap(sql);
			strSaleSlipNo = map1.get("SLIP_NO").toString();
			sql.close();
			System.out.println("333");
			//상품권 판매 마스터 등록
			sql.put(svc.getQuery("INS_MG_SALEMST"));
			
	        sql.setString(i++, strOutDt);				// 일자
	        sql.setString(i++, strStrCd);				// 점
			sql.setString(i++, strSaleSlipNo);			//순번
			sql.setString(i++, orgCd); 					//조직코드
			sql.setString(i++, strTotalAmt); 			//금액 SUM
			
			sql.setString(i++, strOutDt); 			//
			sql.setString(i++, strStrCd); 			// 
			sql.setString(i++, strSaleSlipNo); 			//
			
			sql.setString(i++, userId);				// 신청수량
			sql.setString(i++, userId);				// 상품권종료번호
			res = update(sql);
			if (res == 0) {
				throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}*/
			
			while(mi.next()){
				i=1;
				sql.close();
				
				if(strSlipNo.equals("")){
					sql.put(svc.getQuery("SEL_SLIP_NO"));
					Map map2 = (Map) selectMap(sql);
					strSlipNo = map2.get("SLIP_NO").toString();
					sql.close();
				}
				
				sql.put(svc.getQuery("INS_MG_OUTREQCONF"));
				
				sql.setString(i++, mi.getString("OUT_DT"));				 	
				sql.setString(i++, mi.getString("OUT_STR"));				
				sql.setString(i++, strSlipNo); 								
				sql.setString(i++, mi.getString("OUT_DT"));
				sql.setString(i++, mi.getString("OUT_STR"));
				sql.setString(i++, strSlipNo); 	
				
				sql.setString(i++, mi.getString("GIFT_TYPE_CD"));			// 금종
				sql.setString(i++, mi.getString("ISSUE_TYPE"));				// 신청수량
				sql.setString(i++, mi.getString("GIFT_AMT_TYPE"));			// 상품권종료번호
				sql.setString(i++, mi.getString("GIFT_S_NO"));				// 신청수량
				sql.setString(i++, mi.getString("GIFT_E_NO"));				// 상품권종료번호
				sql.setString(i++, mi.getString("OUT_QTY"));
				sql.setString(i++, mi.getString("VEN_CD"));
				sql.setString(i++, strOutGb);
				sql.setString(i++, userId); 
				sql.setString(i++, userId); 
				
				res = update(sql);
				if (res == 0) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
				ret += 1; 
				
				//상품권 마스터 수정
				i=1;
				sql.close(); 
				String strQuery = svc.getQuery("UPD_MG_GIFTMST") + "\n";
				if(strOutGb.equals("03")){
					strQuery += svc.getQuery("UPD_MG_GIFTMST_IN_DT");
				}else{
					strQuery += svc.getQuery("UPD_MG_GIFTMST_OUT_DT");
				}
				
				sql.put(strQuery);
				sql.setString(i++, strOutGb); 
				sql.setString(i++, mi.getString("OUT_DT"));  				//위탁출고 일자
				sql.setString(i++, mi.getString("OUT_STR"));				//위탁출고 점
				sql.setString(i++, strOutGb); 								//위탁출고 구분
				sql.setString(i++, mi.getString("VEN_CD"));					//위탁출고 협력사
				sql.setString(i++, userId); 
				sql.setString(i++, mi.getString("GIFT_S_NO"));				// 상품권 시작 번호
				sql.setString(i++, mi.getString("GIFT_E_NO"));				// 상품권 종료 번호
				sql.setString(i++, strOutDt);				
				
				res = update(sql);
				if (res == 0) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				
				/*로직 변경으로 주석 처리*/
				/*//프로시저 
				i = 1; 
				psql = new ProcedureWrapper();
				ProcedureResultSet prs = null;

				psql.close();
				psql.put("MSS.PR_SALEDTL", 9);
				
				psql.setString(1, mi.getString("OUT_DT"));
				psql.setString(2, mi.getString("OUT_STR"));
				psql.setString(3, strSlipNo);
				psql.setString(4, mi.getString("GIFT_S_NO"));
				psql.setString(5, mi.getString("GIFT_E_NO"));
				psql.setString(6, userId);
				psql.setString(7, orgCd);
				psql.registerOutParameter(8, DataTypes.VARCHAR); // return value(에러
				psql.registerOutParameter(9, DataTypes.VARCHAR);

				prs = selectProcedure(psql);
				String ret1 = prs.getString(8);
				
				if (ret1 == "1") {
					throw new Exception("[USER]"+"프로시저 오류입니다..");
				}*/
				
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
