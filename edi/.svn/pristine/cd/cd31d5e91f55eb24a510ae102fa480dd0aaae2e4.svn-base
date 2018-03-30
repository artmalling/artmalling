<!-- 
/*******************************************************************************
 * 시스템명 : 단품코드(점별) 조회  팝업
 * 작 성 일 : 2011.08.20
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : ccom0040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 단품코드(점별)코드 조회 팝업
 * 이    력 :
 ******************************************************************************/
--> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="kr.fujitsu.ffw.base.BaseProperty,kr.fujitsu.ffw.util.String2,kr.fujitsu.ffw.control.ActionForm"%>
<%@ page import="ecom.util.Util"%>
<%@ page import="java.util.*"%>
<%@ page import="sun.misc.FormattedFloatingDecimal.Form"%>
<%@ page import="ecom.vo.SessionInfo2"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/ajax-lib.tld" prefix="ajax"%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<%
    String dir = request.getContextPath();

    SessionInfo2 sessionInfo = (SessionInfo2) session.getAttribute("sessionInfo2");
    String USER_ID = sessionInfo.getUSER_ID();                      // 사용자아이디
    String STR_CD  = sessionInfo.getSTR_CD();                       // 점코드
    String STR_NM  = sessionInfo.getSTR_NM();                       // 점명
    String VEN_CD  = sessionInfo.getVEN_CD();                       // 협력사코드
    String VEN_NM  = sessionInfo.getVEN_NAME();                     // 협력사명
    String GB      = sessionInfo.getGB();                           // 1. 협력사     2.브랜드
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<ajax:library />
<head>
<title>단품코드 -POPUP</title>
<link href="/edi/css/ds.css" rel="stylesheet" type="text/css" />
<script language="javascript"  src="/edi/js/common.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

 var returnParam    = dialogArguments[0];
 var skuCd          = dialogArguments[1];
 var skuNm          = dialogArguments[2];
 var authGb         = dialogArguments[3];
 var multiGb        = dialogArguments[4];
 var addCondition   = dialogArguments[5];

/**
 * doInit()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-20
 * 개    요    : initialize
 * return값 : void
**/
function doInit(){
	 
	 frm.s_sku_cd.value     = skuCd;
	 frm.s_sku_nm.value     = skuNm;
	 frm.auth_gb.value      = authGb;
	 frm.addCondition.value = addCondition;
	 
	 frm.s_sku_cd.focus();
	 
	 if(multiGb == "M"){
		 document.getElementById("divTitle1").style.display ="";       
		 document.getElementById("divTitle2").style.display ="none";
	 }else{
		 document.getElementById("divTitle1").style.display ="none";       
         document.getElementById("divTitle2").style.display ="";
	 }
	 
	 if(skuCd.length > 0 || skuNm.length > 0   ){
        btn_Search();
    }
} 
    
