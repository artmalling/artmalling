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

public class POrd302DAO extends AbstractDAO {

	/**
	 * TAG 발행의뢰 마스터 부분을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */ 
	public List searchMaster(ActionForm form, String userId, String org_flag) throws Exception {
		List ret = null; 
		SqlWrapper sql = null; 
		Service svc = null;
		String strQuery = "";
		
		int i = 1;
		String strStrCd   = String2.nvl(form.getParam("strStrCd"));
		String strReqDate = String2.nvl(form.getParam("strReqDate"));
		String strReqDdate2 = String2.nvl(form.getParam("strReqDdate2"));
		String strTagFlag = String2.nvl(form.getParam("strTagFlag")); 
		String strTagType = String2.nvl(form.getParam("strTagType")); 
		
		String tmpTagFlag = null;
		
		String strSkuFlag = null; 
		tmpTagFlag = strTagType.substring(0, 1); 

		
		if("2".equals(tmpTagFlag)){
			strSkuFlag = "2";
		}else{           
			strSkuFlag = "1"; 
		}     
		
		sql = new SqlWrapper();  
		svc = (Service) form.getService();
 
		connect("pot"); 

		sql.setString(i++, strTagFlag);		//구분 : 신규, 재발행
		sql.setString(i++, strStrCd);
		sql.setString(i++, strReqDate);
		sql.setString(i++, strReqDdate2);
//		sql.setString(i++, strSkuFlag);     //단품구분
		sql.setString(i++, strTagType);     //택종류
		sql.setString(i++, userId);
		sql.setString(i++, strStrCd);

		strQuery = svc.getQuery("searchMaster");

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * TAG 발행의뢰 품목  디테일 부분을 조회한다. 
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail(ActionForm form) throws Exception {

		List ret = null;
		Util util = new Util();
	
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;

		String strStrCd = String2.nvl(form.getParam("strStrCd"));  
		String strReqDate = String2.nvl(form.getParam("strReqDate"));
		String strReqSeqNo = String2.nvl(form.getParam("strReqSeqNo")); 

		sql = new SqlWrapper(); 
		svc = (Service) form.getService();

		connect("pot"); 

		sql.setString(i++, strReqSeqNo); 
		sql.setString(i++, strStrCd);
		sql.setString(i++, strReqDate);

		strQuery = svc.getQuery("searchDetail");
		sql.put(strQuery);
 

		ret = select2List(sql);

		//복호화
		return ret;
	}


	/**
	 * TAG 발행의뢰 단품  디테일 부분을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List searchDetail2(ActionForm form) throws Exception {

		List ret  = null;
	
		SqlWrapper sql  = null;
		Service svc     = null;
		String strQuery = "";
		int i = 1;

		String strStrCd    = String2.nvl(form.getParam("strStrCd"));
		String strReqDate  = String2.nvl(form.getParam("strReqDate"));
		String strReqSeqNo = String2.nvl(form.getParam("strReqSeqNo"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strReqSeqNo);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strReqDate);

		strQuery = svc.getQuery("searchDetail2");
		sql.put(strQuery);

		ret = select2List(sql);

		//복호화
		return ret;
	}
	
	/**
	 * 택발행 이후 마스터 정보 수정한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int updTagFlagData(ActionForm form, MultiInput mi1, MultiInput mi2, String userId)
	throws Exception {

    int ret 	= 0;
    int ret2 	= 0;
	int res 	= 0;
	int i   	= 0;
	int mstCnt 	= 0;	
	

	SqlWrapper sql = null;
	Service svc = null;
	
	try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi1.next()) {		//품목 데이터
	
				sql.close();
				if(mi1.IS_UPDATE()){// 수정

					System.out.println("품목데이터 업데이트");	
					i = 1; 
					sql.put(svc.getQuery("UPD_PMKINFO"));
					sql.setString(i++, userId);
					sql.setString(i++, mi1.getString("STR_CD"));
					sql.setString(i++, mi1.getString("PRT_REQ_DT"));
					sql.setString(i++, mi1.getString("PRT_REQ_SEQ_NO"));
					sql.setString(i++, mi1.getString("PRT_DTL_SEQ_NO"));
					
				}
				res = update(sql);

				sql.close();
				i = 1; 
				sql.put(svc.getQuery("UPD_MASTER"));
				sql.setString(i++, userId);
				sql.setString(i++, mi1.getString("STR_CD"));
				sql.setString(i++, mi1.getString("PRT_REQ_DT"));
				sql.setString(i++, mi1.getString("PRT_REQ_SEQ_NO"));
				res = update(sql);
/*	
				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret2 += res;
*/
			}
			
			while (mi2.next()) {		//단품 데이터
	
				sql.close();
				if(mi2.IS_UPDATE()){// 수정

					System.out.println("단품데이터 업데이트");
					i = 1; 
					sql.put(svc.getQuery("UPD_SKUINFO")); 
					sql.setString(i++, userId);
					sql.setString(i++, mi2.getString("STR_CD"));
					sql.setString(i++, mi2.getString("PRT_REQ_DT"));
					sql.setString(i++, mi2.getString("PRT_REQ_SEQ_NO"));
					sql.setString(i++, mi2.getString("PRT_DTL_SEQ_NO"));
					
				}
				res = update(sql);

				sql.close();
				i = 1; 
				sql.put(svc.getQuery("UPD_MASTER"));
				sql.setString(i++, userId);
				sql.setString(i++, mi2.getString("STR_CD"));
				sql.setString(i++, mi2.getString("PRT_REQ_DT"));
				sql.setString(i++, mi2.getString("PRT_REQ_SEQ_NO"));
				res = update(sql);
/*	
				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret2 += res;
*/
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
	 * TAG 발행의뢰 단품  디테일 부분을 조회한다.
	 * 
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public int multiUpdTagFlagData(ActionForm form, MultiInput mi, String userId) throws Exception {

		int res 	= 0;
		int i   	= 0;
		

		SqlWrapper sql = null;
		Service svc = null;
		
		try {
				connect("pot");
				begin();
				sql = new SqlWrapper();
				svc = (Service) form.getService();
				
				while (mi.next()) {		//품목 데이터
					
					i = 1; 
					sql.put(svc.getQuery("UPD_MASTER"));
					sql.setString(i++, userId);
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("PRT_REQ_DT"));
					sql.setString(i++, mi.getString("PRT_REQ_SEQ_NO"));					
					res = update(sql);		
					sql.close();

					
					System.out.println("품목단품데이터 업데이트");	
					i = 1; 
					sql.put(svc.getQuery("UPD_DETAIL"));
					sql.setString(i++, userId);
					sql.setString(i++, mi.getString("STR_CD"));
					sql.setString(i++, mi.getString("PRT_REQ_DT"));
					sql.setString(i++, mi.getString("PRT_REQ_SEQ_NO"));					
					res += update(sql);
					sql.close();
					/*
					if (res !=2) {
						throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
								+ "데이터 입력을 하지 못했습니다.");
					}
					*/
				}
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return res;
	}
}
