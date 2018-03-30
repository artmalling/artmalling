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
 * <p>판매사원관리</p>
 * 
 * @created  on 1.0, 2010/04/29
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod805DAO extends AbstractDAO {

	/**
	 * 판매사원 마스터 을 조회한다.
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

		String strStrCd       = String2.nvl(form.getParam("strStrCd"));
		String strSaleUserNo  = String2.nvl(form.getParam("strSaleUserNo"));
		String strEmpName     = URLDecoder.decode( String2.nvl(form.getParam("strEmpName")), "UTF-8");
		String strOrgCd       = String2.nvl(form.getParam("strOrgCd"));
		String strOrgName     = URLDecoder.decode( String2.nvl(form.getParam("strOrgName")), "UTF-8");
		String strPosAuthFlag = String2.nvl(form.getParam("strPosAuthFlag"));
		String strEmpFlag = String2.nvl(form.getParam("strEmpFlag"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_SALEUSERMST") + "\n";
		sql.setString(i++, strStrCd);
		
		if( !strSaleUserNo.equals("") ){
			sql.setString(i++, strSaleUserNo);
			strQuery += svc.getQuery("SEL_SALEUSERMST_WHERE_SALE_USER_ID") + "\n";
		}
		if( !strEmpName.equals("") ){
			sql.setString(i++, strEmpName);
			strQuery += svc.getQuery("SEL_SALEUSERMST_WHERE_EMP_NAME") + "\n";
		}
		if( !strOrgCd.equals("") ){
			sql.setString(i++, strOrgCd);
			strQuery += svc.getQuery("SEL_SALEUSERMST_WHERE_ORG_CD") + "\n";
		}
		if( !strOrgName.equals("") ){
			sql.setString(i++, strOrgName);
			strQuery += svc.getQuery("SEL_SALEUSERMST_WHERE_ORG_NAME") + "\n";
		}
		if( !strPosAuthFlag.equals("%") ){
			sql.setString(i++, strPosAuthFlag);
			strQuery += svc.getQuery("SEL_SALEUSERMST_WHERE_POS_AUTH_FLAG") + "\n";
		}
		if( !strEmpFlag.equals("%") ){
			sql.setString(i++, strEmpFlag);
			strQuery += svc.getQuery("SEL_SALEUSERMST_WHERE_EMP_FLAG") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_SALEUSERMST_ORDER");
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 판매사원 마스터,
	 * 저장, 수정, 삭제  처리한다.
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
			String newSaleUserId = "";
			while (mi.next()) {
				sql.close();				
				if ( mi.IS_INSERT()) {
					flag = "I";
					newSaleUserId = "";
					if( mi.getString("EMP_FLAG").equals("2")){
						sql.put(svc.getQuery("SEL_SALEUSERMST_CNT"));							
						sql.setString(1,  mi.getString("SALE_USER_ID"));								
						Map map = selectMap( sql );							
						String cnt = String2.nvl((String)map.get("CNT"));
						if( !cnt.equals("0")) {
							throw new Exception("[USER]"+ " ["+mi.getString("SALE_USER_ID")+"] 이미 등록된 사원 입니다.");
						}
						sql.close();
					}
					i = 0;
					sql.put(svc.getQuery("SEL_SALEUSERMST_NEW_SALE_USER_ID"));		
					sql.setString( ++i, mi.getString("EMP_FLAG"      ));
					sql.setString( ++i, mi.getString("SALE_USER_ID"  ));
					sql.setString( ++i, mi.getString("PUMBUN_CD"     ));
					sql.setString( ++i, mi.getString("PUMBUN_CD"     ));					
					Map map = selectMap( sql );							
					newSaleUserId = String2.nvl((String)map.get("NEW_SALE_USER_ID"));
					if( newSaleUserId.equals("")) {
						throw new Exception("[USER]"+ "판매사원 ID를 생성 할 수 없습니다.");
					}
					sql.close();					
					i = 0;
					sql.put(svc.getQuery("INS_SALEUSERMST"));
					sql.setString( ++i, mi.getString("STR_CD"        ));
					sql.setString( ++i, mi.getString("EMP_FLAG"      ));
					// 사원번호				
					sql.setString( ++i, newSaleUserId);
					//
					sql.setString( ++i, mi.getString("EMP_NAME"      ));
					sql.setString( ++i, mi.getString("PWD_NO"        ));
					sql.setString( ++i, mi.getString("ORG_CD"        ));
					sql.setString( ++i, mi.getString("PUMBUN_CD"     ));
					sql.setString( ++i, mi.getString("POS_AUTH_FLAG" ));
					sql.setString( ++i, mi.getString("TEL_NO_1"      ));
					sql.setString( ++i, mi.getString("TEL_NO_2"      ));
					sql.setString( ++i, mi.getString("TEL_NO_3"      )); 
					sql.setString( ++i, mi.getString("BIRTH_DT"      ));
					sql.setString( ++i, mi.getString("LUNAR_FLAG"    ));
					sql.setString( ++i, mi.getString("PWD_MOD_DT"    )); 
					sql.setString( ++i, mi.getString("USE_YN"        ));
					sql.setString( ++i, strID);
					sql.setString( ++i, strID);
					
				} else if (mi.IS_UPDATE()){
					flag = "U";
					i = 0;						
					sql.put(svc.getQuery("UPD_SALEUSERMST"));
					sql.setString( ++i, mi.getString("STR_CD"       ));
					sql.setString( ++i, mi.getString("EMP_NAME"     ));
					sql.setString( ++i, mi.getString("PWD_NO"       ));
					sql.setString( ++i, mi.getString("ORG_CD"       ));
					sql.setString( ++i, mi.getString("PUMBUN_CD"    ));
					sql.setString( ++i, mi.getString("POS_AUTH_FLAG"));
					sql.setString( ++i, mi.getString("TEL_NO_1"     ));
					sql.setString( ++i, mi.getString("TEL_NO_2"     ));
					sql.setString( ++i, mi.getString("TEL_NO_3"     ));
					sql.setString( ++i, mi.getString("BIRTH_DT"     ));
					sql.setString( ++i, mi.getString("LUNAR_FLAG"   ));
					sql.setString( ++i, mi.getString("USE_YN"       ));
					sql.setString( ++i, mi.getString("PWD_MOD_DT"   ));
					sql.setString( ++i, strID);
					sql.setString( ++i, mi.getString("SALE_USER_ID" ));
					newSaleUserId = mi.getString("SALE_USER_ID" );
				} else if (mi.IS_DELETE()){

					flag = "D";
					sql.put(svc.getQuery("SEL_SALEUSERMST_REG_DATE"));							
					sql.setString(1,  mi.getString("SALE_USER_ID"));								
					Map map = selectMap( sql );							
					String delYn = String2.nvl((String)map.get("DEL_YN"));
					if( !delYn.equals("Y")) {
						throw new Exception("[USER]"+mi.getString("SALE_USER_ID")+" 는 이미 적용된 사원 입니다.");
					}
					sql.close();
					i = 0;							
					sql.put(svc.getQuery("DEL_SALEUSERMST"));		
					sql.setString( ++i, mi.getString("SALE_USER_ID"       ));
					newSaleUserId = mi.getString("SALE_USER_ID" );
					

					// POS IFS 삭제는 먼저 실행
					psql.put("DPS.PR_PCSALEUSERPOS_IFS", 5);           // 판매사원
					
		            psql.setString(1, newSaleUserId);                  // 판매사원번호
		            psql.setString(2, flag);                           // 처리유형[I:INSERT, U:UPDATE, D:DELETE]
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
					String tmpMsg = "데이터 입력을 하지 못했습니다.";
					if(flag.equals("D"))
						tmpMsg = "데이터 삭제를 하지 못했습니다.";
					
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여"
							+ tmpMsg);
				}
				
				if( !flag.equals("D")){

					// POS IFS
					psql.put("DPS.PR_PCSALEUSERPOS_IFS", 5);           // 판매사원
					
		            psql.setString(1, newSaleUserId);                  // 판매사원번호
		            psql.setString(2, flag);                           // 처리유형[I:INSERT, U:UPDATE, D:DELETE]
		            psql.setString(3, strID);                          // 작업자ID
		            psql.registerOutParameter(4, DataTypes.INTEGER);   // RETURN결과
		            psql.registerOutParameter(5, DataTypes.VARCHAR);   // RETURN메시지
		            
		            prs = updateProcedure(psql);
		            		            
		            resp = prs.getInt(4);
		            
		            if( resp != 0 ){
		            	throw new Exception("[USER]" + prs.getString(5));
		            }
					
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
