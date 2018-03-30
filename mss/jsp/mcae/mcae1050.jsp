<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은행사마스터 > 대상범위 마스터관리 
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 김슬기
 * 수 정 자 : 
 * 파 일 명 : mcae1050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.18 (김슬기) 신규작성
 *        2011.02.21 (김성미) 프로그램 작성
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
<!--

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
 var top = 115;		//해당화면의 동적그리드top위치
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
    initEmEdit(EM_TRG_CD, "GEN^2", NORMAL);           //대상범위 코드
    initEmEdit(EM_TRG_NAME, "GEN", READ);           //대상범위 코드 명
    
    //콤보 초기화    
    initComboStyle(LC_STR,DS_O_STR, "CODE^0^30,NAME^0^80", 1, PK);      //점
    
    getStore("DS_O_STR", "Y", "1", "N");
    LC_STR.Index = 0;
    LC_STR.Focus();    
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"          width=50   align=center</FC>'
                     + '<FC>id=STR_NM       name="*점"     width=80 edit="none" align=left</FC>'
                     + '<FC>id=TRG_CD       name="*대상범위코드"     width=100 edit="none" align=center</FC>'
                     + '<FC>id=TRG_NAME     name="*대상범위코드명" width=170  align=left</FC>'
                     + '<FC>id=TRG_F     name="*대상범위 시작"    edit={if(TRG_CD = "", true, false)} edit="Numeric" width=170  EditLimit="9" align=right</FC>'
                     + '<FC>id=TRG_T       name=*"대상범위 종료"  edit={if(TRG_CD = "", true, false)} edit="Numeric" width=170  EditLimit="9" align=right</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    
    //그리드 엔터시 로우 추가 
    GD_MASTER.autorow     = "true";
    GD_MASTER.autoevent   = "btn_New()";
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
 * 작 성 일 : 2011-02-21
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search(flag) {
	 if(flag != "checked"){
		 if(DS_IO_MASTER.IsUpdated){
	         if(showMessage(QUESTION , YESNO, "GAUCE-1000", "대상범위 내용이 수정되었습니다. <br> 새로 조회하시겠습니까?") != 1 ){
	             return;
	             }
	      }
	 }
	 
	 if(LC_STR.BindColVal == ""){
        showMessage(EXCLAMATION , OK, "USER-1001", "점");
        LC_STR.Focus();
        return;
    }
    
	btnSearchClick  = true;
    // 조회조건 셋팅
    var strStrCd   = LC_STR.BindColVal;
    var strTrgCd   = EM_TRG_CD.Text;
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strTrgCd="+encodeURIComponent(strTrgCd);  
    TR_MAIN.Action="/mss/mcae105.mc?goTo="+goTo+parameters;  
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
	// 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated || DS_IO_MASTER.CountRow == 0){
        //저장할 내용이 없습니다
        showMessage(EXCLAMATION , OK, "USER-1028");
        return;
    }
    //if(!checkDSBlank( GD_MASTER, "3,4,5")) return;
    if(!checkDSBlank( GD_MASTER, "3")) return;
    for(var i=1;i<=DS_IO_MASTER.CountRow;i++){
    	strComTrgF = DS_IO_MASTER.NameValue(i, "TRG_F");
    	strComTrgT = DS_IO_MASTER.NameValue(i, "TRG_T");

    	if(strComTrgF == 0 && strComTrgT != 0){
        		 showMessage(EXCLAMATION , OK, "USER-1000","대상범위 시작값은 반드시 입력 해야 합니다.");
        		 setGridFocus(j, "TRG_F");
        		 return;
        }
    	if(strComTrgF != 0 && strComTrgT == 0){
   		 showMessage(EXCLAMATION , OK, "USER-1000","대상범위 종료값은 반드시 입력 해야 합니다.");
   		 setGridFocus(j, "TRG_T");
   		 return;
   		}
    }
    
    var strComTrgF, strComTrgT, strTrgF, strTrgT;
    // 중복 내용 확인
    for(var i=1;i<=DS_IO_MASTER.CountRow;i++){
    	strComTrgF = DS_IO_MASTER.NameValue(i, "TRG_F");
    	strComTrgT = DS_IO_MASTER.NameValue(i, "TRG_T");
    	for(var j=1;j<=DS_IO_MASTER.CountRow;j++){
         if(i != j){
        	 if(strComTrgF == DS_IO_MASTER.NameValue(j, "TRG_F") && strComTrgT == DS_IO_MASTER.NameValue(j, "TRG_T")){
        		 showMessage(EXCLAMATION , OK, "USER-1000","중복된 값이 있습니다");
        		 setGridFocus(j, "TRG_F");
        		 return;
        	 }
         }   
        }
    }
    
    if(showMessage(Question, YESNO, "USER-1010") != 1)    return;
    
    strCurRow = DS_IO_MASTER.RowPosition;
    TR_MAIN.Action="/mss/mcae105.mc?goTo=save"; 
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; 
    TR_MAIN.Post();
    
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
  * addRow()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-02-21
  * 개    요 : Grid 레코드 추가
  * return값 : void
  */
 function addRow() {
	  if(!btnSearchClick){
		  showMessage(EXCLAMATION , OK, "USER-1013");
		  return;
	  }
	  
	  if(DS_IO_MASTER.CountRow ==0){
		 DS_IO_MASTER.AddRow();
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD") = LC_STR.BindColVal;
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_NM") = LC_STR.Text;
         GD_MASTER.SetColumn("TRG_NAME");
	  }else{
		 DS_IO_MASTER.AddRow();
	     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD") = DS_IO_MASTER.NameValue(1, "STR_CD");
	     DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_NM") = DS_IO_MASTER.NameValue(1, "STR_NM");
	     GD_MASTER.SetColumn("TRG_NAME");
	  }
     
     GD_MASTER.Focus();
 }
 
 /**
  * delRow()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-02-21
  * 개    요 : Grid 레코드 삭제
  * return값 : void
  */
 function delRow() {
	 var Row = DS_IO_MASTER.RowPosition;
	  if(DS_IO_MASTER.NameValue(Row, "TRG_CD") == ""){
            // 삭제 메세지 
            if(showMessage(QUESTION , YESNO, "USER-1023") != 1){
                DS_IO_MASTER.NameValue(Row, "BTN_DEL") = "";
                return;
            }
            DS_IO_MASTER.DeleteRow(Row);
	    }else{
	            showMessage(EXCLAMATION , OK, "USER-1000","이미 저장된 내용은 삭제하실수 없습니다.");
	            DS_IO_MASTER.NameValue(Row, "BTN_DEL") = "";
	            return;
	    }
 }
 
 /**
  * openPop()
  * 작 성 자 : 김성미
  * 작 성 일 : 2011-02-22
  * 개    요 : 점코드 필수 입력체크
  * return값 : void
  */

 function openPop() {
	 if(LC_STR.BindColVal == ""){
	        showMessage(EXCLAMATION , OK, "USER-1001", "점");
	        LC_STR.Focus();
	        return;
	    }
	 getEvtTrgPop( EM_TRG_CD, EM_TRG_NAME, "S" ,LC_STR.BindColVal);
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
<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,olddata)>
if(colid == "TRG_NAME"){
    checkByteStr(GD_MASTER, "40", "Y", row,colid);
}
</script>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
if(row == 0)  sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>
<!-- 대상범위  조회 -->
<script language=JavaScript for=EM_TRG_CD event=onKillFocus()>
   // if(EM_TRG_CD.text!=null){
       // if(EM_TRG_CD.text.length > 0){
        	getEvtTrgNonPop("DS_O_RESULT", EM_TRG_CD, EM_TRG_NAME, "E" , "Y", LC_STR.BindColVal);
      //  }
  //  }
