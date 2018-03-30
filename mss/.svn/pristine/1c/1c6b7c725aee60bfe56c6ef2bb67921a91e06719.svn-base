/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.util.List;
import java.util.Map;

import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>행사 마스터</p>
 * 
 * @created  on 1.0, 2010/12/14
 * @created  by 김성미(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */
public class MCae106DAO extends AbstractDAO {
	/**
	 * 행사 마스터 정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getEvtMst(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strSdt = String2.nvl(form.getParam("strSdt"));
		String strEdt = String2.nvl(form.getParam("strEdt"));
		String strEventCd = String2.nvl(form.getParam("strEventCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_EVTMST") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSdt);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strSdt);
		sql.setString(i++, strEdt);
		sql.setString(i++, strEventCd);
		
		sql.put(strQuery);
		
		ret = select2List(sql);
		return ret;
	}
	
	/**
	 * 사은 행사 마스터 정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getStrEvt(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strEventCd = String2.nvl(form.getParam("strEventCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		strQuery = svc.getQuery("SEL_STREVT") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strEventCd);
		
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}
	
	
	/**
	 * 사은 행사 마스터 정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List[] getStrEvtInfo(ActionForm form) throws Exception {
		
		List ret[] = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strEventCd = String2.nvl(form.getParam("strEventCd"));
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		ret = new List[2];
		try{
			connect("pot");

			strQuery = svc.getQuery("SEL_EVTSTRPBN");
			sql.put(strQuery);
			sql.setString(1, strStrCd);
			sql.setString(2, strEventCd);
			ret[0] = select2List(sql);
			
			sql.close();
			strQuery = svc.getQuery("SEL_EVTSTRSKU");
			sql.put(strQuery);
			sql.setString(1, strStrCd);
			sql.setString(2, strEventCd);
			ret[1] = select2List(sql);
		}catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}
	
	/**
	 * 브랜드마스터(브랜드) 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getEvtPbn(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strDept = String2.nvl(form.getParam("strDept"));
		String strTeam = String2.nvl(form.getParam("strTeam"));
		String strPc = String2.nvl(form.getParam("strPc"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_EVTPBN") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strStrCd+strDept+strTeam+strPc);
		
		sql.put(strQuery);
		
		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 대상코드 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getTrg(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_TRG") + "\n";
		sql.setString(i++, strStrCd);
		
		sql.put(strQuery);
		
		ret = select2List(sql);

		return ret;
	}
	
	
	/**
	 * 사은 행사 정보 저장
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
		SqlWrapper sql = null;
		Service svc = null;
		
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			// 사은행사 마스터 저장
			saveMst(svc, mi[0], userId);
			
			mi[3].next();
			// 사은행사 대상브랜드 저장
			if(form.getParam("strAllBrand").equals("true")){
				//전관행사시 '******'으로 등록 - 기존 브랜드 등록 내용 삭제
				sql.put(svc.getQuery("DEL_EVTSTRPBN_ALL")); 
				sql.setString(1, mi[3].getString("STR_CD"));
				sql.setString(2, mi[3].getString("EVENT_CD"));
				res = update(sql);
				sql.close();
				
				sql.put(svc.getQuery("INS_EVTSTRPBN")); 
				sql.setString(1, mi[3].getString("STR_CD"));
				sql.setString(2, mi[3].getString("EVENT_CD"));
				sql.setString(3, "******");
				sql.setString(4, "100");
				sql.setString(5, userId);
				sql.setString(6, userId);
				
				res = update(sql);
				
				if (res != 1) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
			}else{
				//브랜드별 행사시 기존 '******' 내역 삭제
				sql.put(svc.getQuery("DEL_EVTSTRPBN")); 
				sql.setString(1, mi[3].getString("STR_CD"));
				sql.setString(2, mi[3].getString("EVENT_CD"));
				sql.setString(3,"******");
				res = update(sql);
				
				savePumbun(svc, mi[1], userId);
			}
			
			// 사은행사 상품 저장
			saveSku(svc, mi[2], userId);

			if(mi[3].getString("EVENT_TYPE").equals("02") && mi[0].getRowNum() > 0){
				// 사은행사 제휴 카드 저장
				saveCard(svc, mi[3], userId);
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
	 * 사은행사 마스터 저장
	 * @param svc 
	 * @param mi 
	 * @param userId 
	 * 
	 * @throws Exception
	 */
	public int saveMst(Service svc, MultiInput mi, String userId)
			throws Exception {
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			while(mi.next()){
				sql.close();
				  
				if (mi.IS_INSERT()) { // 저장
					sql.put(svc.getQuery("INS_STREVT")); 
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("EVENT_CD"));
					sql.setString(i++, mi.getString("EVENT_TYPE"));
					sql.setString(i++, mi.getString("EVENT_GIFT_TYPE"));
					sql.setString(i++, mi.getString("CHAR_ID"));
					sql.setString(i++, mi.getString("ORG_CD"));
					sql.setString(i++, userId);
					sql.setString(i++, userId);
					sql.setString(i++, mi.getString("EVENT_GIFT_CYC"));
					sql.setString(i++, mi.getString("RECP_ADD_YN"));
					sql.setString(i++, mi.getString("RECP_TODAY_YN"));
					sql.setString(i++, mi.getString("CUST_ONLY_YN"));
					sql.setString(i++, mi.getString("CARD_ONLY_YN"));
					sql.setString(i++, mi.getString("PC_EVENT_TYPE"));
					sql.setString(i++, mi.getString("CARD_COMP"));
				}else if(mi.IS_UPDATE()){// 담당자만 수정 가능
					sql.put(svc.getQuery("UPD_STREVT")); 
					sql.setString(i++, mi.getString("CHAR_ID"));
					sql.setString(i++, mi.getString("ORG_CD"));
					sql.setString(i++, userId);
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("EVENT_CD"));
				}
				res = update(sql);
	
				if (res != 1) {
					throw new Exception("[USER]"+"사은행사 마스터 내용을 실패 하였습니다.");
				}
			}
		} catch (Exception e) {
			throw e;
		}
		return res;
	}
	
	/**
	 * 사은행사 브랜드 저장/수정/삭제
	 * @param svc 
	 * @param mi 
	 * @param userId 
	 * 
	 * @throws Exception
	 */
	public int savePumbun(Service svc, MultiInput mi, String userId)
			throws Exception {
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			while(mi.next()){
				sql.close();
				i = 1;
				if (mi.IS_INSERT()) { // 저장
					sql.put(svc.getQuery("INS_EVTSTRPBN")); 
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("EVENT_CD"));
					sql.setString(i++, mi.getString("PUMBUN_CD"));
					sql.setString(i++, mi.getString("APP_RATE"));
					sql.setString(i++, userId);
					sql.setString(i++, userId);
				}else if(mi.IS_UPDATE()){// 인정률 수정
					sql.put(svc.getQuery("UPD_EVTSTRPBN")); 
					sql.setString(i++, mi.getString("APP_RATE"));
					sql.setString(i++, userId);
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("EVENT_CD"));
					sql.setString(i++, mi.getString("PUMBUN_CD"));
				}else if(mi.IS_DELETE()){// 인정률 삭제
					sql.put(svc.getQuery("DEL_EVTSTRPBN")); 
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("EVENT_CD"));
					sql.setString(i++, mi.getString("PUMBUN_CD"));
				}
				
				res = update(sql);
	
				if (res != 1) {
					throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
			}
		} catch (Exception e) {
			throw e;
		}
		return res;
	}
	
	/**
	 * 사은행사 사은품 저장/수정/삭제
	 * @param svc 
	 * @param mi 
	 * @param userId 
	 * 
	 * @throws Exception
	 */
	public int saveSku(Service svc, MultiInput mi, String userId)
			throws Exception {
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		List intCnt = null;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			while(mi.next()){
				if (!mi.getString("SKU_CD").equals("")) {
					//등록된 제휴카드 정보가 있는지 조회
					sql.close();
					i = 1;
					sql.put(svc.getQuery("SEL_EVTSTRSKU_CNT"));
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("EVENT_CD"));
					sql.setString(i++, mi.getString("SKU_CD"));
					intCnt = select2List(sql);
					sql.close();
					i = 1;
					if (intCnt.size() == 0 && mi.IS_INSERT()) { // 저장
						sql.put(svc.getQuery("INS_EVTSTRSKU")); 
						sql.setString(i++, mi.getString("STR_CD"));
						sql.setString(i++, mi.getString("EVENT_CD"));
						sql.setString(i++, mi.getString("SKU_CD"));
						sql.setString(i++, mi.getString("TRG_CD"));
						sql.setString(i++, mi.getString("SKU_GB"));
						//sql.setString(i++, "1");
						sql.setString(i++, mi.getString("BUY_COST_PRC"));
						sql.setString(i++, mi.getString("TRG_F"));
						sql.setString(i++, mi.getString("TRG_T"));
						sql.setString(i++, "N");
						sql.setString(i++, userId);
						sql.setString(i++, userId);
		
					}else if(mi.IS_UPDATE() || (intCnt.size() == 1 && mi.IS_INSERT())){// 수정
						sql.put(svc.getQuery("UPD_EVTSTRSKU")); 
						sql.setString(i++, mi.getString("TRG_CD"));
						sql.setString(i++, mi.getString("BUY_COST_PRC"));
						sql.setString(i++, mi.getString("TRG_F"));
						sql.setString(i++, mi.getString("TRG_T"));
						sql.setString(i++, "N");
						sql.setString(i++, userId);
						sql.setString(i++, mi.getString("STR_CD"));
						sql.setString(i++, mi.getString("EVENT_CD"));
						sql.setString(i++, mi.getString("SKU_CD"));
					}else if(mi.IS_DELETE()){// 삭제
						sql.put(svc.getQuery("DEL_EVTSTRSKU")); 
						sql.setString(i++, "Y");
						sql.setString(i++, userId);
						sql.setString(i++, mi.getString("STR_CD"));
						sql.setString(i++, mi.getString("EVENT_CD"));
						sql.setString(i++, mi.getString("SKU_CD"));
					}
					res = update(sql);
		
					if (res != 1) {
						throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
				}
			}
		} catch (Exception e) {
			throw e;
		}
		return res;
	}
	
	/**
	 * 사은행사 제휴카드 저장/수정
	 * @param svc 
	 * @param mi 
	 * @param userId 
	 * 
	 * @throws Exception
	 */
	public int saveCard(Service svc, MultiInput mi, String userId)
			throws Exception {
		int res = 0;
		int i = 1;
		SqlWrapper sql = null;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			sql.put(svc.getQuery("DEL_EVTCARD")); 
			sql.setString(1, mi.getString("STR_CD"));
			sql.setString(2, mi.getString("EVENT_CD"));
			res = update(sql);
			
			sql.close();
			sql.put(svc.getQuery("INS_EVTCARD")); 
			sql.setString(i++, mi.getString("STR_CD"));
			sql.setString(i++, mi.getString("EVENT_CD"));
			sql.setString(i++, mi.getString("CARD_COMP"));
			sql.setString(i++, mi.getString("VEN_CD"));
			sql.setString(i++, mi.getString("APP_RATE"));
			sql.setString(i++, userId);
			sql.setString(i++, userId);
			res = update(sql);
			if (res != 1) {
				throw new Exception("[USER]"+"데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
		} catch (Exception e) {
			throw e;
		} 
		return res;
	}

}
