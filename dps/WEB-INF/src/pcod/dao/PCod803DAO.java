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
import java.util.List;
import java.util.Map;

import common.util.Util;
//import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>POS메세지 관리</p>
 * 
 * @created  on 1.0, 2010/01/24
 * @created  by 정진영(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod803DAO extends AbstractDAO {


	/**
	 * POS메세지 마스터을 조회한다.
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
		
		String strStrCd = String2.nvl(form.getParam("strStrCd"));
		String strMsgFlag = String2.nvl(form.getParam("strMsgFlag"));
		String strUseYn = String2.nvl(form.getParam("strUseYn"));
		String strMsgExpl = URLDecoder.decode( String2.nvl(form.getParam("strMsgExpl")), "UTF-8");

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strStrCd);
		sql.setString(i++, strMsgFlag);
		sql.setString(i++, strUseYn);
		sql.setString(i++, strMsgExpl);

		strQuery = svc.getQuery("SEL_POSRCPMSG");

		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * POS메세지 디테일을 조회한다.
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

		String strMsgId = String2.nvl(form.getParam("strMsgId"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		sql.setString(i++, strMsgId);

		strQuery = svc.getQuery("SEL_POSRCPMSGDTL");
		sql.put(strQuery);


		ret = select2List(sql);
		return ret;
	}

	/**
	 * POS메세지 마스터와 디테일  저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi[]
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strID)
			throws Exception {

		int ret = 0;
		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		String newMsgId = "";


		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			String useYn = "";
			String mstMsgId = "";
			while (mi[0].next()) {
				sql.close();
				if (mi[0].IS_INSERT()) {

					sql.close();
					sql.put(svc.getQuery("SEL_POSRCPMSG_NEW_ID"));
					
					Map map = selectMap( sql );
					
					newMsgId = String2.nvl((String)map.get("NEW_MSG_ID"));

					if( newMsgId.equals("")) {
						throw new Exception("[USER]"+"메세지ID가 존재하지 않아" + ""
								+ "데이터 입력을 하지 못했습니다.");
					}
					sql.close();
					sql.put(svc.getQuery("INS_POSRCPMSG"));

					sql.setString(1, newMsgId );
					sql.setString(2, mi[0].getString("STR_CD"));
					sql.setString(3, mi[0].getString("MSG_FLAG"));					
					sql.setString(4, mi[0].getString("MSG_EXPL"));
					sql.setString(5, mi[0].getString("USE_YN"));					
					sql.setString(6, strID);		
					sql.setString(7, strID);
					useYn = mi[0].getString("USE_YN");
					mstMsgId = newMsgId;
				} else if (mi[0].IS_UPDATE()) {
					sql.put(svc.getQuery("UPD_POSRCPMSG"));

					sql.setString(1, mi[0].getString("STR_CD"));
					sql.setString(2, mi[0].getString("MSG_FLAG"));					
					sql.setString(3, mi[0].getString("MSG_EXPL"));
					sql.setString(4, mi[0].getString("USE_YN"));					
					sql.setString(5, strID);
					sql.setString(6, mi[0].getString("MSG_ID"));
					useYn = mi[0].getString("USE_YN");
					mstMsgId =  mi[0].getString("MSG_ID");
				} else if (mi[0].IS_DELETE()){
					sql.put(svc.getQuery("UPD_POSRCPMSG"));

					sql.setString(1, mi[0].getString("STR_CD"));
					sql.setString(2, mi[0].getString("MSG_FLAG"));					
					sql.setString(3, mi[0].getString("MSG_EXPL"));
					sql.setString(4, "N");					
					sql.setString(5, strID);
					sql.setString(6, mi[0].getString("MSG_ID"));
					useYn = "N";
					mstMsgId = newMsgId;
				}else{
					continue;
				}

				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += res;
			}

			while (mi[1].next()) {
				sql.close();
				if (mi[1].IS_INSERT()) {
					String msgId = String2.nvl(mi[1].getString("MSG_ID"));					
					if( !msgId.equals("") ) 
						newMsgId = msgId;
					
					if( newMsgId.equals("")) {
						throw new Exception("[USER]"+"메세지ID가 존재하지 않아" + ""
								+ "데이터 입력을 하지 못했습니다.");
					}
					sql.put(svc.getQuery("INS_POSRCPMSGDTL"));

					sql.setString(1, newMsgId);
					sql.setString(2, newMsgId);
					sql.setString(3, mi[1].getString("PRT_FLAG"));					
					sql.setString(4, mi[1].getString("PRT_MSG"));
					sql.setString(5, mi[1].getString("SORT_NO"));
					sql.setString(6, mi[1].getString("USE_YN"));					
					sql.setString(7, strID);	
					sql.setString(8, strID);

				} else if (mi[1].IS_UPDATE()) {
					sql.put(svc.getQuery("UPD_POSRCPMSGDTL"));
					
					sql.setString(1, mi[1].getString("PRT_FLAG"));					
					sql.setString(2, mi[1].getString("PRT_MSG"));
					sql.setString(3, mi[1].getString("SORT_NO"));
					sql.setString(4, mi[1].getString("USE_YN"));					
					sql.setString(5, strID);
					sql.setString(6, mi[1].getString("MSG_ID"));
					sql.setString(7, mi[1].getString("MSG_NO"));
				} else {
					sql.put(svc.getQuery("UPD_POSRCPMSGDTL"));

					sql.setString(1, mi[1].getString("PRT_FLAG"));					
					sql.setString(2, mi[1].getString("PRT_MSG"));
					sql.setString(3, mi[1].getString("SORT_NO"));
					sql.setString(4, "N");					
					sql.setString(5, strID);
					sql.setString(6, mi[1].getString("MSG_ID"));
					sql.setString(7, mi[1].getString("MSG_NO"));
				}

				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}
				ret += res;
			}
			
			// 마스터의 사용여부가 N면 상세의 모든 항목 N로 변경
			if(useYn.equals("N")){
				sql.close();
				sql.put(svc.getQuery("UPD_POSRCPMSGDTL_USE_YN"));
				sql.setString(1, "N");					
				sql.setString(2, strID);
				sql.setString(3, mstMsgId);				
				update(sql);				
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
