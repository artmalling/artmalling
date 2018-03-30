/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */

package mcae.action;

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

import mcae.dao.MCae436DAO;

import org.apache.log4j.Logger;

import com.gauce.GauceDataSet;

import common.vo.SessionInfo;

/**
 * <p>
 * </p>
 * 
 * @created on 1.0, 2016.11.15
 * @created by KHJ(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * @caused by
 */

public class MCae436Action extends DispatchAction {
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(MCae436Action.class);

	/**
	 * <p>
	 * 사은품 지급등록 초기화면
	 * </p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String strGoTo = form.getParam("goTo"); // 분기할곳
		try {
			GauceHelper2.initialize(form, request, response);
			HttpSession session = request.getSession();
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>
	 * 사은 행사 정보 조회
	 * </p>
	 * 
	 */
	public ActionForward getEventCombo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae436DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MCae436DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_EVENT_COMBO");
			helper.setDataSetHeader(dSet, "H_COMBO");
			list = dao.getEventCombo(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}

	/**
	 * <p>
	 * 사은 행사 정보 조회
	 * </p>
	 * 
	 */
	public ActionForward getEventInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae436DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MCae436DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_EVENT_INFO");
			helper.setDataSetHeader(dSet, "H_EVENT_INFO");
			list = dao.getEventInfo(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}


	
	/**
	 * <p>
	 * 스캔 영수증 정보 조회 - 반품영수증여부, 사은품 지급여부 확인.
	 *                         정상인 경우 영수증 정보 조회
	 * </p>
	 * 
	 */
	public ActionForward getRECEIPT_list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		List list2 = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae436DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MCae436DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_RECEIPT");
			helper.setDataSetHeader(dSet, "H_RECEIPT");

			list = dao.getRECEIPT_Check(form);	
			if(list.size() > 0){
				throw new Exception("[USER]" + "반품 된 영수증입니다.영수증번호를 확인해주세요.");
				
			}
			
			System.out.println("getRECEIPT_CHK-------");
			list = dao.getRECEIPT_CHK(form);		
			
