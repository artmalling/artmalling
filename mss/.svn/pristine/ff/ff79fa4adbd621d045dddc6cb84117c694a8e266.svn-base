<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은행사마스터 > 카드사 마스터관리 
 * 작 성 일 : 2011.05.31
 * 작 성 자 : 김정민
 * 수 정 자 : 
 * 파 일 명 : mcae1020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.05.31 (김정민) 신규개발 
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
var btnSearchClick = false;
var strCurRow = 0;

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 105;		//해당화면의 동적그리드top위치
function doInit(){

	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";

    // Input Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화     
    initEmEdit(EM_SEL_VEN_CD, "NUMBER3^6^2", NORMAL);   // [조회용]협력사코드
    initEmEdit(EM_SEL_VEN_NAME, "GEN", READ);           // [조회용]협력사명
    initEmEdit(EM_CARDCOMP, "NUMBER3^2", NORMAL);         // [조회용]제휴카드코드
    initEmEdit(EM_CARDCOMP_NM, "GEN", READ);            // [조회용]제휴카드명
    
    //콤보 초기화    
    initComboStyle(LC_SEL_STR_CD,DS_O_STR, "CODE^0^30,NAME^0^80", 1, NORMAL);      //점
    
    getStore("DS_O_STR", "N", "", "Y");
    DS_O_STR.Filter();     //점구분 : 본사점만 셋팅
    LC_SEL_STR_CD.Index = 0;
    LC_SEL_STR_CD.Focus();    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"            width=50     align=center</FC>'
                     + '<FC>id=STR_CD       name="점"             width=110     align=left  EditStyle=Lookup   Data="DS_O_STR:CODE:NAME" </FC>'
                     + '<FC>id=VEN_CD       name="청구카드협력사"   width=110    align=center</FC>'
                     + '<FC>id=VEN_NAME     name="청구카드협력사명" width=200     align=left</FC>'
                     + '<FC>id=CCOMP_CD     name="카드사코드"      width=110     align=center</FC>'
                     + '<FC>id=CCOMP_NM     name="카드사명"        width=200    align=left</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
     
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
 * 작 성 자 : 김정민
 * 작 성 일 : 2011-05-31
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() { 
	 
	 if(LC_SEL_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION , OK, "USER-1001", "점");
        LC_SEL_STR_CD.Focus();
        return;
    }
    
	btnSearchClick  = true;
    // 조회조건 셋팅
    var strStrCd   = LC_SEL_STR_CD.BindColVal;
    var strVenCd   = EM_SEL_VEN_CD.Text;
    var strCompCd  = EM_CARDCOMP.Text;
    
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd=" + encodeURIComponent(strStrCd)
                   + "&strVenCd=" + encodeURIComponent(strVenCd)
                   + "&strCompCd="+ encodeURIComponent(strCompCd);  
    TR_MAIN.Action="/mss/mcae102.mc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();

    if(strCurRow > 0)  DS_IO_MASTER.RowPosition = strCurRow;
    strCurRow = 0;
    if(TR_MAIN.ErrorCode == 0) btnSearchClick  = false;
    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-02-21
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
 * 작 성 일 : 2011-02-22
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	 
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
 * 작 성 일 : 2010-12-12
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * setGridFocus()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-02-22
  * 개    요 : 그리드에 포커스
  * return값 : void
  */

 function setGridFocus(row, colid) {
    GD_MASTER.SetColumn(colid); //name 컬럼 
    DS_IO_MASTER.RowPosition = row; //3번째 로우 
 }
 
 /**
  * callPopup()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.01.24
  * 개    요 : 팝업 호출
  * return값 :
  */
 function getVenCd() {  
     if(LC_SEL_STR_CD.BindColVal == "" || LC_SEL_STR_CD.BindColVal == "%") {
    	//    alert();
    	 showMessage(EXCLAMATION , OK, "USER-1001", "점");
         LC_SEL_STR_CD.Focus();
         return;
     }
     
     getEvtVenPop( EM_SEL_VEN_CD.Text, EM_SEL_VEN_NAME.Text, 'S', LC_SEL_STR_CD.BindColVal, '01');

 }
 
 /**
  * getCard()
  * 작 성 자 : FKL
  * 작 성 일 : 2011.01.24
  * 개    요 : 팝업 호출
  * return값 :
  */
 function getCard() {
	 if(LC_SEL_STR_CD.BindColVal == "" || LC_SEL_STR_CD.BindColVal == "%") {
	        //    alert();
	         showMessage(EXCLAMATION , OK, "USER-1001", "점");
	         LC_SEL_STR_CD.Focus();
	         return;
	     }
	 
	 getEvtCardComp( EM_CARDCOMP, EM_CARDCOMP_NM, 'S', LC_SEL_STR_CD.BindColVal);
 }
 
-->
</script>
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_STR event=OnFilter(row)>
if (DS_O_STR.NameValue(row, "GBN") == "0") {// 본사점 제외
    return false;
}
return true;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER
	event=CanColumnPosChange(row,colid)>
var strTrgF = DS_IO_MASTER.NameValue(row, "TRG_F");
var strTrgT = DS_IO_MASTER.NameValue(row, "TRG_T");
// 컬럼내용 변경시 범위 내용 입력값 체크
if(colid == "TRG_F" || colid == "TRG_T"){
    if(strTrgF != 0 && strTrgT != 0){
        if(strTrgT != 0 && strTrgF > strTrgT){
            showMessage(EXCLAMATION , OK, "USER-1000","대상범위 시작값이 종료값보다 클수 없습니다.");
           // DS_IO_MASTER.NameValue(row, colid) = "";
            return false;
        }   
    }
    return true;
}
return true;
</script>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
if(row == 0)  sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
    if(clickSORT)return;
</script>
  
<!-- 협력사명 한건 조회 -->
<script language=JavaScript for=EM_SEL_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
//코드가 존재 하지 않으면 명을 클리어 후 리턴
if( EM_SEL_VEN_CD.Text ==""){
	EM_SEL_VEN_NAME.Text = "";
       return;
   } 
   
if(LC_SEL_STR_CD.BindColVal == "" || LC_SEL_STR_CD.BindColVal == "%") {
    //    alert();
     showMessage(EXCLAMATION , OK, "USER-1001", "점");
     EM_SEL_VEN_CD.Text = "";
     EM_SEL_VEN_NAME.Text = "";
     setTimeout("LC_SEL_STR_CD.Focus()",100);  
     return;
 }
 
getEvtVenNonPop("DS_O_RESULT", EM_SEL_VEN_CD, EM_SEL_VEN_NAME, "E" , "Y" , LC_SEL_STR_CD.BindColVal,  '01');
</script>
 
<script language=JavaScript for=EM_CARDCOMP event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    if(LC_SEL_STR_CD.BindColVal == "" || LC_SEL_STR_CD.BindColVal == "%") {
        //    alert();
         showMessage(EXCLAMATION , OK, "USER-1001", "점");
         EM_CARDCOMP.Text = "";
         EM_CARDCOMP_NM.Text = "";
         setTimeout("LC_SEL_STR_CD.Focus()",100);  
         return;
     }
    
    //코드가 존재 하지 않으면 명을 클리어 후 리턴
    if( EM_CARDCOMP.Text ==""){
        EM_CARDCOMP_NM.Text = "";
           return;
       }
    
    if(EM_CARDCOMP.text!=null){
          if(EM_CARDCOMP.text.length > 0){
              getEvtCardCompNonPop( "DS_O_RESULT", EM_CARDCOMP, EM_CARDCOMP_NM,  "E" , "Y",LC_SEL_STR_CD.BindColVal);
          }
      }
</script>

<!-- 점 OnSelChange() -->
<script language=JavaScript for=LC_SEL_STR_CD event=OnSelChange()>
   EM_SEL_VEN_CD.Text = "";
   EM_SEL_VEN_NAME.Text = "";
   EM_CARDCOMP.Text = "";
   EM_CARDCOMP_NM.Text = "";
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
<!-- 검색용 -->
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_STR" classid=<%=Util.CLSID_DATASET%>>
<param name=UseFilter value=true>
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
    
}
</script>

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<DIV id="testdiv" class="testdiv"><!--공통 타이틀/버튼 // -->

