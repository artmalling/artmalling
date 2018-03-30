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

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
/**
 * <p>경품행사 응모자 등록</p>
 * 
 * @created  on 1.0, 2011/01/24
 * @created  by 김유완(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * @caused   by 
 */

public class MCae202DAO extends AbstractDAO {

    /**
     * <p>[경품행사응모자]마스터 내역을 조회힌다.</p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public List getMaster(ActionForm form) throws Exception {

        List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;

        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0;
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
            list = select2List(sql); //조회 된 내역을 List형으로
            
        } catch (Exception e) {//오류처리
            throw e;
        }
        return list;//조회 가 끝난 후  조회된 내역을 List타입으로 반환(xxxx000Action.java에서 받아서 DateSet에 담음)
    }

    /**
     * <p>[경품행사응모자]마스터 내역을 조회힌다.</p>
     * 
     */
    @SuppressWarnings("rawtypes")
    public List getDetail(ActionForm form) throws Exception {

        List       list = null;
        SqlWrapper  sql = null;
        Service     svc = null;

        try {
            connect("pot");
            svc  = (Service)form.getService();
            sql  = new SqlWrapper();
            int i = 0;

            //화면(JSP)에서 입력된 (조회)파라미터(Paramater)
            String strStrCd			= String2.nvl(form.getParam("strStrCd"));		//점 코드
            String strEventCd		= String2.nvl(form.getParam("strEventCd"));		//행사코드

            sql.put(svc.getQuery("SEL_PRMMENTY_DTL")); //(1)xxx000_service.xml에 기술된 SQL파싱 
            //(1)에서 파싱된 SQL에 '?'로 된 내역에 변수 매핑 (?개수와 변수 개수는 동일해야한다.)
            sql.setString(++i, strStrCd);              
            sql.setString(++i, strEventCd);              
            list = select2List(sql);//조회 된 내역을 List형으로
        } catch (Exception e) {//오류처리
            throw e;
        }
        return list;//조회 가 끝난 후  조회된 내역을 List타입으로 반환(xxxx000Action.java에서 받아서 DateSet에 담음)
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
            String strEntryDt		= String2.nvl(form.getParam("strEntryDt"));		//응모일자

            while (mi.next()) {
                sql.close();
                if (mi.IS_INSERT()) { //DateSet의 현제 Row의 상태를 체크한다 IS_INSERT, IS_UPDATE, IS_DELETE
                    int i = 0;
                    sql.put(svc.getQuery("INS_PRMMENTY_DTL"));
                    //JSP에서 입력된 파라미터
                    sql.setString(++i, strStrCd);              
                    sql.setString(++i, strEventCd);   
                    sql.setString(++i, strEntryDt);   
                    sql.setString(++i, strStrCd);              
                    sql.setString(++i, strEventCd);   
                    sql.setString(++i, strEntryDt);   
                    //JSP에서 등록한 DataSet의 내역
                    sql.setString(++i, mi.getString("ENTY_NAME"));
                    //암호화(주민번호 암호화 사용시 사용)
                    sql.setString(++i, mi.getString("SS_NO"));
                    sql.setString(++i, mi.getString("PHONE1_NO"));
                    sql.setString(++i, mi.getString("PHONE3_NO"));
                    sql.setString(++i, mi.getString("PHONE2_NO"));
                    sql.setString(++i, mi.getString("HP1_NO"));
                    sql.setString(++i, mi.getString("HP2_NO"));
                    sql.setString(++i, mi.getString("HP3_NO"));
                    sql.setString(++i, mi.getString("ADDR"));
                    sql.setString(++i, mi.getString("EMAIL"));
//                    sql.setString(++i, mi.getString("SS_NO"));
//                    sql.setString(++i, mi.getString("PHONE1_NO"));
//                    sql.setString(++i, mi.getString("PHONE3_NO"));
//                    sql.setString(++i, mi.getString("PHONE2_NO"));
//                    sql.setString(++i, mi.getString("HP1_NO"));
//                    sql.setString(++i, mi.getString("HP2_NO"));
//                    sql.setString(++i, mi.getString("HP3_NO"));
//                    sql.setString(++i, mi.getString("E_MAIL"));
                    sql.setString(++i, mi.getString("RECP_NO"));
                    sql.setString(++i, mi.getString("ENTY_PATH"));
                    //Action에서 넘겨받은 session의 사용자 ID
                    sql.setString(++i, userID);   
                    sql.setString(++i, userID);   
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
}
