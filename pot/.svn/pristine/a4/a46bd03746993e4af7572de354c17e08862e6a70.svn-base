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

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>실시간로그인현황</p>
 *  
 * @created  on 1.0, 2010/06/23
 * @created  by HSEON(FKSS.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class TCom005DAO extends AbstractDAO { 

	/**
	 * <p> 받는사람 추가 POP TCom0051 : 조회  </p> 
	 */ 
	public List selectUserList(ActionForm form) throws Exception {
		List list = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		int i = 1;	 

        try {
			String strGbn 	  = String2.nvl(form.getParam("strGbn"));		//SMS구분
			String strOrgFlag = String2.nvl(form.getParam("strOrgFlag"));	//조직코드
			String strStrCd   = String2.nvl(form.getParam("strStrCd"));		//점코드 	 
			String strDeptCd  = String2.nvl(form.getParam("strDeptCd"));	//부문코드
			String strTeamCd  = String2.nvl(form.getParam("strTeamCd"));	//팀코드
			String strPcCd    = String2.nvl(form.getParam("strPcCd"));		//PC코드  
			String strUserCd  = URLDecoder.decode(String2.nvl(form.getParam("strUserCd")), "UTF-8");//사용자id/명   
			/* 
			System.out.println( "--------------------------strOrgFlag  ===> " + strOrgFlag );
			System.out.println( "--------------------------strStrCd    ===> " + strStrCd   ); 
			System.out.println( "--------------------------strDeptCd   ===> " + strDeptCd  );
			System.out.println( "--------------------------strTeamCd   ===> " + strTeamCd  );
			System.out.println( "--------------------------strPcCd     ===> " + strPcCd    ); 
			System.out.println( "--------------------------strUserCd   ===> " + strUserCd  ); 
			*/
			sql = new SqlWrapper();
			svc = (Service) form.getService();
	
			connect("pot");
			
			if("0".equals(strGbn))
			{
				// 임직원 
				strQuery = svc.getQuery("SEL_USER_LIST") + "\n";

				if( !strOrgFlag.equals("%")){ 
					sql.setString(i++, strOrgFlag);
					strQuery += svc.getQuery("SEL_USER_WHERE_ORG_FLAG") + "\n";
				}
				
				if( !strStrCd.equals("%") && !strStrCd.equals("")){ 
					sql.setString(i++, strStrCd);
					strQuery += svc.getQuery("SEL_USER_WHERE_STR_CD") + "\n";
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
				
				if( !strUserCd.equals("%")&&!strUserCd.equals("")){ 
					//sql.setString(i++, strUserCd);
					sql.setString(i++, strUserCd);
					strQuery += svc.getQuery("SEL_USER_WHERE_USER_CD") + "\n";
				} 
				strQuery += svc.getQuery("SEL_USER_ORDER"); 
			}
			else
			{
				// 협력사 
				String orgCd = "";
				i = 1;
				
				if( !strStrCd.equals("%") && !strStrCd.equals("")) 	orgCd += strStrCd; 
				if( !strDeptCd.equals("%")) 						orgCd += strDeptCd; 
				if( !strTeamCd.equals("%")) 						orgCd += strTeamCd; 
				if( !strPcCd.equals("%")) 							orgCd += strPcCd;  
				
				strQuery = svc.getQuery("SEL_USER_VEN_LIST") + "\n";
				
				if     ( !strOrgFlag.equals("%") && orgCd.equals(""))
				{
					// 조직구분존재 & 조직코드 없음
					strQuery += svc.getQuery("SEL_USER_VEN_WHERE1_1") + "\n";
					sql.setString(i++, strOrgFlag);  
				}
				else if ( strOrgFlag.equals("%") && !orgCd.equals(""))
				{
					// 조직구분없고 & 조직코드 존재
					strQuery += svc.getQuery("SEL_USER_VEN_WHERE1_2") + "\n";
					sql.setString(i++, orgCd); 
					sql.setString(i++, orgCd); 
				}  
				else if ( !strOrgFlag.equals("%") && !orgCd.equals(""))
				{ 
					// 조직구분 & 코드 존재
					strQuery += svc.getQuery("SEL_USER_VEN_WHERE1_3") + "\n";
					sql.setString(i++, strOrgFlag);
					sql.setString(i++, orgCd); 
				}  

				if( !strUserCd.equals("%")&&!strUserCd.equals("")){ 
					sql.setString(i++, strUserCd);
					strQuery += svc.getQuery("SEL_USER_VEN_WHERE2") + "\n";
				} 
				strQuery += svc.getQuery("SEL_USER_VEN_ORDER");
			}
			
			sql.put(strQuery);  
			list = select2List(sql);
			
			
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
	public int sendSMS(ActionForm form, MultiInput mi[], String strID)
			throws Exception {

		int res 	= 0;
		Util util 	= new Util();
		SqlWrapper sql = null;
		Service svc = null;
		int mstCnt 	= 0;	
		
		String errMsg 	= null;
		int 	ret 	= 0;
		int 	ret1 	= 0;
		int 	ret2 	= 0;	

		int i;
		String mstYn = "N";

		try {
			
			connect("pot");
			begin();
			
			sql = new SqlWrapper();
			svc = (Service) form.getService();
			
			String strSendId 		= null;
			String strSendTel 		= null; 
			String strSendContent 	= null; 
			String strFlag 			= null;
			String strBroadcastYn 	= null; 
			String strSendDate 		= null;
			
			while( mi[0].next())
			{

				
				strSendId 		= mi[0].getString("USER_ID");	// 보내는 사람ID
				strSendTel   	= mi[0].getString("HP_NO");		// 보내는 사람 전화번호 	 
				strSendContent  = mi[0].getString("CONTENT");
				strFlag  		= mi[0].getString("FLAG");		// MAIL FLAG : SMS / LMS
				strBroadcastYn  = mi[0].getString("BROADCAST");	// 동보발송여부
				strSendDate  	= mi[0].getString("SEND_DATE");	// 예약일시
				
				/*
				System.out.println( "--------------------------strSendId    	===> " + strSendId   ); 
				System.out.println( "--------------------------strSendTel   	===> " + strSendTel  );
				System.out.println( "--------------------------strSendContent   ===> " + strSendContent  );
				System.out.println( "--------------------------strFlag     		===> " + strFlag    ); 
				System.out.println( "--------------------------strBroadcastYn   ===> " + strBroadcastYn  ); 
				System.out.println( "--------------------------strSendDate  	===> " + strSendDate  ); 
				*/ 
			}
			
			// -- seq조회 -------------------------------------------------------------------------
			sql.close(); 
			 
			if("SMS".equals(strFlag)) 
				sql.put(svc.getQuery("SEL_SMS_SEQ"));	
			else
				sql.put(svc.getQuery("SEL_LMS_SEQ"));	

			Map map = selectMap( sql );	
			String seq = String2.nvl((String)map.get("SEQ")); 

			while (mi[1].next()) 
			{ 
 
				ret1++;
				// -- SMS저장 ------------------------------------------------------------------------- 

				if("SMS".equals(strFlag)) 
				{
					if( "N".equals(mstYn) )
					{
						sql.close();
						i = 0;
						sql.put(svc.getQuery("INS_SMS_MASTER"));
						
						sql.setString(++i, seq); 
						sql.setString(++i, strSendDate); 
						sql.setString(++i, strSendDate); 
						sql.setString(++i, strSendContent);  
						sql.setString(++i, strSendTel);  
						sql.setString(++i, strBroadcastYn);  
						sql.setString(++i, strBroadcastYn);  
						sql.setString(++i, (mi[1].getString("HP_NO")).replaceAll("-", ""));   
						
						res = update(sql);  

						if( res < 1) {
							throw new Exception("[USER]"+"메세지 전송시 문제가 발생하였습니다.");
						}
					}
					
					//동봉인 경우
					if(("Y").equals(strBroadcastYn))
					{ 
						sql.close();
						i = 0;
						sql.put(svc.getQuery("INS_SMS_DETAIL"));
						
						sql.setString(++i, seq); 
						sql.setString(++i, seq); 
						sql.setString(++i, (mi[1].getString("HP_NO")).replaceAll("-", ""));  
						
						res = update(sql);  

						if( res < 1) {
							throw new Exception("[USER]"+"메세지 전송시 문제가 발생하였습니다.");
						}
						
					}
					mstYn = "Y";
				} 

				// -- LMS저장 ------------------------------------------------------------------------- 
				else
				{
					if( "N".equals(mstYn) )
					{
						sql.close();
						i = 0;
						sql.put(svc.getQuery("INS_LMS_MASTER"));
						
						sql.setString(++i, seq); 
						sql.setString(++i, strSendDate); 
						sql.setString(++i, strSendDate); 
						sql.setString(++i, strSendContent);  
						sql.setString(++i, strSendContent); 
						sql.setString(++i, strSendTel);  
						sql.setString(++i, strBroadcastYn);  
						sql.setString(++i, strBroadcastYn);  
						sql.setString(++i, (mi[1].getString("HP_NO")).replaceAll("-", ""));   
						
						res = update(sql);  

						if( res < 1) {
							throw new Exception("[USER]"+"메세지 전송시 문제가 발생하였습니다.");
						}
					}

					//동봉인 경우
					if(("Y").equals(strBroadcastYn))
					{ 
						sql.close();
						i = 0;
						sql.put(svc.getQuery("INS_LMS_DETAIL"));
						
						sql.setString(++i, seq); 
						sql.setString(++i, seq); 
						sql.setString(++i, (mi[1].getString("HP_NO")).replaceAll("-", ""));  
						
						res = update(sql);  

						if( res < 1) {
							throw new Exception("[USER]"+"메세지 전송시 문제가 발생하였습니다.");
						} 
					} 
					mstYn = "Y"; 
				}  
			}
			
		} catch (Exception e) { 
			rollback();
			throw e;
		} finally {
			end();
		}
		return ret1;
	}
}