<input type=hidden id=HD_VEN_CD>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td><!-- search start -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80">점</th>
						<TD width="120"><comment id="_NSID_"> <object
							id=LC_SEL_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> tabindex=1
							height=140 width=120 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</TD>
						<th width="80">카드사코드</th>
						<td width="200"><comment id="_NSID_">
                                <object id=EM_CARDCOMP classid=<%= Util.CLSID_EMEDIT %> width=60 onKeyup="javascript:checkByteStr(this, 10, 'Y');"  tabindex=1 align="absmiddle">
                                </object>
                        </comment><script>_ws_(_NSID_);</script>
                        <img id=IMG_CARDCOMP src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="getCard()"  align="absmiddle"/>
                        <comment id="_NSID_">
                                <object id=EM_CARDCOMP_NM classid=<%= Util.CLSID_EMEDIT %> width=100 tabindex=1 align="absmiddle">
                                </object>
                        </comment><script>_ws_(_NSID_);</script> </TD>
                        <th width="80" >협력사</th>
                        <td><comment id="_NSID_"> <object
                            id=EM_SEL_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=70
                            tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
                            onclick="getVenCd();" align="absmiddle" /> <comment
                            id="_NSID_"> <object id=EM_SEL_VEN_NAME
                            classid=<%=Util.CLSID_EMEDIT%> width=100 align="absmiddle">
                        </object> </comment><script>_ws_(_NSID_);</script></td>
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
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td width="100%"><comment id="_NSID_"><OBJECT
                            id=GD_MASTER width=100% height=780 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_IO_MASTER">
                        </OBJECT></comment><script>_ws_(_NSID_);</script></td>
                    </tr>
                </table>
		</td>
	</tr>
</table>
</DIV>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

