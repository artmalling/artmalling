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

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

/**
 * <p>
 * 세금계산서관리
 * </p>
 * 
 * @created on 1.0, 2011.06.16
 * @created by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MCae604DAO extends AbstractDAO {

	/**
	 * <p>
	 * 관리비입금내역조회
	 * </p>
	 */
	@SuppressWarnings("rawtypes")
	public List getMaster(ActionForm form) throws Exception {

		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		try {
			connect("pot");
			svc = (Service) form.getService();
			sql = new SqlWrapper();
			
			String strStrCd 	= String2.nvl(form.getParam("strStrCd")); 	// 시설구분
			String strVenCd 	= String2.nvl(form.getParam("strVenCd"));	// 협력사코드
			String strTaxGYN 	= String2.nvl(form.getParam("strTaxGYN"));	// 구분
			int i = 0;
			
			sql.put(svc.getQuery("SEL_MR_CALMST"));
			sql.setString(++i, strVenCd);
			sql.setString(++i, strStrCd);
			sql.setString(++i, strTaxGYN);
			list = select2List(sql);
		} catch (Exception e) {
			System.out.println("DAO : " + e);
			throw e;
		}
		return list;
	}

	/**
	 * <p>
	 * 관리비정산
	 * </p>
	 */
	public int taxProcess(ActionForm form, MultiInput mi, String userId) throws Exception {
		String rtCd 			= null;
		String rtMsg 			= null;
		int ret 				= 0;
		ProcedureWrapper psql 	= null;
		ProcedureResultSet prs 	= null;
		try {
        	begin();
            connect("pot");
			String strIssueDT = String2.nvl(form.getParam("strIssueDT"));	// 발행일자

			while (mi.next()) {
				if (mi.getString("CHK_BOX").equals("T")) { //체크시에만 처리
					int i=1;
					
					psql = new ProcedureWrapper();
					psql.put("MSS.PR_TAXMSTCREATE", 12);
					
					psql.setString(i++, "W04"); /*V_WORK_FLAG*/
					psql.setString(i++, mi.getString("STR_CD")); /*V_STR_CD*/
					psql.setString(i++, mi.getString("VEN_CD")); /*V_VEN_CD*/
					psql.setString(i++, mi.getString("EVENT_CD")); /*V_WORK_KEY*/
					psql.setString(i++, strIssueDT); /*V_ISSUE_DT*/
					psql.setString(i++, strIssueDT); /*V_PAY_YM*/
					psql.setString(i++, mi.getString("TAX_GB")); /*V_TAX_GB*/
					psql.setString(i++, mi.getString("TAX_ISSUE_FLAG")); /*V_TAX_ISSUE_FLAG*/
					psql.setDouble(i++, mi.getDouble("CPN_REC_AMT")); /*V_TOT_AMT*/
					psql.setString(i++, userId);
					psql.registerOutParameter(i++, DataTypes.VARCHAR);
					psql.registerOutParameter(i++, DataTypes.VARCHAR);
					//처리
					prs = updateProcedure(psql);
					rtCd = prs.getString(11);
					rtMsg = prs.getString(12);
					if (!rtCd.equals("S")) {
						throw new Exception("[USER]" + rtMsg );
					}
					//최가화
					psql.close();
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
}
