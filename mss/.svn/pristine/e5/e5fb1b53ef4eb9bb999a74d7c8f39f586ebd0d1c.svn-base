package mgif.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.control.cfg.svc.shift.GauceHelper2;
import kr.fujitsu.ffw.control.cfg.svc.shift.MultiInput;
import kr.fujitsu.ffw.model.ProcedureResultSet;
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import mgif.dao.MGif618DAO;

import com.gauce.GauceDataSet;
import common.vo.SessionInfo;

/**
 * <p>문화센터> 문화강좌> 재무전송> 재무전송(SAP)</p>
 *
 * @created  on 1.0, 2011/05/25
 * @created  by 황정수(TANINE)
 *
 * @modified on
 * @modified by
 * @caused   by
 */

public class MGif618Action extends DispatchAction {
    /*
     * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
     */
    private Logger logger = Logger.getLogger(MGif618Action.class);

    /**
     * <p>화면을 시작한다.</p>
     */
    public ActionForward list(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String strGoTo = form.getParam("goTo"); // 분기할곳
        try {
            GauceHelper2.initialize(form, request, response);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("", e);
        }

        return mapping.findForward(strGoTo);
    }
    
    /**
     * <p>
     * SAP I/F 공통 코드를 조회한다.
     * </p>
     */
    public ActionForward getIFCode(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List list = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        MGif618DAO dao = null;

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {
            dao = new MGif618DAO();
            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_O_SAP_IF");
            helper.setDataSetHeader(dSet, "H_SAP_IF");
            list = dao.getIFCode(form);
            helper.setListToDataset(list, dSet);

        } catch (Exception e) {
            e.printStackTrace();
            logger.error("", e);
            helper.writeException("GAUCE", "101", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    }

    /**
     * <p>
     * SAP I/F를 조회한다.
     * </p>
     */
    public ActionForward searchMaster(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        List list = null;
        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        MGif618DAO dao = null;

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {
            dao = new MGif618DAO();
            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_SEL_MASTER");
            list = dao.searchMaster(form);
            helper.setListToDataset(list, dSet);

        } catch (Exception e) {
            e.printStackTrace();
            logger.error("", e);
            helper.writeException("GAUCE", "101", e.getMessage());
        } finally {
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo);
    }

    /**
     * <p>
     * 매출정산 I/F
     * </p>
     */    
    public ActionForward ifPsposJsIfs(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

          GauceHelper2 helper = null;
          GauceDataSet dSet = null;
          MGif618DAO dao = null;
          ProcedureResultSet prs = null;
          String ret = "";
          HttpSession session = request.getSession();
          String userId = null;
          String strGoTo = form.getParam("goTo"); // 분기할곳

          try {
              SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
              userId = sessionInfo.getUSER_ID();

              helper = new GauceHelper2(request, response, form);

              dSet = helper.getDataSet("DS_O_MASTER");
              dao = new MGif618DAO(); 
              
              ret = dao.ifSapCloseChk(form);
              
              System.out.println("전송마감 체크 ret : " + ret);
              
              if (ret.equals("OK")){
                  ret = dao.ifPsposJsIfs(form, userId);
                  
                  System.out.println("ifPsposJsIfs  :  ret : " + ret);
                  
              }                
          } catch (Exception e) {
              e.printStackTrace();
              logger.error("", e);
              helper.writeException("GAUCE", "002", e.getMessage());
          } finally {
              if (ret.equals("OK")) {
                  helper.close("정상처리 되었습니다.");
              } else {
                  helper.close(ret);
              }
          }
          return mapping.findForward(strGoTo);
      }  
    
    
    /**
     * <p>
     * 기타매출 I/F
     * </p>
     */    
    public ActionForward ifPsetcIfs(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

          GauceHelper2 helper = null;
          GauceDataSet dSet = null;
          MGif618DAO dao = null;
          ProcedureResultSet prs = null;
          String ret = "";
          HttpSession session = request.getSession();
          String userId = null;
          String strGoTo = form.getParam("goTo"); // 분기할곳

          try {
              SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
              userId = sessionInfo.getUSER_ID();

              helper = new GauceHelper2(request, response, form);

              dSet = helper.getDataSet("DS_O_MASTER");
              dao = new MGif618DAO(); 

              ret = dao.ifSapCloseChk(form);
              
              System.out.println("전송마감 체크 ret : " + ret);
              
              if (ret.equals("OK")){
                  ret = dao.ifPsetcIfs(form, userId);
                  
                  System.out.println("ifPsetcIfs  :  ret : " + ret);
                  
              }                 
          } catch (Exception e) {
              e.printStackTrace();
              logger.error("", e);
              helper.writeException("GAUCE", "002", e.getMessage());
          } finally {
              if (ret.equals("OK")) {
                  helper.close("정상처리 되었습니다.");
              } else {
                  helper.close(ret);
              }
          }
          return mapping.findForward(strGoTo);
      }  
        
         
    /**
     * <p>
     * 상품매출 I/F
     * </p>
     */    
    public ActionForward ifPsgsaleIfs(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

          GauceHelper2 helper = null;
          GauceDataSet dSet = null;
          MGif618DAO dao = null;
          ProcedureResultSet prs = null;
          String ret = "";
          HttpSession session = request.getSession();
          String userId = null;
          String strGoTo = form.getParam("goTo"); // 분기할곳

          try {
              SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
              userId = sessionInfo.getUSER_ID();

              helper = new GauceHelper2(request, response, form);

              dSet = helper.getDataSet("DS_O_MASTER");
              dao = new MGif618DAO(); 

              ret = dao.ifSapCloseChk(form);
              
              System.out.println("전송마감 체크 ret : " + ret);
              
              if (ret.equals("OK")){
                  ret = dao.ifPsgsaleIfs(form, userId);
                  
                  System.out.println("ifPsgsaleIfs  :  ret : " + ret);
                  
              }           
          } catch (Exception e) {
              e.printStackTrace();
              logger.error("", e);
              helper.writeException("GAUCE", "002", e.getMessage());
          } finally {
              if (ret.equals("OK")) {
                  helper.close("정상처리 되었습니다.");
              } else {
                  helper.close(ret);
              }
          }
          return mapping.findForward(strGoTo);
      }  
               

    /**
     * <p>
     * 수불손익 I/F
     * </p>
     */    
    public ActionForward ifPtgstkIfs(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

          GauceHelper2 helper = null;
          GauceDataSet dSet = null;
          MGif618DAO dao = null;
          ProcedureResultSet prs = null;
          String ret = "";
          HttpSession session = request.getSession();
          String userId = null;
          String strGoTo = form.getParam("goTo"); // 분기할곳

          try {
              SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
              userId = sessionInfo.getUSER_ID();

              helper = new GauceHelper2(request, response, form);

              dSet = helper.getDataSet("DS_O_MASTER");
              dao = new MGif618DAO(); 
              
              ret = dao.ifSapCloseChk(form);
              
              System.out.println("전송마감 체크 ret : " + ret);
              
              if (ret.equals("OK")){
                  ret = dao.ifPtgstkIfs(form, userId);
                  
                  System.out.println("ifPtgstkIfs  :  ret : " + ret);
                  
              }  
          } catch (Exception e) {
              e.printStackTrace();
              logger.error("", e);
              helper.writeException("GAUCE", "002", e.getMessage());
          } finally {
              if (ret.equals("OK")) {
                  helper.close("정상처리 되었습니다.");
              } else {
                  helper.close(ret);
              }
          }
          return mapping.findForward(strGoTo);
      }  
    
    
    
    /**
     * <p>
     * 매입전표 I/F
     * </p>
     */    
    public ActionForward ifPoslpsapIfs(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

          GauceHelper2 helper = null;
          GauceDataSet dSet = null;
          MGif618DAO dao = null;
          ProcedureResultSet prs = null;
          String ret  = ""; 
          HttpSession session = request.getSession();
          String userId = null;
          String strGoTo = form.getParam("goTo"); // 분기할곳

          try {
              SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
              userId = sessionInfo.getUSER_ID();

              helper = new GauceHelper2(request, response, form);

              dSet = helper.getDataSet("DS_O_MASTER");
              dao = new MGif618DAO();
              
              // 마감 체크 추가 : 2011.09.15
              ret = dao.ifSapCloseChk(form);

              System.out.println("전송마감 체크 ret : " + ret);
              
              if (ret.equals("OK")){
                  ret = dao.ifPoslpsapIfs(form, userId);
                  
                  System.out.println("ifPoslpsapIfs  :  ret : " + ret);
                  
              }
               

          } catch (Exception e) {
              e.printStackTrace();
              logger.error("", e);
              helper.writeException("GAUCE", "002", e.getMessage());
          } finally {
              if (ret.equals("OK")) {
                  helper.close("정상처리 되었습니다.");
              } else {
                  helper.close(ret);
              }
          }
          return mapping.findForward(strGoTo);
      }      
    
     
    
    /**
     * <p>
     * 상품권판매 I/F
     * </p>
     */    
    public ActionForward ifMgsaleIfs(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

          GauceHelper2 helper = null;
          GauceDataSet dSet = null;
          MGif618DAO dao = null;
          ProcedureResultSet prs = null;
          String ret = "";
          HttpSession session = request.getSession();
          String userId = null;
          String strGoTo = form.getParam("goTo"); // 분기할곳

          try {
              SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
              userId = sessionInfo.getUSER_ID();

              helper = new GauceHelper2(request, response, form);

              dSet = helper.getDataSet("DS_O_MASTER");
              dao = new MGif618DAO(); 
              
              ret = dao.ifSapCloseChk(form);

              System.out.println("전송마감 체크 ret : " + ret);
              
              if (ret.equals("OK")){
                  ret = dao.ifMgsaleIfs(form, userId);
                  
                  System.out.println("ifMgsaleIfs  :  ret : " + ret);
                  
              }  
              
          } catch (Exception e) {
              e.printStackTrace();
              logger.error("", e);
              helper.writeException("GAUCE", "002", e.getMessage());
          } finally {
              if (ret.equals("OK")) {
                  helper.close("정상처리 되었습니다.");
              } else {
                  helper.close(ret);
              }
          }
          return mapping.findForward(strGoTo);
      }      
    
    
    /**
     * <p>
     * 상품권 위탁판매출고/반품 I/F
     * </p>
     */    
    public ActionForward ifConsIfs(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

          GauceHelper2 helper = null;
          GauceDataSet dSet = null;
          MGif618DAO dao = null;
          ProcedureResultSet prs = null;
          String ret = "";
          HttpSession session = request.getSession();
          String userId = null;
          String strGoTo = form.getParam("goTo"); // 분기할곳

          try {
              SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
              userId = sessionInfo.getUSER_ID();

              helper = new GauceHelper2(request, response, form);

              dSet = helper.getDataSet("DS_O_MASTER");
              dao = new MGif618DAO(); 
              ret = dao.ifSapCloseChk(form);

              System.out.println("전송마감 체크 ret : " + ret);
              
              if (ret.equals("OK")){
                  ret = dao.ifConsIfs(form, userId);
                  
                  System.out.println("ifConsIfs  :  ret : " + ret);
                  
              }                
              
          } catch (Exception e) {
              e.printStackTrace();
              logger.error("", e);
              helper.writeException("GAUCE", "002", e.getMessage());
          } finally {
              if (ret.equals("OK")) {
                  helper.close("정상처리 되었습니다.");
              } else {
                  helper.close(ret);
              }
          }
          return mapping.findForward(strGoTo);
      }      
        
    
    /**
     * <p>
     * 상품권 위탁판매입금 I/F
     * </p>
     */    
    public ActionForward ifConspayIfs(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

          GauceHelper2 helper = null;
          GauceDataSet dSet = null;
          MGif618DAO dao = null;
          ProcedureResultSet prs = null;
          String ret = "";
          HttpSession session = request.getSession();
          String userId = null;
          String strGoTo = form.getParam("goTo"); // 분기할곳

          try {
              SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
              userId = sessionInfo.getUSER_ID();

              helper = new GauceHelper2(request, response, form);

              dSet = helper.getDataSet("DS_O_MASTER");
              dao = new MGif618DAO();  

              ret = dao.ifSapCloseChk(form);
              
              System.out.println("전송마감 체크 ret : " + ret);
              
              if (ret.equals("OK")){
                  ret = dao.ifConspayIfs(form, userId);
                  
                  System.out.println("ifConspayIfs  :  ret : " + ret);
                  
              }                              
          } catch (Exception e) {
              e.printStackTrace();
              logger.error("", e);
              helper.writeException("GAUCE", "002", e.getMessage());
          } finally {
              if (ret.equals("OK")) {
                  helper.close("정상처리 되었습니다.");
              } else {
                  helper.close(ret);
              }
          }
          return mapping.findForward(strGoTo);
      }      
     
    
    /**
     * <p>
     * 상품권 사은 불출/반납 I/F
     * </p>
     */    
    public ActionForward ifEvtpoutifs(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

          GauceHelper2 helper = null;
          GauceDataSet dSet = null;
          MGif618DAO dao = null;
          ProcedureResultSet prs = null;
          String ret = "";
          HttpSession session = request.getSession();
          String userId = null;
          String strGoTo = form.getParam("goTo"); // 분기할곳

          try {
              SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
              userId = sessionInfo.getUSER_ID();

              helper = new GauceHelper2(request, response, form);

              dSet = helper.getDataSet("DS_O_MASTER");
              dao = new MGif618DAO(); 

              ret = dao.ifSapCloseChk(form);
              
              System.out.println("전송마감 체크 ret : " + ret);
              
              if (ret.equals("OK")){
                  ret = dao.ifEvtpoutifs(form, userId);
                  
                  System.out.println("ifEvtpoutifs  :  ret : " + ret);
                  
              }                                            
              
          } catch (Exception e) {
              e.printStackTrace();
              logger.error("", e);
              helper.writeException("GAUCE", "002", e.getMessage());
          } finally {
              if (ret.equals("OK")) {
                  helper.close("정상처리 되었습니다.");
              } else {
                  helper.close(ret);
              }
          }
          return mapping.findForward(strGoTo);
      }      
           
    
    /**
     * <p>
     * 상품권 가맹회수 정산 I/F
     * </p>
     */    
    public ActionForward ifBrchIfs(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

          GauceHelper2 helper = null;
          GauceDataSet dSet = null;
          MGif618DAO dao = null;
          ProcedureResultSet prs = null;
          String ret = "";
          HttpSession session = request.getSession();
          String userId = null;
          String strGoTo = form.getParam("goTo"); // 분기할곳

          try {
              SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
              userId = sessionInfo.getUSER_ID();

              helper = new GauceHelper2(request, response, form);

              dSet = helper.getDataSet("DS_O_MASTER");
              dao = new MGif618DAO(); 

              ret = dao.ifSapCloseChk(form);
              
              System.out.println("전송마감 체크 ret : " + ret);
              
              if (ret.equals("OK")){
                  ret = dao.ifBrchIfs(form, userId);
                  
                  System.out.println("ifBrchIfs  :  ret : " + ret);
                  
              }                                                        

          } catch (Exception e) {
              e.printStackTrace();
              logger.error("", e);
              helper.writeException("GAUCE", "002", e.getMessage());
          } finally {
              if (ret.equals("OK")) {
                  helper.close("정상처리 되었습니다.");
              } else {
                  helper.close(ret);
              }
          }
          return mapping.findForward(strGoTo);
      }     
    
    
    /**
     * <p>
     * 제휴상품권 지급수수료정산 I/F
     * </p>
     */    
    public ActionForward ifPartgiftIfs(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

          GauceHelper2 helper = null;
          GauceDataSet dSet = null;
          MGif618DAO dao = null;
          ProcedureResultSet prs = null;
          String ret = "";
          HttpSession session = request.getSession();
          String userId = null;
          String strGoTo = form.getParam("goTo"); // 분기할곳

          try {
              SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
              userId = sessionInfo.getUSER_ID();

              helper = new GauceHelper2(request, response, form);

              dSet = helper.getDataSet("DS_O_MASTER");
              dao = new MGif618DAO(); 
              
              ret = dao.ifSapCloseChk(form);
              
              System.out.println("전송마감 체크 ret : " + ret);
              
              if (ret.equals("OK")){
                  ret = dao.ifPartgiftIfs(form, userId);
                  
                  System.out.println("ifPartgiftIfs  :  ret : " + ret);
                  
              }                    
              
          } catch (Exception e) {
              e.printStackTrace();
              logger.error("", e);
              helper.writeException("GAUCE", "002", e.getMessage());
          } finally {
              if (ret.equals("OK")) {
                  helper.close("정상처리 되었습니다.");
              } else {
                  helper.close(ret);
              }
          }
          return mapping.findForward(strGoTo);
      }     
     
    /**
     * <p>
     * 제휴쿠폰 수취수수료정산 I/F
     * </p>
     */    
    public ActionForward ifpartcpnIfs(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

          GauceHelper2 helper = null;
          GauceDataSet dSet = null;
          MGif618DAO dao = null;
          ProcedureResultSet prs = null;
          String ret = "";
          HttpSession session = request.getSession();
          String userId = null;
          String strGoTo = form.getParam("goTo"); // 분기할곳

          try {
              SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
              userId = sessionInfo.getUSER_ID();

              helper = new GauceHelper2(request, response, form);

              dSet = helper.getDataSet("DS_O_MASTER");
              dao = new MGif618DAO();
              
              ret = dao.ifSapCloseChk(form);
              
              System.out.println("전송마감 체크 ret : " + ret);
              
              if (ret.equals("OK")){
                  ret = dao.ifpartcpnIfs(form, userId);
                  
                  System.out.println("ifpartcpnIfs  :  ret : " + ret);
                  
              }                    
              
          } catch (Exception e) {
              e.printStackTrace();
              logger.error("", e);
              helper.writeException("GAUCE", "002", e.getMessage());
          } finally {
              if (ret.equals("OK")) {
                  helper.close("정상처리 되었습니다.");
              } else {
                  helper.close(ret);
              }
          }
          return mapping.findForward(strGoTo);
      }     
    
    
    /**
     * <p>
     * 제휴쿠폰 지급수수료정산 I/F
     * </p>
     */    
    public ActionForward ifPartcpnrecIfs(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

          GauceHelper2 helper = null;
          GauceDataSet dSet = null;
          MGif618DAO dao = null;
          ProcedureResultSet prs = null;
          String ret = "";
          HttpSession session = request.getSession();
          String userId = null;
          String strGoTo = form.getParam("goTo"); // 분기할곳

          try {
              SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
              userId = sessionInfo.getUSER_ID();

              helper = new GauceHelper2(request, response, form);

              dSet = helper.getDataSet("DS_O_MASTER");
              dao = new MGif618DAO(); 

              ret = dao.ifSapCloseChk(form);
              
              System.out.println("전송마감 체크 ret : " + ret);
              
              if (ret.equals("OK")){
                  ret = dao.ifPartcpnrecIfs(form, userId);
                  
                  System.out.println("ifPartcpnrecIfs  :  ret : " + ret);
                  
              }                           
          } catch (Exception e) {
              e.printStackTrace();
              logger.error("", e);
              helper.writeException("GAUCE", "002", e.getMessage());
          } finally {
              if (ret.equals("OK")) {
                  helper.close("정상처리 되었습니다.");
              } else {
                  helper.close(ret);
              }
          }
          return mapping.findForward(strGoTo);
      }     
        

    /**
     * <p>
     * 제휴상품권 입금 I/F
     * </p>
     */    
    public ActionForward ifPartgiftpayIfs(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

          GauceHelper2 helper = null;
          GauceDataSet dSet = null;
          MGif618DAO dao = null;
          ProcedureResultSet prs = null;
          String ret = "";
          HttpSession session = request.getSession();
          String userId = null;
          String strGoTo = form.getParam("goTo"); // 분기할곳

          try {
              SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
              userId = sessionInfo.getUSER_ID();

              helper = new GauceHelper2(request, response, form);

              dSet = helper.getDataSet("DS_O_MASTER");
              dao = new MGif618DAO(); 
              
              ret = dao.ifSapCloseChk(form);
              
              System.out.println("전송마감 체크 ret : " + ret);
              
              if (ret.equals("OK")){
                  ret = dao.ifPartgiftpayIfs(form, userId);
                  
                  System.out.println("ifPartgiftpayIfs  :  ret : " + ret);
                  
              } 
              
          } catch (Exception e) {
              e.printStackTrace();
              logger.error("", e);
              helper.writeException("GAUCE", "002", e.getMessage());
          } finally {
              if (ret.equals("OK")) {
                  helper.close("정상처리 되었습니다.");
              } else {
                  helper.close(ret);
              }
          }
          return mapping.findForward(strGoTo);
      }     

    
    /**
     * <p>
     * 제휴쿠폰 지급정산입금 I/F
     * </p>
     */    
    public ActionForward ifsPartcpnpayIfs(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

          GauceHelper2 helper = null;
          GauceDataSet dSet = null;
          MGif618DAO dao = null;
          ProcedureResultSet prs = null;
          String ret = "";
          HttpSession session = request.getSession();
          String userId = null;
          String strGoTo = form.getParam("goTo"); // 분기할곳

          try {
              SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
              userId = sessionInfo.getUSER_ID();

              helper = new GauceHelper2(request, response, form);

              dSet = helper.getDataSet("DS_O_MASTER");
              dao = new MGif618DAO(); 
              
              ret = dao.ifSapCloseChk(form);
              
              System.out.println("전송마감 체크 ret : " + ret);
              
              if (ret.equals("OK")){
                  ret = dao.ifsPartcpnpayIfs(form, userId);
                  
                  System.out.println("ifsPartcpnpayIfs  :  ret : " + ret);
                  
              } 
          } catch (Exception e) {
              e.printStackTrace();
              logger.error("", e);
              helper.writeException("GAUCE", "002", e.getMessage());
          } finally {
              if (ret.equals("OK")) {
                  helper.close("정상처리 되었습니다.");
              } else {
                  helper.close(ret);
              }
          }
          return mapping.findForward(strGoTo);
      }     

    /**
     * <p>
     * 제휴쿠폰 수취정산입금 I/F
     * </p>
     */    
    public ActionForward ifsPartcpnrecpayIfs(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

          GauceHelper2 helper = null;
          GauceDataSet dSet = null;
          MGif618DAO dao = null;
          ProcedureResultSet prs = null;
          String ret = "";
          HttpSession session = request.getSession();
          String userId = null;
          String strGoTo = form.getParam("goTo"); // 분기할곳

          try {
              SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
              userId = sessionInfo.getUSER_ID();

              helper = new GauceHelper2(request, response, form);

              dSet = helper.getDataSet("DS_O_MASTER");
              dao = new MGif618DAO(); 

              ret = dao.ifSapCloseChk(form);
              
              System.out.println("전송마감 체크 ret : " + ret);
              
              if (ret.equals("OK")){
                  ret = dao.ifsPartcpnrecpayIfs(form, userId);
                  
                  System.out.println("ifsPartcpnrecpayIfs  :  ret : " + ret);
                  
              }               
          } catch (Exception e) {
              e.printStackTrace();
              logger.error("", e);
              helper.writeException("GAUCE", "002", e.getMessage());
          } finally {
              if (ret.equals("OK")) {
                  helper.close("정상처리 되었습니다.");
              } else {
                  helper.close(ret);
              }
          }
          return mapping.findForward(strGoTo);
      }     

    
    
    
    /**
     * <p>
     * 임대료 및 관리미 청구 I/F
     * </p>
     */    
    public ActionForward ifMrCharegIfs(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

          GauceHelper2 helper = null;
          GauceDataSet dSet = null;
          MGif618DAO dao = null;
          ProcedureResultSet prs = null;
          String ret = "";
          HttpSession session = request.getSession();
          String userId = null;
          String strGoTo = form.getParam("goTo"); // 분기할곳

          try {
              SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
              userId = sessionInfo.getUSER_ID();

              helper = new GauceHelper2(request, response, form);

              dSet = helper.getDataSet("DS_O_MASTER");
              dao = new MGif618DAO(); 

              ret = dao.ifSapCloseChk(form);
              
              System.out.println("전송마감 체크 ret : " + ret);
              
              if (ret.equals("OK")){
                  ret = dao.ifMrCharegIfs(form, userId);
                  
                  System.out.println("ifMrCharegIfs  :  ret : " + ret);
                  
              }               
          } catch (Exception e) {
              e.printStackTrace();
              logger.error("", e);
              helper.writeException("GAUCE", "002", e.getMessage());
          } finally {
              if (ret.equals("OK")) {
                  helper.close("정상처리 되었습니다.");
              } else {
                  helper.close(ret);
              }
          }
          return mapping.findForward(strGoTo);
      }     


    
    /**
     * <p>
     * 임대료 및 관리비 입금 I/F
     * </p>
     */    
    public ActionForward ifMrInIfs(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

          GauceHelper2 helper = null;
          GauceDataSet dSet = null;
          MGif618DAO dao = null;
          ProcedureResultSet prs = null;
          String ret = "";
          HttpSession session = request.getSession();
          String userId = null;
          String strGoTo = form.getParam("goTo"); // 분기할곳

          try {
              SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
              userId = sessionInfo.getUSER_ID();

              helper = new GauceHelper2(request, response, form);

              dSet = helper.getDataSet("DS_O_MASTER");
              dao = new MGif618DAO(); 

              ret = dao.ifSapCloseChk(form);
              
              System.out.println("전송마감 체크 ret : " + ret);
              
              if (ret.equals("OK")){
                  ret = dao.ifMrInIfs(form, userId);
                  
                  System.out.println("ifMrInIfs  :  ret : " + ret);
                  
              }               
          } catch (Exception e) {
              e.printStackTrace();
              logger.error("", e);
              helper.writeException("GAUCE", "002", e.getMessage());
          } finally {
              if (ret.equals("OK")) {
                  helper.close("정상처리 되었습니다.");
              } else {
                  helper.close(ret);
              }
          }
          return mapping.findForward(strGoTo);
      }     

    
    
    
    /**
     * <p>
     * SAP I/F 전송
     * </p>
     */
    public ActionForward ifsSend(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        GauceHelper2 helper = null;
        GauceDataSet dSet = null;
        MGif618DAO dao = null;
        int ret = 0;
        HttpSession session = request.getSession();
        String userId = null;

        String strGoTo = form.getParam("goTo"); // 분기할곳

        try {
            SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
            userId = sessionInfo.getUSER_ID();

            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_O_MASTER");
            helper.setDataSetHeader(dSet, "H_SEL_MASTER");

            MultiInput mi = helper.getMutiInput(dSet);

            dao = new MGif618DAO();
            ret = dao.ifsSend(form, mi, userId);

        } catch (Exception e) {
            e.printStackTrace();
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
        } finally {
            // 저장, 삭제, 수정의 경우 아래의 메시지를 사용
            helper.close(dSet, "정상처리 되었습니다.");
        }
        return mapping.findForward(strGoTo);
    }

}