</script>
<script language=JavaScript for=LC_STR event=OnSelChange()>
if(DS_IO_MASTER.CountRow == 0) return;
if(DS_IO_MASTER.IsUpdated && LC_STR.BindColVal != DS_IO_MASTER.NameValue(1,"STR_CD")){
    if(showMessage(QUESTION , YESNO, "GAUCE-1000", "대상범위 내용이 수정되었습니다. <br> 새로 조회하시겠습니까?") == 1 ){
        btn_Search("checked");
    }else{
    	LC_STR.BindColVal = DS_IO_MASTER.NameValue(1,"STR_CD")
    }
 }else{
	 btn_Search();
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
<object id="DS_O_STR" classid=<%=Util.CLSID_DATASET%>></object>
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
						<th width="100" class="point">점</th>
						<TD width="140"><comment id="_NSID_"> <object
							id=LC_STR classid=<%=Util.CLSID_LUXECOMBO%> tabindex=1
							height=140 width=140 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</TD>
						<th width="100">대상범위</th>
						<TD><comment id="_NSID_"> <object id=EM_TRG_CD
							classid=<%=Util.CLSID_EMEDIT%> width=60 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:openPop();" align="absmiddle" /> <comment
							id="_NSID_"> <object id=EM_TRG_NAME
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></TD>
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
	<tr>
	<td class="PT0 PB03">
	   <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr valign="bottom">
                <td align="right">
                <img id="IMG_ADD_ROW" style="vertical-align: middle;" src="/<%=dir%>/imgs/btn/add_row.gif" width="52" height="18" onclick="addRow();" hspace="2" /><img id="IMG_DEL_ROW" style="vertical-align: middle;" src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18" onclick="delRow();" />
                </td>
           </tr>
          </table>
	</td>
	</tr>
	<tr valign="top">
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
                    class="BD4A">
                    <tr>
                        <td width="100%"><comment id="_NSID_"><OBJECT
                            id=GD_MASTER width=100% height=770 classid=<%=Util.CLSID_GRID%>>
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

