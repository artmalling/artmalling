/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package tcom.dao;

import java.net.URLDecoder;
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
 * <p>조직조회</p>
 *
 * @created  on 1.0, 2010/02/09
 * @created  by 이재득(FKSS.)
 *
 * @modified on
 * @modified by
 * @caused   by
 */

public class TCom103DAO extends AbstractDAO {


	/**
	 * 그룹을 조회한다._그리드사용
	 *
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectGroupGrid(ActionForm form) throws Exception {

		List		list 	= null;
		SqlWrapper	sql 	= null;
		Service 	svc 	= null;
		try {

			sql = new SqlWrapper();
			svc = (Service) form.getService();

			sql.put(svc.getQuery("SEL_GROUP_GRID"));

			connect("pot");
			list = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}

	/**
	 * 그룹을 조회한다.
	 *
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectGroupList(ActionForm form) throws Exception {

		List		list 	= null;
		SqlWrapper	sql 	= null;
		Service 	svc 	= null;

		try {
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			sql.put(svc.getQuery("SEL_GROUP_LIST"));

			connect("pot");
			list = select2List(sql);
		} catch (Exception e) {
			throw e;
		}
		return list;
	}


	/**
	 * 사용자를 조회한다.
	 *
	 * @param form
	 * @return
	 * @throws Exception
	 */
	public List selectUserList(ActionForm form) throws Exception {

		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;
		Util      util = new Util();

		try {

			String strOrgFlag = String2.nvl(form.getParam("strOrgFlag"));	//조직코드
			String strStrCd   = String2.nvl(form.getParam("strStrCd"));		//점코드
			String strUseYn   = String2.nvl(form.getParam("strUseYn"));		//사용여부
			String strDeptCd  = String2.nvl(form.getParam("strDeptCd"));	//부문코드
			String strTeamCd  = String2.nvl(form.getParam("strTeamCd"));	//팀코드
			String strPcCd    = String2.nvl(form.getParam("strPcCd"));		//PC코드
			String strGroupCd = String2.nvl(form.getParam("strGroupCd"));	//그룹코드
			String strUserCd  = URLDecoder.decode(String2.nvl(form.getParam("strUserCd")), "UTF-8");//사용자id/명

//			System.out.println( "--------------------------strOrgFlag  ===> " + strOrgFlag );
//			System.out.println( "--------------------------strStrCd    ===> " + strStrCd   );
//			System.out.println( "--------------------------strUseYn    ===> " + strUseYn   );
//			System.out.println( "--------------------------strDeptCd   ===> " + strDeptCd  );
//			System.out.println( "--------------------------strTeamCd   ===> " + strTeamCd  );
//			System.out.println( "--------------------------strPcCd     ===> " + strPcCd    );
//			System.out.println( "--------------------------strGroupCd  ===> " + strGroupCd );
//			System.out.println( "--------------------------strUserCd   ===> " + strUserCd );

			sql = new SqlWrapper();
			svc = (Service) form.getService();

			connect("pot");

			strQuery = svc.getQuery("SEL_USER_LIST") + "\n";

			if( !strOrgFlag.equals("%")){
				sql.setString(i++, strOrgFlag);
				strQuery += svc.getQuery("SEL_USER_WHERE_ORG_FLAG") + "\n";
			}

			if( !strStrCd.equals("%") && !strStrCd.equals("")){
				sql.setString(i++, strStrCd);
				strQuery += svc.getQuery("SEL_USER_WHERE_STR_CD") + "\n";
			}

			if( !strUseYn.equals("%")){
				sql.setString(i++, strUseYn);
				strQuery += svc.getQuery("SEL_USER_WHERE_USE_YN") + "\n";
			}

			if( !strDeptCd.equals("%")){
				sql.setString(i++, strDeptCd);
				strQuery += svc.getQuery("SEL_USER_WHERE_DEPT_CD") + "\n";
			}

			if( !strTeamCd.equals("%")){
				sql.setString(i++, strTeamCd);
				strQuery += svc.getQuery("SEL_USER_WHERE_TEAM_CD") + "\n";
			}

			if( !strPcCd.equals("%")){
				sql.setString(i++, strPcCd);
				strQuery += svc.getQuery("SEL_USER_WHERE_PC_CD") + "\n";
			}

			if( !strGroupCd.equals("")){
				sql.setString(i++, strGroupCd);
				strQuery += svc.getQuery("SEL_USER_WHERE_GROUP_CD") + "\n";
			}

			if( !strUserCd.equals("%")&&!strUserCd.equals("")){
				sql.setString(i++, strUserCd);
				sql.setString(i++, strUserCd);
				strQuery += svc.getQuery("SEL_USER_WHERE_USER_CD") + "\n";
			}

			strQuery += svc.getQuery("SEL_USER_ORDER");

			sql.put(strQuery);

			list = select2List(sql);

			//util.decryptedStr(list,3);     //암호 복호화 -- MARIO OUTLET
		} catch (Exception e) {
			throw e;
		}

		return list;
	}

