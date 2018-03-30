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
 * <p>POS공지사항관리</p>
 * 
 * @created  on 1.0, 2010/05/02
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod807DAO extends AbstractDAO {

	/**
	 * POS공지사항 마스터 을 조회한다.
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

		String strRegDtFrom     = String2.nvl(form.getParam("strRegDtFrom"));
		String strRegDtTo       = String2.nvl(form.getParam("strRegDtTo"));
		String strStrCd         = String2.nvl(form.getParam("strStrCd"));
		String strNotiSDt       = String2.nvl(form.getParam("strNotiSDt"));
		String strNotiEDt       = String2.nvl(form.getParam("strNotiEDt"));
		String strNotiTitle     = URLDecoder.decode( String2.nvl(form.getParam("strNotiTitle")), "UTF-8");
		String strNotiNo        = String2.nvl(form.getParam("strNotiNo"));
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_POSNOTIMST") + "\n";
		
		if( !strRegDtFrom.equals("") && !strRegDtTo.equals("") ){
			sql.setString(i++, strRegDtFrom);
			sql.setString(i++, strRegDtTo);
			strQuery += svc.getQuery("SEL_POSNOTIMST_WHERE_REG_DT") + "\n";
		}
		
		if( !strNotiNo.equals("")){
			sql.setString(i++, strNotiNo);
			strQuery += svc.getQuery("SEL_POSNOTIMST_WHERE_NOTI_NO") + "\n";
			
		}
		if( !strStrCd.equals("%") && !strStrCd.equals("") ){
			sql.setString(i++, strStrCd);
			strQuery += svc.getQuery("SEL_POSNOTIMST_WHERE_STR_CD") + "\n";
		}
		if( !strNotiTitle.equals("") ){
			sql.setString(i++, strNotiTitle);
			strQuery += svc.getQuery("SEL_POSNOTIMST_WHERE_NOTI_TITLE") + "\n";
		}
		if( !strNotiSDt.equals("") && !strNotiEDt.equals("") ){
			sql.setString(i++, strNotiSDt);
			sql.setString(i++, strNotiEDt);
			strQuery += svc.getQuery("SEL_POSNOTIMST_WHERE_NOTI_DT") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_POSNOTIMST_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * POS공지사항 마스터,
	 * 저장, 수정  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;
		
		int resp = 0;//프로시저 리턴값
		ProcedureWrapper psql = null;	//프로시저 사용위함
		
		int i;
		try {
			connect("pot");
			begin();
			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			String flag = "";
			String newNotiNo = "";
			while (mi.next()) {
				sql.close();				
				if ( mi.IS_INSERT()) {
					flag = "I";
					newNotiNo = "";
					sql.put(svc.getQuery("SEL_POSNOTIMST_NEW_NOTI_NO"));					
					Map map = selectMap( sql );							
					newNotiNo = String2.nvl((String)map.get("NEW_NOTI_NO"));
					if( newNotiNo.equals("")) {
						throw new Exception("[USER]"+ "공지번호를 생성 할 수 없습니다.");
					}
					sql.close();		
					i = 0;		
					
					sql.put(svc.getQuery("INS_POSNOTIMST"));
					sql.setString( ++i, newNotiNo);
					sql.setString( ++i, mi.getString("STR_CD"        ));
					sql.setString( ++i, mi.getString("NOTI_TITLE"    ));
					sql.setString( ++i, mi.getString("NOTI_CONTENT"  ));
					sql.setString( ++i, mi.getString("NOTI_S_DT"     ));
					sql.setString( ++i, mi.getString("NOTI_E_DT"     ));
					sql.setString( ++i, strID);
					sql.setString( ++i, strID);
					
				} else if (mi.IS_UPDATE()){
					i = 0;	
					flag = "U";
					sql.put(svc.getQuery("UPD_POSNOTIMST"));
					sql.setString( ++i, mi.getString("STR_CD"        ));
					sql.setString( ++i, mi.getString("NOTI_TITLE"    ));
					sql.setString( ++i, mi.getString("NOTI_CONTENT"  ));
					sql.setString( ++i, mi.getString("NOTI_S_DT"     ));
					sql.setString( ++i, mi.getString("NOTI_E_DT"     ));
					sql.setString( ++i, strID);
					sql.setString( ++i, mi.getString("NOTI_NO"       ));
					newNotiNo = mi.getString("NOTI_NO"       );
				} else {
					continue;
				}
				
				res = update(sql);

				if (res != 1) {
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 입력을 하지 못했습니다.");
				}

				// POS IFS
				psql.put("DPS.PR_PCNOTIPOS_IFS", 5);               // 공지사항
				
	            psql.setString(1, newNotiNo);                      // 공지번호
	            psql.setString(2, flag);                           // 처리유형[I:INSERT, U:UPDATE, D:DELETE]
	            psql.setString(3, strID);                          // 작업자ID
	            psql.registerOutParameter(4, DataTypes.INTEGER);   // RETURN결과
	            psql.registerOutParameter(5, DataTypes.VARCHAR);   // RETURN메시지
	            
	            prs = updateProcedure(psql);
	            		            
	            resp = prs.getInt(4);
	            
	            if( resp != 0 ){
	            	throw new Exception("[USER]" + prs.getString(5));
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
	 * POS공지사항 마스터,
	 * 삭제  처리한다.
	 * 
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int delete(ActionForm form, MultiInput mi, String strID)
			throws Exception {

		int ret = 0;
		int res = 0;
		SqlWrapper sql = null;
		Service svc = null;

		int resp = 0;//프로시저 리턴값
		ProcedureWrapper psql = null;	//프로시저 사용위함
		
		int i;
		try {
			connect("pot");
			begin();

			psql = new ProcedureWrapper();	//프로시저 사용위함
			ProcedureResultSet prs = null;
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			while (mi.next()) {
				sql.close();				
				if (mi.IS_DELETE()){
					i = 0;							
					sql.put(svc.getQuery("DEL_POSNOTIMST"));		
					sql.setString( ++i, mi.getString("NOTI_NO" ));

					// POS IFS
					psql.put("DPS.PR_PCNOTIPOS_IFS", 5);               // 공지사항
					
		            psql.setString(1, mi.getString("NOTI_NO"));        // 공지번호
		            psql.setString(2, "D");                            // 처리유형[I:INSERT, U:UPDATE, D:DELETE]
		            psql.setString(3, strID);                          // 작업자ID
		            psql.registerOutParameter(4, DataTypes.INTEGER);   // RETURN결과
		            psql.registerOutParameter(5, DataTypes.VARCHAR);   // RETURN메시지
		            
		            prs = updateProcedure(psql);
		            		            
		            resp = prs.getInt(4);
		            
		            if( resp != 0 ){
		            	throw new Exception("[USER]" + prs.getString(5));
		            }
		            
				} else {
					continue;
				}
				
				res = update(sql);

				if (res != 1) {
					
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ "데이터 삭제를 하지 못했습니다.");
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
