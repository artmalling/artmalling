/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.dao;

import java.util.List;
import java.util.Map;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;

import common.util.Util;

/**
 * <p>메뉴/프로그램을 조회합니다.</p>
 *
 * @created  on 1.0, 2010.12.12
 * @created  by 정지인(FUJITSU KOREA LTD.)
 *
 * @modified on
 * @modified by
 * @caused   by
 */

public class TCom102DAO extends AbstractDAO {

	/**
	 * <p>트리뷰를 위한 List를 리턴한다. </p>
	 *
	 */
	public List getTreeList(ActionForm form) throws Exception {

		List		list	= null;
		SqlWrapper	sql		= null;
		Service		svc		= null;

		String strSubSystem	= null;
		try {

			strSubSystem = String2.nvl(form.getParam("strSubSystem"));	// 시스템구분
			//System.out.println("_________________" + strSubSystem);

			sql = new SqlWrapper();
			svc = (Service) form.getService();

			sql.put(svc.getQuery("SEL_TREE_VIEW"));
			sql.setString(1, strSubSystem);

			connect("pot");
			list = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	/**
	 * <p>모든 프로그램ID조회. </p>
	 *
	 */
	public List getAllPid(ActionForm form) throws Exception {

		List		list	= null;
		SqlWrapper	sql		= null;
		Service		svc		= null;

		try {

			connect("pot");
			svc  = (Service)form.getService();
			sql  = new SqlWrapper();

			sql.put(svc.getQuery("SEL_PROGRAM_ID"));
			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	/**
	 * <p>대분류 정보를 List로 리턴한다.</p>
	 *
	 */
	public List getLMENU(ActionForm form) throws Exception {

		List		list	= null;
		SqlWrapper	sql		= null;
		Service		svc		= null;

		String strSubSystem	= null;

		try {
			strSubSystem = String2.nvl(form.getParam("strSubSystem"));	// 시스템구분

			sql = new SqlWrapper();
			svc = (Service) form.getService();

			sql.put(svc.getQuery("SEL_LMENU"));
			sql.setString(1, strSubSystem);

			connect("pot");
			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	/**
	 * <p>중분류 정보를 List로 리턴한다.</p>
	 *
	 */
	public List getMMENU(ActionForm form) throws Exception {

		List		list	= null;
		SqlWrapper	sql		= null;
		Service		svc		= null;

		String strLCode	= null;
		
		try {

			strLCode = String2.nvl(form.getParam("strLCode"));	// 대분류코드

			svc  = (Service)form.getService();
			sql  = new SqlWrapper();

			sql.put(svc.getQuery("SEL_MMENU"));
			sql.setString(1, strLCode);


			connect("pot");
			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	/**
	 * <p>소분류 정보를 List로 리턴한다.</p>
	 *
	 */
	public List getSMENU(ActionForm form) throws Exception {

		List		list = null;
		SqlWrapper	sql = null;
		Service		svc = null;

		String strLCode	= null;
		String strMCode	= null;

		try {

			strLCode = String2.nvl(form.getParam("strLCode"));	// 대분류코드
			strMCode = String2.nvl(form.getParam("strMCode"));	// 중분류코드
			//System.out.println("_________________" + strMCode);

			svc  = (Service)form.getService();
			sql  = new SqlWrapper();

			sql.put(svc.getQuery("SEL_SMENU"));
			sql.setString(1, strLCode);
			sql.setString(2, strMCode);

			connect("pot");
			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	/**
	 * <p>프로그램 정보를 List로 리턴한다. </p>
	 *
	 */
	public List getPROGRAM(ActionForm form) throws Exception {

		List		list = null;
		SqlWrapper	sql = null;
		Service		svc = null;

		String strLCode	= null;
		String strMCode	= null;
		String strSCode	= null;

		try {

			strLCode = String2.nvl(form.getParam("strLCode"));	// 대분류코드
			strMCode = String2.nvl(form.getParam("strMCode"));	// 중분류코드
			strSCode = String2.nvl(form.getParam("strSCode"));	// 소분류코드

			svc  = (Service)form.getService();
			sql  = new SqlWrapper();

			if(!"".equals(strSCode))
			{
				// 소분류까지 조회
				sql.put(svc.getQuery("SEL_PROGRAM"));
				sql.setString(1, strSCode);
			}
			else if(!"".equals(strMCode))
			{
				sql.put(svc.getQuery("SEL_PROGRAM_LM"));
				sql.setString(1, strLCode);
				sql.setString(2, strMCode);
			}
			else
			{
				sql.put(svc.getQuery("SEL_PROGRAM_L"));
				sql.setString(1, strLCode);
			}

			connect("pot");
			list = select2List(sql);

		} catch (Exception e) {
			throw e;
		}
		return list;
	}


	public int saveAll(ActionForm form, MultiInput mi[], String strID) throws Exception {

		int 		ret 	= 0;
		int 		res 	= 0;
		Util 		util 	= new Util();
		SqlWrapper 	sql 	= null;
		Service 	svc 	= null;
		String    	procGbn	= null;
		String 		errMsg 	= null;
		int i;

		try{

			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			// ----- 대분류 ------------------------------------------------------------------------------ //
			while (mi[0].next())
			{
				sql.close();

				if ( ("").equals(mi[0].getString("SUB_SYSTEM")) )
					throw new Exception("시스템구분을 알 수 없습니다.");

				res = 0;

				if (mi[0].IS_INSERT())
				{
					i = 0;
					sql.put(svc.getQuery("SEL_LMENU_CNT"));
					sql.setString(++i, mi[0].getString("LCODE"));

					Map map = selectMap( sql );

					String cnt = String2.nvl((String)map.get("CNT"));

					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"대분류 중복 데이터 입니다.[" + mi[0].getString("LCODE") + "]");
					}
					sql.close();

					i = 0;
					procGbn = "ins";
					sql.put(svc.getQuery("INS_LMENU"));
					sql.setString(++i, mi[0].getString("LCODE"));
					sql.setString(++i, mi[0].getString("LNAME"));
					sql.setString(++i, mi[0].getString("SUB_SYSTEM"));
					sql.setString(++i, mi[0].getString("SEQ"));
					sql.setString(++i, strID);
				}
				else if (mi[0].IS_UPDATE())
				{
					i = 0;
					procGbn = "upt";
					sql.put(svc.getQuery("UPD_LMENU"));
					sql.setString(++i, mi[0].getString("LNAME"));
					sql.setString(++i, mi[0].getString("SEQ"));
					sql.setString(++i, strID);
					sql.setString(++i, mi[0].getString("LCODE"));
					sql.setString(++i, mi[0].getString("SUB_SYSTEM"));
				}
				else
				{
					i = 0;
					procGbn = "del";
					sql.put(svc.getQuery("DEL_LMENU"));
					sql.setString(++i, mi[0].getString("LCODE"));
					sql.setString(++i, mi[0].getString("SUB_SYSTEM"));
				}

				res = update(sql);

				if (res !=1)
				{
					if (procGbn == "ins") errMsg = "저장하지 못했습니다. [" + mi[0].getString("LNAME")+"]" ;
					if (procGbn == "upt") errMsg = "수정하지 못했습니다. [" + mi[0].getString("LNAME")+"]" ;
					if (procGbn == "del") errMsg = "삭제하지 못했습니다. [" + mi[0].getString("LNAME")+"]" ;
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여  데이터를 "+ errMsg);

				}
				ret += res;
			}

			// ----- 중분류 ------------------------------------------------------------------------------ //
			while (mi[1].next())
			{
				sql.close();
				res = 0;

				if ( ("").equals(mi[1].getString("LCODE")) )
					throw new Exception("대분류코드를 알 수 없습니다.");


				if (mi[1].IS_INSERT())
				{
					i = 0;
					sql.put(svc.getQuery("SEL_MMENU_CNT"));
					sql.setString(++i, mi[1].getString("LCODE"));
					sql.setString(++i, mi[1].getString("MCODE"));

					Map map = selectMap( sql );

					String cnt = String2.nvl((String)map.get("CNT"));

					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"중분류 중복 데이터 입니다.[" + mi[1].getString("MCODE") + "]");
					}

					sql.close();

					i = 0;
					procGbn = "ins";
					sql.put(svc.getQuery("INS_MMENU"));
					sql.setString(++i, mi[1].getString("LCODE"));
					sql.setString(++i, mi[1].getString("MCODE"));
					sql.setString(++i, mi[1].getString("MNAME"));
					sql.setString(++i, "".equals(mi[1].getString("IS_USE"))?"Y":mi[1].getString("IS_USE"));
					sql.setString(++i, mi[1].getString("SEQ"));
					sql.setString(++i, strID);
				}
				else if (mi[1].IS_UPDATE())
				{
					i = 0;
					procGbn = "upt";
					sql.put(svc.getQuery("UPD_MMENU"));
					sql.setString(++i, mi[1].getString("MNAME"));
					sql.setString(++i, mi[1].getString("SEQ"));
					sql.setString(++i, strID);
					sql.setString(++i, mi[1].getString("LCODE"));
					sql.setString(++i, mi[1].getString("MCODE"));
				}
				else
				{
					i = 0;
					procGbn = "del";
					sql.put(svc.getQuery("DEL_MMENU"));
					sql.setString(++i, mi[1].getString("LCODE"));
					sql.setString(++i, mi[1].getString("MCODE"));
				}

				res = update(sql);

				if (res !=1)
				{
					if (procGbn == "ins") errMsg = "저장하지 못했습니다. [" + mi[1].getString("MNAME")+"]" ;
					if (procGbn == "upt") errMsg = "수정하지 못했습니다. [" + mi[1].getString("MNAME")+"]" ;
					if (procGbn == "del") errMsg = "삭제하지 못했습니다. [" + mi[1].getString("MNAME")+"]" ;
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여  데이터를 "+ errMsg);
				}
				ret += res;

			}

			// ----- 소분류 ------------------------------------------------------------------------------ //
			while (mi[2].next())
			{
				sql.close();
				res = 0;

				if ( ("").equals(mi[2].getString("LCODE")) || ("").equals(mi[2].getString("MCODE")))
					throw new Exception("대분류코드/중분류코드를 알 수 없습니다.");

				if (mi[2].IS_INSERT())
				{
					i = 0;
					sql.put(svc.getQuery("SEL_SMENU_CNT"));
					//sql.setString(++i, mi[2].getString("LCODE"));
					//sql.setString(++i, mi[2].getString("MCODE"));
					sql.setString(++i, mi[2].getString("SCODE"));

					Map map = selectMap( sql );

					String cnt = String2.nvl((String)map.get("CNT"));

					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"소분류 중복 데이터 입니다. [" + mi[2].getString("SCODE") + "]");
					}

					sql.close();

					i = 0;
					procGbn = "ins";
					sql.put(svc.getQuery("INS_SMENU"));
					sql.setString(++i, mi[2].getString("SCODE"));
					sql.setString(++i, mi[2].getString("MCODE"));
					sql.setString(++i, mi[2].getString("LCODE"));
					sql.setString(++i, mi[2].getString("SNAME"));
					sql.setString(++i, "".equals(mi[2].getString("IS_USE"))?"Y":mi[2].getString("IS_USE"));
					sql.setString(++i, mi[2].getString("SEQ"));
					sql.setString(++i, strID);
				}
				else if (mi[2].IS_UPDATE())
				{
					i = 0;
					procGbn = "upt";
					sql.put(svc.getQuery("UPD_SMENU"));
					sql.setString(++i, mi[2].getString("SNAME"));
					sql.setString(++i, mi[2].getString("SEQ"));
					sql.setString(++i, strID);
					sql.setString(++i, mi[2].getString("SCODE"));
					sql.setString(++i, mi[2].getString("MCODE"));
					sql.setString(++i, mi[2].getString("LCODE"));
				}
				else
				{
					i = 0;
					procGbn = "del";
					sql.put(svc.getQuery("DEL_SMENU"));
					sql.setString(++i, mi[2].getString("SCODE"));
					sql.setString(++i, mi[2].getString("MCODE"));
					sql.setString(++i, mi[2].getString("LCODE"));
				}

				res = update(sql);

				if (res !=1)
				{
					if (procGbn == "ins") errMsg = "저장하지 못했습니다. [" + mi[2].getString("SNAME")+"]" ;
					if (procGbn == "upt") errMsg = "수정하지 못했습니다. [" + mi[2].getString("SNAME")+"]" ;
					if (procGbn == "del") errMsg = "삭제하지 못했습니다. [" + mi[2].getString("SNAME")+"]" ;
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여  데이터를 "+ errMsg);
				}
				ret += res;
			}

			// ----- 프로그램 ---------------------------------------------------------------------------- //
			while (mi[3].next())
			{
				sql.close();
				res = 0;

				if ( ("").equals(mi[3].getString("SCODE")))
					throw new Exception("소분류코드를 알 수 없습니다.");


				if (mi[3].IS_INSERT())
				{
					i = 0;
					sql.put(svc.getQuery("SEL_PROGRAM_CNT"));
					sql.setString(++i, mi[3].getString("SCODE"));

					Map map = selectMap( sql );

					String cnt = String2.nvl((String)map.get("CNT"));

					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"프로그램ID 중복 데이터 입니다.[" + mi[3].getString("SCODE") + "]");
					}

					sql.close();

					i = 0;
					procGbn = "ins";

					sql.put(svc.getQuery("INS_PROGRAM"));
					sql.setString(++i, mi[3].getString("SCODE"));
					sql.setString(++i, mi[3].getString("SCODE"));
					sql.setString(++i, mi[3].getString("PNAME1"));
					sql.setString(++i, mi[3].getString("PNAME2"));
					sql.setString(++i, mi[3].getString("URL"));
					sql.setString(++i, "T".equals(mi[3].getString("IS_RET"))?"Y":"N");
					sql.setString(++i, "T".equals(mi[3].getString("IS_NEW"))?"Y":"N");
					sql.setString(++i, "T".equals(mi[3].getString("IS_DEL"))?"Y":"N");
					sql.setString(++i, "T".equals(mi[3].getString("IS_SAVE"))?"Y":"N");
					sql.setString(++i, "T".equals(mi[3].getString("IS_EXCEL"))?"Y":"N");
					sql.setString(++i, "T".equals(mi[3].getString("IS_PRINT"))?"Y":"N");
					sql.setString(++i, "T".equals(mi[3].getString("IS_CONFIRM"))?"Y":"N");
					sql.setString(++i, "T".equals(mi[3].getString("USE_YN"))?"Y":"N");
					sql.setString(++i, strID);
				}
				else if (mi[3].IS_UPDATE())
				{
					// 사용자권한 update
//					sql.close();
//					i = 0;
//					sql.put(svc.getQuery("UPD_USRPGM"));
//					sql.setString(++i, "T".equals(mi[3].getString("IS_RET"))?"Y":"N");
//					sql.setString(++i, "T".equals(mi[3].getString("IS_NEW"))?"Y":"N");
//					sql.setString(++i, "T".equals(mi[3].getString("IS_DEL"))?"Y":"N");
//					sql.setString(++i, "T".equals(mi[3].getString("IS_SAVE"))?"Y":"N");
//					sql.setString(++i, "T".equals(mi[3].getString("IS_EXCEL"))?"Y":"N");
//					sql.setString(++i, "T".equals(mi[3].getString("IS_PRINT"))?"Y":"N");
//					sql.setString(++i, "T".equals(mi[3].getString("IS_CONFIRM"))?"Y":"N");
//					sql.setString(++i, strID);
//					sql.setString(++i, mi[3].getString("PID"));
//					update(sql);

					// 그룹권한 update
//					sql.close();
//					i = 0;
//					sql.put(svc.getQuery("UPD_GRPPGM"));
//					sql.setString(++i, "T".equals(mi[3].getString("IS_RET"))?"Y":"N");
//					sql.setString(++i, "T".equals(mi[3].getString("IS_NEW"))?"Y":"N");
//					sql.setString(++i, "T".equals(mi[3].getString("IS_DEL"))?"Y":"N");
//					sql.setString(++i, "T".equals(mi[3].getString("IS_SAVE"))?"Y":"N");
//					sql.setString(++i, "T".equals(mi[3].getString("IS_EXCEL"))?"Y":"N");
//					sql.setString(++i, "T".equals(mi[3].getString("IS_PRINT"))?"Y":"N");
//					sql.setString(++i, "T".equals(mi[3].getString("IS_CONFIRM"))?"Y":"N");
//					sql.setString(++i, strID);
//					sql.setString(++i, mi[3].getString("PID"));
//					update(sql);

					// 프로그램 권한
					sql.close();
					i = 0;
					procGbn = "upt";

					sql.put(svc.getQuery("UPD_PROGRAM"));
					sql.setString(++i, mi[3].getString("PNAME1"));
					sql.setString(++i, mi[3].getString("PNAME2"));
					sql.setString(++i, mi[3].getString("URL"));
					sql.setString(++i, "T".equals(mi[3].getString("IS_RET"))?"Y":"N");
					sql.setString(++i, "T".equals(mi[3].getString("IS_NEW"))?"Y":"N");
					sql.setString(++i, "T".equals(mi[3].getString("IS_DEL"))?"Y":"N");
					sql.setString(++i, "T".equals(mi[3].getString("IS_SAVE"))?"Y":"N");
					sql.setString(++i, "T".equals(mi[3].getString("IS_EXCEL"))?"Y":"N");
					sql.setString(++i, "T".equals(mi[3].getString("IS_PRINT"))?"Y":"N");
					sql.setString(++i, "T".equals(mi[3].getString("IS_CONFIRM"))?"Y":"N");
					sql.setString(++i, "T".equals(mi[3].getString("USE_YN"))?"Y":"N");
					sql.setString(++i, strID);
					sql.setString(++i, mi[3].getString("PID"));
				}
				else
				{
					// 사용자 권한 삭제
					sql.close();
					i = 0;
					sql.put(svc.getQuery("DEL_USRPGM"));
					sql.setString(++i, mi[3].getString("PID"));
					update(sql);

					// 그룹별 권한 삭제
					sql.close();
					i = 0;
					sql.put(svc.getQuery("DEL_GRPPGM"));
					sql.setString(++i, mi[3].getString("PID"));
					update(sql);
					
					//프로그램 권한 삭제
					sql.close();
					i = 0;
					procGbn = "del";
					sql.put(svc.getQuery("DEL_PROGRAM"));
					sql.setString(++i, mi[3].getString("PID"));
				}

				res = update(sql);

				if (res !=1)
				{
					if (procGbn == "ins") errMsg = "저장하지 못했습니다. [" + mi[3].getString("PNAME1")+"]" ;
					if (procGbn == "upt") errMsg = "수정하지 못했습니다. [" + mi[3].getString("PNAME1")+"]" ;
					if (procGbn == "del") errMsg = "삭제하지 못했습니다. [" + mi[3].getString("PNAME1")+"]" ;
					throw new Exception("[USER]" + "데이터의 적합성 문제로 인하여  데이터를 "+ errMsg);
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