/*************************************************************************
 * 2. 공통버튼
    (1) 조회       - btn_Search(), subQuery()
    (2) 신규       - btn_New()
    (3) 삭제       - btn_Delete()
    (4) 저장       - btn_Save()
    (5) 엑셀       - btn_Excel()
    (6) 출력       - btn_Print()
    (7) 확정       - btn_Conf()
*************************************************************************/ 
/**
 * btn_Search()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-08-20
 * 개    요    : 점별 단품코드 조회
 * return값 : void
**/
function btn_Search() 
{ 
	 var skuCd = frm.s_sku_cd.value;    
	 var skuNm = frm.s_sku_nm.value;    
	 var auth  = frm.auth_gb.value;     
	 var cond  = frm.addCondition.value;
    
	 var param   = "&goTo=searchOnPop"
				 + "&skuCd="         + skuCd
		         + "&skuNm="         + skuNm
		         + "&auth="          + auth
		         + "&cond="          + cond;

	<ajax:open callback="on_searchOnPopXML" 
	 param    ="param" 
	 method   ="POST" 
	 urlvalue ="/edi/ccom004.cc"/>
	
	<ajax:callback function="on_searchOnPopXML"> 
	 
	var content = "";
	var tmpArr = new Array(); 
    if( rowsNode.length > 0 ){
    	content =  "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_detail'>";
        for( var i = 0; i < rowsNode.length; i++ ){
            for( var j = 0; j < rowsNode[i].childNodes.length; j++ ){
                tmpArr[j] = rowsNode[i].childNodes[j].childNodes[0].nodeValue == "null" ? "" : String(rowsNode[i].childNodes[j].childNodes[0].nodeValue);
            }
            // 조회내용리스트 스크립트 생성
            content += setList(i, tmpArr);
        }
        content += "</table>";
        document.getElementById("divContent").innerHTML = content;
    }
	</ajax:callback>
}
/**
* setList(row, tmpArr)
* 작 성 자 : 김경은
* 작 성 일 : 2011-08-20
* 개    요   : 조회내용 리스트 생성 
* return : void
*/
function setList(row, tmpArr){
    var tmpContent = "";
    var col        = 0;
    // tmpArr[]
    //  단품코드[0]       ,단품명[1]        ,영수증명   [2]      ,브랜드코드   [3]      ,브랜드명    [4]    
    // ,품목코드   [5]      ,판매단위   [6]     ,구성규격   [7]      ,구성규격단위 [8]   ,상품권금종  [9]    
    // ,스타일코드  [10]   ,칼라코드   [11]     ,사이즈코드  [12]   ,단품종류   [13]  

    tmpContent +=  "<tr   onMouseOver='setRowBgColor("+row+",0);' onMouseOut='setRowBgColor("+row+",1);' ondblclick='doDoubleClick("+row+");' >";
    tmpContent += "     <input type='hidden' name='d_recp_name'     id='d_recp_name"+row+"'     value='"+tmpArr[2]+"'  />";   // 영수증명
    tmpContent += "     <input type='hidden' name='d_pumbun_cd'     id='d_pumbun_cd"+row+"'     value='"+tmpArr[3]+"'  />";   // 브랜드코드
    tmpContent += "     <input type='hidden' name='d_pumbun_name'   id='d_pumbun_name"+row+"'   value='"+tmpArr[4]+"'  />";   // 브랜드명
    tmpContent += "     <input type='hidden' name='d_pummok_cd'     id='d_pummok_cd"+row+"'     value='"+tmpArr[5]+"'  />";   // 품목
    tmpContent += "     <input type='hidden' name='d_sale_unit_cd'  id='d_sale_unit_cd"+row+"'  value='"+tmpArr[6]+"'  />";   // 판매단위
    tmpContent += "     <input type='hidden' name='d_cmp_spec_cd'   id='d_cmp_spec_cd"+row+"'   value='"+tmpArr[7]+"'  />";   // 구성규격
    tmpContent += "     <input type='hidden' name='d_cmp_spec_unit' id='d_cmp_spec_unit"+row+"' value='"+tmpArr[8]+"' />";    // 구성구격단위
    tmpContent += "     <input type='hidden' name='d_gift_amt_type' id='d_gift_amt_type"+row+"' value='"+tmpArr[9]+"' />";    // 상품권금종
    tmpContent += "     <input type='hidden' name='d_style_cd'      id='d_style_cd"+row+"'      value='"+tmpArr[10]+"' />";   // 스타일코드
    tmpContent += "     <input type='hidden' name='d_color_cd'      id='d_color_cd"+row+"'      value='"+tmpArr[11]+"' />";   // 칼라코드
    tmpContent += "     <input type='hidden' name='d_size_cd'       id='d_size_cd"+row+"'       value='"+tmpArr[12]+"' />";   // 사이즈코드
    tmpContent += "     <input type='hidden' name='d_sku_type'      id='d_sku_type"+row+"'      value='"+tmpArr[13]+"' />";   // 단품종류
    
    if(multiGb == "M")
        tmpContent += "     <td class='r1' width='30'><input type='checkbox' name='d_check'  id='d_check"+row+"'  value='' style='width:25;text-align:center;'/></td>";
    
    tmpContent += "     <td class='r1' width='90' name='d_skuCd'  id='d_skuCd"+row+"'>"+tmpArr[0]+"</td>";
    tmpContent += "     <td class='r3' title="+tmpArr[1]+" name='d_skuNm' id='d_skuNm"+row+"'>"+tmpArr[1]+"</td>";
    //tmpContent += "     <td class='r1' width='90'><input type='text'     name='d_skuCd'  id='d_skuCd"+row+"'  value='"+tmpArr[0]+"' style='width:90;text-align:center;' disabled='disabled' /></td>";
    //tmpContent += "     <td class='r1' title="+tmpArr[1]+" ><input type='text' name='d_skuNm'      id='d_skuNm"+row+"'      value='"+tmpArr[1]+"' style='width:170;text-align:left;' maxlength='40' disabled='disabled'/></td>";
    tmpContent += "</tr>";
    return tmpContent; 
}
/*************************************************************************
 * 3. 함수
*************************************************************************/

/**
 * btn_Close()
 * 작 성 자 : ckj
 * 작 성 일 : 2006.07.12
 * 개    요 : Close
 * return값 : void
**/  
function btn_Close()
{
    window.close();
}

