/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package pstk.dao;

import java.util.List;
import java.util.Map;


import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;


/**
 * <p>저장품출고확정</p>
 * 
 * @created  on 1.0, 2010/06/02
 * @created  by 정진영(FKSS)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

/*
 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
 */
public class PStk404DAO extends AbstractDAO {
	
	/**
	 * 저장품출고 헤더조회 
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
		
		String strStrCd      = String2.nvl(form.getParam("strStrCd"));       //점
		String strFromDt     = String2.nvl(form.getParam("strFromDt"));      //기간(from)
		String strToDt       = String2.nvl(form.getParam("strToDt"));        //기간(to)
		String strVenCd      = String2.nvl(form.getParam("strVenCd"));       //협력사
		String strPumbunCd   = String2.nvl(form.getParam("strPumbunCd"));    //품번
		String strSlipStatus = String2.nvl(form.getParam("strSlipStatus"));  //확정구분
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_OUTSTOREHD") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strFromDt);
		sql.setString(i++, strToDt);

		if( !strVenCd.equals("")){
			sql.setString(i++, strVenCd);
			strQuery += svc.getQuery("SEL_OUTSTOREHD_WHERE_VEN_CD") + "\n";
		}
		if( !strSlipStatus.equals("%")){
			sql.setString(i++, strSlipStatus);
			strQuery += svc.getQuery("SEL_OUTSTOREHD_WHERE_SLIP_STATUS") + "\n";
		}
		if( !strPumbunCd.equals("")){
			sql.setString(i++, strPumbunCd);
			strQuery += svc.getQuery("SEL_OUTSTOREHD_WHERE_PUMBUN_CD") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_OUTSTOREHD_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
    }

    /**
     * 저장품출고상세 조회 
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
		
		String strStrCd     = String2.nvl(form.getParam("strStrCd"));     //점
		String strSlipNo    = String2.nvl(form.getParam("strSlipNo"));    //전표일자
		String strSlipSeqNo = String2.nvl(form.getParam("strSlipSeqNo")); //전표일련번호
		String strPumbunCd  = String2.nvl(form.getParam("strPumbunCd"));    //품번
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_OUTSTOREDT") + "\n";
		sql.setString(i++, strSlipNo);
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipSeqNo);
		if( !strPumbunCd.equals("")){
			sql.setString(i++, strPumbunCd);
			strQuery += svc.getQuery("SEL_OUTSTOREDT_WHERE_PUMBUN_CD") + "\n";
		}
		strQuery += svc.getQuery("SEL_OUTSTOREDT_ORDER");		
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
    }

    /**
     * 저장품출고
     * 확정
     * 
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
	public int conf(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		Map map = null;
		
		int i;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi.next()) {
				sql.close();
				
				if (mi.IS_UPDATE()){

					//확정여부 체크
					sql.put(svc.getQuery("SEL_OUTSTOREHD_CONF_FLAG"));
					sql.setString(1, mi.getString("SLIP_NO"));	
					sql.setString(2, mi.getString("STR_CD"));	
					sql.setString(3, mi.getString("SLIP_SEQ_NO"));	
					map = selectMap( sql );
					String confFlag = String2.nvl((String)map.get("CONF_FLAG"));
					if( !confFlag.equals("1")) {
						throw new Exception("[USER]"+"["+mi.getString("SLIP_NO")+","+mi.getString("SLIP_SEQ_NO")+"]확정된 데이터 입니다.");
					}
					
					sql.close();

					// 수정될 수 체크
					sql.put(svc.getQuery("SEL_OUTSTORE_CONF_CNT"));
					sql.setString(1, strID);	
					sql.setString(2, mi.getString("SLIP_NO"));	
					sql.setString(3, mi.getString("STR_CD"));	
					sql.setString(4, mi.getString("SLIP_SEQ_NO"));	
					map = selectMap( sql );
					String tmpCnt = String2.nvl((String)map.get("CNT"));
					int appCnt = Integer.parseInt(tmpCnt);
					
					sql.close();					
					i = 1;
					sql.put(svc.getQuery("MERGE_STOREGOOD"));			
					sql.setString(i++, strID);					
					sql.setString(i++, mi.getString("SLIP_NO"));		
					sql.setString(i++, mi.getString("STR_CD"));	
					sql.setString(i++, mi.getString("SLIP_SEQ_NO"));	
					// 저장품 수불에 데이터 반영
					res = update(sql);
					if( appCnt != res){
						throw new Exception("[USER]"+ "데이터의 적합성 문제로 인하여"
								+ "데이터를 처리 하지 못했습니다.");
					}
					sql.close();
					i = 1;
					
					sql.put(svc.getQuery("UPD_OUTSTOREHD"));				
					sql.setString(i++, "2");                        // 확정 : 2               	
					sql.setString(i++, mi.getString("CONF_DT"));	
					sql.setString(i++, strID);				
					sql.setString(i++, mi.getString("SLIP_NO"));	
					sql.setString(i++, mi.getString("STR_CD"));	
					sql.setString(i++, mi.getString("SLIP_SEQ_NO"));	
					// 저장품출고헤더 확정값 입력.
					res = update(sql);
					
					
				} else{
					continue;
				}


				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
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
