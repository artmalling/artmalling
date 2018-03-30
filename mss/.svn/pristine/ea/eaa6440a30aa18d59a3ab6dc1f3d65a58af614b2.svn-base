/*
** Copyright (c) 2010 한국후지쯔. All rights reserved.
**
** This software is the confidential and proprietary information of 한국후지쯔.
** You shall not disclose such Confidential Information and shall use it
** only in accordance with the terms of the license agreement you entered into
** with 한국후지쯔
*/
 
package mgif.dao;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import common.util.Util;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.control.cfg.svc.shift.Service;
import kr.fujitsu.ffw.model.AbstractDAO;
import kr.fujitsu.ffw.model.SqlWrapper;
import kr.fujitsu.ffw.util.String2;
import kr.fujitsu.ffw.model.DataTypes;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.model.ProcedureWrapper;

/**
 * <p>SAP I/F</p>
 *
 * @created  on 1.0, 2011/09/05
 * @created  by 김재겸(TANINE)
 *
 * @modified on
 * @modified by
 * @caused   by
 */
 
public class MGif618DAO extends AbstractDAO {
	
	 /**
     * SAP I/F 콤보를 조회한다 MSS 에서만 사용하는 I/F 내용조회
     *
     * @param form
     * @return
     * @throws Exception
     */
    public List getIFCode(ActionForm form) throws Exception {

        List ret = null;
        SqlWrapper sql = null;
        Service svc = null;
        String strQuery = "";
        sql = new SqlWrapper();
        svc = (Service) form.getService();
        connect("pot");
        strQuery = svc.getQuery("SEL_SAP_IF");
        sql.put(strQuery);
        // SELECT목록
        ret = select2List(sql);
        return ret;
    }
	
    /**
     * SAP I/F를 조회한다
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

        // 파라미터
        String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
        String strSapIf  = String2.nvl(form.getParam("strSapIf"));
        String strReqDt  = String2.nvl(form.getParam("strReqDt"));
        String strCalGb  = String2.nvl(form.getParam("strCalGb"));

        Util util = new Util();
        sql = new SqlWrapper();
        svc = (Service) form.getService();

        connect("pot");

        if(strCalGb.equals("1")){
        	strQuery = svc.getQuery("SEL_MASTER_DT");
        }else if(strCalGb.equals("2")){
        	strQuery = svc.getQuery("SEL_MASTER_YM");
        }
        
        sql.setString(i++, strReqDt);
        sql.setString(i++, strSapIf);
        sql.setString(i++, strCntrCd);
        sql.setString(i++, strReqDt);
        sql.setString(i++, strSapIf);
        sql.setString(i++, strCntrCd);
        sql.put(strQuery);
        
        // SELECT목록
        ret = select2List(sql);

        return ret;
    }
    
    
    /**
     * <p>
     * SAP 전송 마감 체크 
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */ 
    public String ifSapCloseChk(ActionForm form)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("DPS.PR_SAP_CLOSECHK", 5);