/**
 * btn_Conf()
 * 작 성 자 : 정진영
 * 작 성 일 : 2011.02.21
 * 개    요 : 확인버튼 클릭 처리
 * return값 : void
**/  
function btn_Conf(){
    if( multiGb == "M"){
    	var idx = 0;
    	var len = frm.d_check.length;
        for( var i = 0; i<len; i++){
        	if( frm.d_check[i].checked){
        		var skuCd  = document.getElementById("d_skuCd"+i).innerText;
        	    var skuNm  = document.getElementById("d_skuNm"+i).innerText;
        		var objJson = "[{";
                objJson += "'SKU_CD':'"+skuCd+"',";
                objJson += "'SKU_NM':'"+skuNm+"'";
                objJson += "}]"; 
                returnParam[idx++] = eval(objJson)[0]; 
        	}
        }
        window.returnValue = true;
        window.close();      
    }
}    
/**
 * doDoubleClick(row)
 * 작 성 자 : 김경은
 * 작 성 일 : 2011.08.10
 * 개    요 : 더블클릭 처리
 * return값 : void
**/  
function doDoubleClick(row){
     var skuCd  = document.getElementById("d_skuCd"+row).innerText;
     var skuNm  = document.getElementById("d_skuNm"+row).innerText;
     if( multiGb == "M"){
         var objJson = "[{";
         objJson += "'SKU_CD':'"+skuCd+"',";
         objJson += "'SKU_NM':'"+skuNm+"'";
         objJson += "}]"; 
         returnParam[0] = eval(objJson)[0];
     }else{
         returnParam.put("SKU_CD", skuCd);
         returnParam.put("SKU_NM", skuNm);
     }
     
         
     window.returnValue = true;
     window.close();
}
    
/**
* scrollControl()
* 작 성 자 : 김경은
* 작 성 일 : 2011-08-20
* 개    요   : 왼쪽 리스트 스크롤바 Control 
* return : void
*/
function scrollControl(flag){
        document.all.divTitle.scrollLeft = document.all.divContent.scrollLeft;
}

/**
* setRowBgColor(row,flag)
* 작 성 자 : 김경은
* 작 성 일 : 2011-08-20
* 개    요   : 선택된 Row의 BGColor를 변경한다.
*         row      : 선택 Row
*         flag     : over(0), out(1)
* return : void
*/
function setRowBgColor(row,flag) {
	var color = flag == "0" ? "#fff56E":"#ffffff";
	if( multiGb == "M")
	    document.getElementById("d_check"+row).style.backgroundColor = color;
	
    document.getElementById("d_skuCd"+row).style.backgroundColor = color;
    document.getElementById("d_skuNm"+row).style.backgroundColor = color;
}

</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body  onLoad="doInit();">
<form name="frm">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="pop01"></td>
    <td class="pop02" ></td>
    <td class="pop03" ></td>
  </tr>
  <tr>
    <td class="pop04" ></td>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="" class="title">
              <img src="/edi/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
              <span id="title1" class="PL03">단품코드 </span>
            </td>
            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                   <td><img src="/edi/imgs/btn/search.gif" width="50" height="22"  onClick="btn_Search();"/></td>
                   <td><img src="/edi/imgs/btn/confirm.gif" width="50" height="22" onClick="btn_Conf()"/></td>
                   <td><img src="/edi/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>
               </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="popT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="90">단품코드</th>
                <td >
                    <input type="text" name="s_sku_cd" id="s_sku_cd" size="17" maxlength="13" onkeypress="javascript:onlyNumber();" style='text-align:left;IME-MODE: disabled' onblur="btn_Search();"/>
                </td>
              </tr>
              <tr>
                <th width="90">단품명</th>
                <td>
                    <input type="text" name="s_sku_nm" id="s_sku_nm" size="30" style="text-align:left;"/>
                </td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
               <tr valign="top">
                   <td>    
                       <div id="divTitle1" style="width: 100%; overflow: hidden;">
                       <table width=100% border="0" cellspacing="0" cellpadding="0" class="g_table">
                           <tr>
                               <th width="30">선택</th>
                               <th width="90">단품코드</th>
                               <th>단품명</th>
                           </tr>
                       </table>
                       </div>
                       
                       <div id="divTitle2" style="width: 100%; overflow: hidden;">
                       <table width=100% border="0" cellspacing="0" cellpadding="0" class="g_table">
                           <tr>
                               <th width="90">단품코드</th>
                               <th>단품명</th>
                           </tr>
                       </table>
                       </div>
                   </td>
               </tr>
               <tr>
                   <td>
                   <div id="divContent" style="width: 100%; height: 245px; overflow:scroll" onscroll="scrollControl();">
                   <table width=100% border='0' cellspacing='0' cellpadding='0' class='g_table' id='tb_detail'>
                   </table>
                   </div>
                   </td>
               </tr>
           </table>
        </td>
      </tr>
    </table></td>
     <td class="pop06" ></td>
  </tr>
  <tr>
     <td class="pop07" ></td>
     <td class="pop08" ></td>
     <td class="pop09" ></td>
  </tr>
</table>
<input type="hidden" name="auth_gb"        id="auth_gb"        value="">
<input type="hidden" name="addCondition"   id="addCondition"   value="">
</form>
</body>
</html>
