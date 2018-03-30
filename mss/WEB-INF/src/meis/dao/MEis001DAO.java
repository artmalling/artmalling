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
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import common.util.Util;

/**
 * <p>경영실적항목관리</p>
 * 
 * @created on 1.0, 2011/05/01
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis001DAO extends AbstractDAO {

	/**
	 * 경영실적항목트리조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchBizTree(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strBizLCd = null;
		String strBizMCd = null;
		String strBizSCd = null;

		try {
			//파라미터 값 가져오기
			strBizLCd = String2.trimToEmpty(form.getParam("strBizLCd")); //대분류코드
			strBizMCd = String2.trimToEmpty(form.getParam("strBizMCd")); //중분류코드
			strBizSCd = String2.trimToEmpty(form.getParam("strBizSCd")); //소분류코드

			strLoc = "SEL_BIZ_TREE_START";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			
			if (!"%".equals(strBizLCd)){
				sql.put(svc.getQuery("SEL_BIZ_TREE_WHERE_LCD"));
				sql.setString(i++, strBizLCd);
			}
			if (!"%".equals(strBizMCd)){
				sql.put(svc.getQuery("SEL_BIZ_TREE_WHERE_MCD"));
				sql.setString(i++, strBizMCd);
			}
			if (!"%".equals(strBizSCd)){
				sql.put(svc.getQuery("SEL_BIZ_TREE_WHERE_SCD"));
				sql.setString(i++, strBizSCd);
			}
			
			sql.put(svc.getQuery("SEL_BIZ_TREE_END"));
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 계정/예산항목정보조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchBizDtl(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strBizCd = null;

		try {
			//파라미터 값 가져오기
			strBizCd = String2.trimToEmpty(form.getParam("strBizCd")); //실적항목코드

			strLoc = "SEL_BIZ_DTL";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			sql.setString(i++, strBizCd);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 경영실적항목 변경 및 신규 처리
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strUserId)
			throws Exception {
		int ret        = 0;
		int i          = 0;
		Service svc    = null;
		//파라미터 변수선언
		String strBizCd = null;
		try {
			begin();
			connect("pot");
			
			//파라미터 값 가져오기
			strBizCd = String2.trimToEmpty(form.getParam("strBizCd")); //실적항목코드
			
			svc = (Service) form.getService();
			//경영실적항목 마스터 처리
			if(mi[0].next()){
				if(mi[0].IS_INSERT()){
					if (!isExistMstPK(svc, strBizCd)) {
						ret += insertMst(svc, mi[0], strUserId, false);
					} else {
						throw new Exception("[USER]"+"[" + strBizCd + "]와 동일한 실적항목코드가 존재합니다.");
					}
				} else if(mi[0].IS_UPDATE()){
					ret += updateMst(svc, mi[0], strUserId);
				}
			}
			
			//경영실적항목 상세 처리
			while(mi[1].next()){
				if(mi[1].IS_INSERT()){
					isSameAccNm(svc, mi[1].getString("ACC_CD"), mi[1].getString("ACC_CD_NM"));
					ret += insertDtl(svc, mi[1], strBizCd, strUserId);
				} else if(mi[1].IS_UPDATE()){
					isSameAccNm(svc, mi[1].getString("ACC_CD"), mi[1].getString("ACC_CD_NM"));
					ret += updateDtl(svc, mi[1], strBizCd, strUserId);
				} else if(mi[1].IS_DELETE()){
					//월별경영실적항목명세 데이터 존재여부체크
					if (isExistRsltDtl(svc, mi[1], strBizCd))
						throw new Exception("[USER]"+"월별경영실적항목명세 데이터가 존재하여 삭제할수 없습니다.");
					//월별경영계획항목명세 데이터 존재여부체크
					if (isExistPlanDtl(svc, mi[1], strBizCd))
						throw new Exception("[USER]"+"월별경영계획항목명세 데이터가 존재하여 삭제할수 없습니다.");
					ret += deleteDtl(svc, mi[1], strBizCd);
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
	 * 경영실적항목 삭제 처리
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form, MultiInput mi, String strUserId)
			throws Exception {
		int ret        = 0;
		int i          = 0;
		Service svc    = null;
		try {
			begin();
			connect("pot");
			
			svc = (Service) form.getService();
			//경영실적항목 삭제처리
			if(mi.next()){
				//경영실적항목마스터에 하위항목존재체크
				if (isExistMstChild(svc, mi.getString("BIZ_CD")))
					throw new Exception("[USER]"+"경영실적항목마스터에 하위항목이 존재하여 삭제할수 없습니다.");
				//월별경영실적항목마스터 데이터 존재여부체크
				if (isExistRsltMst(svc, mi.getString("BIZ_CD")))
					throw new Exception("[USER]"+"월별경영실적항목마스터 데이터가 존재하여 삭제할수 없습니다.");
				//월별경영계획항목마스터 데이터 존재여부체크
				if (isExistPlanMst(svc, mi.getString("BIZ_CD")))
					throw new Exception("[USER]"+"월별경영계획항목마스터 데이터가 존재하여 삭제할수 없습니다.");
				//경영실적항목명세 데이터 삭제
				ret += deleteDtlAll(svc, mi.getString("BIZ_CD"));
				//경영실적항목마스터 데이터 삭제
				ret += deleteMst(svc, mi.getString("BIZ_CD"));
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
	 *  <p>경영실적항목마스터 키값을 중복체크를 한다.</p>
	 */
	private boolean isExistMstPK(Service svc, String strBizCd) throws Exception {
		SqlWrapper sql = new SqlWrapper();
		boolean ret    = false;
		Map map        = null;

		sql.put(svc.getQuery("SEL_BIZ_CD")); 
		sql.setString(1, strBizCd);
		map = this.selectMap(sql);
		       
		if (map.size() > 0){
			ret = true;
		}
		return ret;
	}
	
	/**
	 *  <p>경영실적항목상세 키값을 중복체크를 한다.</p>
	 */
	private boolean isExistDtlPK(Service svc, String strBizCd, String strAccFlag
		, String strAccCd) throws Exception {
		
		SqlWrapper sql = new SqlWrapper();
		boolean ret    = false;
		Map map        = null;

		sql.put(svc.getQuery("SEL_DTL_CD")); 
		sql.setString(1, strBizCd);
		sql.setString(2, strAccFlag);
		sql.setString(3, strAccCd);
		map = this.selectMap(sql);
		       
		if (map.size() > 0){
			ret = true;
		}
		return ret;
	}
	
	/**
	 *  <p>경영실적항목마스터 신규등록</p>
	 */
	private int insertMst(Service svc, MultiInput mi, String strUserId, boolean isFromExcel) throws Exception {
		int ret        = 0;
		int i          = 0;
		String strLoc  = "INS_BIZ_MST";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		sql.setString(++i, mi.getString("BIZ_CD"));
		sql.setString(++i, mi.getString("BIZ_CD_NM"));
		sql.setString(++i, mi.getString("BIZ_CD_LEVEL"));
		sql.setString(++i, mi.getString("BIZ_CD").substring(0,2));
		sql.setString(++i, mi.getString("BIZ_CD").substring(2,4));
		sql.setString(++i, mi.getString("BIZ_CD").substring(4,6));
		if(isFromExcel && "1".equals(mi.getString("BIZ_CD_LEVEL"))){
			sql.setString(++i, "000000");
		} else {
			sql.setString(++i, mi.getString("P_BIZ_CD"));
		}
		sql.setString(++i, mi.getString("RPT_YN"));
		sql.setInt(++i, mi.getInt("PRT_SEQ"));
		sql.setString(++i, mi.getString("USE_YN"));
		sql.setString(++i, strUserId);
		sql.setString(++i, strUserId);

		ret = this.update(sql);
		if(ret != 1)
			throw new Exception("[USER]"+"경영실적항목마스터 신규등록을 실패하였습니다.");
		
		return ret;
	}
	
	/**
	 *  <p>경영실적항목마스터 수정</p>
	 */
	private int updateMst(Service svc, MultiInput mi, String strUserId) throws Exception {
		int ret        = 0;
		int i          = 0;
		String strLoc  = "UPD_BIZ_MST";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		
		sql.setString(++i, mi.getString("BIZ_CD_NM"));
		sql.setString(++i, mi.getString("RPT_YN"));
		sql.setInt(++i, mi.getInt("PRT_SEQ"));
		sql.setString(++i, mi.getString("USE_YN"));
		sql.setString(++i, strUserId);
		sql.setString(++i, mi.getString("BIZ_CD"));

		ret = this.update(sql);
		if(ret != 1)
			throw new Exception("[USER]"+"경영실적항목마스터 수정을 실패하였습니다.");
		
		return ret;
	}
	
	/**
	 *  <p>계정/예산항목정보 신규등록</p>
	 */
	private int insertDtl(Service svc, MultiInput mi, String strBizCd, 
		String strUserId) throws Exception {
		
		int ret        = 0;
		int i          = 0;
		String strLoc  = "INS_BIZ_DTL";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		sql.setString(++i, strBizCd);
		sql.setString(++i, mi.getString("ACC_FLAG"));
		sql.setString(++i, mi.getString("ACC_CD"));
		sql.setString(++i, mi.getString("ACC_CD_NM"));
		sql.setString(++i, strUserId);
		sql.setString(++i, strUserId);

		ret = this.update(sql);
		if(ret != 1)
			throw new Exception("[USER]"+"경영실적항목상세 신규등록을 실패하였습니다.");
		
		return ret;
	}
	
	/**
	 *  <p>계정/예산항목정보 수정</p>
	 */
	private int updateDtl(Service svc, MultiInput mi, String strBizCd, 
		String strUserId) throws Exception {
		
		int ret        = 0;
		int i          = 0;
		String strLoc  = "UPD_BIZ_DTL";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		
		sql.setString(++i, mi.getString("ACC_CD_NM"));
		sql.setString(++i, strUserId);
		sql.setString(++i, strBizCd);
		sql.setString(++i, mi.getString("ACC_FLAG"));
		sql.setString(++i, mi.getString("ACC_CD"));

		ret = this.update(sql);
		if(ret != 1)
			throw new Exception("[USER]"+"경영실적항목상세 수정을 실패하였습니다.");
		
		return ret;
	}
	
	/**
	 *  <p>계정/예산항목정보 삭제</p>
	 */
	private int deleteDtl(Service svc, MultiInput mi, String strBizCd) throws Exception {
		
		int ret        = 0;
		int i          = 0;
		String strLoc  = "DEL_BIZ_DTL";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		
		sql.setString(++i, strBizCd);
		sql.setString(++i, mi.getString("ACC_FLAG"));
		sql.setString(++i, mi.getString("ACC_CD"));

		ret = this.update(sql);
		if(ret != 1)
			throw new Exception("[USER]"+"경영실적항목상세 삭제를 실패하였습니다.");
		
		return ret;
	}
	
	/**
	 *  <p>경영실적항목마스터에 하위항목존재체크</p>
	 */
	private boolean isExistMstChild(Service svc, String strBizCd) throws Exception {
		SqlWrapper sql = new SqlWrapper();
		boolean ret    = false;
		Map map        = null;

		sql.put(svc.getQuery("SEL_P_BIZ_CD")); 
		sql.setString(1, strBizCd);
		map = this.selectMap(sql);
		       
		if (map.size() > 0){
			ret = true;
		}
		return ret;
	}
	
	/**
	 *  <p>월별경영실적항목마스터 데이터 존재여부체크</p>
	 */
	private boolean isExistRsltMst(Service svc, String strBizCd) throws Exception {
		SqlWrapper sql = new SqlWrapper();
		boolean ret    = false;
		Map map        = null;

		sql.put(svc.getQuery("SEL_RESULT_MST")); 
		sql.setString(1, strBizCd);
		map = this.selectMap(sql);
		       
		if (map.size() > 0){
			ret = true;
		}
		return ret;
	}
	
	/**
	 *  <p>월별경영계획항목마스터 데이터 존재여부체크</p>
	 */
	private boolean isExistPlanMst(Service svc, String strBizCd) throws Exception {
		SqlWrapper sql = new SqlWrapper();
		boolean ret    = false;
		Map map        = null;

		sql.put(svc.getQuery("SEL_PLAN_MST")); 
		sql.setString(1, strBizCd);
		map = this.selectMap(sql);
		       
		if (map.size() > 0){
			ret = true;
		}
		return ret;
	}
	
	/**
	 *  <p>경영실적항목명세 데이터 삭제</p>
	 */
	private int deleteDtlAll(Service svc, String strBizCd) throws Exception {
		
		int ret        = 0;
		int i          = 0;
		String strLoc  = "DEL_BIZ_DTL_BY_BIZ_CD";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		
		sql.setString(++i, strBizCd);

		ret = this.update(sql);
		return ret;
	}
	
	/**
	 *  <p>경영실적항목마스터 데이터 삭제</p>
	 */
	private int deleteMst(Service svc, String strBizCd) throws Exception {
		
		int ret        = 0;
		int i          = 0;
		String strLoc  = "DEL_BIZ_MST";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		
		sql.setString(++i, strBizCd);

		ret = this.update(sql);
		
		if(ret != 1)
			throw new Exception("[USER]"+"경영실적항목마스터 삭제를 실패하였습니다.");
		return ret;
	}
	
	/**
	 * 경영실적항목 변경 및 신규 처리
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List checkValidation(ActionForm form, GauceDataSet ds)
			throws Exception {
		Service svc            = null;
		GauceDataRow grow      = null;
		List rtn               = null;
		List rtnRow            = null;
		String strPtnSeq       = null;
		String strBizCd        = null;
		String strBizNm        = null;
		String strLevel        = null;
		String strRptUse       = null;
		String strUseYn        = null;
		String strAccFlag      = null;
		String strAccCd        = null;
		String strAccNm        = null;
		String strPBizCd       = null;
		GauceDataColumn gcol[] = null;
		try {
			connect("pot");
			svc  = (Service) form.getService();
			rtn  = new ArrayList();
			gcol = ds.getDataColumns();
			for(int i = 0; i < ds.getDataRowCnt() ; i++){				
				grow   = ds.getDataRow(i);
				rtnRow = new ArrayList();
				for(int y = 0; y< ds.getDataColCnt()-1 ; y++){
					rtnRow.add(grow.getString(y));
				}
				strPtnSeq  = grow.getString(0);
				strBizCd   = grow.getString(1);
				strBizNm   = grow.getString(2);
				strLevel   = grow.getString(3);
				strRptUse  = grow.getString(4);
				strUseYn   = grow.getString(5);
				strAccFlag = grow.getString(6);
				strAccCd   = grow.getString(7);
				strAccNm   = grow.getString(8);
				strPBizCd  = grow.getString(9);
				//validation체크
				if("".equals(strAccFlag)){//마스터항목
					//실적항목코드중복체크
					if(!"".equals(strPtnSeq) &&  !Util.isNumber(strPtnSeq)){
						rtnRow.add("출력순서는 숫자만 입력가능합니다.");
					} else if (isExistMstPK(svc, strBizCd)) {
						rtnRow.add("동일한 실적항목코드가 존재합니다");
					} else if(strBizCd.getBytes().length != 6){
						rtnRow.add("실적항목코드의 자리수는 6자리입니다.");
					} else if(strBizNm.getBytes().length  > 60){
						rtnRow.add("실적항목명의 길이는 60자이하입니다.");
					} else if(!("1".equals(strLevel) || "2".equals(strLevel) || "3".equals(strLevel))){
						rtnRow.add("항목레벨이 잘못되었습니다.");
					} else if(!("Y".equals(strRptUse) || "N".equals(strRptUse))){
						rtnRow.add("보고서사용구분이 잘못되었습니다.");
					} else if(!("Y".equals(strUseYn) || "N".equals(strUseYn))){
						rtnRow.add("사용여부가 잘못되었습니다.");
					} else {
						rtnRow.add("");
					}
				}else{//상세항목
					if(strBizCd.getBytes().length != 6){
						rtnRow.add("실적항목코드의 자리수는 6자리입니다.");
					} else if(!("1".equals(strAccFlag) || "2".equals(strAccFlag))){
						rtnRow.add("계정구분코드가 잘못되었습니다.");
					} else if("".equals(strAccCd)){
						rtnRow.add("계정과목코드는  필수입력항목입니다.");
					} else if("".equals(strAccNm)){
						rtnRow.add("계정과목명은  필수입력항목입니다.");
					} else if(strAccNm.getBytes().length  > 60){
						rtnRow.add("계정과목명의 길이는 60자이하입니다.");
					} else {
						rtnRow.add("");
					}
				}
				
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
			//경영실적항목 삭제처리
			while(mi.next()){
				if("T".equals(mi.getString("CHECK_FLAG"))){
					strBizCd = mi.getString("BIZ_CD");
					if("".equals(mi.getString("ACC_FLAG"))){//경영항목실적마스터 입력
						if (!isExistMstPK(svc, strBizCd)) {
							ret += insertMst(svc, mi, strUserId, true);
						} else {
							throw new Exception("[USER]"+"[" + strBizCd + "]와 동일한 실적항목코드가 존재합니다.");
						}
					} else { //경영실적항목명세 입력
						if (!isExistMstPK(svc, strBizCd)) {//항목마스터에 데이터가 항목코드가 존재하는지 체크
							ret += insertMst(svc, mi, strUserId, true);
						}
						if (!isExistDtlPK(svc, strBizCd, mi.getString("ACC_FLAG"), mi.getString("ACC_CD"))) {
							isSameAccNm(svc, mi.getString("ACC_CD"), mi.getString("ACC_CD_NM"));
							ret += insertDtl(svc, mi, strBizCd, strUserId);						
						} else {
							throw new Exception("[USER]"+"[" + strBizCd + "]와 동일한 실적항목코드가 존재합니다.");
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
		return ret;
	}
	
	/**
	 * 출력순서 가져오기
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getSeq(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strLvl    = null;

		try {
			//파라미터 값 가져오기
			strLvl = String2.trimToEmpty(form.getParam("strLvl")); //실적항목코드

			strLoc = "SEL_BIZ_SEQ";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			sql.setString(i++, strLvl);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 *  <p>항목명 동일여부 체크</p>
	 */
	private void isSameAccNm(Service svc, String strAccCd, String strAccNm) throws Exception {
		SqlWrapper sql = new SqlWrapper();
		Map map        = null;

		sql.put(svc.getQuery("SEL_ACC_NAME")); 
		sql.setString(1, strAccCd);
		map = this.selectMap(sql);
		       
		if (map.size() > 0){
			if(!strAccNm.equals(map.get("ACC_CD_NM").toString())){
				throw new Exception("[USER]"+" 계정항목코드[" + strAccCd + "]의 항목명은 " + map.get("ACC_CD_NM").toString() + "이어야합니다.");
			}
		}
	}
	
	/**
	 *  <p>월별경영실적항목명세 데이터 존재여부체크</p>
	 */
	private boolean isExistRsltDtl(Service svc, MultiInput mi, String strBizCd) throws Exception {
		SqlWrapper sql = new SqlWrapper();
		boolean ret    = false;
		Map map        = null;

		sql.put(svc.getQuery("SEL_RESULT_DTL")); 
		sql.setString(1, strBizCd);
		sql.setString(2, mi.getString("ACC_FLAG"));
		sql.setString(3, mi.getString("ACC_CD"));
		map = this.selectMap(sql);
		       
		if (map.size() > 0){
			ret = true;
		}
		return ret;
	}
	
	/**
	 *  <p>월별경영계획항목명세 데이터 존재여부체크</p>
	 */
	private boolean isExistPlanDtl(Service svc, MultiInput mi, String strBizCd) throws Exception {
		SqlWrapper sql = new SqlWrapper();
		boolean ret    = false;
		Map map        = null;

		sql.put(svc.getQuery("SEL_PLAN_DTL")); 
		sql.setString(1, strBizCd);
		sql.setString(2, mi.getString("ACC_FLAG"));
		sql.setString(3, mi.getString("ACC_CD"));
		map = this.selectMap(sql);
		       
		if (map.size() > 0){
			ret = true;
		}
		return ret;
	}
}
