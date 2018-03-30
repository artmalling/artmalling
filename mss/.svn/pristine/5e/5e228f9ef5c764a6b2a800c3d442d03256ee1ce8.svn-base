<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 정산관리> 자사위탁판매 정산
 * 작 성 일 : 2011.06.07
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif6040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.06.07 (김성미) 프로그램작성 
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"       type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"><!--

var strCurRow = 0;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_CAL_YM, "THISMN", PK);    //적용종료일
    initEmEdit(EM_S_VEN_CD, "NUMBER3^6", NORMAL);             //협력사코드
    initEmEdit(EM_S_VEN_NM, "GEN", READ);                     //협력사명
    
    //콤보 초기화
  initComboStyle(LC_S_STR,DS_O_STR, "CODE^0^30,NAME^0^80", 1, PK);    //법인구분
  
  getStore("DS_O_STR", "N", "", "N");
  
  LC_S_STR.Index = 0;
  LC_S_STR.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"         width=30   align=center</FC>'
                     + '<FC>id=FLAG         name=""     width=20  align=center HeadCheckShow="true" EditStyle="CheckBox"</FC>'
                     + '<FC>id=OUT_STR_NM      name="본사점" edit=none  sumtext="합계"   width=70 align=left</FC>'
                     + '<FC>id=CAL_YM       name="정산월"   edit=none  mask="XXXX/XX"  width=80  align=center</FC>'
                     + '<FC>id=VEN_CD    name="협력사코드"    edit=none   width=75  align=center</FC>'
                     + '<FC>id=VEN_NM    name="협력사명"    edit=none   width=110  align=left</FC>'
                     + '<FC>id=OUT_AMT    name="출고금액" edit=none  sumtext=@sum   width=100   align=right</FC>'
                     + '<FC>id=TOT_PAY_AMT    name="입금금액"  edit=none   width=80   align=right</FC>'
                     + '<FC>id=PAY_AMT    name="실입금금액" edit=none sumtext=@sum     width=110   align=right</FC>'
                     + '<FC>id=FEE_PAY_AMT    name="수수료금액" edit=none sumtext=@sum    width=110   align=right</FC>'
                     + '<FC>id=CUR_BOND_AMT    name="당월미수채권" edit=none sumtext=@sum    width=110   align=right</FC>';
   
    initGridStyle(GD_OUTREQCONF, "common", hdrProperies, true);
    GD_OUTREQCONF.ViewSummary = 1; 
    
    var hdrProperies1 = '<FC>id={currow}    name="NO"         width=30   align=center</FC>'
        + '<FC>id=STR_NM      name="본사점" sumtext="합계"  edit=none  width=90 align=left</FC>'
        + '<FC>id=CAL_YM    name="정산월"   mask="XXXX/XX"    width=80  edit=none align=center</FC>'
        + '<FC>id=VEN_NM      name="위탁협력사"  edit=none   width=90   align=left</FC>'
        + '<FC>id=BASIC_BOND_AMT    name="기초미수채권"   sumtext=@sum  edit=none  width=90  align=right</FC>'
        + '<FC>id=BOND_AMT    name="출고금액"   sumtext=@sum  edit=none  width=90  align=right</FC>'
        + '<FC>id=TOT_PAY_AMT    name="입금금액" sumtext=@sum edit=none   width=90   align=right</FC>'
        + '<FC>id=PAY_AMT    name="실입금금액"  sumtext=@sum edit=none  width=90   align=right</FC>'
        + '<FC>id=FEE_PAY_AMT    name="수수료금액"  sumtext=@sum edit=none  width=90   align=right</FC>'
        + '<FC>id=CUR_BOND_AMT    name="당월미수채권"  sumtext=@sum edit=none  width=90   align=right</FC>'
        + '<FC>id=FINAL_BOND_AMT    name="기말미수채권"  sumtext=@sum edit=none  width=90   align=right</FC>';
      
   initGridStyle(GD_JOINCAL, "common", hdrProperies1, false);
   GD_JOINCAL.ViewSummary = 1; 
  
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
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-06-02
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(LC_S_STR.BindColVal == ""){  // 본사점
        showMessage(EXCLAMATION , OK, "USER-1001", "회수점");
        return;
    }
    
	if(EM_CAL_YM.Text.length < 6){   // 정산년월
        showMessage(EXCLAMATION , OK, "USER-1001","정산년월");
        EM_S_S_DT.Focus();
        return;
    }
    
    var parameters = "&strStrCd="+ encodeURIComponent(LC_S_STR.BindColVal)
                   + "&strYM="   + encodeURIComponent(EM_CAL_YM.Text)
                   + "&strVenCd="+ encodeURIComponent(EM_S_VEN_CD.Text);
    
    TR_MAIN.Action="/mss/mgif604.mg?goTo=getList"+parameters;  
    TR_MAIN.KeyValue="SERVLET(O:DS_O_OUTREQCONF=DS_O_OUTREQCONF,O:DS_O_JOINCAL=DS_O_JOINCAL)"; //조회는 O
    TR_MAIN.Post();
    
    DS_O_OUTREQCONF.RowPosition = strCurRow;
    
  //조회결과 Return
    setPorcCount("SELECT", DS_O_OUTREQCONF.CountRow);
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2011-06-03
 * 개    요 : 자사상품권 정산내용 저장
 * return값 : void
 */
