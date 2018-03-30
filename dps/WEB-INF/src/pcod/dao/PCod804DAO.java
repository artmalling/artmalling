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
 * <p>임대협력사명판관리</p>
 * 
 * @created  on 1.0, 2010/04/25
 * @created  by 정진영(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class PCod804DAO extends AbstractDAO {

	/**
	 * 임대협력사명판 마스터 을 조회한다.
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
		
		String strCompNo = String2.nvl(form.getParam("strCompNo"));
		String strCompName = URLDecoder.decode( String2.nvl(form.getParam("strCompName")), "UTF-8");
		String strUseYn = String2.nvl(form.getParam("strUseYn"));
		String strVenCd = String2.nvl(form.getParam("strVenCd"));

		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");

		strQuery = svc.getQuery("SEL_POSSTMPMST") + "\n";
		
		if( !strCompNo.equals("") ){
			sql.setString(i++, strCompNo);
			strQuery += svc.getQuery("SEL_POSSTMPMST_WHERE_COMP_NO") + "\n";
		}
		if( !strCompName.equals("") ){
			sql.setString(i++, strCompName);
			strQuery += svc.getQuery("SEL_POSSTMPMST_WHERE_COMP_NAME") + "\n";
		}
		if( !strVenCd.equals("") ){
			sql.setString(i++, strVenCd);
			strQuery += svc.getQuery("SEL_POSSTMPMST_WHERE_VEN_CD") + "\n";
		}
		if( !strUseYn.equals("%") ){
			sql.setString(i++, strUseYn);
			strQuery += svc.getQuery("SEL_POSSTMPMST_WHERE_USE_YN") + "\n";
		}
		
		strQuery += svc.getQuery("SEL_POSSTMPMST_ORDER") + "\n";
		
		sql.put(strQuery);

		ret = select2List(sql);

		return ret;
	}

	/**
	 * 임대협력사명판 마스터,
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
		
		int i;
		try {
			connect("pot");
			begin();
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			String flag = "";
			while (mi.next()) {
				sql.close();				
				if ( mi.IS_INSERT()) {
					flag = "I";
					sql.put(svc.getQuery("SEL_POSSTMPMST_VEN_CD_CNT"));							
					sql.setString(1,  mi.getString("VEN_CD"));								
					Map map = selectMap( sql );							
					String posCnt = String2.nvl((String)map.get("CNT"));
					if( !posCnt.equals("0")) {
						throw new Exception("[USER]"+"이미 등록된 협력사 입니다.");
					}
					sql.close();
					i = 0;							
					sql.put(svc.getQuery("INS_POSSTMPMST"));
					sql.setString( ++i, mi.getString("VEN_CD"       ));
					sql.setString( ++i, mi.getString("REP_NAME"     ));
					sql.setString( ++i, mi.getString("COMP_NO"      ));
					sql.setString( ++i, mi.getString("COMP_NAME"    ));
					sql.setString( ++i, mi.getString("ADDR"         ));
					sql.setString( ++i, mi.getString("PHONE1_NO"    ));
					sql.setString( ++i, mi.getString("PHONE2_NO"    ));
					sql.setString( ++i, mi.getString("PHONE3_NO"    ));
					sql.setString( ++i, mi.getString("USE_YN"       ));
					sql.setString(++i, strID);
					sql.setString(++i, strID);
					
				} else if (mi.IS_UPDATE()){

					flag = "U";
					i = 0;							
					sql.put(svc.getQuery("UPD_POSSTMPMST"));
					sql.setString( ++i, mi.getString("REP_NAME"     ));
					sql.setString( ++i, mi.getString("COMP_NO"      ));
					sql.setString( ++i, mi.getString("COMP_NAME"    ));
					sql.setString( ++i, mi.getString("ADDR"         ));
					sql.setString( ++i, mi.getString("PHONE1_NO"    ));
					sql.setString( ++i, mi.getString("PHONE2_NO"    ));
					sql.setString( ++i, mi.getString("PHONE3_NO"    ));
					sql.setString( ++i, mi.getString("USE_YN"       ));
					sql.setString(++i, strID);
					sql.setString( ++i, mi.getString("VEN_CD"       ));
				} else if (mi.IS_DELETE()){

					flag = "D";
					sql.put(svc.getQuery("SEL_POSSTMPMST_REG_DATE"));							
					sql.setString(1,  mi.getString("VEN_CD"));								
					Map map = selectMap( sql );							
					String posCnt = String2.nvl((String)map.get("EDIT_YN"));
					if( !posCnt.equals("Y")) {
						throw new Exception("[USER]"+mi.getString("VEN_CD")+" 는 이미 적용된 협력사 입니다.");
					}
					sql.close();
					i = 0;							
					sql.put(svc.getQuery("DEL_POSSTMPMST"));
					sql.setString( ++i, mi.getString("VEN_CD"       ));
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

	public int sendstmpemg(ActionForm form, String userId)
			throws Exception {

		SqlWrapper sql        = null;
		Service svc           = null;
		ProcedureWrapper psql = null;	//프로시저 사용위함
		int resp    		  = 0;      //프로시저 리턴값
		
		try {
	
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			psql = new ProcedureWrapper();
			ProcedureResultSet prs = null;
			
			int i = 1;            
			psql.put("DPS.PR_PCSTMPPOS_EMG_IFS", 5);
			     
			psql.setString(i++, form.getParam("strProcDt")); 	// 처리일자
            psql.setString(i++, userId);		                // 사용자 
            psql.setString(i++, form.getParam("strVenCd"));  // 거래선           
            
            psql.registerOutParameter(i++, DataTypes.INTEGER);//4
            psql.registerOutParameter(i++, DataTypes.VARCHAR);//5
            //psql.registerOutParameter(i++, DataTypes.VARCHAR);//6

            prs = updateProcedure(psql);
            
            resp += prs.getInt(4);    

            if (resp < 0) {
                throw new Exception("[USER]"+ prs.getString(5));
            }
		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return resp;
	}    
	
}
