package esal.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.control.ActionForward;
import kr.fujitsu.ffw.control.ActionMapping;
import kr.fujitsu.ffw.control.ActionUtil;
import kr.fujitsu.ffw.control.DispatchAction;
import kr.fujitsu.ffw.util.String2;

import org.apache.log4j.Logger;

import ecom.vo.SessionInfo2;
import esal.dao.Esal107DAO;

public class Esal107Action extends DispatchAction 
{
	/*
	 * Java Pattern 에서 지원하는 logger를 사용할 수 있도록 객체를 선언
	 */
	private Logger logger = Logger.getLogger(Esal105Action.class);

	/**
	 * <p>메뉴를 보여준다.</p>
	 * 
	 */
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String strGoto = form.getParam("goTo");
		
		try {
			
			HttpSession session = request.getSession();
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("", e);
		}
        
		return mapping.findForward(strGoto);
	}
	
	/**
	 * <p>조회</p>
	 * 
	 */
	public ActionForward getMaster(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Esal107DAO dao = null;
		StringBuffer sb = new StringBuffer();
		
		String strGoto = form.getParam("goTo");
		
		try{

			dao = new Esal107DAO();
			
			sb = dao.getMaster(form);  
			
		}catch(Exception e){
			e.printStackTrace();
			
		}

		
		ActionUtil.sendAjaxResponse(response, sb);
		return mapping.findForward(strGoto);
	}
	
	/**
	 * 엑셀다운로드화면 호출
	 */
	public ActionForward getExcel(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		List rt = null;
		Esal107DAO dao = null;
		
		//Excel 저장시간
		Date today = new Date();
		SimpleDateFormat dateTime = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		SimpleDateFormat dateTime2 = new SimpleDateFormat("yyyyMMddHHmmss");
		String nowTime = dateTime.format(today);
		String nowTimeFileNm = dateTime2.format(today);
		
		StringBuffer sb =  new StringBuffer();
		response.setCharacterEncoding("ISO-8859-1");  //클라이언트가 서버에보내는 문자 인코딩
		response.setHeader("Content-Disposition", "attachment;filename=기간별단품매출현황_"+nowTimeFileNm+".xls");
		response.setHeader("Content-Description", "JSP Generated Data");
		response.setContentType("application/vnd.ms-excel");
		//response.setContentType("text/html;charset=utf-8");  //텍스트나 HTML문서이면서 문자인코딩은 uft8로 전송
		response.setContentType("text/html;charset=ISO-8859-1");  //텍스트나 HTML문서이면서 문자인코딩은 ISO-8859-1 전송
		try{ 
			String strCd    = String2.nvl(form.getParam("strCd"));			//점코드
			String venCd    = String2.nvl(form.getParam("venCd"));			//협력사코드
			String pumbunCd = String2.nvl(form.getParam("pumbunCd"));		//품번코드
			String pummokCd = String2.nvl(form.getParam("pummokCd"));		//품목코드
			String sDate    = String2.nvl(form.getParam("sDate"));			//일자
			String stkYm    = String2.nvl(form.getParam("stkYm"));			//년도
			String stkSDt   = String2.nvl(form.getParam("stkSDt"));			//시작일
			
			//품목,품번코드
			String pCd		= pumbunCd;
			String pNm		= "품번";
			if (pumbunCd.equals("") || pumbunCd.equals(null)) pCd = pummokCd; pNm = "품목";
			
			dao = new Esal107DAO();
			rt = dao.getExcel(form);
			
			if (rt.size() < 1) {
				/*
				sb.append("<script> ");
				sb.append("alert('조회된 내역이 없습니다.');");
				sb.append("</script>");
				 */
			} else {
				sb.append("<%@ page language=\"java\" contentType=\"text/html;charset=utf-8\"%>");
				sb.append("<html>");
				sb.append("<head>");
				sb.append("<title></title>");
				//sb.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">");
				//sb.append("<meta http-equiv=\"Content-Type\" content=\"application/vnd.ms-excel; charset=utf-8\">");
				sb.append("<body>");
				sb.append("    <table border=1 width='1870'>");
				sb.append("        <tr style='color:black; font-weight:bold;' bgcolor=#CACACA>");
				sb.append("            <td colspan=20 align='center'><H3>단품별장부재고조회</H3></td> ");
				sb.append("        </tr> ");
				sb.append("        <tr style='color:black; font-weight:bold;' bgcolor=#CACACA>");
				sb.append("            <td colspan=20 align='left'>*점코드 : "+strCd+" |  *협력사코드 : "+venCd+" |  *"+pNm+"코드 : "+pCd+" |  *일자 : "+sDate+" |  *년도 : "+stkYm+" |  *시작일 : "+stkSDt+" |  *저장일자 : "+nowTime+" </td> ");
				sb.append("        </tr> ");
				sb.append("        <tr style='color:black; font-weight:bold;'>");
				sb.append("            <td rowspan='2' width='40'>NO</td>");
				sb.append("            <td rowspan='2' width='70'>품번코드</td>");
				sb.append("            <td rowspan='2' width='190'>품번명</td>");
				sb.append("            <td rowspan='2' width='80'>품목코드</td>");
				sb.append("            <td rowspan='2' width='190'>품목명</td>");
				sb.append("            <td rowspan='2' width='120'>단품코드</td>");
				sb.append("            <td rowspan='2' width='190'>단품명</td>");
				sb.append("            <td colspan='2' width='150'>기초재고</td>");
				sb.append("            <td colspan='2' width='150'>매입</td>");
				sb.append("            <td colspan='2' width='150'>매출</td>");
				sb.append("            <td colspan='2' width='150'>재고조정</td>");
				sb.append("            <td colspan='2' width='150'>기말재고</td>");
				sb.append("            <td rowspan='2' width='120'>소스마킹</td>");
				sb.append("            <td rowspan='2' width='60'>판매<br>단위</td>");
				sb.append("            <td rowspan='2' width='60'>구성<br>단위</td>");
				sb.append("        </tr> ");
				
				sb.append("        <tr style='color:black; font-weight:bold;'>");
				sb.append("            <td width='50'>수량</td>");
				sb.append("            <td width='100'>금액</td>");
				sb.append("            <td width='50'>수량</td>");
				sb.append("            <td width='100'>금액</td>");
				sb.append("            <td width='50'>수량</td>");
				sb.append("            <td width='100'>금액</td>");
				sb.append("            <td width='50'>수량</td>");
				sb.append("            <td width='100'>금액</td>");
				sb.append("            <td width='50'>수량</td>");
				sb.append("            <td width='100'>금액</td>");
				sb.append("        </tr> ");
				
				List colRt = null;
				int a1 = 0;
				int a2 = 0;
				int b1 = 0;
				int b2 = 0;
				int c1 = 0;
				int c2 = 0;
				int d1 = 0;
				int d2 = 0;
				int e1 = 0;
				int e2 = 0;
				for (int i=0; i<rt.size(); i++) {
					sb.append("        <tr>");
					colRt = (List) rt.get(i);
					sb.append("            <td>"+(i+1)+"</td>");
					for (int r=0; r<colRt.size(); r++) {
						if (5<r && 16>r) {
							sb.append("            <td>"+colRt.get(r)+"</td>");
						} else {
							sb.append("            <td style='mso-number-format:\\@'>"+colRt.get(r)+"</td>");
						}
					}
					//합계계산
					a1+= Integer.parseInt((String) colRt.get(6));	//기초재고 수량
					a2+= Integer.parseInt((String) colRt.get(7));	//기초재고 금액
					b1+= Integer.parseInt((String) colRt.get(8));	//매입 수량
					b2+= Integer.parseInt((String) colRt.get(9));	//매입 금액
					c1+= Integer.parseInt((String) colRt.get(10));	//매출 수량
					c2+= Integer.parseInt((String) colRt.get(11));	//매출 금액
					d1+= Integer.parseInt((String) colRt.get(12));	//재고조정 수량
					d2+= Integer.parseInt((String) colRt.get(13));	//재고조정 금액
					e1+= Integer.parseInt((String) colRt.get(14));	//기말재고 수량
					e2+= Integer.parseInt((String) colRt.get(15));	//기말재고 금액
					
					sb.append("        </tr> ");
				}
				sb.append("        <tr bgcolor=#b9d9ea> ");
				sb.append("            <td colspan='7' align='center' >합계</td>");
				sb.append("            <td>"+a1+"</td>");
				sb.append("            <td>"+a2+"</td>");
				sb.append("            <td>"+b1+"</td>");
				sb.append("            <td>"+b2+"</td>");
				sb.append("            <td>"+c1+"</td>");
				sb.append("            <td>"+c2+"</td>");
				sb.append("            <td>"+d1+"</td>");
				sb.append("            <td>"+d2+"</td>");
				sb.append("            <td>"+e1+"</td>");
				sb.append("            <td>"+e2+"</td>");
				sb.append("            <td colspan='3' align='center' ></td>");
				sb.append("        </tr> ");
				sb.append("    </table> ");
				sb.append("</body> ");
				sb.append("</html>");
			}
			response.getWriter().println(new String(sb.toString().getBytes(), "iso-8859-1"));
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return mapping.findForward("excelDowns");
	}
}
