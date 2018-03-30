/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.dao;

import java.net.*;
import java.util.List;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>리콜행사 대상회원 등록</p>
 * 
 * @created  on 1.0, 2011/01/24
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCae109DAO extends AbstractDAO {

    /**
     * <p>[리콜행사 대상회원]마스터 내역을 조회힌다.</p>
     * 
     */
    
    public List getMaster(ActionForm form) throws Exception {

        List		ret = null;
        SqlWrapper	sql = null;
        Service		svc = null;
        int i = 0;
     //   try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            
            //화면(JSP)에서 입력된 (조회)파라미터(Paramater)
            String strStrCd			= String2.nvl(form.getParam("strStrCd"));		//점 코드
            String strEventSDate	= String2.nvl(form.getParam("strEventSDate"));	//행사기간(From)
            String strEventEDate	= String2.nvl(form.getParam("strEventEDate"));	//행사기간(To)
            String strEventCd		= String2.nvl(form.getParam("strEventCd"));		//행사코드

            sql.put(svc.getQuery("SEL_PRMMENTY_MST"));//(1)xxx000_service.xml에 기술된 SQL파싱
            //(1)에서 파싱된 SQL에 '?'로 된 내역에 변수 매핑 (?개수와 변수 개수는 동일해야한다.)
            sql.setString(++i, strEventCd);              
            sql.setString(++i, strStrCd);              
            sql.setString(++i, strEventSDate);             
            sql.setString(++i, strEventSDate);             
            sql.setString(++i, strEventEDate);              
            sql.setString(++i, strEventEDate);              
            sql.setString(++i, strEventSDate);             
            sql.setString(++i, strEventEDate);              
            sql.setString(++i, strEventSDate);             
            sql.setString(++i, strEventEDate);              
            ret = select2List(sql); //조회 된 내역을 List형으로
/*            
        } catch (Exception e) {//오류처리
            throw e;
        }*/
        return ret;//조회 가 끝난 후  조회된 내역을 List타입으로 반환(xxxx000Action.java에서 받아서 DateSet에 담음)
    }

    /**
     * <p>[리콜행사 대상회원]디테일 내역을 조회힌다.</p>
     * 
     */

    public List getDetail(ActionForm form) throws Exception {

        List		ret = null;
        SqlWrapper	sql = null;
        Service		svc = null;
        Util util 		= new Util();
		String strQuery = "";
		int i = 0;

        //try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();

            //화면(JSP)에서 입력된 (조회)파라미터(Paramater)
            String strStrCd			= String2.nvl(form.getParam("strStrCd"));		//점 코드
            String strEventCd		= String2.nvl(form.getParam("strEventCd"));		//행사코드
            String strCardNo		= String2.nvl(form.getParam("strCardNo"));		//카드번호

            //sql.put(svc.getQuery("SEL_PRMMENTY_DTL")); 
            strQuery = svc.getQuery("SEL_PRMMENTY_DTL") + "\n";
            sql.put(strQuery);
            sql.setString(++i, strStrCd);              
            sql.setString(++i, strEventCd);
            
            ret = select2List(sql);
            //ret = util.decryptedStr(ret,0);     
            
/*        } catch (Exception e) {
            throw e;
        }*/
        return ret;
    }
 
    /**
     * <p>응모자 내역을 저장한다.</p>
     * @param form, mi, strID
     * @return ret
     * @throws Exception
     */
    public int save(ActionForm form, MultiInput mi, String userID)
    throws Exception {
        int ret = 0;
        int res = 0;
        Util util = new Util();
        SqlWrapper sql = null;
        Service svc = null;

        try {
            connect("pot");
            begin(); //DB트렌젝션 시작
            sql = new SqlWrapper();
            svc = (Service) form.getService();
            //화면(JSP)에서 입력된 (조회)파라미터(Paramater)
            String strStrCd			= String2.nvl(form.getParam("strStrCd"));		//점 코드
            String strEventCd		= String2.nvl(form.getParam("strEventCd"));		//행사코드

            while (mi.next()) {
                sql.close();
                if (mi.IS_INSERT()) { //DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
                    int i = 0;
                    sql.put(svc.getQuery("INS_PRMMENTY_DTL"));

                    sql.setString(++i, strStrCd);              
                    sql.setString(++i, strEventCd);
                    sql.setString(++i, userID);   
                    sql.setString(++i, userID);
                    sql.setString(++i, mi.getString("CARD_CUST_ID"));
                    sql.setString(++i, mi.getString("CUST_ID"));
                } else if (mi.IS_UPDATE()) { //DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
                	throw new Exception("" + "변경 작업은 할 수 없습니다.");
                	
                } else {
                    throw new Exception("" + "등록된 내역은 삭제 할 수 없습니다.");
                }

                res = update(sql);

                if (res != 1) {
                    throw new Exception("" + "데이터의 적합성 문제로 인하여"
                            + "데이터 입력을 하지 못했습니다.");
                }
                ret += res;
            }

        } catch (Exception e) {
            rollback();//오류시 모든 DB트렌젝션의 내영을 rollback(원복)한다.
            throw e;
        } finally {
            end();//정상처리시 트렉젝션을 종료한다. DB트렌젝션 사용시 반드시 기술한다.(begin(); 사용시)
        }

        return ret;
    }

	public List chkCardNo(ActionForm form) throws Exception {
		
		List ret = null;
		SqlWrapper sql = null;
		Service svc = null;
		String strQuery = "";
		Util util = new Util();
		int i = 1;
		
		sql = new SqlWrapper();
		svc = (Service) form.getService();

		connect("pot");
		
		String strCardNo = String2.nvl(form.getParam("strCardNo"));		//응모일자
		
		strQuery = svc.getQuery("SEL_CHECK") + "\n";
		
		
		sql.put(strQuery);

		sql.setString(i++, strCardNo);
		ret = select2List(sql);
		return ret;
	}
}
