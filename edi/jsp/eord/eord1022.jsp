<!--
/*******************************************************************************
 * 시스템명 : 시스템명 : EDI > EDI > 전표출력
 * 작 성 일 : 2011.08.18
 * 작 성 자 : 김재겸
 * 수 정 자 :
 * 파 일 명 : eord1022.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 전표출력 전표 출력
 * 이    력 :
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"
 import="kr.fujitsu.ffw.base.BaseProperty,kr.fujitsu.ffw.util.String2,kr.fujitsu.ffw.control.ActionForm" %>
<%@ page import="ecom.util.Util" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="sun.misc.FormattedFloatingDecimal.Form"%>
<%@ page import="ecom.vo.SessionInfo2"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    String dir = request.getContextPath();

    // 리스트정보
    List masterList = (List)request.getAttribute("masterList");
    List detailList = (List)request.getAttribute("detailList");
    int masterCount = masterList.size();
    int detailCount = detailList.size();
    // 리스트 공백채우기
    masterList = listBlankAdd(masterList);
    detailList = listBlankAdd(detailList);

    // 파라미터정보
    String strStrCd = request.getParameter("StrCd");
    String strSlipNo = request.getParameter("SlipNo");
%>
<%!
//전역변수=======================================================
String loopFlag = "Y";
int fixLine = 15;
int preRow = 0;
int loopCnt = 0;
// 합계
double totalOrdQty = 0;
double totalNewCostAmt = 0;
double totalNewSaletAmt = 0;
//===============================================================

    // 테이블해더 구하기
    public String getTableHeader(Map map, int mstIdx, int loopIdx) {
        String content = "";
        String slipFlag = map.get("SLIP_FLAG").toString(); // 전표구분
        String skuFlag = map.get("SKU_FLAG").toString(); // 단품구분
        String strSlipFlag = "";
        String strSkuFlag = "";

        // 매입, 단품
        if (slipFlag.equals("A") && skuFlag.equals("1")) {
            strSlipFlag = "매입전표";

        // 매입, 비단품
        } else if (slipFlag.equals("A") && skuFlag.equals("2")) {
            strSlipFlag = "품목매입전표";

        // 반품, 단품
        } else if (slipFlag.equals("B") && skuFlag.equals("1")) {
            strSlipFlag = "반품전표";

        // 반품, 비단품
        } else if (slipFlag.equals("B") && skuFlag.equals("2")) {
            strSlipFlag = "품목반품전표";
        }

        if (loopIdx == 0) {
            strSkuFlag = "매입사용";
        } else if (loopIdx == 1) {
            strSkuFlag = "협력사용";
        } else {
            strSkuFlag = "재무팀용";
        }

        // 전표번호
        String strSlipNoFormat = map.get("SLIP_NO").toString().substring(0,4)+"-"+map.get("SLIP_NO").toString().substring(4,11);
        
        // 페이지 설정
        if (mstIdx > 0 || loopIdx > 0) {
            content += "<br style=\"overflow:hidden; height:0; line-height:0; page-break-before:always;\" />";
        }
        
        content += "<div id=\"slip_"+map.get("SLIP_NO")+"\">";
        content += "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"print_table\">";
        content += "  <colgroup>";
        content += "  <col width=\"80\" />";
        content += "  <col width=\"20%\" />";
        content += "  <col width=\"80\" />";        
        content += "  <col />";
        content += "  <col width=\"80\" />";
        content += "  <col width=\"12%\" />";
        content += "  <col width=\"80\" />";
        content += "  <col width=\"8%\" />";
        content += "  </colgroup>";
        content += "  <tbody>";
        content += "  <tr>";
        content += "    <th class=\"th_right\">발주일</th>";
        content += "    <td class=\"td_center\">"+getDateFormat(map.get("ORD_DT").toString())+"</td>";
        content += "    <td rowspan=\"2\" colspan=\"3\" class=\"td_center font_16_bold\">";
        content += "      ( "+map.get("BIZ_TYPE_NM")+" ) "+strSlipFlag+" <span class=\"font_15\">(거래명세서겸용)</span>";
        content += "      <p class=\"font_15_bold\">("+strSkuFlag+")</p>";
        content += "    </td>";
        content += "    <td rowspan=\"2\" colspan=\"3\" class=\"td_center\"><img src=\"/edi/eord102.eo?goTo=barcode&Data="+map.get("SLIP_NO")+"\" height=\"35\" alt=\""+map.get("SLIP_NO")+"\" /></td>";
        content += "  </tr>";
        content += "  <tr>";
        content += "    <th class=\"th_right\">점</th>";
        content += "    <td><span class=\"blank_text\">"+map.get("STR_CD")+"</span>"+map.get("STR_NM")+"</td>";
        content += "  </tr>";
        content += "  <tr>";
        content += "    <th class=\"th_right\">팀</th>";
        content += "    <td><span class=\"blank_text\">"+map.get("TEAM_CD")+"</span>"+map.get("TEAM_NM")+"</td>";
        content += "    <th class=\"th_right\">PC</th>";
        content += "    <td>"+map.get("PC_CD")+"&nbsp; "+map.get("PC_NM")+"</td>";
        content += "    <th class=\"th_right\">협력사</th>";
        content += "    <td>"+map.get("VEN_CD")+"&nbsp; "+map.get("VEN_NM")+"</td>";
        content += "    <th class=\"th_right\">PAGE</th>";
        content += "    <td class=\"td_center\">1/1</td>";
        content += "  </tr>";
        content += "  <tr>";
        content += "    <th class=\"th_right\">브랜드</th>";
        content += "    <td><span class=\"blank_text\">"+map.get("PUMBUN_CD")+"</span>"+map.get("PUMBUN_NM")+"</td>";
        content += "    <th class=\"th_right\">거래형태</th>";
        content += "    <td>"+map.get("BIZ_TYPE_NM")+" / "+map.get("TAX_FLAG_NM")+"</td>";
        if (skuFlag.equals("1")){
        content += "    <th class=\"th_right\">전표번호</th>";
        content += "    <td colspan=\"3\" class=\"td_center font_15_bold\">"+strSlipNoFormat+"</td>";
        } else {
        content += "    <th rowspan=\"2\" class=\"th_right\">전표번호</th>";
        content += "    <td rowspan=\"2\" colspan=\"3\" class=\"td_center font_20_bold\">"+strSlipNoFormat+"</td>";
        }
        content += "  </tr>";
        content += "  <tr>";
        content += "    <th class=\"th_right\">납품예정일</th>";
        content += "    <td class=\"td_center\">"+getDateFormat(map.get("DELI_DT").toString())+"</td>";
        if (skuFlag.equals("1")){
        content += "    <th class=\"th_right\">가격적용일</th>";
        content += "    <td class=\"td_center\">"+getDateFormat(map.get("NEW_PRC_APP_DT").toString())+"</td>";
        content += "    <th class=\"th_right\">지불구분</th>";
        content += "    <td colspan=\"3\">"+map.get("PAY_COND_NM")+"</td>";
        } else {
        content += "    <th class=\"th_right\">마진적용일</th>";
        content += "    <td class=\"td_center\">"+getDateFormat(map.get("MG_APP_DT").toString())+"</td>";
        }
        content += "  </tr>";
        content += "  </tbody>";
        content += "</table>";
        content += "</div>";

        return content;
    }

    // 테이블리스트 구하기
    public String getTableList(Map mstMap, List dtlList, int loopIdx) {
        NumberFormat NF = NumberFormat.getNumberInstance();
        DecimalFormat DF = new DecimalFormat("0.00");

        int dtlCnt = dtlList.size();
        String content = "";
        String skuFlag = mstMap.get("SKU_FLAG").toString(); // 단품구분

        // 단품
        String strTitleSkuCd = "단품코드";
        String strTitleSkuNm = "단품명";
        String strTitleRate = "차익율";
        // 비단품이면
        if (skuFlag.equals("2")){
            strTitleSkuCd = "품목코드";
            strTitleSkuNm = "품목명";
            strTitleRate = "마진율";
        }

        content += "<div style=\"margin-top:10px;\">";
        content += "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"print_table\">";
        content += "  <colgroup>";
        content += "  <col width=\"4%\" />";
        content += "  <col width=\"8%\" />";
        content += "  <col width=\"24%\" />";
        content += "  <col width=\"6%\" />";
        content += "  <col width=\"8%\" />";
        content += "  <col width=\"8%\" />";
        content += "  <col width=\"8%\" />";
        content += "  <col width=\"8%\" />";
        content += "  <col width=\"8%\" />";
        content += "  <col width=\"8%\" />";
        content += "  <col />";
        content += "  </colgroup>";
        content += "  <tbody>";
        content += "  <tr>";
        content += "    <th rowspan=\"2\">No</th>";
        content += "    <th rowspan=\"2\">"+strTitleSkuCd+"</th>";
        content += "    <th rowspan=\"2\">"+strTitleSkuNm+"</th>";
        content += "    <th rowspan=\"2\">단위</th>";
        content += "    <th rowspan=\"2\">수량</th>";
        content += "    <th colspan=\"2\">원가(VAT제외)</th>";
        content += "    <th colspan=\"2\">매가(VAT포함)</th>";
        content += "    <th rowspan=\"2\">"+strTitleRate+"(%)</th>";
        content += "    <th rowspan=\"2\">비고</th>";
        content += "  </tr>";
        content += "  <tr>";
        content += "    <th>단가</th>";
        content += "    <th>금액</th>";
        content += "    <th>단가</th>";
        content += "    <th>금액</th>";
        content += "  </tr>";
        
        if (dtlList != null && dtlCnt > 0) {
            int k = 1;
            int m = preRow;
            for (m = preRow; m < dtlCnt; m++) {
                Map dtlMap = (Map)dtlList.get(m);
                // 단품
                String strSkuCdValue = dtlMap.get("SKU_CD").toString();
                String strSkuNmValue = dtlMap.get("SKU_NM").toString();
                String strRateValue = dtlMap.get("NEW_GAP_RATE").toString();
                // 비단품이면
                if (skuFlag.equals("2")){
                    strSkuCdValue = dtlMap.get("PUMMOK_CD").toString();
                    strSkuNmValue = dtlMap.get("PUMMOK_NM").toString();
                    strRateValue = dtlMap.get("MG_RATE").toString();
                }

                // 마스터정보 같은자료 구하기
                if (mstMap.get("SLIP_NO").equals(dtlMap.get("SLIP_NO")) && k <= fixLine) {
                    preRow = m;    //이전 마지막 처리 저장
                	if (k < fixLine) {
                        // 합계구하기
                        double ordQty = Double.parseDouble(dtlMap.get("ORD_QTY").toString());
                        double newCostAmt = Double.parseDouble(dtlMap.get("NEW_COST_AMT").toString());
                        double newSaleAmt = Double.parseDouble(dtlMap.get("NEW_SALE_AMT").toString());
                        totalOrdQty += ordQty;
                        totalNewCostAmt += newCostAmt;
                        totalNewSaletAmt += newSaleAmt;
                		
                        content += "<tr>";
                        content += "  <td class=\"td_center\">"+((loopCnt*(fixLine-1))+k)+"</td>"; //실제 표기 행
                        content += "  <td class=\"td_center\">"+strSkuCdValue+"</td>";
                        content += "  <td>"+strSkuNmValue+"</td>";
                        content += "  <td>"+dtlMap.get("ORD_UNIT_NM")+"</td>";
                        content += "  <td class=\"td_right\">"+NF.format(ordQty)+"</td>";
                        content += "  <td class=\"td_right\">"+NF.format(Double.parseDouble(dtlMap.get("NEW_COST_PRC").toString()))+"</td>";
                        content += "  <td class=\"td_right\">"+NF.format(newCostAmt)+"</td>";
                        content += "  <td class=\"td_right\">"+NF.format(Double.parseDouble(dtlMap.get("NEW_SALE_PRC").toString()))+"</td>";
                        content += "  <td class=\"td_right\">"+NF.format(newSaleAmt)+"</td>";
                        content += "  <td class=\"td_right\">"+DF.format(Double.valueOf(strRateValue).doubleValue())+"</td>";
                        content += "  <td>"+dtlMap.get("REMARK")+"</td>";
                        content += "</tr>";
                        loopFlag = "N";
                	} else { //이 후 처리되어야 할 전표가 있을 때 
                		loopFlag = "Y";
                	}
                    k++;
                }
            }
            
            // 빈row생성
            int blankCnt = fixLine - k;
            if (blankCnt > 0) {
                for (m = 0; m < blankCnt; m++) {
                    content += "<tr>";
                    content += "  <td>&nbsp;</td>";
                    content += "  <td>&nbsp;</td>";
                    content += "  <td>&nbsp;</td>";
                    content += "  <td>&nbsp;</td>";
                    content += "  <td>&nbsp;</td>";
                    content += "  <td>&nbsp;</td>";
                    content += "  <td>&nbsp;</td>";
                    content += "  <td>&nbsp;</td>";
                    content += "  <td>&nbsp;</td>";
                    content += "  <td>&nbsp;</td>";
                    content += "  <td>&nbsp;</td>";
                    content += "</tr>";
                }
                // 해당전표의 값이 없을 시 초기화
                if (blankCnt == 14) {
                    //초기화
                    totalOrdQty = 0;
                    totalNewCostAmt = 0;
                    totalNewSaletAmt = 0;
                    loopCnt = 0;
                    preRow = 0;
                    loopFlag = "N";
                }
            } 

            // 합계(마지막 행에 합계처리)
            if (loopFlag.equals("N")) {
                content += "<tr>";
                content += "  <td>&nbsp;</td>";
                content += "  <td class=\"td_center\">합계</td>";
                content += "  <td>&nbsp;</td>";
                content += "  <td>&nbsp;</td>";
                content += "  <td class=\"td_right\">"+NF.format(totalOrdQty)+"</td>";
                content += "  <td>&nbsp;</td>";
                content += "  <td class=\"td_right\">"+NF.format(totalNewCostAmt)+"</td>";
                content += "  <td>&nbsp;</td>";
                content += "  <td class=\"td_right\">"+NF.format(totalNewSaletAmt)+"</td>";
                content += "  <td>&nbsp;</td>";
                content += "  <td>&nbsp;</td>";
                content += "</tr>";
                
                totalOrdQty = 0;
                totalNewCostAmt = 0;
                totalNewSaletAmt = 0;
                loopCnt = 0;
                preRow = 0;
            } else {
                content += "<tr>";
                content += "  <td colspan=11>&nbsp;</td>";
                content += "</tr>";
                loopCnt++;
            }
        // 조회된 행이 없는경우 빈값으로 처리
        } else {
            for (int j = 0; j < fixLine; j++) {
                content += "<tr>";
                content += "  <td>&nbsp;</td>";
                content += "  <td>&nbsp;</td>";
                content += "  <td>&nbsp;</td>";
                content += "  <td>&nbsp;</td>";
                content += "  <td>&nbsp;</td>";
                content += "  <td>&nbsp;</td>";
                content += "  <td>&nbsp;</td>";
                content += "  <td>&nbsp;</td>";
                content += "  <td>&nbsp;</td>";
                content += "  <td>&nbsp;</td>";
                content += "  <td>&nbsp;</td>";
                content += "</tr>";
            }
            //마지막행 처리
            content += "<tr>";
            content += "  <td colspan=11>&nbsp;</td>";
            content += "</tr>";
            
            //초기화
            totalOrdQty = 0;
            totalNewCostAmt = 0;
            totalNewSaletAmt = 0;
            loopCnt = 0;
            preRow = 0;
            loopFlag = "N";
        }
        content += "  </tbody>";
        content += "</table>";
        content += "</div>";

        return content;
    }

    // 테이블풋터 구하기
    public String getTablefooter(Map map, int loopIdx) {
        NumberFormat NF = NumberFormat.getNumberInstance();
        DecimalFormat DF = new DecimalFormat("0.00");

        String content = "";

        content += "<div style=\"margin-top:10px;\">";
        content += "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"print_table\">";
        content += "  <colgroup>";
        content += "  <col width=\"90\" />";
        content += "  <col width=\"14%\" />";
        content += "  <col width=\"90\" />";
        content += "  <col />";
        content += "  <col width=\"90\" />";
        content += "  <col width=\"14%\" />";
        content += "  </colgroup>";
        content += "  <tbody>";
        content += "  <tr>";
        content += "    <th class=\"th_right\">사업자등록번호</th>";
        content += "    <td class=\"td_center\">"+map.get("COMP_NO")+"</td>";
        content += "    <th class=\"th_right\">상호</th>";
        content += "    <td><p style=\"float:left;\">"+map.get("COMP_NAME")+"</p><p style=\"font-weight:bold; text-align:right;\">(인)</p></td>";
        content += "    <th class=\"th_right\">부가가치세</th>";
        content += "    <td class=\"td_right\">"+NF.format(Double.parseDouble(map.get("VAT_TAMT").toString()))+"</td>";
        content += "  </tr>";
        content += "  <tr>";
        content += "    <th class=\"th_right\">대표자</th>";
        content += "    <td>"+map.get("REP_NAME")+"</td>";
        content += "    <th class=\"th_right\">사업장</th>";
        content += "    <td>"+map.get("ADDRESS")+"</td>";
        content += "    <th class=\"th_right\">점출차익액</th>";
        content += "    <td class=\"td_right\">"+NF.format(Double.parseDouble(map.get("GAP_TOT_AMT").toString()))+"</td>";
        content += "  </tr>";
        content += "  <tr>";
        content += "    <th class=\"th_right\">업태</th>";
        content += "    <td>"+map.get("BIZ_STAT")+"</td>";
        content += "    <th class=\"th_right\">종목</th>";
        content += "    <td>"+map.get("BIZ_CAT")+"</td>";
        content += "    <th class=\"th_right\">합계차익율(%)</th>";
        content += "    <td class=\"td_right\">"+DF.format(Double.valueOf(map.get("NEW_GAP_RATE").toString()).doubleValue())+"</td>";
        content += "  </tr>";
        content += "  <tr>";
        content += "    <th class=\"th_right\">협력사 연락처</th>";
        content += "    <td>"+map.get("FAX_NO")+"</td>";
        content += "    <th class=\"th_right\">비고</th>";
        content += "    <td>"+map.get("REMARK")+"</td>";
        content += "    <th class=\"th_right\">검품확정일</th>";
        content += "    <td class=\"td_center\">"+map.get("CHK_DT")+"</td>";
        content += "  </tr>";
        content += "  </tbody>";
        content += "</table>";
        content += "</div>";

        content += "<div class=\"margin_top_10\">";
        content += "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">";
        content += "  <colgroup>";
        content += "  <col width=\"45%\" />";
        content += "  <col width=\"35%\" />";
        content += "  <col />";
        content += "  <tr>";
        content += "    <td>";
        content += "      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"print_table\">";
        content += "        <colgroup>";
        content += "        <col width=\"30\" />";
        content += "        <col width=\"30%\" />";
        content += "        <col width=\"30%\" />";
        content += "        <col />";
        content += "        </colgroup>";
        content += "        <tbody>";
        content += "        <tr>";
        content += "          <td rowspan=\"2\" valign=\"middle\" class=\"td_center print_font_bold\">영<br />업<br />팀<br /></td>";
        content += "          <td class=\"td_center print_font_bold\">SM</td>";
        content += "          <td class=\"td_center print_font_bold\">영업팀장</td>";
        content += "          <td class=\"td_center print_font_bold\">점장</td>";
        content += "        </tr>";
        content += "        <tr>";
        content += "          <td class=\"td_rowspan2\">&nbsp;</td>";
        content += "          <td>&nbsp;</td>";
        content += "          <td>&nbsp;</td>";
        content += "        </tr>";
        content += "        </tbody>";
        content += "      </table>";
        content += "    </td>";
        content += "    <td style=\"padding:0 10px;\">";
        content += "      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"print_table\">";
        content += "        <colgroup>";
        content += "        <col width=\"30\" />";
        content += "        <col width=\"45%\" />";
        content += "        <col />";
        content += "        </colgroup>";
        content += "        <tbody>";
        content += "        <tr>";
        content += "          <td rowspan=\"2\" valign=\"middle\" class=\"td_center print_font_bold\">매<br />입<br />팀<br /></td>";
        content += "          <td class=\"td_center print_font_bold\">바이어</td>";
        content += "          <td class=\"td_center print_font_bold\">매입팀장</td>";
        content += "        </tr>";
        content += "        <tr>";
        content += "          <td class=\"td_rowspan2\">&nbsp;</td>";
        content += "          <td>&nbsp;</td>";
        content += "        </tr>";
        content += "        </tbody>";
        content += "      </table>";
        content += "    </td>";
        content += "    <td>";
        content += "      <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"print_table\">";
        content += "        <colgroup>";
        content += "        <col width=\"30\" />";
        content += "        <col />";
        content += "        </colgroup>";
        content += "        <tbody>";
        content += "        <tr>";
        content += "          <td rowspan=\"2\" valign=\"middle\" class=\"td_center print_font_bold\">검<br />품<br />팀<br /></td>";
        content += "          <td class=\"td_center print_font_bold\">검품</td>";
        content += "        </tr>";
        content += "        <tr>";
        content += "          <td class=\"td_rowspan2\">&nbsp;</td>";
        content += "        </tr>";
        content += "        </tbody>";
        content += "      </table>";
        content += "    </td>";
        content += "  </tr>";
        content += "</table>";
        content += "</div>";

        return content;
    }

     // 날자포맷 구하기
     public String getDateFormat(String date) {
         String strDate = "&nbsp;";
         String tempDate = date.trim();
         if (tempDate.length() == 8) {
             strDate = tempDate.substring(0,4)+"/"
                     + tempDate.toString().substring(4,6)+"/"
                     + tempDate.toString().substring(6,8) ;
         }

         return strDate;
     }

     // 리스트 공백채우기
     public List listBlankAdd(List obj) {
         for (int j = 0; j < obj.size(); j++) {
             Map tmpMap = (Map) obj.get(j);
             Iterator iter = tmpMap.keySet().iterator();
             while (iter.hasNext()) {
                 String key = (String) iter.next();
                 String value = (String) tmpMap.get(key);
                 if (value.trim().length() == 0) {
                     tmpMap.put(key, "&nbsp;");
                 }
             }
             obj.set(j, tmpMap);
         }

         return obj;
     }
%>
<html>
<ajax:library />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>전표출력</title>
<link href="<%=dir%>/css/ds.css" rel="stylesheet" type="text/css" />
<script language="javascript" src="<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script type="text/javascript">
var globalStrCd= "<%= strStrCd %>";
var globalSlipNo = "<%= strSlipNo %>";
var master;
var detail;
var masterRow = 0;
var detailRow = 0;

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-04-18
 * 개    요 : 해당 페이지 LOAD 시
 * return값 : void
 */

