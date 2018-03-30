<!-- 
/*******************************************************************************
 * 시스템명 : 포인트카드 > 회원관리 > 멤버쉽운영 > 포인트승인테스트
 * 작 성 일    : 2010.04.05
 * 작 성 자    : jinjung.kim
 * 수 정 자    : 
 * 파 일 명    : DMBO6150.jsp
 * 버       전    : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개       요    :  
 * 이       력    :
 *           2010.04.05 (jinjung.kim) 신규작성
 *
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"        prefix="gauce" %>
<%@ taglib uri="/WEB-INF/tld/app.tld"            prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                              *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dcs.js"  type="text/javascript"></script>


<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                      *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">
<!--
function doInit() {

    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_MASTER2.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_MASTER3.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    var hdrProperies  = '<FC>id=IDX     name="순번"       width=40    align=center  edit=none </FC>'
    	               + '<FC>id=GBN     name="항목"       width=150   align=left    edit=none  </FC>'
                       + '<FC>id=TYPE    name="유형"       width=70    align=center  edit=none </FC>'
                       + '<FC>id=LENG    name="길이"       width=70    align=right   edit=none  </FC>'
                       + '<FC>id=INPUT   name="데이터"     width=200   align=left    </FC>'
                       + '<FC>id=CLENG   name="현재길이"   width=70    align=right   edit=none </FC>';

    initGridStyle(GR_MASTER, "common", hdrProperies, true);
    initGridStyle(GR_MASTER2, "common", hdrProperies, true);
    initGridStyle(GR_MASTER3, "common", hdrProperies, true);
    
    GR_MASTER.ColumnProp("IDX",   "bgcolor") = "#eaeef4";
    GR_MASTER.ColumnProp("GBN",   "bgcolor") = "#eaeef4";
    GR_MASTER.ColumnProp("TYPE",  "bgcolor") = "#eaeef4";
    GR_MASTER.ColumnProp("LENG",  "bgcolor") = "#eaeef4";
    GR_MASTER.ColumnProp("CLENG", "bgcolor") = "#eaeef4";
    GR_MASTER.IndWidth = 0;
    
    GR_MASTER2.ColumnProp("IDX",   "bgcolor") = "#eaeef4";
    GR_MASTER2.ColumnProp("GBN",   "bgcolor") = "#eaeef4";
    GR_MASTER2.ColumnProp("TYPE",  "bgcolor") = "#eaeef4";
    GR_MASTER2.ColumnProp("LENG",  "bgcolor") = "#eaeef4";
    GR_MASTER2.ColumnProp("CLENG", "bgcolor") = "#eaeef4";
    GR_MASTER2.IndWidth = 0;
    
    GR_MASTER3.ColumnProp("IDX",   "bgcolor") = "#eaeef4";
    GR_MASTER3.ColumnProp("GBN",   "bgcolor") = "#eaeef4";
    GR_MASTER3.ColumnProp("TYPE",  "bgcolor") = "#eaeef4";
    GR_MASTER3.ColumnProp("LENG",  "bgcolor") = "#eaeef4";
    GR_MASTER3.ColumnProp("CLENG", "bgcolor") = "#eaeef4";
    GR_MASTER3.IndWidth = 0;
    
    btn_Search();
    
}


function btn_Search() {
	var goTo        = "searchMaster";    
    TR_SEARCH.Action  ="/dcs/dmbo615.do?goTo=" + goTo ;
    TR_SEARCH.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER,O:DS_IO_MASTER2=DS_IO_MASTER2,O:DS_IO_MASTER3=DS_IO_MASTER3)"; 
    TR_SEARCH.Post();
}



function btn_New() {
	DS_IO_MASTER.UndoAll();
}

function btn_Save() 
{
    if (!(rgbn[0].checked || rgbn[1].checked || rgbn[2].checked)) {
        showMessage(EXCLAMATION, OK, "USER-1000",  "전문구분을 선택하십시오.");
        return;
    }
    
    var goTo = "saveData";    
    var GBN = "";
        
    if (rgbn[0].checked) { GBN = "A"; }
    if (rgbn[1].checked) { GBN = "B"; }
    if (rgbn[2].checked) { GBN = "C"; }
    
    var tf = "T";
    if (GBN == "A") {
        for (var i = 1 ; i <= DS_IO_MASTER.CountRow; i++) {
            if (DS_IO_MASTER.NameValue(i, "CHK") == "T") { tf = "F";} else { tf = "T";}
            DS_IO_MASTER.NameValue(i, "CHK") = tf;
        }
        TR_SAVE.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; 
    } else if (GBN == "B") {
        for (var i = 1 ; i <= DS_IO_MASTER2.CountRow; i++) {
            if (DS_IO_MASTER2.NameValue(i, "CHK") == "T") { tf = "F";} else { tf = "T";}
            DS_IO_MASTER2.NameValue(i, "CHK") = tf;
        }
        TR_SAVE.KeyValue="SERVLET(I:DS_IO_MASTER2=DS_IO_MASTER2)"; 
    } else if (GBN == "C") {
        for (var i = 1 ; i <= DS_IO_MASTER3.CountRow; i++) {
            if (DS_IO_MASTER3.NameValue(i, "CHK") == "T") { tf = "F";} else { tf = "T";}
            DS_IO_MASTER3.NameValue(i, "CHK") = tf;
        }
        TR_SAVE.KeyValue="SERVLET(I:DS_IO_MASTER3=DS_IO_MASTER3)"; 
    }

    TR_SAVE.Action  ="/dcs/dmbo615.do?goTo=" + goTo + "&GBN=" + GBN;
    TR_SAVE.Post();
}

function clickaa(value) {
    document.getElementById("tab" + value).style.display = "";
    var all = document.all;
    for (var i = 0 ; i < all.length; i++) {
        if (all[i].tagName == "TABLE") {
            if (null != all[i].id) {
                if (all[i].id.substring(0,3) == "tab") {
                    all[i].style.display = "none";
                }
            }
        }
    }
    document.getElementById("tab" + value).style.display = "";
}
-->
</script>
</head>
<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(var i = 0; i < this.SrvErrCount('UserMsg'); i++) {
        showMessage(INFORMATION, OK, "USER-1000", this.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_SEARCH event=onSuccess>
    for(var i = 0; i < this.SrvErrCount('UserMsg'); i++) {
        showMessage(INFORMATION, OK, "USER-1000", this.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_SAVE.ErrorMsg);
</script>
<script language=JavaScript for=TR_SEARCH event=onFail>
    trFailed(TR_SEARCH.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
    if (row > 0) {
        if ("" != this.NameValue(row, "INPUT")) {
            //this.NameValue(row, "INPUT") = this.NameValue(row, "INPUT").substring(0, parseInt(this.NameValue(row, "LENG")));
            this.NameValue(row, "INPUT") = trim(this.NameValue(row, "INPUT"));
            this.NameValue(row, "CLENG") = this.NameValue(row, "INPUT").length;
        }
    }
</script>
<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>
    if (row > 0) {
        //if ("" != this.NameValue(row, "INPUT")) {
            //this.NameValue(row, "INPUT") = this.NameValue(row, "INPUT").substring(0, parseInt(this.NameValue(row, "LENG")));
            this.NameValue(row, "INPUT") = trim(this.NameValue(row, "INPUT"));
            this.NameValue(row, "CLENG") = this.NameValue(row, "INPUT").length;
        //}
        if (this.NameValue(row, "CLENG") > parseInt(this.NameValue(row, "LENG"))) {
            alert("입력값이 최대길이를 초과하였습니다.");
            return false;
        }
        if (this.NameValue(row, "TYPE") == "N") {
            for (var i = 0 ; i < this.NameValue(row, "INPUT").length; i++) {
                if (isNaN(this.NameValue(row, "INPUT").substring(i, i + 1))) {
                    alert("숫자형 데이터만 입력받을 수 있는 항목입니다.");
                    return false;
                }
            }
        }
    }
    return true;
</script>
<script language=JavaScript for=DS_IO_MASTER2 event=OnRowPosChanged(row)>
    if (row > 0) {
        if ("" != this.NameValue(row, "INPUT")) {
            //this.NameValue(row, "INPUT") = this.NameValue(row, "INPUT").substring(0, parseInt(this.NameValue(row, "LENG")));
            this.NameValue(row, "INPUT") = trim(this.NameValue(row, "INPUT"));
            this.NameValue(row, "CLENG") = this.NameValue(row, "INPUT").length;
        }
    }
</script>
<script language=JavaScript for=DS_IO_MASTER2 event=CanRowPosChange(row)>
    if (row > 0) {
        //if ("" != this.NameValue(row, "INPUT")) {
            //this.NameValue(row, "INPUT") = this.NameValue(row, "INPUT").substring(0, parseInt(this.NameValue(row, "LENG")));
            this.NameValue(row, "INPUT") = trim(this.NameValue(row, "INPUT"));
            this.NameValue(row, "CLENG") = this.NameValue(row, "INPUT").length;
        //}
        if (this.NameValue(row, "CLENG") > parseInt(this.NameValue(row, "LENG"))) {
            alert("입력값이 최대길이를 초과하였습니다.");
            return false;
        }
        if (this.NameValue(row, "TYPE") == "N") {
            for (var i = 0 ; i < this.NameValue(row, "INPUT").length; i++) {
                if (isNaN(this.NameValue(row, "INPUT").substring(i, i + 1))) {
                    alert("숫자형 데이터만 입력받을 수 있는 항목입니다.");
                    return false;
                }
            }
        }
    }
    return true;
</script>

<script language=JavaScript for=DS_IO_MASTER3 event=OnRowPosChanged(row)>
    if (row > 0) {
        if ("" != this.NameValue(row, "INPUT")) {
            //this.NameValue(row, "INPUT") = this.NameValue(row, "INPUT").substring(0, parseInt(this.NameValue(row, "LENG")));
            this.NameValue(row, "INPUT") = trim(this.NameValue(row, "INPUT"));
            this.NameValue(row, "CLENG") = this.NameValue(row, "INPUT").length;
        }
    }
</script>
<script language=JavaScript for=DS_IO_MASTER3 event=CanRowPosChange(row)>
    if (row > 0) {
        //if ("" != this.NameValue(row, "INPUT")) {    
            this.NameValue(row, "INPUT") = trim(this.NameValue(row, "INPUT"));
            this.NameValue(row, "CLENG") = this.NameValue(row, "INPUT").length;
        //}
        if (this.NameValue(row, "CLENG") > parseInt(this.NameValue(row, "LENG"))) {
            alert("입력값이 최대길이를 초과하였습니다.");
            return false;
        }
        if (this.NameValue(row, "TYPE") == "N") {
            for (var i = 0 ; i < this.NameValue(row, "INPUT").length; i++) {
                if (isNaN(this.NameValue(row, "INPUT").substring(i, i + 1))) {
                    alert("숫자형 데이터만 입력받을 수 있는 항목입니다.");
                    return false;
                }
            }
        }
    }
    return true;
</script>



<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                              *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                  *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->
<!-- ===============- Output용 -->
<comment id="_NSID_">
  <object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_IO_MASTER2"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="DS_IO_MASTER3"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
  <object id="TR_SEARCH" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
  </object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
  <object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
  </object>
</comment>
<script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                 *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                           *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<div id="testdiv" class="testdiv">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    
    
    <tr>
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
        <tr>
          <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th colspan="2">
                <input type="radio" name=rgbn value="A" checked onclick="clickaa(this.value);">1. 백화점&nbsp;&nbsp;
                <input type="radio" name=rgbn value="B" onclick="clickaa(this.value);">2. 주차관제 - 무료주차확인&nbsp;&nbsp;
                <input type="radio" name=rgbn value="C" onclick="clickaa(this.value);">3. 백화점외 - 포인트 적립/사용
                </th>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      </td> 
    </tr>
    
     <tr>
      <td class="dot"></td>
    </tr>
   
    <tr valign="top">
      <td class="PB03">
        <table id=tabA width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
                <comment id="_NSID_">
                <object id=GR_MASTER width="100%" height=510 classid=<%=Util.CLSID_GRID%> tabindex=1>
                  <param name="DataID" value="DS_IO_MASTER">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table>
        <table id=tabB width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" style="display:none">
          <tr>
            <td>
                <comment id="_NSID_">
                <object id=GR_MASTER2 width="100%" height=510 classid=<%=Util.CLSID_GRID%> tabindex=1>
                  <param name="DataID" value="DS_IO_MASTER2">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table>
        <table id=tabC width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" style="display:none">
          <tr>
            <td>
                <comment id="_NSID_">
                <object id=GR_MASTER3 width="100%" height=510 classid=<%=Util.CLSID_GRID%> tabindex=1>
                  <param name="DataID" value="DS_IO_MASTER3">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    
  </table>
</div>
</body>
</html>

