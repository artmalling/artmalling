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
 * <p>저장품입고등록</p>
 * 
 * @created  on 1.0, 2010/06/01
 * @created  by 정진영(FKSS)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

/*
 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
 */
public class PStk401DAO extends AbstractDAO {
	
	/**
	 * 저장품입고 헤더조회 
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
		
		String strStrCd    = String2.nvl(form.getParam("strStrCd"));     //점
		String strFromDt   = String2.nvl(form.getParam("strFromDt"));    //기간(from)
		String strToDt     = String2.nvl(form.getParam("strToDt"));      //기간(to)
		String strVenCd    = String2.nvl(form.getParam("strVenCd"));     //협력사
		String strPumbunCd = String2.nvl(form.getParam("strPumbunCd"));  //품번
		String strSlipFlag = String2.nvl(form.getParam("strSlipFlag"));  //입/출고구분
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_INSTOREHD") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strFromDt);
		sql.setString(i++, strToDt);

		if( !strVenCd.equals("")){
			sql.setString(i++, strVenCd);
			strQuery += svc.getQuery("SEL_INSTOREHD_WHERE_VEN_CD") + "\n";
		}
		if( !strSlipFlag.equals("%")){
			sql.setString(i++, strSlipFlag);
			strQuery += svc.getQuery("SEL_INSTOREHD_WHERE_SLIP_FLAG") + "\n";
		}
		if( !strPumbunCd.equals("")){
			sql.setString(i++, strPumbunCd);
			strQuery += svc.getQuery("SEL_INSTOREHD_WHERE_PUMBUN_CD") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_INSTOREHD_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
    }

    /**
     * 저장품입고상세 조회 
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
		String strPumbunCd  = String2.nvl(form.getParam("strPumbunCd"));  //품번
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_INSTOREDT") + "\n";
		sql.setString(i++, strStrCd);
		sql.setString(i++, strSlipNo);
		sql.setString(i++, strSlipSeqNo);
		if( !strPumbunCd.equals("")){
			sql.setString(i++, strPumbunCd);
			strQuery += svc.getQuery("SEL_INSTOREDT_WHERE_PUMBUN_CD") + "\n";
		}
		strQuery += svc.getQuery("SEL_INSTOREDT_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
    }

    /**
     * 저장품입고헤더, 저장품입고상세
     * 저장/삭제
     * 
     * @param form
     * @param mis[]
     * @param strID
     * @return
     * @throws Exception
     */
	public int save(ActionForm form, MultiInput mis[], String strID)
			throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		Map map = null;
		String newSlipSeqNo = "";
		String newSlipNo = "";
		