function btn_Save() {
	// 저장할 데이터 없는 경우
	   if(DS_O_OUTREQCONF.CountRow == 0 || !DS_O_OUTREQCONF.IsUpdated){
	         //저장할 내용이 없습니다
	           showMessage(EXCLAMATION , OK, "USER-1028");
	           return;
	       }
	 
	   if (showMessage(QUESTION , YESNO, "USER-1010") != 1) return;
	   
	   
	   TR_MAIN.Action="/mss/mgif604.mg?goTo=save"; 
	   TR_MAIN.KeyValue="SERVLET(I:DS_O_OUTREQCONF=DS_O_OUTREQCONF)"; //조회는 O
	   TR_MAIN.Post();
	   
	   strCurRow = DS_O_OUTREQCONF.RowPosition;
	   
	  if(TR_MAIN.ErrorCode == 0) btn_Search();
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2011-06-03
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * getVenCd()
 * 작 성 자 : 
 * 작 성 일 : 2011-04-06
 * 개    요 : 가맹점 팝업 오픈시 점코드 필수
 * return값 : void
 */
function getVenCd(){
    if(LC_S_STR.BindColVal == "%"){
           showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
           LC_S_STR.Focus();
           return;
       }
    getMssEvtVenPop( EM_S_VEN_CD, EM_S_VEN_NM, 'S', '3', '', LC_S_STR.BindColVal, '')
}

--></script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
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
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_S_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_STR event=OnFilter(row)>
if (DS_O_STR.NameValue(row, "CODE") != "00") {// 본사점
    return false;
}
return true;
</script>
<script language=JavaScript for=DS_O_OUTREQCONF event=OnRowPosChanged(row)>
 if(clickSORT)
     return;
</script>
<script language=JavaScript for=DS_O_JOINCAL event=OnRowPosChanged(row)>
 if(clickSORT)
     return;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_OUTREQCONF event=OnClick(row,colid)>
if(row == 0 && colid != "FLAG") sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GD_JOINCAL event=OnClick(row,colid)>
if(row == 0) sortColId( eval(this.DataID), row, colid);
</script>
<script language="javascript"  for=GD_OUTREQCONF event=OnHeadCheckClick(Col,Colid,bCheck)>
    var strFlag = "";
    if(bCheck == 1){
     strFlag = "T";
    }else{
        strFlag = "F";
    }
    for(var i=1;i<=DS_O_OUTREQCONF.CountRow;i++){
    	DS_O_OUTREQCONF.NameValue(i,"FLAG") = strFlag;
    }
</script>
 <script language=JavaScript for=EM_S_VEN_CD event=OnKillFocus()>
//변경된 내역이 없으면 무시
 if(!this.Modified)
     return;
 //코드가 존재 하지 않으면 명을 클리어 후 리턴
 if( this.Text ==""){
     EM_S_VEN_NM.Text = "";
        return;
    }
 if(this.Text.length > 0){
        if(LC_S_STR.BindColVal == "%"){
            showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
            LC_S_STR.Focus();
            return;
        }
        getMssEvtVenNonPop( "DS_O_RESULT", EM_S_VEN_CD, EM_S_VEN_NM, "E", "Y", "2", '', LC_S_STR.BindColVal, '');
    }
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_O_STR"  classid=<%= Util.CLSID_DATASET %>>
<param name=UseFilter value=true>
</object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_OUTREQCONF"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_JOINCAL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_S_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<DIV id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB05"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="90" class="point">본사점</th>
            <td width="130">
                <comment id="_NSID_">
                   <object id=LC_S_STR classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=128 align="absmiddle" tabindex=1>
                   </object>
               </comment><script>_ws_(_NSID_);</script> 
            </td>
            <th width="90" class="point">정산년월</th>
            <td width=125>
               <comment id="_NSID_">
                 <object id=EM_CAL_YM classid=<%=Util.CLSID_EMEDIT%> onblur="checkDateTypeYM(this);" width=100 tabindex=1 align="absmiddle">
                 </object></comment><script>_ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',EM_CAL_YM)" align="absmiddle" />
              </td>
               <th width="90">위탁협력사</th>
            <td>
                <comment id="_NSID_">
                    <object id=EM_S_VEN_CD classid=<%=Util.CLSID_EMEDIT%>   width=70 tabindex=1 align="absmiddle" tabindex=1>
                    </object>
                </comment>
                <script> _ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" align="absmiddle" onclick="javascript:getVenCd();" class="PR03"/>
                 <comment id="_NSID_">
                    <object id=EM_S_VEN_NM classid=<%=Util.CLSID_EMEDIT%>   width=120 tabindex=1 align="absmiddle">
                    </object>
                </comment>
                <script> _ws_(_NSID_);</script>
              </td>
          </tr> 
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr><td class="dot"></td></tr>
  <tr>
  <td class="PB05">
     <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr class="PB02">
        <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 위탁매출 내역
        </td>
        </tr>
        <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
          <td>
              <comment id="_NSID_"><OBJECT id=GD_OUTREQCONF width=100% height=220 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_O_OUTREQCONF">
              </OBJECT></comment><script>_ws_(_NSID_);</script>
          </td>  
           </tr>
          </table>
        </td>
        </tr>
        </table>
  </TD>
  </TR>
  <TR>
  <TD>
   <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr class="PB02">
        <td class="sub_title"><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 정산내역
        </td>
        </tr>
        <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
          <td>
              <comment id="_NSID_"><OBJECT id=GD_JOINCAL width=100% height=245 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_O_JOINCAL">
              </OBJECT></comment><script>_ws_(_NSID_);</script>
          </td>  
           </tr>
          </table>
        </td>
        </tr>
        </table>
  </TD>
  </TR>
</table>
</DIV>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

