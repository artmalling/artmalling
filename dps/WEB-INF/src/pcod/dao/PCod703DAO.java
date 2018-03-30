/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pcod.dao;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
//import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>행사코드관리</p>
 * 
 * @created  on 1.0, 2010/02/09
 * @created  by 이재득(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod703DAO extends AbstractDAO {


	/**
	 * 행사코드을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchMaster(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	
		
		String strEventYm      = String2.nvl(form.getParam("strEventYm"));
		String strEventType    = String2.nvl(form.getParam("strEventType"));
		String strEventMngFlag = String2.nvl(form.getParam("strEventMngFlag"));
		String strEventLCd     = String2.nvl(form.getParam("strEventLCd"));
		String strEventMCd     = String2.nvl(form.getParam("strEventMCd"));
		String strEventSCd     = String2.nvl(form.getParam("strEventSCd"));		
		String strEventCd      = String2.nvl(form.getParam("strEventCd"));
		String strEventName    = URLDecoder.decode( String2.nvl(form.getParam("strEventName")), "UTF-8");

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		strQuery = svc.getQuery("SEL_EVTMST") + "\n";	
		sql.setString(i++, strEventYm);
		
		if( !strEventType.equals("%")){
			sql.setString(i++, strEventType);
			strQuery += svc.getQuery("SEL_EVTMST_WHERE_EVENT_TYPE") + "\n";
		}
		if( !strEventMngFlag.equals("%")){
			sql.setString(i++, strEventMngFlag);
			strQuery += svc.getQuery("SEL_EVTMST_WHERE_EVENT_MNG_FLAG") + "\n";
		}
		if( !strEventLCd.equals("%")){
			sql.setString(i++, strEventLCd);
			strQuery += svc.getQuery("SEL_EVTMST_WHERE_EVENT_L_CD") + "\n";
		}
		if( !strEventMCd.equals("%")){
			sql.setString(i++, strEventMCd);
			strQuery += svc.getQuery("SEL_EVTMST_WHERE_EVENT_M_CD") + "\n";
		}
		if( !strEventSCd.equals("%")){
			sql.setString(i++, strEventSCd);
			strQuery += svc.getQuery("SEL_EVTMST_WHERE_EVENT_S_CD") + "\n";
		}
		if( !strEventCd.equals("")){
			sql.setString(i++, strEventCd);
			strQuery += svc.getQuery("SEL_EVTMST_WHERE_EVENT_CD") + "\n";
		}
		if( !strEventName.equals("")){
			sql.setString(i++, strEventName);
			strQuery += svc.getQuery("SEL_EVTMST_WHERE_EVENT_NAME") + "\n";
		}

		strQuery += svc.getQuery("SEL_EVTMST_ORDER");
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 점별 행사을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		String strEventCd = String2.nvl(form.getParam("strEventCd"));

		connect("pot");
		
		sql.setString(i++, strEventCd);
		strQuery = svc.getQuery("SEL_STREVT") ;
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}
	
	/**
	 * 행사장을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchEvtPlac(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		String strEventCd = String2.nvl(form.getParam("strEventCd"));

		connect("pot");
		
		sql.setString(i++, strEventCd);
		strQuery = svc.getQuery("SEL_STREVTPLAC") ;
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * POS을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchEvtPos(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		String strEventCd = String2.nvl(form.getParam("strEventCd"));

		connect("pot");
		
		sql.setString(i++, strEventCd);
		strQuery = svc.getQuery("SEL_STREVTPOS") ;
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 행사 마스터, 점별행사, 행사장, POS
	 * 저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strID)
			throws Exception {

		int ret = 0;
		try {
			connect("pot");
			begin();
			// 행사 정보
			ret += saveEvtmst(form, mi[0], strID);
			// 점별행사 정보,행사장 정보,POS 정보
			ret += saveStrEvt( form, mi[1], mi[2], mi[3], strID);

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}		
		return ret;
	}

	/**
	 * 행사 마스터
	 * 삭제  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form, MultiInput mi)
			throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;

		try {
			connect("pot");
			begin();
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				sql.close();
				if ( mi.IS_DELETE()) {	
					sql.put(svc.getQuery("SEL_EVEVT_REG_CNT"));							
					sql.setString(1, mi.getString("EVENT_CD"));						
					sql.setString(2, mi.getString("EVENT_CD"));									
					Map map = selectMap( sql );							
					String regCnt = String2.nvl((String)map.get("CNT"));
					if( !regCnt.equals("0")) {
						throw new Exception("[USER]"+" [ "+ mi.getString("EVENT_CD") + " ] 행사를 사용하는 품번 또는 단품이 존재합니다.");
					}
					sql.close();
					i = 0;			
					sql.put(svc.getQuery("SEL_EVEVT_DTL_CNT"));							
					sql.setString(1, mi.getString("EVENT_CD"));									
					map = selectMap( sql );							
					String dtlCnt = String2.nvl((String)map.get("CNT"));
					if( !dtlCnt.equals("0")) {
						throw new Exception("[USER]"+" [ "+ mi.getString("EVENT_CD") + " ] 행사를 사용하는 점이 존재합니다.");
					}
					sql.close();
					i = 0;								
					sql.put(svc.getQuery("DEL_EVTMST"));
					sql.setString(++i, mi.getString("EVENT_CD"));
					
				} else {
					continue;	
				}
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 삭제을 하지 못했습니다.");
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
	 * 행사 저장
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	private int saveEvtmst(ActionForm form, MultiInput mi, String strID) throws Exception {
		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		int i;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		while (mi.next()) {
			sql.close();
			if ( mi.IS_INSERT()) {				
				i = 0;							
				sql.put(svc.getQuery("INS_EVTMST"));
				// 행사코드생성
				sql.setString(++i, mi.getString("EVENT_THME_CD"));
				sql.setString(++i, mi.getString("EVENT_YM"));
				sql.setString(++i, mi.getString("EVENT_THME_CD"));
				sql.setString(++i, mi.getString("EVENT_YM"));
				
				sql.setString(++i, mi.getString("EVENT_NAME"));				
				sql.setString(++i, mi.getString("EVENT_YM"));
				
				// 행사 일련번호 생성
				sql.setString(++i, mi.getString("EVENT_THME_CD"));				
				sql.setString(++i, mi.getString("EVENT_YM"));
				
				sql.setString(++i, mi.getString("EVENT_S_DT"));
				sql.setString(++i, mi.getString("EVENT_E_DT"));
				sql.setString(++i, mi.getString("EVENT_E_DT"));
				sql.setString(++i, mi.getString("EVENT_THME_CD"));
				sql.setString(++i, mi.getString("EVENT_TYPE"));
				sql.setString(++i, mi.getString("EVENT_PLU_FLAG"));
				sql.setString(++i, mi.getString("EVENT_MNG_FLAG"));
				sql.setString(++i, mi.getString("EVENT_ORG_CD"));
				sql.setString(++i, mi.getString("EVENT_CHAR_ID"));
				sql.setString(++i, strID);
				sql.setString(++i, strID);
				sql.setString(++i, mi.getString("BIGO"));

				
			} else if (mi.IS_UPDATE()){

				sql.put(svc.getQuery("SEL_EVEVT_REG_CNT"));							
				sql.setString(1, mi.getString("EVENT_CD"));						
				sql.setString(2, mi.getString("EVENT_CD"));									
				Map map = selectMap( sql );							
				String regCnt = String2.nvl((String)map.get("CNT"));
				/*if( !regCnt.equals("0")) {
					throw new Exception("[USER]"+" [ "+ mi.getString("EVENT_CD") + " ] 행사를 사용하는 품번 또는 단품이 존재합니다.");
				}*/
				sql.close();
				i = 0;							
				sql.put(svc.getQuery("UPD_EVTMST"));
				sql.setString(++i, mi.getString("EVENT_YM"));
				sql.setString(++i, mi.getString("EVENT_NAME"));
				sql.setString(++i, mi.getString("EVENT_S_DT"));
				sql.setString(++i, mi.getString("EVENT_E_DT"));
				sql.setString(++i, mi.getString("EVENT_TYPE"));
				sql.setString(++i, mi.getString("EVENT_PLU_FLAG"));
				sql.setString(++i, mi.getString("EVENT_MNG_FLAG"));
				sql.setString(++i, mi.getString("EVENT_ORG_CD"));
				sql.setString(++i, mi.getString("EVENT_CHAR_ID"));
				sql.setString(++i, strID);
				sql.setString(++i, mi.getString("BIGO"));
				sql.setString(++i, mi.getString("EVENT_CD"));
				
				
			} else {
				continue;	
			}
			res = update(sql);

			if (res != 1) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
			
			ret += res;
		}
		return ret;
		
	}

	/** 
	 * 점별행사, 행사장, POS
	 * 저장 및 삭제
	 * 
	 * @param form
	 * @param miStr
	 * @param miPlac
	 * @param miPos
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	private int saveStrEvt(ActionForm form, MultiInput miStr, MultiInput miPlac, MultiInput miPos, String strID) throws Exception {
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		List delList = new ArrayList();
		int i;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		// 점별행사 정보
		while (miStr.next()) {
			sql.close();
			if ( miStr.IS_UPDATE()) {
				
				sql.put(svc.getQuery("SEL_STR_EVEVT_CNT"));							
				sql.setString(1, miStr.getString("STR_CD"));	
				sql.setString(2, miStr.getString("EVENT_CD"));			
				Map map = selectMap( sql );							
				String strEvtCnt = String2.nvl((String)map.get("CNT"));
				// 등록 되지 않았는데 선택되지 않고 수정되었으면 무시
				if( strEvtCnt.equals("0") && miStr.getString("SEL").equals("F"))
					continue;
				
				if( !miStr.getString("EVENT_S_DT").equals(miStr.getString("ORG_EVENT_S_DT"))){
					sql.close();
					sql.put(svc.getQuery("SEL_STR_EVEVT_REG_CNT"));							
					sql.setString(1, miStr.getString("STR_CD"));								
					sql.setString(2, miStr.getString("EVENT_CD"));						
					sql.setString(3, miStr.getString("STR_CD"));						
					sql.setString(4, miStr.getString("EVENT_CD"));									
					map = selectMap( sql );							
					String regCnt = String2.nvl((String)map.get("CNT"));
					if( !regCnt.equals("0")) {
						throw new Exception("[USER]"+" [ "+miStr.getString("STR_CD")+","+ miStr.getString("EVENT_CD") + " ] 를 사용하는 품번 또는 단품이 존재합니다.");
					}
				}
				
				// 수정 되었는데 선택이 "F"일 경우 삭제 (상세정보 삭제 후 처리)
				if( miStr.getString("SEL").equals("F") ){
					Map tmpMap = new HashMap();
					tmpMap.put("STR_CD", miStr.getString("STR_CD"));
					tmpMap.put("EVENT_CD", miStr.getString("EVENT_CD"));
					delList.add(tmpMap);
					continue;
				}
				sql.close();
				// 등록되지 않았으므로 신규 입력
				if( strEvtCnt.equals("0") ){
					i = 0;					
					sql.put(svc.getQuery("INS_STREVT"));
					sql.setString(++i, miStr.getString("STR_CD"));
					sql.setString(++i, miStr.getString("EVENT_CD"));
					sql.setString(++i, miStr.getString("EVENT_S_DT"));
					sql.setString(++i, miStr.getString("EVENT_E_DT"));
					sql.setString(++i, miStr.getString("EVENT_E_DT"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
				
				// 등록 되어 있으므로 수정 입력
				}else{
					i = 0;					
					sql.put(svc.getQuery("UPD_STREVT"));
					sql.setString(++i, miStr.getString("EVENT_S_DT"));
					sql.setString(++i, miStr.getString("EVENT_E_DT"));
					sql.setString(++i, strID);
					sql.setString(++i, miStr.getString("STR_CD"));
					sql.setString(++i, miStr.getString("EVENT_CD"));
				}		
			} else {
				continue;	
			}
			res = update(sql);

			if (res != 1) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
			
			ret += res;
		}
		
		// 행사장 정보
		ret += saveStrEvtPlac(form, miPlac, strID);
		// POS 정보
		ret += saveStrEvtPos(form, miPos, strID);
		
		// 삭제 내역이 없을 경우 리턴
		if( delList.size() < 1)
			return ret;
		
	    for(int k=0; k<delList.size(); k++){
	    	Map param = (Map)delList.get(k);
			sql.close();		
			i = 0;			
			String strCd = String2.nvl((String)param.get("STR_CD"));
			String eventCd = String2.nvl((String)param.get("EVENT_CD"));
			sql.put(svc.getQuery("SEL_STR_EVEVT_DTL_CNT"));					
			sql.setString(++i, strCd);	
			sql.setString(++i, eventCd);						
			sql.setString(++i, strCd);	
			sql.setString(++i, eventCd);			
			sql.setString(++i, strCd);	
			sql.setString(++i, eventCd);						
			sql.setString(++i, strCd);	
			sql.setString(++i, eventCd);
			Map map = selectMap( sql );					
			String dtlCnt = String2.nvl((String)map.get("CNT"));
			if( !dtlCnt.equals("0")) {
				throw new Exception("[USER]"+" [ "+strCd+"]점, [ "+eventCd+"]행사의 행사장 또는 POS 또는 품번 또는 단품 이  존재합니다.");
			}

			sql.close();
			i = 0;			
			sql.put(svc.getQuery("DEL_STREVT"));
			sql.setString(++i, strCd);
			sql.setString(++i, eventCd);
			
			res = update(sql);

			if (res != 1) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 삭제을 하지 못했습니다.");
			}
			
			ret += res;
	    }

		return ret;
		
	}
	/**
	 * 행사장 정보
	 * 저장 및 삭제
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	private int saveStrEvtPlac(ActionForm form, MultiInput mi, String strID) throws Exception {
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		String flag = "";
		// 행사장 정보
		while (mi.next()) {
			sql.close();
			if ( mi.IS_INSERT()) {
				sql.put(svc.getQuery("SEL_STR_EVEVT_PLACE_CNT"));							
				sql.setString(1, mi.getString("STR_CD"));	
				sql.setString(2, mi.getString("EVENT_CD"));	
				sql.setString(3, mi.getString("EVENT_PLACE_CD"));		
				Map map = selectMap( sql );							
				String regCnt = String2.nvl((String)map.get("CNT"));
				if( !regCnt.equals("0")) {
					throw new Exception("[USER]"+" [ "+ mi.getString("EVENT_PLACE_CD") + " ] 행사장이 이미 등록 되어 있습니다.");
				}	
				sql.close();
				i = 0;					
				sql.put(svc.getQuery("INS_STREVTPLAC"));
				sql.setString(++i, mi.getString("STR_CD"));
				sql.setString(++i, mi.getString("EVENT_CD"));
				sql.setString(++i, mi.getString("EVENT_PLACE_CD"));
				sql.setString(++i, strID);
				sql.setString(++i, strID);
				flag = "I";
				
			}else if ( mi.IS_DELETE()) {
				i = 0;			
				sql.put(svc.getQuery("DEL_STREVTPLAC"));
				sql.setString(++i, mi.getString("STR_CD"));
				sql.setString(++i, mi.getString("EVENT_CD"));
				sql.setString(++i, mi.getString("EVENT_PLACE_CD"));
				flag = "D";
			} else {
				continue;	
			}
			
			res = update(sql);

			if (res != 1) {
				String msg ="";
				if( flag.equals("D")){
					msg ="데이터 삭제을 하지 못했습니다.";
				}else{
					msg ="데이터 입력을 하지 못했습니다.";					
				}
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ msg);
			}
			
			ret += res;
		}
		return ret;
		
	}
	/**
	 * POS 정보
	 * 저장 및 삭제
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	private int saveStrEvtPos(ActionForm form, MultiInput mi, String strID) throws Exception {
		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		int i;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();
		
		String flag = "";
		// POS 정보
		while (mi.next()) {
			sql.close();
			if ( mi.IS_INSERT()) {
				sql.put(svc.getQuery("SEL_STR_EVEVT_POS_CNT"));							
				sql.setString(1, mi.getString("STR_CD"));	
				sql.setString(2, mi.getString("EVENT_CD"));	
				sql.setString(3, mi.getString("POS_NO"));		
				Map map = selectMap( sql );							
				String regCnt = String2.nvl((String)map.get("CNT"));
				if( !regCnt.equals("0")) {
					throw new Exception("[USER]"+" [ "+ mi.getString("POS_NO") + " ] POS가 이미 등록 되어 있습니다.");
				}	
				sql.close();
				i = 0;					
				sql.put(svc.getQuery("INS_STREVTPOS"));
				sql.setString(++i, mi.getString("STR_CD"));
				sql.setString(++i, mi.getString("EVENT_CD"));
				sql.setString(++i, mi.getString("POS_NO"));
				sql.setString(++i, mi.getString("SPS_YN"));
				sql.setString(++i, strID);
				sql.setString(++i, strID);
				flag = "I";
				
			}else if ( mi.IS_UPDATE()) {
				i = 0;					
				sql.put(svc.getQuery("UPD_STREVTPOS"));
				sql.setString(++i, mi.getString("SPS_YN"));
				sql.setString(++i, strID);
				sql.setString(++i, mi.getString("STR_CD"));
				sql.setString(++i, mi.getString("EVENT_CD"));
				sql.setString(++i, mi.getString("POS_NO"));
				flag = "U";
				
			}else if ( mi.IS_DELETE()) {
				i = 0;			
				sql.put(svc.getQuery("DEL_STREVTPOS"));
				sql.setString(++i, mi.getString("STR_CD"));
				sql.setString(++i, mi.getString("EVENT_CD"));
				sql.setString(++i, mi.getString("POS_NO"));
				flag = "D";
			} else { 
				continue;	
			}
			
			res = update(sql);

			if (res != 1) {
				String msg ="";
				if( flag.equals("D")){
					msg ="데이터 삭제을 하지 못했습니다.";
				}else{
					msg ="데이터 입력을 하지 못했습니다.";					
				}
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ msg);
			}
			
			ret += res;
		}
		return ret;
		
	}
}