	/**
	 * 사용자/그룹을 저장, 수정, 삭제 처리한다.
	 *
	 * @param form
	 * @param mi
	 * @param strID
	 * @return
	 * @throws Exception
	 */
	public int save(ActionForm form, MultiInput mi[], String strID) throws Exception {

		
		Util		util 	= new Util();
		SqlWrapper	sql 	= null;
		Service		svc 	= null;

		String	errMsg 	= null;
		int 	ret 	= 0;
		int 	ret1 	= 0;
		int 	ret2 	= 0;
		int		res		= 0;
		int		i		= 0;
		int		mstCnt	= 0;

		try {
			connect("pot");
			begin();
			sql = new SqlWrapper();
			svc = (Service) form.getService();

			while (mi[0].next()) {

				sql.close();
				if (mi[0].IS_INSERT()) {
					i = 0;
					sql.put(svc.getQuery("SEL_GROUP_CNT"));

					sql.setString(++i, mi[0].getString("GROUP_CD"));

					Map map = selectMap( sql );

					String cnt = String2.nvl((String)map.get("CNT"));

					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"중복 데이터 입니다.");
					}
					sql.close();

					i = 0;
					sql = new SqlWrapper();
					svc = (Service) form.getService();
					sql.put(svc.getQuery("INS_GROUP"));

					sql.setString(++i, mi[0].getString("GROUP_CD"));
					sql.setString(++i, mi[0].getString("GROUP_NAME"));
					sql.setString(++i, strID);
					sql.setString(++i, strID);

					res = update(sql);
				}

				else if (mi[0].IS_UPDATE()) {
					i = 0;
					sql = new SqlWrapper();
					svc = (Service) form.getService();
					sql.put(svc.getQuery("UPT_GROUP"));

					sql.setString(++i, mi[0].getString("GROUP_NAME"));
					sql.setString(++i, strID);
					sql.setString(++i, mi[0].getString("GROUP_CD"));

					res = update(sql);
				}

				else if (mi[0].IS_DELETE())
				{

					/*
					i = 0;
					sql.put(svc.getQuery("SEL_USER_CNT"));

					sql.setString(++i, mi[0].getString("GROUP_CD"));

					Map map = selectMap( sql );

					String cnt = String2.nvl((String)map.get("CNT"));

					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"해당 그룹코드를 사용하는 사용자가 존재합니다.");
					}
					sql.close();
					*/

					// 그룹삭제 시 해당 그룹 사용하는 사용자 그룹 초기화
					i = 0;
					sql = new SqlWrapper();
					svc = (Service) form.getService();
					sql.put(svc.getQuery("UPT_USER_GROUP"));
					sql.setString(++i, strID);
					sql.setString(++i, mi[0].getString("GROUP_CD"));

					res = update(sql);

					sql.close();


					// 그룹삭제 시 그룹권한 삭제
					i = 0;
					sql = new SqlWrapper();
					svc = (Service) form.getService();
					sql.put(svc.getQuery("DEL_GRPPGM"));
					sql.setString(++i, mi[0].getString("GROUP_CD"));

					res = update(sql);

					sql.close();

					i = 0;
					sql = new SqlWrapper();
					svc = (Service) form.getService();
					sql.put(svc.getQuery("DEL_GROUP"));

					sql.setString(++i, mi[0].getString("GROUP_CD"));

					res = update(sql);

				}

				if (res < 1)
				{
					if(mi[0].IS_DELETE()) errMsg = "삭제" ;
					else errMsg = "입력" ;

					throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터를 " + errMsg + "하지 못했습니다.");
				}
				ret1 += res;
			}

