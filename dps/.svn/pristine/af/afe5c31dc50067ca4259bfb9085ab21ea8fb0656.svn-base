/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pord.dao;

import java.util.List;
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


/**
 * <p>예제  DAO</p>
 * 
 * @created  on 1.0, 2010/01/13 
 * @created  by 정진영(FKSS)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class POrd301DAO extends AbstractDAO {

	/**
	 * TAG 발행의뢰 마스터 부분을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getList(ActionForm form, String userId) throws Exception {     
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;  
		
		String strStrCd      	= String2.nvl(form.getParam("strStrCd"));
		String strPrtReqDt      = String2.nvl(form.getParam("strPrtReqDt"));
		String strPrtReqDt2     = String2.nvl(form.getParam("strPrtReqDt2"));
		String strPumbunCd      = String2.nvl(form.getParam("strPumbunCd"));
		String strPrtReqSeqNo   = String2.nvl(form.getParam("strPrtReqSeqNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");		
		if(strPrtReqSeqNo.equals("") || strPrtReqSeqNo.equals(null)){
			sql.setString(i++, strStrCd);     
			sql.setString(i++, strPrtReqDt);  
			sql.setString(i++, strPrtReqDt2);        
			sql.setString(i++, strPumbunCd);       
			sql.setString(i++, userId);               
			sql.setString(i++, strStrCd);           
			strQuery = svc.getQuery("SEL_LIST_ODD_PRT_REQ_NO") + "\n";			
		}else{
			sql.setString(i++, strStrCd);     
			sql.setString(i++, strPrtReqDt);  
			sql.setString(i++, strPrtReqDt2);     
			sql.setString(i++, strPumbunCd);      
			sql.setString(i++, strPrtReqSeqNo);       
			sql.setString(i++, userId);             
			sql.setString(i++, strStrCd);     
			strQuery = svc.getQuery("SEL_LIST") + "\n";			
		}
		
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}

	/**
	 * TAG 발행의뢰 마스터 부분을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMaster(ActionForm form, String userId) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		
		String strStrCd      	= String2.nvl(form.getParam("strStrCd"));
		String strPrtReqDt      = String2.nvl(form.getParam("strPrtReqDt"));
		String strPrtReqSeqNo   = String2.nvl(form.getParam("strPrtReqSeqNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");		

		sql.setString(i++, strStrCd);     
		sql.setString(i++, strPrtReqDt);      
		sql.setString(i++, strPrtReqSeqNo);      
		strQuery = svc.getQuery("SEL_MASTER") + "\n";			

		
		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}

	/**
	 * TAG 발행의뢰 단품  디테일 부분을 조회한다.
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
		
		String strStrCd      	= String2.nvl(form.getParam("strStrCd"));
		String strPrtReqDt      = String2.nvl(form.getParam("strPrtReqDt"));
		String strPrtReqSeqNo   = String2.nvl(form.getParam("strPrtReqSeqNo"));
		String strSkuFlag       = String2.nvl(form.getParam("strSkuFlag"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");		
		sql.setString(i++, strStrCd);     
		sql.setString(i++, strPrtReqDt);     
		sql.setString(i++, strPrtReqSeqNo);      
		sql.setString(i++, strSkuFlag);  
		
		strQuery = svc.getQuery("SEL_DETAIL") + "\n";

		sql.put(strQuery);
		ret = select2List(sql);
		return ret;
	}

	/**
	 * 단품 매가원가
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getSkuInfo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd	= String2.nvl(form.getParam("strStrCd"));
		String strSkuCd	= String2.nvl(form.getParam("strSkuCd"));
		String strAppDt	= String2.nvl(form.getParam("strAppDt"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strSkuCd);
		sql.setString(i++, strAppDt);

		strQuery = svc.getQuery("SEL_SKU_SALE_PRC") + "\n";
//		System.out.println("strquery : "+ strQuery);
		sql.put(strQuery);
		ret = select2List(sql);
		//System.out.println("Mret.size()= " + ret.size());
		return ret;

	}
	
	/**
	 *  물품 입고/반품 내용을  저장, 수정 처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int saveMaster(ActionForm form, MultiInput mi1, MultiInput mi2, String userId)
	throws Exception {

    int ret 	= 0;
    int ret2 	= 0;
	int res 	= 0;
	int i   	= 0;
	int mstCnt 	= 0;	
	
	String strPrtReqSeqNo  = "";		// 전표번호
		
	SqlWrapper sql = null;
	Service svc = null;
	
	try {
		connect("pot");
		begin();
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		while (mi1.next()) {
			
			sql.close();
			if (mi1.IS_INSERT()) { // 저장
			
				// 전표번호를 생성한다.(시퀀스사용)
				sql.put(svc.getQuery("SEL_PRT_REQ_SEQ_NO"));	
				
				Map mapStrPrtReqSeqNo = (Map)selectMap(sql);
				strPrtReqSeqNo = mapStrPrtReqSeqNo.get("PRT_REQ_SEQ_NO").toString();
				mi1.setString("PRT_REQ_SEQ_NO", strPrtReqSeqNo);
				sql.close();
			
				String strStrCd			= String2.nvl(form.getParam("strStrCd"));
				String strPrtReqDt		= String2.nvl(form.getParam("strPrtReqDt"));
				String strPumbunCd		= String2.nvl(form.getParam("strPumbunCd"));
				String strVenCd			= String2.nvl(form.getParam("strVenCd"));
				String strMgAppDt		= String2.nvl(form.getParam("strMgAppDt"));
				String strEventFlag		= String2.nvl(form.getParam("strEventFlag"));
				String strEventRate		= String2.nvl(form.getParam("strEventRate"));
				String strTagFlag		= String2.nvl(form.getParam("strTagFlag"));
				String strPrtYYYY       = String2.nvl(form.getParam("strPrtYYYY"));
				
				sql.put(svc.getQuery("INS_MASTER")); 
				
				sql.setString(1, strStrCd);
				sql.setString(2, strPrtReqDt);
				sql.setString(3, strPrtReqSeqNo);
				sql.setString(4, strPumbunCd);
				sql.setString(5, strVenCd);
				sql.setString(6, strMgAppDt);
				sql.setString(7, strEventFlag);
				sql.setString(8, strEventRate);
				sql.setString(9, strTagFlag);
				sql.setString(10, strPrtYYYY);
				sql.setString(11, userId);
				sql.setString(12, userId);
				sql.setString(13, userId);

			}else if(mi1.IS_UPDATE()){// 수정
				
				String strPumbunCd		= String2.nvl(form.getParam("strPumbunCd"));
				String strVenCd			= String2.nvl(form.getParam("strVenCd"));
				String strMgAppDt		= String2.nvl(form.getParam("strMgAppDt"));
				String strEventFlag		= String2.nvl(form.getParam("strEventFlag"));
				String strEventRate		= String2.nvl(form.getParam("strEventRate"));
				String strTagFlag		= String2.nvl(form.getParam("strTagFlag"));
				String strPrtYYYY       = String2.nvl(form.getParam("strPrtYYYY"));
				
				sql.put(svc.getQuery("UPD_MASTER"));
				
				sql.setString(1, strPumbunCd);
				sql.setString(2, strVenCd);
				sql.setString(3, strMgAppDt);
				sql.setString(4, strEventFlag);
				sql.setString(5, strEventRate);
				sql.setString(6, strTagFlag);
				sql.setString(7, strPrtYYYY);
				sql.setString(8, userId);
				sql.setString(9, mi1.getString("STR_CD"));
//				sql.setString(10, mi1.getString("PRT_REQ_DT"));
				sql.setString(10, mi1.getString("PRT_REQ_SEQ_NO"));
				
			}else if(mi1.IS_DELETE()){// 삭제	
				
				sql.put(svc.getQuery("DEL_MASTER")); 

				sql.setString(1, mi1.getString("STR_CD"));
				sql.setString(2, mi1.getString("PRT_REQ_DT"));
				sql.setString(3, mi1.getString("PRT_REQ_SEQ_NO"));
				
			}
			res = update(sql);

			if (res != 1) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}			
			ret += res;
		}
		
		while (mi2.next()) {		//단품 데이터

			sql.close();
			if (mi2.IS_INSERT()) { // 저장
//				System.out.println("strPrtReqSeqNo1 :::::" + strPrtReqSeqNo);
				if(!"".equals(strPrtReqSeqNo)){
//					System.out.println("strPrtReqSeqNo2 :::::" + strPrtReqSeqNo);
					mi2.setString("PRT_REQ_SEQ_NO", strPrtReqSeqNo);
				}
				
				// 1. 전표상세번호 생성
				sql.put(svc.getQuery("SEL_PRT_DTL_SEQ_NO"));
				
				sql.setString(1, mi2.getString("STR_CD"));
				sql.setString(2, mi2.getString("PRT_REQ_SEQ_NO"));
				sql.setString(3, mi2.getString("PRT_REQ_DT"));
	
				Map mapSeqNo = (Map)selectMap(sql);
				mi2.setString("PRT_DTL_SEQ_NO", mapSeqNo.get("PRT_DTL_SEQ_NO").toString());
//				System.out.println("############"+mapSeqNo.get("PRT_DTL_SEQ_NO").toString());
				
				String strPrtDtlSeqNo = mapSeqNo.get("PRT_DTL_SEQ_NO").toString();
				sql.close();				

				sql.put(svc.getQuery("INS_DETAIL")); 

//				System.out.println("strPrtDtlSeqNo = " + strPrtDtlSeqNo);
				
				sql.setString(1, mi2.getString("STR_CD"));
				sql.setString(2, mi2.getString("PRT_REQ_DT"));
				sql.setString(3, mi2.getString("PRT_REQ_SEQ_NO"));
				sql.setString(4, strPrtDtlSeqNo);
				sql.setString(5, mi2.getString("PUMMOK_SRT_CD"));
				sql.setString(6, mi2.getString("PUMMOK_CD"));
				sql.setString(7, mi2.getString("REQ_CNT"));
				sql.setString(8, mi2.getString("SALE_PRC"));
				sql.setString(9, userId);
				sql.setString(10, userId);
			}else if(mi2.IS_UPDATE()){// 수정
				
				sql.put(svc.getQuery("UPD_DETAIL"));

				sql.setString(1, mi2.getString("PUMMOK_SRT_CD"));
				sql.setString(2, mi2.getString("PUMMOK_CD"));
//				sql.setString(3, mi2.getString("SKU_CD"));
				sql.setString(3, mi2.getString("REQ_CNT"));
				sql.setString(4, mi2.getString("SALE_PRC"));
				sql.setString(5, userId);
				
				sql.setString(6, mi2.getString("STR_CD"));
				sql.setString(7, mi2.getString("PRT_REQ_SEQ_NO"));
				sql.setString(8, mi2.getString("PRT_DTL_SEQ_NO"));
				
			}else if(mi2.IS_DELETE()){// 삭제	
				
				sql.put(svc.getQuery("DEL_PBNSKU")); 

				sql.setString(1, mi2.getString("STR_CD"));
				sql.setString(2, mi2.getString("PRT_REQ_SEQ_NO"));
				sql.setString(3, mi2.getString("PRT_DTL_SEQ_NO"));
				
			}
			res = update(sql);

			if (res != 1) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 입력을 하지 못했습니다.");
			}
			ret2 += res;
		}
	} catch (Exception e) {
		rollback();
		throw e;
	} finally {
		end();
	}
	return res;
}
	
	/**
	 *  TAG 발행 의뢰 마스터 삭제
	 */
	public int deleMaster(ActionForm form, String userId)
	throws Exception {
		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			sql.close();

			String strStrCd			= String2.nvl(form.getParam("strStrCd"));
			String strPrtReqDt		= String2.nvl(form.getParam("strPrtReqDt"));
			String strPrtReqSeqNo	= String2.nvl(form.getParam("strPrtReqSeqNo"));

			sql.put(svc.getQuery("DEL_DETAIL_ALL"));

			sql.setString(1, strStrCd);
			sql.setString(2, strPrtReqDt);
			sql.setString(3, strPrtReqSeqNo);
			res = update(sql);			

			sql.close();
			sql.put(svc.getQuery("DEL_MASTER"));

			sql.setString(1, strStrCd);
			sql.setString(2, strPrtReqDt);
			sql.setString(3, strPrtReqSeqNo);
			res = update(sql);

			if (res  < 0) {
				throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
						+ "데이터 삭제를 하지 못했습니다.");
			}

			ret += res;
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}	
	
	/**
	 * 행사구분 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMarginFlag(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd			= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd		= String2.nvl(form.getParam("strPumbunCd"));
		String strMarginAppDt	= String2.nvl(form.getParam("strMarginAppDt"));

//		System.out.println(strStrCd);
//		System.out.println(strPumbunCd);
//		System.out.println(strMarginAppDt);
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strMarginAppDt);

		strQuery = svc.getQuery("SEL_MARGIN_FLAG") + "\n";
//		System.out.println("strquery : "+ strQuery);
//		System.out.println("행사구분타나!!!!");
		sql.put(strQuery);
		ret = select2List(sql);
		//System.out.println("Mret.size()= " + ret.size());
		return ret;
	}
	
	/**
	 * 행사율 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getMarginRate(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd			= String2.nvl(form.getParam("strStrCd"));
		String strPumbunCd		= String2.nvl(form.getParam("strPumbunCd"));
		String strMarginAppDt	= String2.nvl(form.getParam("strMarginAppDt"));
		String strMarginGbn	    = String2.nvl(form.getParam("strMarginGbn"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strMarginAppDt);
		sql.setString(i++, strMarginGbn);

//		System.out.println("마진율타나");
		strQuery = svc.getQuery("SEL_MARGIN_RATE") + "\n";
//		System.out.println("strquery : "+ strQuery);
		sql.put(strQuery);
		ret = select2List(sql);
		//System.out.println("Mret.size()= " + ret.size());
		return ret;

	}	
	/**
	 * 품목코드 조회
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List getPummokInfo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strPumbunCd	= String2.nvl(form.getParam("strPumbunCd"));
		String strPummokCd	= String2.nvl(form.getParam("strPummokCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strPumbunCd);
		sql.setString(i++, strPummokCd);

//		System.out.println("마진율타나");
		strQuery = svc.getQuery("SEL_PUMMOK_INFO") + "\n";
//		System.out.println("strquery : "+ strQuery);
		sql.put(strQuery);
		ret = select2List(sql);
		//System.out.println("Mret.size()= " + ret.size());
		return ret;

	}
}