		int i;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			//저장품입고헤더
			MultiInput mi = mis[0];			
			while (mi.next()) {
				sql.close();
				//신규 입력시
				if (mi.IS_INSERT()) {
					//신규 전표일련번호
					sql.put(svc.getQuery("SEL_INSTOREHD_NEXT_SLIP_SEQ_NO"));
					sql.setString(1, mi.getString("STR_CD"));	
					sql.setString(2, mi.getString("SLIP_NO"));	
					map = selectMap( sql );
					newSlipSeqNo = String2.nvl((String)map.get("NEXT_SLIP_SEQ_NO"));
					if( newSlipSeqNo.equals("")) {
						throw new Exception("[USER]"+"전표일련번호를 생성 할 수 없습니다.");
					}
					newSlipNo = mi.getString("SLIP_NO");
					sql.close();
					i = 1;					
					
					sql.put(svc.getQuery("INS_INSTOREHD"));
					sql.setString(i++, mi.getString("STR_CD"));					
					sql.setString(i++, mi.getString("SLIP_NO"));					
					sql.setString(i++, newSlipSeqNo);					
					sql.setString(i++, mi.getString("SLIP_FLAG"));					
					sql.setString(i++, mi.getString("SLIP_STATUS"));					
					sql.setString(i++, mi.getString("VEN_CD"));							
					sql.setString(i++, mi.getString("CONF_DT"));					
					sql.setString(i++, mi.getString("IN_TOT_QTY"));					
					sql.setString(i++, mi.getString("IN_TOT_AMT"));			
					sql.setString(i++, strID);					
					sql.setString(i++, strID);

					// 저장품입고헤더 신규추가한다.
					res = update(sql);

				//수정 입력시
				} else if (mi.IS_UPDATE()) {

					//확정여부 체크
					sql.put(svc.getQuery("SEL_INSTOREHD_CONF_FLAG"));
					sql.setString(1, mi.getString("STR_CD"));	
					sql.setString(2, mi.getString("SLIP_NO"));	
					sql.setString(3, mi.getString("SLIP_SEQ_NO"));	
					map = selectMap( sql );
					String confFlag = String2.nvl((String)map.get("CONF_FLAG"));
					if( !confFlag.equals("1")) {
						throw new Exception("[USER]"+"["+mi.getString("SLIP_NO")+","+mi.getString("SLIP_SEQ_NO")+"]확정된 데이터 입니다.");
					}
					sql.close();
					i = 1;
					
					sql.put(svc.getQuery("UPD_INSTOREHD"));
					
					sql.setString(i++, mi.getString("IN_TOT_QTY"));
					sql.setString(i++, mi.getString("IN_TOT_AMT"));
					sql.setString(i++, strID);
					sql.setString(i++, mi.getString("STR_CD"));	
					sql.setString(i++, mi.getString("SLIP_NO"));	
					sql.setString(i++, mi.getString("SLIP_SEQ_NO"));	

					// 저장품입고헤더 수정한다.
					res = update(sql);
					
				} else{
					continue;
				}


				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터를 입력 하지 못했습니다.");
				}
				ret += res;
			}
			
			// 저장품입고상세			
			mi = mis[1];			
			while (mi.next()) {
				sql.close();
				//신규 입력시
				if (mi.IS_INSERT()) {
					if(!mi.getString("SLIP_SEQ_NO").equals("")){
						newSlipSeqNo = mi.getString("SLIP_SEQ_NO");
					}
					newSlipNo = newSlipNo.equals("")?mi.getString("SLIP_NO"):newSlipNo;
					//확정여부 체크
					sql.put(svc.getQuery("SEL_INSTOREHD_CONF_FLAG"));
					sql.setString(1, mi.getString("STR_CD"));	
					sql.setString(2, newSlipNo);	
					sql.setString(3, newSlipSeqNo);	
					map = selectMap( sql );
					String confFlag = String2.nvl((String)map.get("CONF_FLAG"));
					if( !confFlag.equals("1")) {
						throw new Exception("[USER]"+"["+mi.getString("SLIP_NO")+","+newSlipSeqNo+"]확정된 데이터 입니다.");
					}
					sql.close();
					i = 1;					

					//중복되는 단품 조회
					sql.put(svc.getQuery("SEL_INSTOREDT_SKU_CD_CNT"));
					sql.setString(1, mi.getString("STR_CD"));	
					sql.setString(2, newSlipNo);	
					sql.setString(3, newSlipSeqNo);	
					sql.setString(4, mi.getString("SKU_CD"));	
					map = selectMap( sql );
					String cnt = String2.nvl((String)map.get("CNT"));
					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"["+mi.getString("SKU_CD")+"] 중복된 데이터가 있습니다.");
					}
					sql.close();
					i = 1;
					
					sql.put(svc.getQuery("INS_INSTOREDT"));
					
					sql.setString(i++, mi.getString("STR_CD"));					
					sql.setString(i++, newSlipNo);					
					sql.setString(i++, newSlipSeqNo);			
					// 저장품입고상세 일련번호 생성
					sql.setString(i++, mi.getString("STR_CD"));					
					sql.setString(i++, mi.getString("SLIP_NO"));					
					sql.setString(i++, newSlipSeqNo);		
					
					sql.setString(i++, mi.getString("PUMBUN_CD"));	
					sql.setString(i++, mi.getString("PUMMOK_CD"));				
					sql.setString(i++, mi.getString("DEPT_CD"));						
					sql.setString(i++, mi.getString("TEAM_CD"));						
					sql.setString(i++, mi.getString("PC_CD"));							
					sql.setString(i++, mi.getString("SKU_CD"));					
					sql.setString(i++, mi.getString("UNIT_CD"));					
					sql.setString(i++, mi.getString("IN_QTY"));					
					sql.setString(i++, mi.getString("IN_PRC"));					
					sql.setString(i++, mi.getString("IN_AMT"));				
					sql.setString(i++, strID);					
					sql.setString(i++, strID);

					// 저장품입고상세 신규추가한다.
					res = update(sql);

				//수정 입력시
				} else if (mi.IS_UPDATE()) {

					//확정여부 체크
					sql.put(svc.getQuery("SEL_INSTOREHD_CONF_FLAG"));
					sql.setString(1, mi.getString("STR_CD"));	
					sql.setString(2, mi.getString("SLIP_NO"));	
					sql.setString(3, mi.getString("SLIP_SEQ_NO"));	
					map = selectMap( sql );
					String confFlag = String2.nvl((String)map.get("CONF_FLAG"));
					if( !confFlag.equals("1")) {
						throw new Exception("[USER]"+"["+mi.getString("SLIP_NO")+","+mi.getString("SLIP_SEQ_NO")+"]확정된 데이터 입니다.");
					}
					sql.close();
					i = 1;
					
					sql.put(svc.getQuery("UPD_INSTOREDT"));
					
					sql.setString(i++, mi.getString("IN_QTY"));
					sql.setString(i++, mi.getString("IN_PRC"));
					sql.setString(i++, mi.getString("IN_AMT"));
					sql.setString(i++, strID);
					sql.setString(i++, mi.getString("STR_CD"));	
					sql.setString(i++, mi.getString("SLIP_NO"));	
					sql.setString(i++, mi.getString("SLIP_SEQ_NO"));	
					sql.setString(i++, mi.getString("SEQ_NO"));

					// 저장품입고상세 수정한다.
					res = update(sql);
				// 삭제시	
				} else if (mi.IS_DELETE()){

					//확정여부 체크
					sql.put(svc.getQuery("SEL_INSTOREHD_CONF_FLAG"));
					sql.setString(1, mi.getString("STR_CD"));	
					sql.setString(2, mi.getString("SLIP_NO"));	
					sql.setString(3, mi.getString("SLIP_SEQ_NO"));	
					map = selectMap( sql );
					String confFlag = String2.nvl((String)map.get("CONF_FLAG"));
					if( !confFlag.equals("1")) {
						throw new Exception("[USER]"+"["+mi.getString("SLIP_NO")+","+mi.getString("SLIP_SEQ_NO")+"]확정된 데이터 입니다.");
					}
					
					sql.close();
					i = 1;
					
					sql.put(svc.getQuery("DEL_INSTOREDT"));					
					sql.setString(i++, mi.getString("STR_CD"));	
					sql.setString(i++, mi.getString("SLIP_NO"));	
					sql.setString(i++, mi.getString("SLIP_SEQ_NO"));	
					sql.setString(i++, mi.getString("SEQ_NO"));
					// 저장품입고상세 삭제한다.
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

    /**
     * 저장품입고헤더
     * 삭제
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
		Map map = null;
		
		int i;
		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			while (mi.next()) {
				sql.close();
				
				if (mi.IS_DELETE()){

					//확정여부 체크
					sql.put(svc.getQuery("SEL_INSTOREHD_CONF_FLAG"));
					sql.setString(1, mi.getString("STR_CD"));	
					sql.setString(2, mi.getString("SLIP_NO"));	
					sql.setString(3, mi.getString("SLIP_SEQ_NO"));	
					map = selectMap( sql );
					String confFlag = String2.nvl((String)map.get("CONF_FLAG"));
					if( !confFlag.equals("1")) {
						throw new Exception("[USER]"+"["+mi.getString("SLIP_NO")+","+mi.getString("SLIP_SEQ_NO")+"]확정된 데이터 입니다.");
					}
					
					sql.close();
					i = 1;
					
					sql.put(svc.getQuery("DEL_INSTOREHD_TO_INSTOREDT"));					
					sql.setString(i++, mi.getString("STR_CD"));	
					sql.setString(i++, mi.getString("SLIP_NO"));	
					sql.setString(i++, mi.getString("SLIP_SEQ_NO"));	
					// 저장품입고상세 삭제한다.
					update(sql);
					
					sql.close();
					i = 1;
					
					sql.put(svc.getQuery("DEL_INSTOREHD"));					
					sql.setString(i++, mi.getString("STR_CD"));	
					sql.setString(i++, mi.getString("SLIP_NO"));	
					sql.setString(i++, mi.getString("SLIP_SEQ_NO"));	
					// 저장품입고헤더 삭제한다.
					res = update(sql);
					
				} else{
					continue;
				}


				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터를 삭제 하지 못했습니다.");
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