			while (mi[1].next())
			{
				sql.close();


				// MARIO OUTLET USER INSERT FUNCTION ADD
				if ((mi[1].IS_INSERT()))
				{
					i = 0;
					sql = new SqlWrapper();
					svc = (Service) form.getService();
					sql.put(svc.getQuery("SEL_USER_CNT"));

					sql.setString(++i, mi[1].getString("USER_ID"));

					
					Map map = selectMap( sql );

					String cnt = String2.nvl((String)map.get("CNT"));

					if( !cnt.equals("0")) {
						throw new Exception("[USER]"+"중복 데이터 입니다.");
					}
					sql.close();
					
					i = 0;
					sql = new SqlWrapper();
					svc = (Service) form.getService();
					sql.put(svc.getQuery("INS_USER"));

					sql.setString(++i, mi[1].getString("USER_ID"));
					sql.setString(++i, mi[1].getString("USER_NAME"));
					sql.setString(++i, mi[1].getString("PWD_NO"));
					sql.setString(++i, mi[1].getString("GROUP_CD"));
					sql.setString(++i, mi[1].getString("STR_CD"));
					sql.setString(++i, mi[1].getString("ORG_FLAG"));

					String deptCd = mi[1].getString("DEPT_CD");
					if(("").equals(deptCd)) deptCd = "00";
					
					sql.setString(++i, deptCd);

					String teamCd = mi[1].getString("TEAM_CD");
					if(("").equals(teamCd)) teamCd = "00";

					sql.setString(++i, teamCd);

					String pcCd = mi[1].getString("PC_CD");
					if(("").equals(pcCd)) pcCd = "00";

					sql.setString(++i, pcCd);

					// 조직레벨
					String orgLevel = "";
					if 		( !("00").equals(mi[1].getString("CORNER_CD")) 	) 	orgLevel = "5";
					else if	( !("00").equals(pcCd))  							orgLevel = "4";
					else if	( !("00").equals(teamCd))				  			orgLevel = "3";
					else if	( !("00").equals(deptCd))				  			orgLevel = "2";
					else													  	orgLevel = "1";

					sql.setString(++i, orgLevel);
					sql.setString(++i, mi[1].getString("SUB_SYS"));
					sql.setString(++i, strID);

					String orgCd = "";

					orgCd = rPad(  mi[1].getString("STR_CD") + deptCd + teamCd + pcCd + mi[1].getString("CORNER_CD"), 10, "0" );

					sql.setString(++i, orgCd);
					sql.setString(++i, mi[1].getString("CORNER_CD"));
					sql.setString(++i, strID);

					if		("F".equals(mi[1].getString("USE_YN"))) sql.setString(++i, "N");
					else if ("T".equals(mi[1].getString("USE_YN")))	sql.setString(++i, "Y");
					else											sql.setString(++i, "");

					if		("F".equals(mi[1].getString("MULTI_LOGIN")))sql.setString(++i, "N");
					else if ("T".equals(mi[1].getString("MULTI_LOGIN")))sql.setString(++i, "Y");
					else												sql.setString(++i, "");

					sql.setString(++i, mi[1].getString("V_FCL_CD"));	// VOC소속
					sql.setString(++i, mi[1].getString("V_EMP_GRADE"));	// VOC등급

					sql.setString(++i, mi[1].getString("VIEW_LEVEL"));	//
					sql.setString(++i, mi[1].getString("V_DEPT_CD"));	// VOC처리부문
					sql.setString(++i, mi[1].getString("V_TEAM_CD"));	// VOC처리팀
					sql.setString(++i, mi[1].getString("V_CHAR_CD1"));	// VOC처리PC1
					sql.setString(++i, mi[1].getString("V_CHAR_CD2"));	// VOC처리PC2
					sql.setString(++i, mi[1].getString("V_CHAR_CD3"));	// VOC처리PC3
					sql.setString(++i, "POT");
					sql.setString(++i, mi[1].getString("HP1_NO"));	// 핸드폰1
					sql.setString(++i, mi[1].getString("HP2_NO"));	// 핸드폰2
					sql.setString(++i, mi[1].getString("HP3_NO"));	// 핸드폰3
					sql.setString(++i, mi[1].getString("E_MAIL"));	// 이메일
					sql.setString(++i, mi[1].getString("POSITION"));	// 직급


					res = update(sql);
					//System.out.println(sql);
				}
				else if (mi[1].IS_UPDATE())
				{
					if(!("").equals(mi[1].getString("PWD_NO")))
					{
						i = 0;
						sql = new SqlWrapper();
						svc = (Service) form.getService();
						sql.put(svc.getQuery("UPT_USER_PWD"));
						sql.setString(++i, mi[1].getString("PWD_NO"));
						sql.setString(++i, strID);
						sql.setString(++i, mi[1].getString("USER_ID"));

						res = update(sql);
						sql.close();
					}

					//조직코드 셋팅
					String orgCd = "";
					if(!("").equals(mi[1].getString("STR_CD")))
					{
						orgCd = rPad(  mi[1].getString("STR_CD") + mi[1].getString("DEPT_CD") + mi[1].getString("TEAM_CD") + mi[1].getString("PC_CD"), 10, "0" );
					}

					// 조직레벨
					String orgLevel = "";
					if		( !("").equals(mi[1].getString("PC_CD"))) 	orgLevel = "4";
					else if ( !("").equals(mi[1].getString("TEAM_CD")))	orgLevel = "3";
					else if ( !("").equals(mi[1].getString("DEPT_CD")))	orgLevel = "2";
					else if ( !("").equals(mi[1].getString("STR_CD")))	orgLevel = "1";
					else												orgLevel = "";

					i = 0;
					sql = new SqlWrapper();
					svc = (Service) form.getService();
					sql.put(svc.getQuery("UPT_USER"));

					String strGroup = "";

					sql.setString(++i, mi[1].getString("USER_NAME"));	// 사원명
					sql.setString(++i, mi[1].getString("SUB_SYS"));		// 시스템구분

					if (("999").equals(mi[1].getString("GROUP_CD")) ) strGroup = "";
					else											  strGroup = mi[1].getString("GROUP_CD");
					
					sql.setString(++i, strGroup);						// 그룹코드

					sql.setString(++i, mi[1].getString("ORG_FLAG"));	// 조직구분
					sql.setString(++i, mi[1].getString("STR_CD"));		// 점코드
					sql.setString(++i, mi[1].getString("DEPT_CD"));		// 부문코드
					sql.setString(++i, mi[1].getString("TEAM_CD"));		// 팀코드
					sql.setString(++i, mi[1].getString("PC_CD"));		// PC코드
					sql.setString(++i, mi[1].getString("V_FCL_CD"));	// VOC소속
					sql.setString(++i, mi[1].getString("V_EMP_GRADE"));	// VOC등급

					if		("F".equals(mi[1].getString("USE_YN"))) sql.setString(++i, "N");
					else if ("T".equals(mi[1].getString("USE_YN")))	sql.setString(++i, "Y");
					else											sql.setString(++i, "");

					if		("F".equals(mi[1].getString("MULTI_LOGIN")))sql.setString(++i, "N");
					else if ("T".equals(mi[1].getString("MULTI_LOGIN")))sql.setString(++i, "Y");
					else												sql.setString(++i, "");

					sql.setString(++i, mi[1].getString("VIEW_LEVEL"));	// 뷰레벨
					sql.setString(++i, orgCd);							// 조직코드
					sql.setString(++i, orgLevel);						// 조직레벨
					sql.setString(++i, mi[1].getString("V_DEPT_CD"));	// VOC처리부문
					sql.setString(++i, mi[1].getString("V_TEAM_CD"));	// VOC처리팀
					sql.setString(++i, mi[1].getString("V_CHAR_CD1"));	// VOC처리PC1
					sql.setString(++i, mi[1].getString("V_CHAR_CD2"));	// VOC처리PC2
					sql.setString(++i, mi[1].getString("V_CHAR_CD3"));	// VOC처리PC3
					sql.setString(++i, mi[1].getString("HP1_NO"));	// 핸드폰1
					sql.setString(++i, mi[1].getString("HP2_NO"));	// 핸드폰2
					sql.setString(++i, mi[1].getString("HP3_NO"));	// 핸드폰3
					sql.setString(++i, strID);
					sql.setString(++i, mi[1].getString("E_MAIL"));	// 이메일
					sql.setString(++i, mi[1].getString("POSITION"));	// 이메일
					sql.setString(++i, mi[1].getString("USER_ID"));

					res = update(sql);
					//System.out.println(sql);
				}
				else
				{
					i = 0;
					sql = new SqlWrapper();
					svc = (Service) form.getService();
					sql.put(svc.getQuery("DEL_USER"));

					sql.setString(++i, strID);
					sql.setString(++i, mi[1].getString("USER_ID"));

					res = update(sql);
				}


				if (res != 1)
				{
					if (mi[1].IS_DELETE()) 	errMsg = "삭제" ;
					else					errMsg = "입력" ;

					throw new Exception("" + "데이터의 적합성 문제로 인하여 데이터를 " + errMsg + "하지 못했습니다.");
				}
				ret2 += res;
			}

			// MST / DTL   변경 시  MST 건수 리턴
			// MST 없이 DTL 변경 시 DTL 건수 리턴
			if ( mi[0].getRowNum() > 0 ) ret = mi[0].getRowNum() ;
			else 						 ret = mi[1].getRowNum() ;

		} catch (Exception e) {
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret;
	}


	public static String rPad(String str, int size, String fStr)
	{
		byte[] b= str.getBytes();
		int len = b.length;

		int tmp = size-len;

		for (int i=0; i<tmp; i++)
		{
			str += fStr;
		}
		return str;
	}
}