			if(list.size() > 0){
				throw new Exception("[USER]" + "이미 사은품이 지급된 영수증입니다.");
				
			} else {

				System.out.println("getRECEIPT_list-------");
				list2 = dao.getRECEIPT_list(form);
				if(list2.size() == 0){
					throw new Exception("[USER]" + "해당 영수증 정보가 없습니다.");
					
				}
				
				helper.setListToDataset(list2, dSet);				
            }
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}


	/**
	 * <p>
	 * 영수증 브랜드 사은 합산/개별 정보 조회
	 * </p>
	 * 
	 */
	public ActionForward getPbSaleInfo_all(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[] = null;
		
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;

		MCae436DAO dao = null;
        MultiInput   mi      = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {

			dao = new MCae436DAO();
			dSet = new  GauceDataSet[4];
			list = new List[3];
			
			helper = new GauceHelper2(request, response, form);

			dSet[0] = helper.getDataSet("DS_O_PB_EVENT");
			helper.setDataSetHeader(dSet[0], "H_PB_EVENT");

			dSet[1] = helper.getDataSet("DS_O_PAID_EVENT");
			helper.setDataSetHeader(dSet[1], "H_PAID_EVENT");
			
			dSet[2] = helper.getDataSet("DS_O_CARD_EVENT");
			helper.setDataSetHeader(dSet[2], "H_CARD_EVENT");

			dSet[3] = helper.getDataSet("DS_O_RECEIPT_ADD");
            mi = helper.getMutiInput(dSet[3]);

			list = dao.getPbSaleInfo_all(form, mi);

			for (int i = 0; i < list.length; i++) {
				helper.setListToDataset(list[i], dSet[i]);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
			
	}
	

	/**
	 * <p>
	 * 영수증 브랜드 사은 합산/개별 정보 조회
	 * </p>
	 * 
	 */
	public ActionForward getPbSaleInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[] = null;
		
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;

		MCae436DAO dao = null;
        MultiInput   mi      = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {

			dao = new MCae436DAO();
			dSet = new  GauceDataSet[3];
			list = new List[2];
			
			helper = new GauceHelper2(request, response, form);

			dSet[0] = helper.getDataSet("DS_O_PB_EVENT");
			helper.setDataSetHeader(dSet[0], "H_PB_EVENT");

			dSet[1] = helper.getDataSet("DS_O_PAID_EVENT");
			helper.setDataSetHeader(dSet[1], "H_PAID_EVENT");

			dSet[2] = helper.getDataSet("DS_O_RECEIPT_ADD");
            mi = helper.getMutiInput(dSet[2]);

			System.out.println("getPbSaleInfo-------");
			list = dao.getPbSaleInfo(form, mi);

			System.out.println("length-------" + list.length);
			for (int i = 0; i < list.length; i++) {
				helper.setListToDataset(list[i], dSet[i]);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
			
	}


	/**
	 * <p>
	 * 지난 영수증 브랜드 사은 합산/개별 정보 조회
	 * </p>
	 * 
	 */
	public ActionForward getPbSaleInfo_Per(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[] = null;
		
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;

		MCae436DAO dao = null;
        MultiInput   mi      = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳
		
		try {

			dao = new MCae436DAO();
			dSet = new  GauceDataSet[3];
			list = new List[2];
			
			helper = new GauceHelper2(request, response, form);

			dSet[0] = helper.getDataSet("DS_O_PB_EVENT");
			helper.setDataSetHeader(dSet[0], "H_PB_EVENT");

			dSet[1] = helper.getDataSet("DS_O_PAID_EVENT");
			helper.setDataSetHeader(dSet[1], "H_PAID_EVENT");

			dSet[2] = helper.getDataSet("DS_O_RECEIPT_ADD");
            mi = helper.getMutiInput(dSet[2]);

			System.out.println("getPbSaleInfo_Per-------");
			list = dao.getPbSaleInfo_Per(form, mi);

			System.out.println("length-------" + list.length);
			for (int i = 0; i < list.length; i++) {
				helper.setListToDataset(list[i], dSet[i]);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
			
	}

	
	/**
	 * <p>
	 * 당일 영수증 정보 조회
	 * </p>
	 * 
	 */
	public ActionForward getSaleInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[] = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = null;
		MCae436DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MCae436DAO();
			dSet = new GauceDataSet[2];
			list = new List[2];
			helper = new GauceHelper2(request, response, form);
			dSet[0] = helper.getDataSet("DS_IO_SALE_INFO_TMP");
			helper.setDataSetHeader(dSet[0], "H_SALE_INFO");
			dSet[1] = helper.getDataSet("DS_IO_SALE_CHK");
			helper.setDataSetHeader(dSet[1], "H_SALECHK");
			
			list = dao.getSaleInfo(form);
			helper.setListToDataset(list[0], dSet[0]);
			helper.setListToDataset(list[1], dSet[1]);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}


	
	
	/**
	 * <p>
	 * 영수증 정보 조회 - 고객카드정보로 조회
	 * </p>
	 * 
	 */
	public ActionForward getSaleInfo2(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae436DAO dao = null;
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MCae436DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_SALE_INFO_TMP");
			helper.setDataSetHeader(dSet, "H_SALE_INFO");
			list = dao.getSaleInfo2(form);
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}

	/**
	 * <p>
	 * 지급품 조회
	 * </p>
	 * 
	 */
	public ActionForward getSkuList_back(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae436DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MCae436DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_IO_SKU_LIST");
			helper.setDataSetHeader(dSet, "H_SKU_LIST");
			list = dao.getSkuList_back(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
	
	/**
	 * <p>
	 * 지급품 조회
	 * </p>
	 * 
	 */
	public ActionForward getSkuList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list[] = null;
		
		GauceHelper2 helper  = null;
		GauceDataSet dSet[]  = null;
		
		MCae436DAO   dao     = null;
        
		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MCae436DAO();
			dSet = new  GauceDataSet[6];
			list = new List[3];

			helper = new GauceHelper2(request, response, form);			


			dSet[0] = helper.getDataSet("DS_IO_SKU_LIST_ALL");
			helper.setDataSetHeader(dSet[0], "H_SKU_LIST_ALL");	

			dSet[1] = helper.getDataSet("DS_IO_SKU_LIST");
			helper.setDataSetHeader(dSet[1], "H_SKU_LIST");

			dSet[2] = helper.getDataSet("DS_IO_SKU_LIST_CARD");
			helper.setDataSetHeader(dSet[2], "H_SKU_LIST_CARD");
			

			MultiInput mi[] = new MultiInput[3];

            System.out.println(" mi[0]----------" );
			dSet[3] = helper.getDataSet("DS_O_PB_EVENT");
            mi[0] = helper.getMutiInput(dSet[3]);

            System.out.println(" mi[1]----------" );
			dSet[4] = helper.getDataSet("DS_O_PAID_EVENT");
            mi[1] = helper.getMutiInput(dSet[4]);

            System.out.println(" mi[2]----------" );
			dSet[5] = helper.getDataSet("DS_O_CARD_EVENT");
            mi[2] = helper.getMutiInput(dSet[5]);

            System.out.println(" getSkuList---------" );
			list = dao.getSkuList(form, mi);

			System.out.println("length-------" + list.length);
			for (int i = 0; i < list.length; i++) {
				helper.setListToDataset(list[i], dSet[i]);
			}
			
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}
		
	
	
    /**
     * <p> 상품권 번호 정합성 체크 </p>
     * 
     */
	public ActionForward chkGiftCardNo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae436DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {
			dao = new MCae436DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_CHECK");
			helper.setDataSetHeader(dSet, "H_GIFTCARD_NO_CHK");
			list = dao.chkGiftCardNo(form);
			helper.setListToDataset(list, dSet);

		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}

	/**
	 * <p>
	 * 상품권 조회
	 * </p>
	 */
    public ActionForward getGiftCardNo(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        List list			= null;
        GauceHelper2 helper	= null;
        GauceDataSet dSet	= null;
        MCae436DAO dao		= null;
        
        String strGoTo = form.getParam("goTo");
        try {

            helper = new GauceHelper2(request, response, form);
            dSet = helper.getDataSet("DS_IO_GIFTCARD_NO");			
            helper.setDataSetHeader(dSet, "H_GIFTCARD_NO"); 
            

            dao = new MCae436DAO();
            list = dao.getGiftCardNo(form); //DAO에서 처리된 내역을 List타입으로 받음
            helper.setListToDataset(list, dSet); 

        } catch (Exception e) {//오류처리
            logger.error("", e);
            helper.writeException("GAUCE", "002", e.getMessage());
            
        } finally {//모든행위가 끝난뒤 처리해야할 내역
            helper.close(dSet);
        }
        return mapping.findForward(strGoTo); //(xxxx_config.xml)에 정의된 매핑 Forward명 입력
    }	
	
	
	/**
	 * <p>
	 * 지급품 정보 (매입원가, 대상코드)조회
	 * </p>
	 * 
	 */
	public ActionForward getSkuInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		List list = null;
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		MCae436DAO dao = null;

		String strGoTo = form.getParam("goTo"); // 분기할곳

		try {

			dao = new MCae436DAO();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_SKU_INFO");
			helper.setDataSetHeader(dSet, "H_SKU_LIST");
			list = dao.getSkuInfo(form);
			helper.setListToDataset(list, dSet);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGoTo);
	}

	/**
	 * <p>
	 * 카드 고객 정보 조회
	 * </p>
	 * 
	 */
	public ActionForward getCardInfo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		GauceHelper2 helper = null;
		GauceDataSet dSet = null;
		List ret = null;
		String userId = "";
		HttpSession session = request.getSession();
		String strGo = form.getParam("goTo");
		try {
			SessionInfo sessionInfo = (SessionInfo) session
					.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);
			dSet = helper.getDataSet("DS_O_CARD_INFO");
			helper.setDataSetHeader(dSet, "H_CARD_INFO");
			MCae436DAO dao = new MCae436DAO();
			ret = dao.getCardInfo(form, userId);
			helper.setListToDataset(ret, dSet);
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
		} finally {
			helper.close(dSet);
		}
		return mapping.findForward(strGo);
	}

	/**
	 * <p>
	 * 사은품 지급 등록
	 * </p>
	 * 
	 */
	public ActionForward save(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		int ret = 0;
		GauceHelper2 helper = null;
		GauceDataSet dSet[] = new GauceDataSet[3];
		MCae436DAO dao = new MCae436DAO();
		HttpSession session = request.getSession();
		String userId = null;
		MultiInput mi[] = new MultiInput[3];
		String strGiftName = "";
		try {
			SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
			userId = sessionInfo.getUSER_ID();
			helper = new GauceHelper2(request, response, form);
			
			dSet[0] = helper.getDataSet("DS_IO_SKU_LIST_ALL");
			dSet[1] = helper.getDataSet("DS_IO_SKU_LIST");
			dSet[2] = helper.getDataSet("DS_IO_SKU_LIST_CARD");

			for (int i = 0; i < mi.length; i++) {
				mi[i] = helper.getMutiInput(dSet[i]);
			}
			
			ret = dao.save(form, mi, userId);
			//strGiftName = mi[2].getString("SKU_NAME");
		} catch (Exception e) {
			logger.error("", e);
			helper.writeException("GAUCE", "002", e.getMessage());
			
		} finally {
			//helper.close(dSet, strGiftName + " 사은품이 지급 되었습니다.");
			helper.close(dSet, "사은품이 정상 지급 되었습니다.");
		}
		return mapping.findForward("save");
	}
}