            proc.setString(++i, strCntrCd); // 1   점 
            proc.setString(++i, strSapIf ); // 2   처리코드
            proc.setString(++i, strPorcDt); // 3   처리일자
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 4
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 5
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(4));
            ret = procResult.getString(5);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }      
              
    
    /**
     * <p>
     * 매출정산 I/F
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
    
    public String ifPsposJsIfs(ActionForm form, String strID)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("DPS.PR_PSPOSJS_IFS", 4);

            proc.setString(++i, strCntrCd); // 1
            proc.setString(++i, strPorcDt); // 2
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 3
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 4
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(3));
            ret = procResult.getString(4);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }    
    
    /**
     * <p>
     * 기타매출 I/F
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
    
    public String ifPsetcIfs(ActionForm form, String strID)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("DPS.PR_PSETC_IFS", 4);

            proc.setString(++i, strCntrCd); // 1
            proc.setString(++i, strPorcDt); // 2
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 3
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 4
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(3));
            ret = procResult.getString(4);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }
    
     
    /**
     * <p>
     * 상품매출 I/F
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
    
    public String ifPsgsaleIfs(ActionForm form, String strID)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("DPS.PR_PSGSALE_IFS", 4);

            proc.setString(++i, strCntrCd); // 1
            proc.setString(++i, strPorcDt); // 2
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 3
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 4
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(3));
            ret = procResult.getString(4);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }
        
    /**
     * <p>
     * 수불손익 I/F
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
    
    public String ifPtgstkIfs(ActionForm form, String strID)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("DPS.PR_PTGSTK_IFS", 4);

            proc.setString(++i, strCntrCd); // 1
            proc.setString(++i, strPorcDt); // 2
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 3
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 4
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(3));
            ret = procResult.getString(4);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }    
    
    
    /**
     * <p>
     * 매입전표 I/F
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
    
    public String ifPoslpsapIfs(ActionForm form, String strID)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("DPS.PR_POSLPSAP_IFS", 4);

            proc.setString(++i, strCntrCd); // 1
            proc.setString(++i, strPorcDt); // 2
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 3
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 4
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(3));
            ret = procResult.getString(4);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }    
        
    /**
     * <p>
     * 상품권판매 I/F
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */ 
    public String ifMgsaleIfs(ActionForm form, String strID)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("MSS.PR_MGSAPGIFTSALE_IFS", 4);

            proc.setString(++i, strCntrCd); // 1
            proc.setString(++i, strPorcDt); // 2
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 3
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 4
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(3));
            ret = procResult.getString(4);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }    
        
    /**
     * <p>
     * 상품권 위탁판매출고/반품 I/F
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */ 
    public String ifConsIfs(ActionForm form, String strID)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("MSS.PR_MGSAPCONSIGNMENT_IFS", 4);

            proc.setString(++i, strCntrCd); // 1
            proc.setString(++i, strPorcDt); // 2
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 3
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 4
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(3));
            ret = procResult.getString(4);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }  
    
    
    /**
     * <p>
     * 상품권 위탁판매입금 I/F
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */ 
    public String ifConspayIfs(ActionForm form, String strID)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("MSS.PR_MGSAPCONSIGNMENTPAY_IFS", 4);

            proc.setString(++i, strCntrCd); // 1
            proc.setString(++i, strPorcDt); // 2
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 3
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 4
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(3));
            ret = procResult.getString(4);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }      
    
    
    /**
     * <p>
     * 상품권 사은 불출/반납 I/F
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */ 
    public String ifEvtpoutifs(ActionForm form, String strID)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("MSS.PR_MGSAPPOUTCONF_IFS", 4);

            proc.setString(++i, strCntrCd); // 1
            proc.setString(++i, strPorcDt); // 2
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 3
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 4
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(3));
            ret = procResult.getString(4);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }      
        
    /**
     * <p>
     * 상품권 가맹회수 정산 I/F
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */ 
    public String ifBrchIfs(ActionForm form, String strID)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("MSS.PR_MGSAPBRCH_IFS_ALL", 4);

            proc.setString(++i, strCntrCd); // 1
            proc.setString(++i, strPorcDt); // 2
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 3
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 4
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(3));
            ret = procResult.getString(4);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }    
    
    
    /**
     * <p>
     * 제휴상품권 지급수수료정산 I/F
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */ 
    public String ifPartgiftIfs(ActionForm form, String strID)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("MSS.PR_MGSAPPARTNERGIFTFEE_IFS", 4);

            proc.setString(++i, strCntrCd); // 1
            proc.setString(++i, strPorcDt); // 2
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 3
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 4
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(3));
            ret = procResult.getString(4);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }     
    
    
    /**
     * <p>
     * 제휴쿠폰 수취수수료정산 I/F
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */ 
    public String ifpartcpnIfs(ActionForm form, String strID)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("MSS.PR_MGSAPPARTNERCUPNRECFEE_IFS", 4);

            proc.setString(++i, strCntrCd); // 1
            proc.setString(++i, strPorcDt); // 2
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 3
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 4
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(3));
            ret = procResult.getString(4);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }  
    
    /**
     * <p>
     * 제휴쿠폰 지급수수료정산 I/F
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */ 
    public String ifPartcpnrecIfs(ActionForm form, String strID)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("MSS.PR_MGSAPPARTNERCUPNFEE_IFS", 4);

            proc.setString(++i, strCntrCd); // 1
            proc.setString(++i, strPorcDt); // 2
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 3
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 4
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(3));
            ret = procResult.getString(4);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }      
    
    
    /**
     * <p>
     * 제휴상품권 입금 I/F
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */ 
    public String ifPartgiftpayIfs(ActionForm form, String strID)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("MSS.PR_MGSAPPARTNERGIFTPAY_IFS", 4);

            proc.setString(++i, strCntrCd); // 1
            proc.setString(++i, strPorcDt); // 2
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 3
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 4
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(3));
            ret = procResult.getString(4);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }      
        
    
    /**
     * <p>
     * 제휴쿠폰 지급정산입금 I/F
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */ 
    public String ifsPartcpnpayIfs(ActionForm form, String strID)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("MSS.PR_MGSAPPARTNERCUPNPAY_IFS", 4);

            proc.setString(++i, strCntrCd); // 1
            proc.setString(++i, strPorcDt); // 2
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 3
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 4
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(3));
            ret = procResult.getString(4);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }      
          

    /**
     * <p>
     * 제휴쿠폰 수취정산입금 I/F
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */ 
    public String ifsPartcpnrecpayIfs(ActionForm form, String strID)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("MSS.PR_MGSAPPARTNERCUPNRECPAY_IFS", 4);

            proc.setString(++i, strCntrCd); // 1
            proc.setString(++i, strPorcDt); // 2
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 3
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 4
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(3));
            ret = procResult.getString(4);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }      
          
     

    /**
     * <p>
     * 임대료 및 관리미 청구 I/F
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */ 
    public String ifMrCharegIfs(ActionForm form, String strID)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("MSS.PR_MRSAPMNTN_CHAREG_IFS", 4);

            proc.setString(++i, strCntrCd); // 1
            proc.setString(++i, strPorcDt); // 2
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 3
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 4
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(3));
            ret = procResult.getString(4);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }      
      
    
    
    
    

    /**
     * <p>
     * 임대료 및 관리비 입금 I/F
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */ 
    public String ifMrInIfs(ActionForm form, String strID)
            throws Exception {

        String ret = "";
        ProcedureWrapper proc = null;

        try {
            // DB설정
            connect("pot");
            begin();
            proc = new ProcedureWrapper();

            ProcedureResultSet procResult = null;
            
            int i = 0;            
            // 파라미터
            String strCntrCd = String2.nvl(form.getParam("strCntrCd"));
            String strSapIf  = String2.nvl(form.getParam("strSapIf"));
            String strPorcDt = String2.nvl(form.getParam("strReqDt"));
            
            // 프로시저 닫기
            proc.close();
            
            proc.put("MSS.PR_MRSAPMNTN_IN_IFS", 4);

            proc.setString(++i, strCntrCd); // 1
            proc.setString(++i, strPorcDt); // 2
            proc.registerOutParameter(++i, DataTypes.INTEGER); // 3
            proc.registerOutParameter(++i, DataTypes.VARCHAR); // 4
            
            procResult = updateProcedure(proc);
            
            System.out.println(procResult.getInt(3));
            ret = procResult.getString(4);
            System.out.println(ret);
            
        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }

        return ret;
    }      
          
    
    
    /**
     * <p>
     * SAP I/F 전송
     * </p>
     *
     * @param form
     * @param mi
     * @param strID
     * @return
     * @throws Exception
     */
    public int ifsSend(ActionForm form, MultiInput mi, String strID)
    		throws Exception {

		int res = 0;
		Util util = new Util();
		SqlWrapper sql = null;
		Service svc = null;
		ProcedureWrapper proc = null;
		String ret = "";        
		
		try {
		    // DB설정
		    connect("pot");
		    begin();
		    sql = new SqlWrapper();
		    svc = (Service) form.getService();
		
		    int i;
		    // 파라미터
		    String strCntrCd   = String2.nvl(form.getParam("strCntrCd"));
		    String strSapIf    = String2.nvl(form.getParam("strSapIf"));
		    String strReqDt    = String2.nvl(form.getParam("strReqDt"));
		    String strCalGb = String2.nvl(form.getParam("strCalGb"));
		    // SQL닫기
		    sql.close();
		    // 전표 HEADER 등록
		    if(strCalGb.equals("1")){
		    	sql.put(svc.getQuery("INS_IFS_XI_DOC_HEADER_DT"));
		    }else if(strCalGb.equals("2")){
		    	sql.put(svc.getQuery("INS_IFS_XI_DOC_HEADER_YM"));
		    }
		    
		    i = 0;
		    sql.setString(++i, strReqDt);
		    sql.setString(++i, strSapIf);
		    sql.setString(++i, strCntrCd);
		
		    // SQL실행
		    res = update(sql);
		    // 결과체크
		    if (res < 1) {
		        throw new Exception("데이터의 적합성 문제로 인하여 데이터 입력을 하지 못했습니다.");
		    }
		
		    // SQL닫기
		    sql.close();
		    // 전표 LIST 등록
		    if(strCalGb.equals("1")){
		    	sql.put(svc.getQuery("INS_IFS_XI_DOC_LIST_DT"));
		    } else if(strCalGb.equals("2")){
		    	sql.put(svc.getQuery("INS_IFS_XI_DOC_LIST_YM"));
		    }
		    i = 0;
		    sql.setString(++i, strReqDt);
		    sql.setString(++i, strSapIf);
		    sql.setString(++i, strCntrCd);
		
		    // SQL실행
		    res = update(sql);
		    // 결과체크
		    if (res < 1) {
		        throw new Exception("데이터의 적합성 문제로 인하여 데이터 입력을 하지 못했습니다.");
		    }
		    
		    sql.close();
		    // REQDT 수정 
		    if(strCalGb.equals("1")){
		    	sql.put(svc.getQuery("UPS_IFS_DOCH_DT"));
		    } else if(strCalGb.equals("2")){
		    	sql.put(svc.getQuery("UPS_IFS_DOCH_YM"));
		    }
		    i = 0;
		    sql.setString(++i, strReqDt);
		    sql.setString(++i, strSapIf);
		    sql.setString(++i, strCntrCd);
		    
		    // SQL실행
		    res = update(sql);
		    // 결과체크
		    if (res < 1) {
		        throw new Exception("데이터의 적합성 문제로 인하여 데이터 입력을 하지 못했습니다.");
		    }
		    
		    sql.close();
		    // REQDT 수정 
		    if(strCalGb.equals("1")){
		    	sql.put(svc.getQuery("UPS_IFS_DOCL_DT"));
		    } else if(strCalGb.equals("2")){
		    	sql.put(svc.getQuery("UPS_IFS_DOCL_YM"));
		    }
		    i = 0;
		    sql.setString(++i, strReqDt);
		    sql.setString(++i, strSapIf);
		    sql.setString(++i, strCntrCd);
		    
		    // SQL실행
		    res = update(sql);
		    // 결과체크
		    if (res < 1) {
		        throw new Exception("데이터의 적합성 문제로 인하여 데이터 입력을 하지 못했습니다.");
		    }
		    
		    sql.close();
		    // tranYn 값 수정 
		    if(strCalGb.equals("1")){
		    	sql.put(svc.getQuery("UPS_COM_XI_DOC_DT"));
		    } else if(strCalGb.equals("2")){
		    	sql.put(svc.getQuery("UPS_COM_XI_DOC_YM"));
		    }
		    i = 0;
		    sql.setString(++i, strReqDt);
		    sql.setString(++i, strSapIf);
		    sql.setString(++i, strCntrCd);
		    
		    // SQL실행
		    res = update(sql);
		    // 결과체크
		    if (res < 1) {
		        throw new Exception("데이터의 적합성 문제로 인하여 데이터 입력을 하지 못했습니다.");
		    }
		    
		    // 일마감 /월 마감 세팅 추가 할것 : procedure call
		    proc = new ProcedureWrapper();
		    ProcedureResultSet procResult = null;
		    i = 0;            
		    
		    // 프로시저 닫기
		    proc.close();
		    
		    proc.put("DPS.PR_SAP_IF_UPT", 6);
		
		    proc.setString(++i, strCntrCd); // 1 : 점
		    proc.setString(++i, strSapIf); // 2 : 처리코드
		    proc.setString(++i, strReqDt); // 3 : 처리일자
		    proc.setString(++i, "Y"); // 4  : 마감구분
		    
		    
		    proc.registerOutParameter(++i, DataTypes.INTEGER); // 5 : 결과코드
		    proc.registerOutParameter(++i, DataTypes.VARCHAR); // 6 : 결과 메세지
		    
		    procResult = updateProcedure(proc);
		    
		    System.out.println(procResult.getInt(5));
		    ret = procResult.getString(6);
		    System.out.println(ret);
		    
		    if (!ret.equals("OK")) {
		    	throw new Exception(ret);
		    }
		
		} catch (Exception e) {
		    rollback();
		    throw e;
		} finally {
		    end();
		}
		
		return res;
		}
}