function doinit(){

}

// 프린트
function btn_Print() {
    pageprint();
}

// 창닫기
function btn_Close() {
    window.close();
}

// 스크롤
function scrollAll() {
    document.getElementById("topTitle").scrollLeft = document.getElementById("DIV_Content").scrollLeft;
}

var initBody;
function beforePrint() {
    initBody = document.body.innerHTML;
    document.body.innerHTML = document.getElementById("print_content").innerHTML;
}

function afterPrint() {
    document.body.innerHTML = initBody;
}

function pageprint() {
    window.onbeforeprint = beforePrint;
    window.onafterprint = afterPrint;
    window.print();
}
</script>

<style type="text/css">
div { float:none; }
p { margin:0; padding:0; }
.margin_top_10 { margin:10px 0; }

.print_table { width:100%; border:solid 1px #b4d0e1; font-size:12px; }
.print_table th { height:22px; padding:0 5px; border:1px solid #b4d0e1; background-color:#ebf2f8; color:#146ab9; letter-spacing:-0.1ex; font-size:12px; font-weight:normal; text-align:center; }
.print_table th.th_right { text-align:right; }
.print_table td { height:22px; padding:0 5px; border:1px solid #b4d0e1; background-color:#fff; letter-spacing:-0.1ex; font-size:12px; font-weight:normal; text-align:left; }
.print_table td.td_right { text-align:right; }
.print_table td.td_center { text-align:center; }
.print_table td.td_blank_left { border-left:1px solid #fff; }
.print_table td.td_blank_right { border-right:1px solid #fff; }
.print_table td.td_rowspan2 { height:44px; }

.print_table .font_15_bold { font-size:15px; font-weight:bold; }
.print_table .font_16_bold { font-size:16px; font-weight:bold; }
.print_table .font_20_bold { font-size:20px; font-weight:bold; }
.print_table .font_15 { font-size:15px; font-weight:normal; }
.print_table .font_16 { font-size:16px; font-weight:normal; }
.print_table .font_bold { font-weight:bold; }

.print_table .text_center { text-align:center; }
.print_table .blank_text { width:70px; margin-right:10px; text-align:right; }

#print_wrap { overflow:scroll; width:805px; height:546px; padding:10px; border:1px solid #abbdd0; }
#print_content { width:930px; }

@media print {
  #print_content { width:100%; margin:0; padding:0; }
  .margin_top_10 { margin:10px 0 2px 0; }

  .print_table { width:100%; border:solid 1px #000; font-size:11px; }
  .print_table th { height:21px; padding:0 5px; border:solid 1px #000; background-color:#eee; color:#000; letter-spacing:-0.1ex; font-size:11px; font-weight:bold; text-align:center; }
  .print_table th.th_right { text-align:right; }
  .print_table td { height:21px; padding:0 5px; border:solid 1px #000; background-color:#fff; letter-spacing:-0.1ex; font-size:11px; font-weight:normal; text-align:left; }
  .print_table td.td_right { text-align:right; }
  .print_table td.td_center { text-align:center; }
  .print_table td.td_rowspan2 { height:42px; }

  .print_table .print_font_bold { font-weight:bold; }
}
</style>
</head>
<body onload="doinit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="pop01"></td>
    <td class="pop02"></td>
    <td class="pop03"></td>
  </tr>
  <tr>
    <td class="pop04"></td>
    <td>
      <!-- wrap -->
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <colgroup>
        <col width="148" />
        <col />
        </colgroup>
        <tr>
          <td colspan="2">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="396" class="title"><img src="<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05 PL03" /> 전표출력</td>
                <td>
                  <table border="0" align="right"cellpadding="0" cellspacing="0">
                    <tr valign="top">
                      <td height="25"><img src="<%=dir%>/imgs/btn/print.gif" width="50" height="22" alt="프린트" onclick="btn_Print(); return false;" /></td>
                      <td><img src="<%=dir%>/imgs/btn/close.gif" width="50" height="22" alt="닫기" onclick="btn_Close(); return false;" /></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr valign="top">
          <td>
            <table width="100%"  border="0" cellspacing="0" cellpadding="0" class="BD4A">
              <tr valign="top">
                <td>
                  <div id="topTitle" style="width:153px;overflow:hidden;">
                    <table width="153" cellpadding="0" cellspacing="0" border="0" class="g_table">
                      <colgroup>
                      <col width="35" />
                      <col width="90" />
                      <col />
                      </colgroup>
                      <tr>
                        <th>NO </th>
                        <th>전표번호</th>
                        <th>&nbsp;</th>
                      </tr>
                    </table>
                  </div>
                </td>
              </tr>
              <tr>
                <td>
                  <div id="print_left" style="width:153px;height:514px;overflow:scroll;overflow-x:hidden;" >
                    <table width="153" cellspacing="0" cellpadding="0" border="0" class="g_table">
                      <colgroup>
                      <col width="35" />
                      <col width="90" />
                      <col />
                      </colgroup>
                      <tbody>
                      <%
                        for (int m = 0; m < masterCount; m++) {
                            Map masterMap = (Map)masterList.get(m);
                            String slipNoFormat = masterMap.get("SLIP_NO").toString().substring(0,4)+"-"
                                                + masterMap.get("SLIP_NO").toString().substring(4,11);
                      %>
                      <tr>
                        <td class="r1"><%= m+1 %></td>
                        <td class="r1"><a href="#slip_<%= masterMap.get("SLIP_NO") %>"><%= slipNoFormat %></a></td>
                        <td>&nbsp;</td>
                      </tr>
                      <%
                        }
                      %>
                      </tbody>
                    </table>
                  </div>
                </td>
              </tr>
            </table>
          </td>
          <td align="left" class="PL10">
            <div id="print_wrap">
              <div id="print_content">
              <% 
	              int maxLoop = ((int)Math.floor(detailCount/14))+1;
                  for (int k = 0; k < masterCount; k++) {
                      Map masterMap = (Map)masterList.get(k);
                      
                      //매입사용
                      loopFlag = "Y";
                      for (int m = 0; m < maxLoop; m++) {
                    	  if (loopFlag.equals("N")) break;
                          // header
                          out.println(getTableHeader(masterMap, k, 0));
                          // list
                          out.println(getTableList(masterMap, detailList, 0));
                          // footer
                          out.println(getTablefooter(masterMap, 0));
                      }
                      
                      //협력사용
                      loopFlag = "Y";
                      for (int m = 0; m < maxLoop; m++) {
                    	  if (loopFlag.equals("N")) break;
                          // header
                          out.println(getTableHeader(masterMap, k, 1));
                          // list
                          out.println(getTableList(masterMap, detailList, 1));
                          // footer
                          out.println(getTablefooter(masterMap, 1));
                      }
                      
                      //재무팀용
                      loopFlag = "Y";
                      for (int m = 0; m < maxLoop; m++) {
                    	  if (loopFlag.equals("N")) break;
                          // header
                          out.println(getTableHeader(masterMap, k, 2));
                          // list
                          out.println(getTableList(masterMap, detailList, 2));
                          // footer
                          out.println(getTablefooter(masterMap, 2));
                      }
                  }
              %>
              </div>
            </div>
          </td>
        </tr>
      </table>
      <!-- //wrap -->
    </td>
    <td class="pop06"></td>
  </tr>
  <tr>
     <td class="pop07"></td>
     <td class="pop08"></td>
     <td class="pop09"></td>
  </tr>
</table>
</body>
</html>
