/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package meis.dao;

import java.util.ArrayList;
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

import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import common.util.Util;

/**
 * <p>계정별비용계획관리</p>
 * 
 * @created on 1.0, 2011/05/23
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis026DAO extends AbstractDAO {

	/**
	 * 계정별 비용계획조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchAcc(ActionForm form) throws Exception {

		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strPlanY = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); //점코드
			strPlanY = String2.trimToEmpty(form.getParam("strPlanY")); //경영계획년도

			strLoc = "SEL_ACC";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPlanY);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPlanY);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 조직별 비용계획조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchOrg(ActionForm form) throws Exception {
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strPlanY = null;
		String strAccCd = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); //점코드
			strPlanY = String2.trimToEmpty(form.getParam("strPlanY")); //경영계획년도
			strAccCd = String2.trimToEmpty(form.getParam("strAccCd")); //계정항목코드

			strLoc = "SEL_ORG";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPlanY);
			sql.setString(i++, strAccCd);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;
		
	}
	
	/**
	 * 월별 비용계획조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMonth(ActionForm form) throws Exception {
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strStrCd = null;
		String strPlanY = null;
		String strAccCd = null;
		String strOrgCd = null;

		try {
			//파라미터 값 가져오기
			strStrCd = String2.trimToEmpty(form.getParam("strStrCd")); //점코드
			strPlanY = String2.trimToEmpty(form.getParam("strPlanY")); //경영계획년도
			strAccCd = String2.trimToEmpty(form.getParam("strAccCd")); //계정항목코드
			strOrgCd = String2.trimToEmpty(form.getParam("strOrgCd")); //조직코드

			strLoc = "SEL_MONTH";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPlanY);
			sql.setString(i++, strAccCd);
			sql.setString(i++, strOrgCd);
			sql.setString(i++, strPlanY+"01");
			sql.setString(i++, strPlanY+"12");
			sql.setString(i++, strAccCd);
			sql.setString(i++, strStrCd);
			sql.setString(i++, strPlanY);
			sql.setString(i++, strOrgCd);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;

	}
	
	/**
	 * 조직기타정보 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchEtc(ActionForm form) throws Exception {
		List ret        = null;
		SqlWrapper sql  = null;
		Service svc     = null;
		String strLoc   = null;
		int i           = 1;
		//파라미터 변수선언
		String strOrgCd = null;

		try {
			//파라미터 값 가져오기
			strOrgCd = String2.trimToEmpty(form.getParam("strOrgCd")); //점코드

			strLoc = "SEL_ORG_INFO";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			sql.setString(i++, strOrgCd);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;
		
	}
	
	/**
	 * 년월별 비용계획 등록/수정
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strUserId)
			throws Exception {
		int ret        = 0;
		int i          = 1;
		Service svc    = null;
		SqlWrapper sql = null;
		try {
			begin();
			connect("pot");
			
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			
			while(mi[0].next()){
				if(mi[0].IS_DELETE()){
					i = 1;
					sql.put(svc.getQuery("DEL_ORG_ACCPLAN")); 
					sql.setString(i++, mi[0].getString("STR_CD"));
					sql.setString(i++, mi[0].getString("ACC_CD"));
					sql.setString(i++, mi[0].getString("ORG_CD"));
					sql.setString(i++, mi[0].getString("BIZ_PLAN_YEAR"));
					ret += this.update(sql);
					sql.close();
				} else{
					while(mi[1].next()){
						i = 1;
						sql.put(svc.getQuery("UST_ACCPLAN")); 
						sql.setString(i++, mi[1].getString("BIZ_PLAN_YM"));
						sql.setString(i++, mi[1].getString("STR_CD"));
						sql.setString(i++, mi[1].getString("ACC_CD"));
						sql.setString(i++, mi[1].getString("ORG_CD"));
						sql.setString(i++, mi[1].getString("BIZ_PLAN_YEAR"));
						sql.setString(i++, mi[1].getString("PLAN_AMT"));
						sql.setString(i++, strUserId);
						sql.setString(i++, mi[1].getString("ORG_CD"));
						sql.setString(i++, mi[1].getString("ORG_CD"));
						ret += this.update(sql);
						sql.close();
					}
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
	 * 계정별 비용삭제
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form, MultiInput mi)
			throws Exception {
		int ret        = 0;
		int i          = 0;
		Service svc    = null;
		SqlWrapper sql = null;
		try {
			begin();
			connect("pot");
			
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			//계정별 비용삭제
			if(mi.next()){
				sql.put(svc.getQuery("DEL_ACC_ACCPLAN"));
				sql.setString(++i, mi.getString("STR_CD"));
				sql.setString(++i, mi.getString("ACC_CD"));
				sql.setString(++i, mi.getString("BIZ_PLAN_YEAR"));

				ret = this.update(sql);
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
	 * 확정(확정취소)처리
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int confirm(ActionForm form, MultiInput mi, String strUserId)
			throws Exception {
		int ret        = 0;
		int i          = 0;
		Service svc    = null;
		SqlWrapper sql = null;
		String strConf = null;
		String strFlag = null;
		ProcedureResultSet procResult = null;
		try {
			begin();
			connect("pot");
			
			strConf = String2.trimToEmpty(form.getParam("strConf"));
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			//계정별 비용삭제
			if(mi.next()){
				
				if("1".equals(strConf)){
					sql.put(svc.getQuery("CONF_ACCPLAN"));
					sql.setString(++i, "2");
					strFlag = "C";
					sql.setString(++i, strUserId);
					sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("BIZ_PLAN_YEAR"));
				} else {
					sql.put(svc.getQuery("CONF_CANCEL_ACCPLAN"));
					sql.setString(++i, "1");
					strFlag = "D";
					sql.setString(++i, strUserId);
					//sql.setString(++i, mi.getString("STR_CD"));
					sql.setString(++i, mi.getString("BIZ_PLAN_YEAR"));
				}
				

				ret = this.update(sql);
				if(ret < 1){
					throw new Exception("[USER]확정(확정취소)처리를 실패하였습니다.");
				}
				
				procResult = confirm(svc, mi.getString("STR_CD"), mi.getString("BIZ_PLAN_YEAR"), strFlag);
				//에러처리
				if (!"0".equals(procResult.getString(4)))
					throw new Exception("[USER]"+ procResult.getString(5));
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
	 * 확정(확정취소)처리별 항목별경영계획집계 처리
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	private ProcedureResultSet confirm(Service svc, String strStrCd, String strPlanY, String strGubun)
			throws Exception {

		ProcedureWrapper proc = null;
		int i = 0;
		proc = new ProcedureWrapper();
		proc.put("MSS.PR_MEBIZPLANCRE", 5);

		proc.setString(++i, strStrCd);
		proc.setString(++i, strPlanY);
		proc.setString(++i, strGubun);
		proc.registerOutParameter(++i, DataTypes.VARCHAR);
		proc.registerOutParameter(++i, DataTypes.VARCHAR);

		return updateProcedure(proc);

	}
	
	/**
	 * 엑셀업로드 데이터의 벨리데이션 체크
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List checkValidation(ActionForm form, GauceDataSet ds)
			throws Exception {
		Service svc        = null;
		GauceDataRow grow  = null;
		List rtn           = null;
		List rtnRow        = null;
		String strStrCd    = null;
		String strStrNm    = null;
		String strAccCd    = null;
		String strAccNm    = null;
		String strOrgCd    = null;
		String strOrgNm    = null;
		String strPlanYm   = null;
		String strPlanAmt  = null;
		try {
			connect("pot");
			svc  = (Service) form.getService();
			rtn  = new ArrayList();
			for(int i = 0; i < ds.getDataRowCnt() ; i++){
				strStrNm  = "";
				strAccNm  = "";
				strOrgNm  = "";
				grow   = ds.getDataRow(i);
				rtnRow = new ArrayList();
				for(int y = 0; y< 5 ; y++){
					rtnRow.add(grow.getString(y));
				}
				
				strStrCd   = grow.getString(0);
				strAccCd   = grow.getString(1);
				strOrgCd   = grow.getString(2);
				strPlanYm  = grow.getString(3);
				strPlanAmt = grow.getString(4);
				//날자 정합성체크
                if(!Util.isValidDate(strPlanYm, "yyyyMM")){
                	rtnRow.add(strStrNm);
                	rtnRow.add(strAccNm);
					rtnRow.add(strOrgNm);
					rtnRow.add("년월의 데이터가 유효하지 않습니다.");
				} else {
					//점코드체크
					strStrNm = isExistStrCd(svc, strStrCd);
					rtnRow.add(strStrNm);
					if ("".equals(strStrNm)) {
						rtnRow.add(strAccNm);
						rtnRow.add(strOrgNm);
						rtnRow.add("점코드가 존재하지 않습니다.");
					} else {
						//계정항목코드체크
						strAccNm = isExistAccCd(svc, strAccCd, strPlanYm);
						rtnRow.add(strAccNm);
						if ("".equals(strAccNm)) {
							rtnRow.add(strOrgNm);
							rtnRow.add("계정항목코드가 존재하지 않습니다.");
						} else {
							//조직코드체크
							strOrgNm = isExistOrgCd(svc, strOrgCd);
							rtnRow.add(strOrgNm);
							if ("".equals(strOrgNm)) {
								rtnRow.add("조직코드가 존재하지 않습니다.");
							} else {
								if(isExistAccPlan(svc, strPlanYm, strStrCd, strAccCd, strOrgCd, strPlanYm.substring(0, 4))){
									rtnRow.add("동일한 년별계정별경영계획 정보가 존재합니다.");
								} else {
									if(!strOrgCd.startsWith(strStrCd)){
										rtnRow.add("점코드와 조직코드 정보가 일치하지 않습니다.");
									} else {
										rtnRow.add("");
									}
								}
							}
						}
					}
				}
				rtnRow.add("F");
				rtn.add(rtnRow);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return rtn;
	}
	
	/**
	 * 엑셀업로드항목 저장
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int uploadExcel(ActionForm form, MultiInput mi, String strUserId)
			throws Exception {
		int ret         = 0;
		int i           = 0;
		Service svc     = null;
		String strBizCd = null;
		try {
			begin();
			connect("pot");
			
			svc = (Service) form.getService();
			while(mi.next()){
				if("T".equals(mi.getString("CHECK_FLAG"))){
					if(!isExistAccPlan(svc, mi.getString("PLAN_YM"), mi.getString("STR_CD")
						, mi.getString("ACC_CD"), mi.getString("ORG_CD"), mi.getString("PLAN_YM").substring(0, 4))){
						if(isExistBizPlan(svc, mi.getString("PLAN_YM"), mi.getString("ACC_CD"))){
							ret += insertAccPlan(svc, mi, strUserId);
						} else {
							throw new Exception("[USER]"+"월별경영계획항목명세 테이블에 "+ mi.getString("PLAN_YM")+"의 데이터가 존재하지 않습니다.");
						}
						
					} else {
						throw new Exception("[USER]"+"동일한 년별계정별경영계획 정보가 존재합니다.");
					}
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
	 *  <p>점코드 체크</p>
	 */
	private String isExistStrCd(Service svc, String strStrCd) throws Exception {
		SqlWrapper sql = new SqlWrapper();
		String ret     = "";
		Map map        = null;

		sql.put(svc.getQuery("SEL_STR_NM")); 
		sql.setString(1, strStrCd);
		map = this.selectMap(sql);
		       
		if (map.size() > 0){
			ret = map.get("STR_NAME").toString();
		}
		return ret;
	}
	
	/**
	 *  <p>계정항목체크</p>
	 */
	private String isExistAccCd(Service svc, String strAccCd, String strPlanYm) throws Exception {
		SqlWrapper sql = new SqlWrapper();
		String ret     = "";
		Map map        = null;

		sql.put(svc.getQuery("SEL_ACC_NM")); 
		sql.setString(1, strPlanYm);
		sql.setString(2, strAccCd);
		map = this.selectMap(sql);
		       
		if (map.size() > 0){
			ret = map.get("ACC_CD_NM").toString();
		}
		return ret;
	}
	
	/**
	 *  <p>조직 체크</p>
	 */
	private String isExistOrgCd(Service svc, String strOrgCd) throws Exception {
		SqlWrapper sql = new SqlWrapper();
		String ret     = "";
		Map map        = null;

		sql.put(svc.getQuery("SEL_ORG_NM")); 
		sql.setString(1, strOrgCd);
		map = this.selectMap(sql);
		       
		if (map.size() > 0){
			ret = map.get("ORG_NAME").toString();
		}
		return ret;
	}
	
	/**
	 *  <p>년별계정별경영계획</p>
	 */
	private boolean isExistAccPlan(Service svc, String strPlanYm, String strStrCd
		, String strAccCd, String strOrgCd, String strPlanYear) throws Exception {
		
		SqlWrapper sql = new SqlWrapper();
		boolean ret    = false;
		Map map        = null;

		sql.put(svc.getQuery("SEL_ACC_PLAN")); 
		sql.setString(1, strPlanYm);
		sql.setString(2, strStrCd);
		sql.setString(3, strAccCd);
		sql.setString(4, strOrgCd);
		sql.setString(5, strPlanYear);
		map = this.selectMap(sql);
		       
		if (map.size() > 0){
			ret = true;
		}
		return ret;
	}
	
	/**
	 *  <p>월별경영계획항목명세존재체크</p>
	 */
	private boolean isExistBizPlan(Service svc, String strPlanYm
		, String strAccCd) throws Exception {
		
		SqlWrapper sql = new SqlWrapper();
		boolean ret    = false;
		Map map        = null;

		sql.put(svc.getQuery("SEL_BIZ_PLAN")); 
		sql.setString(1, strPlanYm);
		sql.setString(2, strAccCd);
		map = this.selectMap(sql);
		       
		if (map.size() > 0){
			ret = true;
		}
		return ret;
	}
	
	/**
	 *  <p>년별계정별경영계획 신규등록</p>
	 */
	private int insertAccPlan(Service svc, MultiInput mi, String strUserId) throws Exception {
		int ret        = 0;
		int i          = 0;
		String strLoc  = "INS_ACC_PLAN";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		sql.setString(++i, mi.getString("PLAN_YM"));
		sql.setString(++i, mi.getString("STR_CD"));
		sql.setString(++i, mi.getString("ACC_CD"));
		sql.setString(++i, mi.getString("PLAN_YM").substring(0, 4));
		sql.setString(++i, mi.getString("AMT"));
		sql.setString(++i, strUserId);
		sql.setString(++i, strUserId);
		sql.setString(++i, mi.getString("ORG_CD"));

		ret = this.update(sql);
		if(ret != 1)
			throw new Exception("[USER]"+"년별계정별경영계획 신규등록을 실패하였습니다.");
		
		return ret;
	}
}
