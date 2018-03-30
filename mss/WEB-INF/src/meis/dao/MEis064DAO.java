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
 * <p>월별경영실적지침관리</p>
 * 
 * @created on 1.0, 2011/06/14
 * @created by 이정식
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MEis064DAO extends AbstractDAO {

	/**
	 * 월별경영실적지침트리조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchBizRsltTree(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strRsltYm = null;

		try {
			//파라미터 값 가져오기
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); //경영실적년월

			strLoc = "SEL_BIZ_RSLT_TREE";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strRsltYm);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return ret;
	}
	
	/**
	 * 월별계정/예산항목정보조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchBizRsltDtl(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strRsltYm = null;
		String strBizCd  = null;
		String strFlag   = null;

		try {
			//파라미터 값 가져오기
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); //실적년월
			strBizCd  = String2.trimToEmpty(form.getParam("strBizCd"));  //실적항목코드
			strFlag   = String2.trimToEmpty(form.getParam("strFlag"));

			strLoc = "SEL_BIZ_RSLT_DTL";
			if("1".equals(strFlag)) strLoc = "SEL_BIZ_DTL";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			sql.setString(i++, strRsltYm);
			sql.setString(i++, strBizCd);
			
			connect("pot");

			ret = select2List(sql);
			
//			if(ret.size() == 0){
//				sql.close();
//				sql.put(svc.getQuery("SEL_BIZ_DTL"));
//				i = 1;
//				sql.setString(i++, strRsltYm);
//				sql.setString(i++, strBizCd);
//				ret = select2List(sql);
//			}
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 월별 경영실적항목 변경 및 신규 처리
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strUserId)
			throws Exception {
		int ret          = 0;
		int i            = 0;
		Service svc      = null;
		//파라미터 변수선언
		String strBizCd  = null;
		String strRsltYm = null;
		try {
			begin();
			connect("pot");
			
			//파라미터 값 가져오기
			strBizCd  = String2.trimToEmpty(form.getParam("strBizCd"));  //실적항목코드
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); //실적년월
			
			svc = (Service) form.getService();
			//월별경영실적항목 마스터 처리
			if(mi[0].next()){
				if(mi[0].IS_INSERT()){
					ret += insertRsltMst(svc, mi[0], strUserId, false);
				} else if(mi[0].IS_UPDATE()){
					ret += updateRsltMst(svc, mi[0], strUserId);
				}
			}
			
			//월경영실적항목 상세 처리
			while(mi[1].next()){
				if("0".equals(mi[1].getString("DIV_FLAG"))){
					if(mi[1].IS_INSERT()){
						if (isExistRsltDtl(svc, mi[1].getString("BIZ_RSLT_YM"), mi[1].getString("ACC_CD")))
							throw new Exception("[USER]"+"동일한 계정항목코드가 존재합니다.<br>월별경영실적항목명세는 실적년월별 유일한 계정항목코드가 필요합니다.");
						ret += insertRsltDtl(svc, mi[1], strBizCd, strUserId);
					}
				} else{
					if(mi[1].IS_INSERT()){
						if (isExistRsltDtl(svc, mi[1].getString("BIZ_RSLT_YM"), mi[1].getString("ACC_CD")))
							throw new Exception("[USER]"+"동일한 계정항목코드가 존재합니다.<br>월별경영실적항목명세는 실적년월별 유일한 계정항목코드가 필요합니다.");
						ret += insertRsltDtl(svc, mi[1], strBizCd, strUserId);
					} else if(mi[1].IS_UPDATE()){
						ret += updateRsltDtl(svc, mi[1], strBizCd, strUserId);
					} else if(mi[1].IS_DELETE()){
						//년별 계정별 경영실적 데이터 존재여부체크
						if (isExistAccRslt(svc, mi[1].getString("BIZ_RSLT_YM"), mi[1].getString("ACC_CD")))
							throw new Exception("[USER]"+"년별 계정별 경영실적 데이터가 존재하여 삭제할수 없습니다.");
						ret += deleteRsltDtl(svc, mi[1], strBizCd);
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
	 * 월별경영실적항목 삭제 처리
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
				//월별경영실적항목마스터에 하위항목존재체크
				if (isExistMstChild(svc, mi.getString("BIZ_RSLT_YM"), mi.getString("BIZ_CD")))
					throw new Exception("[USER]"+"월별경영실적항목마스터에 하위항목이 존재하여 삭제할수 없습니다.");
				//월별경영실적항목명세 데이터 삭제
				ret += deleteDtlAll(svc, mi.getString("BIZ_RSLT_YM"), mi.getString("BIZ_CD"));
				//월별경영실적항목마스터 데이터 삭제
				ret += deleteMst(svc, mi.getString("BIZ_RSLT_YM"), mi.getString("BIZ_CD"));
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
	private boolean isExistMst(Service svc, String strBizCd) throws Exception {
		SqlWrapper sql = new SqlWrapper();
		boolean ret    = false;
		Map map        = null;

		sql.put(svc.getQuery("SEL_BIZ_MST")); 
		sql.setString(1, strBizCd);
		map = this.selectMap(sql);
		       
		if (map.size() > 0){
			ret = true;
		}
		return ret;
	}

	/**
	 *  <p>월별경영실적항목마스터 키값을 중복체크를 한다.</p>
	 */
	private boolean isExistRsltMst(Service svc, String strBizCd, String strRsltYm) throws Exception {
		SqlWrapper sql = new SqlWrapper();
		boolean ret    = false;
		Map map        = null;

		sql.put(svc.getQuery("SEL_BIZ_RSLT_MST")); 
		sql.setString(1, strRsltYm);
		sql.setString(2, strBizCd);
		map = this.selectMap(sql);
		       
		if (map.size() > 0){
			ret = true;
		}
		return ret;
	}
	
	/**
	 *  <p>경영실적항목상세 키값을 중복체크를 한다.</p>
	 */
	private boolean isExistDtl(Service svc, String strBizCd, String strAccFlag
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
	 *  <p>월별경영실적항목상세 키값을 중복체크를 한다.</p>
	 */
	private boolean isExistRsltDtl(Service svc, String strRsltYm, String strBizCd, String strAccFlag
		, String strAccCd) throws Exception {
		
		SqlWrapper sql = new SqlWrapper();
		boolean ret    = false;
		Map map        = null;

		sql.put(svc.getQuery("SEL_RSLT_DTL")); 
		sql.setString(1, strRsltYm);
		sql.setString(2, strBizCd);
		if(!"".equals(strAccFlag)){
			sql.put(svc.getQuery("SEL_RSLT_DTL_WHERE"));
			sql.setString(3, strAccFlag);
			sql.setString(4, strAccCd);
		}
		
		map = this.selectMap(sql);
		       
		if (map.size() > 0){
			ret = true;
		}
		return ret;
	}
	
	/**
	 *  <p>월별경영실적항목마스터 신규등록</p>
	 */
	private int insertRsltMst(Service svc, MultiInput mi, String strUserId, boolean isFromExcel) throws Exception {
		int ret        = 0;
		int i          = 0;
		String strLoc  = "INS_BIZ_RSLT_MST";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		sql.setString(++i, mi.getString("BIZ_RSLT_YM"));
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
			throw new Exception("[USER]"+"월별경영실적항목마스터 신규등록을 실패하였습니다.");
		
		return ret;
	}
	
	/**
	 *  <p>월별경영실적항목마스터 수정</p>
	 */
	private int updateRsltMst(Service svc, MultiInput mi, String strUserId) throws Exception {
		int ret        = 0;
		int i          = 0;
		String strLoc  = "UPD_BIZ_RSLT_MST";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		
		sql.setString(++i, mi.getString("RPT_YN"));
		sql.setInt(++i, mi.getInt("PRT_SEQ"));
		sql.setString(++i, mi.getString("USE_YN"));
		sql.setString(++i, strUserId);
		sql.setString(++i, mi.getString("BIZ_RSLT_YM"));
		sql.setString(++i, mi.getString("BIZ_CD"));

		ret = this.update(sql);
		if(ret != 1)
			throw new Exception("[USER]"+"월별경영실적항목마스터 수정을 실패하였습니다.");
		
		return ret;
	}
	
	/**
	 *  <p>계정/예산항목정보 신규등록</p>
	 */
	private int insertRsltDtl(Service svc, MultiInput mi, String strBizCd, 
		String strUserId) throws Exception {
		
		int ret        = 0;
		int i          = 0;
		String strLoc  = "INS_BIZ_RSLT_DTL";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		sql.setString(++i, mi.getString("BIZ_RSLT_YM"));
		sql.setString(++i, strBizCd);
		sql.setString(++i, mi.getString("ACC_FLAG"));
		sql.setString(++i, mi.getString("ACC_CD"));
		sql.setString(++i, mi.getString("ACC_CD_NM"));
		sql.setString(++i, strUserId);
		sql.setString(++i, strUserId);

		ret = this.update(sql);
		if(ret != 1)
			throw new Exception("[USER]"+"월별경영실적항목상세 신규등록을 실패하였습니다.");
		
		return ret;
	}
	
	/**
	 *  <p>계정/예산항목정보 신규등록</p>
	 */
	private int insertRsltDtlAll(Service svc, String strRsltYm, String strBizCd, 
		String strUserId) throws Exception {
		
		int ret        = 0;
		int i          = 0;
		String strLoc  = "INS_BIZ_RSLT_DTL_ALL";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		sql.setString(++i, strRsltYm);
		sql.setString(++i, strUserId);
		sql.setString(++i, strUserId);
		sql.setString(++i, strBizCd);

		ret = this.update(sql);

		return ret;
	}
	
	/**
	 *  <p>계정/예산항목정보 수정</p>
	 */
	private int updateRsltDtl(Service svc, MultiInput mi, String strBizCd, 
		String strUserId) throws Exception {
		
		int ret        = 0;
		int i          = 0;
		String strLoc  = "UPD_BIZ_RSLT_DTL";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		
		sql.setString(++i, mi.getString("ACC_CD_NM"));
		sql.setString(++i, strUserId);
		sql.setString(++i, mi.getString("BIZ_RSLT_YM"));
		sql.setString(++i, strBizCd);
		sql.setString(++i, mi.getString("ACC_FLAG"));
		sql.setString(++i, mi.getString("ACC_CD"));

		ret = this.update(sql);
		if(ret != 1)
			throw new Exception("[USER]"+"월별경영실적항목상세 수정을 실패하였습니다.");
		
		return ret;
	}
	
	/**
	 *  <p>계정/예산항목정보 삭제</p>
	 */
	private int deleteRsltDtl(Service svc, MultiInput mi, String strBizCd) throws Exception {
		
		int ret        = 0;
		int i          = 0;
		String strLoc  = "DEL_BIZ_RSLT_DTL";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		
		sql.setString(++i, mi.getString("BIZ_RSLT_YM"));
		sql.setString(++i, strBizCd);
		sql.setString(++i, mi.getString("ACC_FLAG"));
		sql.setString(++i, mi.getString("ACC_CD"));

		ret = this.update(sql);
		if(ret != 1)
			throw new Exception("[USER]"+"월별경영실적항목상세 삭제를 실패하였습니다.");
		
		return ret;
	}
	
	/**
	 *  <p>경영실적항목마스터에 하위항목존재체크</p>
	 */
	private boolean isExistMstChild(Service svc, String strRsltYm, String strBizCd) throws Exception {
		SqlWrapper sql = new SqlWrapper();
		boolean ret    = false;
		Map map        = null;

		sql.put(svc.getQuery("SEL_P_BIZ_CD")); 
		sql.setString(1, strRsltYm);
		sql.setString(2, strBizCd);
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
	 *  <p>경영실적항목명세 데이터 삭제</p>
	 */
	private int deleteDtlAll(Service svc, String strRsltYm, String strBizCd) throws Exception {
		
		int ret        = 0;
		int i          = 0;
		String strLoc  = "DEL_BIZ_DTL_BY_BIZ_CD";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		
		sql.setString(++i, strRsltYm);
		sql.setString(++i, strBizCd);

		ret = this.update(sql);
		return ret;
	}
	
	/**
	 *  <p>경영실적항목마스터 데이터 삭제</p>
	 */
	private int deleteMst(Service svc, String strRsltYm, String strBizCd) throws Exception {
		
		int ret        = 0;
		int i          = 0;
		String strLoc  = "DEL_BIZ_MST";
		SqlWrapper sql = new SqlWrapper();
		
		sql.put(svc.getQuery(strLoc));
		
		sql.setString(++i, strRsltYm);
		sql.setString(++i, strBizCd);

		ret = this.update(sql);
		
		if(ret != 1)
			throw new Exception("[USER]"+"월별경영실적항목마스터 삭제를 실패하였습니다.");
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
		String strRsltYm       = null;
		GauceDataColumn gcol[] = null;
		try {
			connect("pot");
			svc  = (Service) form.getService();
			rtn  = new ArrayList();
			gcol = ds.getDataColumns();
			strRsltYm  = String2.trimToEmpty(form.getParam("strRsltYm"));
			for(int i = 0; i < ds.getDataRowCnt() ; i++){				
				grow   = ds.getDataRow(i);
				rtnRow = new ArrayList();
				for(int y = 0; y< ds.getDataColCnt()-2 ; y++){
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
				//validation체크
				if("".equals(strAccFlag)){//마스터항목
					//월별 실적항목코드중복체크
					if (!isExistMst(svc, strBizCd)) {
						rtnRow.add("경영실적항목마스터에 실적코드가 존재하지 않습니다.");
					} else if(!"".equals(strPtnSeq) &&  !Util.isNumber(strPtnSeq)){
						rtnRow.add("출력순서는 숫자만 입력가능합니다.");
					} else if (isExistRsltMst(svc, strBizCd, strRsltYm)) {
						rtnRow.add("동일한 월별실적항목코드가 존재합니다");
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
					if (!isExistDtl(svc, strBizCd, strAccFlag, strAccCd)) {
						rtnRow.add("경영실적항목상세에 실적코드가 존재하지 않습니다.");
					} else if(strBizCd.getBytes().length != 6){
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
				rtnRow.add(strRsltYm);
				
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
					strBizCd = mi.getString("BIZ_CD");
					if("".equals(mi.getString("ACC_FLAG"))){//경영항목실적마스터 입력
						if (!isExistRsltMst(svc, strBizCd, mi.getString("BIZ_RSLT_YM"))) {
							ret += insertRsltMst(svc, mi, strUserId, true);
						} else {
							throw new Exception("[USER]"+"[" + strBizCd + "]와 동일한 월별실적항목코드가 존재합니다.");
						}
					} else { //경영실적항목명세 입력
						if (!isExistRsltMst(svc, strBizCd, mi.getString("BIZ_RSLT_YM"))) {
							ret += insertRsltMst(svc, mi, strUserId, true);
						}
						if (!isExistRsltDtl(svc, mi.getString("BIZ_RSLT_YM"), mi.getString("ACC_CD"))) {
							ret += insertRsltDtl(svc, mi, strBizCd, strUserId);						
						} else {
							throw new Exception("[USER]"+" 동일한 월별실적상세코드가 존재합니다.");
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
	 * 항목마스터 복사
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public String[] copyBizMst(ActionForm form, MultiInput mi, String strUserId)
			throws Exception {
		int ret          = 0;
		int i            = 0;
		Service svc      = null;
		String strBizCd  = null;
		String strRsltYm = null;
		String msg[]     = new String[3];
		try {
			begin();
			connect("pot");
			
			svc = (Service) form.getService();
			
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm"));
			
			msg[0] = "";
			msg[1] = "";
			msg[2] = "";
			
			while(mi.next()){
				strBizCd = mi.getString("BIZ_CD");
				if (!isExistRsltMst(svc, strBizCd, strRsltYm)) {
					ret += insertRsltMst(svc, mi, strUserId, true);
					if (!isExistRsltDtl(svc, mi.getString("BIZ_RSLT_YM"), strBizCd, "", "")) {
						ret += insertRsltDtlAll(svc, strRsltYm, strBizCd, strUserId);						
					} else {
						msg[2] = msg[2] + strBizCd + ",";
					}
				} else {
					msg[1] = msg[1] + strBizCd + ",";
				}
			}
			if("".equals(msg[1]) && "".equals(msg[2])){
				msg[0] = "" + ret;				
			} else {
				if(!"".equals(msg[1])) msg[1] = msg[1].substring(0, msg[1].length()-1);
				if(!"".equals(msg[2])) msg[2] = msg[2].substring(0, msg[2].length()-1);
				rollback();
			}
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return msg;
	}
	
	/**
	 * 경영실적항목마스터조회
	 * 월별경영실적항목마스터 전월조회
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPre(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		String strRsltYm = null;
		String strPreYM  = null;
		

		try {
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); //실적년월
			strPreYM  = Util.addMonth(strRsltYm+"01", -1 , "yyyyMM");

			strLoc = "SEL_RSLT_MST";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			sql.setString(1, strRsltYm);
			sql.setString(2, strPreYM);

			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 * 월별경영실적항목명세 전월조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchPreDtl(ActionForm form) throws Exception {

		List ret         = null;
		SqlWrapper sql   = null;
		Service svc      = null;
		String strLoc    = null;
		int i            = 1;
		//파라미터 변수선언
		String strBizCd  = null;
		String strRsltYm = null;
		String strPreYM  = null;

		try {
			//파라미터 값 가져오기
			strBizCd = String2.trimToEmpty(form.getParam("strBizCd")); //항목코드
			strRsltYm = String2.trimToEmpty(form.getParam("strRsltYm")); //실적년월
			strPreYM  = Util.addMonth(strRsltYm+"01", -1 , "yyyyMM");

			strLoc = "SEL_RSLT_DTL2";
            
			sql    = new SqlWrapper();
			svc    = (Service) form.getService();
			sql.put(svc.getQuery(strLoc));
			sql.setString(i++, strPreYM);
			sql.setString(i++, strBizCd);
			
			connect("pot");

			ret = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return ret;
	}
	
	/**
	 *  <p>년별 계정별 경영실적 데이터 존재여부체크</p>
	 */
	private boolean isExistAccRslt(Service svc, String strRsltYm, String strAccCd) throws Exception {
		SqlWrapper sql = new SqlWrapper();
		boolean ret    = false;
		Map map        = null;

		sql.put(svc.getQuery("SEL_ACC_RSLT")); 
		sql.setString(1, strRsltYm);
		sql.setString(2, strAccCd);
		map = this.selectMap(sql);
		
		if (map.size() > 0){
			ret = true;
		}
		
		return ret;
	}
	
	/**
	 *  <p>월별실적계획항목명세 중복체크</p>
	 */
	private boolean isExistRsltDtl(Service svc, String strPlanYm, String strAccCd) throws Exception {
		SqlWrapper sql = new SqlWrapper();
		boolean ret    = false;
		Map map        = null;

		sql.put(svc.getQuery("SEL_RSLT_DTL_EXIST")); 
		sql.setString(1, strPlanYm);
		sql.setString(2, strAccCd);
		map = this.selectMap(sql);
		
		if (map.size() > 0){
			ret = true;
		}
		
		return ret;
	}
}
