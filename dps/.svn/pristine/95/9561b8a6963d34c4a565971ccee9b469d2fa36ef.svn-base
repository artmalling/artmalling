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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper; 
import kr.fujitsu.ffw.util.String2;

/**
 * <p> 청구대상 데이터 조회DAO </p>
 * 
 * @created on 1.0, 2010/05/31
 * @created by 김영진
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class PSal916DAO extends AbstractDAO {
	/**
	 * <p>
	 * 청구대상 데이터 조회
	 * </p>
	 * 
	 */
	public List searchMaster(ActionForm form) throws Exception {
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		
		String query = "";

		int i = 1;
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));  
		String strRcvDt  = String2.nvl(form.getParam("strRcvDt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		query = svc.getQuery("SEL_MASTER") + "\n"; 
		sql.setString(i++, strStrCd);
		sql.setString(i++, strRcvDt);
				
		sql.put(query);
		ret = select2List(sql);
		
		return ret;
	}
	
	/**
	 * 청구대상데이터 수정  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int ret = 0;
		int res = 0;		
		SqlWrapper sql = null;
		Service svc = null;	
				
		String orgCdCnt = "";
		int i;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();	
			String strStrCd    = String2.nvl(form.getParam("strStrCd"));

			while (mi.next()) {
				sql.close();
				
				if (mi.IS_INSERT()) {
                    
					i = 0;					
					/*
					sql.put(svc.getQuery("INS_PD_BUYREQPREPHOLD"));	
					
					sql.setString(++i, strStrCd);
					sql.setString(++i, mi.getString("BCOMP_CD"));
					sql.setString(++i, mi.getString("JBRCH_ID"));
					sql.setString(++i, mi.getString("APPR_COUNT"));
					sql.setString(++i, mi.getString("APPR_AMT"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);	
					*/	
					sql.put(svc.getQuery("INS_PD_BUYREQXLS"));	
					
					sql.setString(++i, mi.getString("SALE_DT"));
					sql.setString(++i, mi.getString("WORK_FLAG"));
					sql.setString(++i, mi.getString("CARD_NO")); //카드번호 암호화
					sql.setString(++i, mi.getString("EXP_DT"));
					sql.setString(++i, mi.getString("DIV_MONTH"));
					sql.setString(++i, mi.getString("APPR_AMT"));
					sql.setString(++i, mi.getString("SVC_AMT"));
					sql.setString(++i, mi.getString("APPR_NO"));
					sql.setString(++i, mi.getString("APPR_DT"));
					sql.setString(++i, mi.getString("APPR_TIME"));
					sql.setString(++i, mi.getString("CAN_DT"));
					sql.setString(++i, mi.getString("CAN_TIME"));
					sql.setString(++i, mi.getString("DOLLAR_FLAG"));
					sql.setString(++i, mi.getString("FILLER"));
					sql.setString(++i, mi.getString("POS_NO"));
					sql.setString(++i, mi.getString("TRAN_NO"));
					sql.setString(++i, mi.getString("POS_SEQ_NO"));
					sql.setString(++i, mi.getString("POS_SEQ_NO"));
					sql.setString(++i, mi.getString("PAY_TYPE"));
					sql.setString(++i, strStrCd);
					sql.setString(++i, strStrCd);
					sql.setString(++i, strStrCd);
					sql.setString(++i, mi.getString("CARD_NO"));
					sql.setString(++i, mi.getString("CARD_NO"));
					sql.setString(++i, strStrCd);
					sql.setString(++i, mi.getString("CARD_NO"));
					sql.setString(++i, mi.getString("POS_NO"));
					sql.setString(++i, strID);	
					sql.setString(++i, strID);
					
				}else if (mi.IS_UPDATE()) {					
					i = 0;
					sql.put(svc.getQuery("PD_BUYREQPREPHOLD_COUNT"));							
					sql.setString(++i, mi.getString("PROC_DT"));
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("BCOMP_CD"));
					sql.setString(++i, mi.getString("JBRCH_ID"));
					
					Map map = selectMap( sql );							
					orgCdCnt = String2.nvl((String)map.get("CNT"));
					System.out.println(orgCdCnt);
					if( !orgCdCnt.equals("0")) {
						sql.close();
						
						i = 0;	
						
						sql.put(svc.getQuery("UPD_PD_BUYREQPREPHOLD"));	
						
						sql.setString(++i, mi.getString("APPR_COUNT"));
						sql.setString(++i, mi.getString("APPR_AMT"));					
						sql.setString(++i, strID);
						sql.setString(++i, mi.getString("PROC_DT"));
						sql.setString(++i, mi.getString("STR_CD"));
						sql.setString(++i, mi.getString("BCOMP_CD"));
						sql.setString(++i, mi.getString("JBRCH_ID"));
					}else{
						sql.close();
						
						i = 0;					
						
						sql.put(svc.getQuery("INS_PD_BUYREQPREPHOLD"));	
						
						sql.setString(++i, strStrCd);
						sql.setString(++i, mi.getString("BCOMP_CD"));
						sql.setString(++i, mi.getString("JBRCH_ID"));
						sql.setString(++i, mi.getString("APPR_COUNT"));
						sql.setString(++i, mi.getString("APPR_AMT"));
						sql.setString(++i, strID);
						sql.setString(++i, strID);
					}
				}	
				res = update(sql);				

				if (res == 0) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
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
	 * <p>
	 * 월관리비 저장
	 * </p>
	 */
	public int delete(ActionForm form, MultiInput mi)
			throws Exception {
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		String orgCdCnt = "";
		
		try {
			connect("pot");
			begin();	
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				res = 0;
				sql.close();
				if ( mi.IS_DELETE()){
					int i = 0;	
					
					sql.put(svc.getQuery("DEL_PD_BUYREQXLS"));
					sql.setString(++i, mi.getString("RCV_DT"));
					sql.setString(++i, mi.getString("SEQ_NO"));
					sql.setString(++i, mi.getString("STR_CD"));			
					
					res = update(sql);	
				} 

				if (res < 1) {
					throw new Exception("" + "데이터의 적합성 문제로 인하여"
							+ "데이터를 처리 하지 못했습니다.");
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
}
