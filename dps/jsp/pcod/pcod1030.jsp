<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 협력사코드> 점별협력사조회
 * 작 성 일 : 2010.03.07
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pcod1030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 점별협력사정보를 조회한다.
 * 이    력 :
 *        2010.03.07 (이재득) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">

var strStrCd        = "";
//var strBuySaleFlag  = "";
var strBizType      = "";     
var strVenCd        = "";
var strVenNm        = "";
var strUseYn        = "";
var strStrCdPopUp   = "";
var strCompFlag     = "";
var strCompNo	 	= "";



/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.07
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){

    // Input Data Set Header 초기화
    DS_I_STR_COND.setDataHeader(
    		 'STR_CD:STRING(2)'
            +',COMP_FLAG:STRING(1)'
            +',COMP_NO:STRING(10)'
            +',BIZ_TYPE:STRING(1)'
            +',USE_YN:STRING(1)'
            +',VEN_CD:STRING(6)'
            +',VEN_NM:STRING(40)');    
    DS_I_STR_COND.ClearData();
    DS_I_STR_COND.Addrow();
    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화    
    initEmEdit(EM_O_VEN_CD, "CODE^6^0", NORMAL);   //협력사코드
    initEmEdit(EM_O_VEN_NM, "GEN^40", NORMAL);  //협력사명    
    
    //콤보 초기화    
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^140", 1, NORMAL);  //점(조회)
    //initComboStyle(LC_O_BUY_SALE_FLAG,DS_O_BUY_SALE_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);  //매입매출구분(조회)
    initComboStyle(LC_O_BIZ_TYPE,DS_O_BIZ_TYPE, "CODE^0^30,NAME^0^90", 1, NORMAL);  //거래형태
    initComboStyle(LC_O_USE_YN,DS_O_USE_YN, "CODE^0^30,NAME^0^80", 1, NORMAL);  //사용여부
    
    initComboStyle(LC_O_COMP_FLAG, DS_O_COMP_FLAG, "CODE^0^30,NAME^0^150", 1, NORMAL);                  //사업자구분
	getEtcCode("DS_O_COMP_FLAG", "D", "P024", "Y");
	LC_O_COMP_FLAG.Index = 0;
	
	initEmEdit(LC_O_COMP_NO,            "NUMBER^10^0",   NORMAL);          //사업자번호
	LC_O_COMP_NO.Format = "000-00-00000";
	LC_O_COMP_NO.Alignment = 0;
	
    //점콤보 가져오기 ( gauce.js )
    getStore("DS_O_STR_CD", "N", "", "Y");
    getStore("DS_I_STR_CD", "N", "", "N");
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    //getEtcCode("DS_O_BUY_SALE_FLAG", "D", "P017", "Y");  //매입매출구분
    getEtcCode("DS_O_BIZ_TYPE", "D", "P003", "Y");       //거래형태
    getEtcCode("DS_O_USE_YN", "D", "D022", "Y");         //사용여부
    getEtcCode("DS_I_BUY_SALE_FLAG", "D", "P017", "N");  //매입매출구분
    getEtcCode("DS_I_BIZ_TYPE", "D", "P003", "N");       //거래형태  
    getEtcCode("DS_I_PAY_CYC", "D", "P052", "N");        //지불주기
    getEtcCode("DS_I_PAY_DT_FLAG", "D", "P051", "N");    //지불일구분  
    getEtcCode("DS_I_PAY_WAY", "D", "P049", "N");        //지불방법 
    getEtcCode("DS_I_PAY_HOLI_FLAG", "D", "P050", "N");  //지불시기구분  
    getEtcCode("DS_I_RUND_FLAG", "D", "P021", "N");      //반올림구분 
    getEtcCode("DS_I_POS_CAL_FLAG", "D", "P084", "N");   //POS정산구분
    getEtcCode("DS_I_BANK_CD", "D", "P041", "N");        //은행코드
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD,"%");
    LC_O_STR_CD.Index=0;
    //setComboData(LC_O_BUY_SALE_FLAG,"%");
    setComboData(LC_O_BIZ_TYPE,"%");
    setComboData(LC_O_USE_YN,"Y");
    
    LC_O_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}          name="NO"              width=30   align=center   </FC>'
    	             + '<FG>                     name="점"'
    	             + '<FC>id=STR_CD            name="코드"            width=50   align=center   </FC>'
    	             + '<FC>id=STR_CD            name="명"              width=60   align=left   EditStyle=Lookup    Data="DS_I_STR_CD:CODE:NAME"</FC>'
    	             + '</FG>'  
    	             + '<FC>id=COMP_NO     		 name="사업자번호"      width=110    align=center   Mask="XXX-XX-XXXXX"  </FC>'
    	             + '<FG>                     name="협력사"'
                     + '<FC>id=VEN_CD            name="코드"            width=60   align=center   </FC>'
                     + '<FC>id=VEN_NAME          name="명"              width=150   align=left    </FC>'
                     + '</FG>'       
                     + '<FC>id=BUY_SALE_FLAG     name="매입매출;구분"    width=80   align=left   EditStyle=Lookup    Data="DS_I_BUY_SALE_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=BIZ_TYPE          name="거래형태"         width=90   align=left   EditStyle=Lookup    Data="DS_I_BIZ_TYPE:CODE:NAME"</FC>'
                     + '<FC>id=EDI_YN            name="EDI;사용여부"     width=55   align=center   </FC>'
                     + '<FC>id=PAY_CYC           name="지불주기"         width=55   align=left   EditStyle=Lookup    Data="DS_I_PAY_CYC:CODE:NAME"</FC>' 
                     + '<FC>id=PAY_DT_FLAG       name="지불일;구분"      width= 50  align=left   EditStyle=Lookup    Data="DS_I_PAY_DT_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=PAY_WAY           name="지불방법"         width=60   align=left   EditStyle=Lookup    Data="DS_I_PAY_WAY:CODE:NAME"</FC>'
                     + '<FC>id=PAY_HOLI_FLAG     name="지불시기;구분"    width=80   align=left   EditStyle=Lookup    Data="DS_I_PAY_HOLI_FLAG:CODE:NAME"</FC>'       
                     + '<FC>id=RUND_FLAG         name="반올림;구분"      width=90  aling=left   EditStyle=Lookup    Data="DS_I_RUND_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=POS_CAL_FLAG      name="POS정산;구분"     width=110   align=left   EditStyle=Lookup    Data="DS_I_POS_CAL_FLAG:CODE:NAME"</FC>'        
                     + '<FC>id=BANK_CD           name="은행"             width=90   align=left   EditStyle=Lookup    Data="DS_I_BANK_CD:CODE:NAME"</FC>'
                     + '<FC>id=BANK_ACC_NO       name="입금계좌"         width=100  align=left   </FC>'
                     + '<FC>id=ACC_NO_OWN        name="예금주"           width=60   align=left   </FC>'
                     + '<FC>id=USE_YN            name="사용여부"         width=55   align=center </FC>'                  
                     + '<FC>id=BIZ_S_DT          name="거래시작일"       width=90   align=center   Mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=BIZ_E_DT          name="거래종료일"       width=90   align=center   Mask="XXXX/XX/XX"</FC>';
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
}
//+ '<FC>id=COMP_NO     name="사업자번호"    width=80   align=left  </FC>'
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
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-07
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	DS_IO_MASTER.ClearData();
	DS_I_STR_COND.UserStatus(1) = '1';
	
	strStrCd        = LC_O_STR_CD.Text;
	strCompFlag     = LC_O_COMP_FLAG.BindColVal;   //사업자구분
	strCompNo	 	= LC_O_COMP_NO.Text;		  //사업자번호
	strBizType      = LC_O_BIZ_TYPE.Text;     
	strVenCd        = EM_O_VEN_CD.Text;
	strVenNm        = EM_O_VEN_NM.Text;	
	strUseYn        = LC_O_USE_YN.Text;

	var goTo       = "searchMaster" ;    
    var action     = "O";
    TR_MAIN.Action="/dps/pcod103.pc?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET(I:DS_I_STR_COND=DS_I_STR_COND,"+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
    
    
    var sortExpr = DS_IO_MASTER.Sortexpr;
    
    DS_IO_MASTER.Sortexpr = "+STR_CD+COMP_NO+VEN_CD";
    DS_IO_MASTER.Sort();
    DS_IO_MASTER.RowPosition = "1";
    
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.07
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.07
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.07
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-03-07
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {	 
	 if (strVenCd == "")
         strVenCd = "전체";
	 if (strVenNm == "")
		 strVenNm = "전체";
	 if (strCompFlag == "" || strCompFlag == "%")
		 strCompFlag = "전체";
	 if (strCompNo == "")
		 strCompNo = "전체";
       
     var parameters = "점="+strStrCd
     				+ " -사업자구분="+strCompFlag
					+ " -사업자번호="+strCompNo
                    + " -거래형태="+strBizType                   
                    + " -협력사코드="+strVenCd
                    + " -협력사명="+strVenNm                    
                    + " -사용여부="+strUseYn;
       
   //openExcel2(GD_MASTER, "점별협력사조회", parameters, true );
   openExcel5(GD_MASTER, "점별협력사조회", parameters, true , "",g_strPid );

   
   GD_MASTER.Focus();
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.07
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.07
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

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
<!-- 협력사코드 변경시 -->
<script language=JavaScript for=EM_O_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text==''){
        EM_O_VEN_NM.Text = "";
        return;
    }   
    setVenNmWithoutPop( "DS_O_VEN_CD", this, EM_O_VEN_NM, '0');
   	  
</script>

<script language=JavaScript for=LC_O_STR_CD event=OnSelChange>
    if (LC_O_STR_CD.BindColVal != "%"){
    	strStrCdPopUp = LC_O_STR_CD.BindColVal;
    }else
    	strStrCdPopUp = "";    	
</script>
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
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
<comment id="_NSID_">
<object id="DS_O_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_COMP_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_BIZ_TYPE" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_USE_YN" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_VEN_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_I_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_BUY_SALE_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_BIZ_TYPE" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_PAY_CYC" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_PAY_DT_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_PAY_WAY" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_PAY_HOLI_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_RUND_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_POS_CAL_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_BANK_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_STR_COND" classid=<%= Util.CLSID_DATASET %>></object>
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


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80">점</th>
						<td width="165"><comment id="_NSID_"> <object id=LC_O_STR_CD
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<!-- 
						<th width="80">매입매출구분</th>
						<td width="165"><comment id="_NSID_"> <object
							id=LC_O_BUY_SALE_FLAG classid=<%= Util.CLSID_LUXECOMBO %>
							height=100 width=165 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
						</td>
						-->
						<th width="80">사업자구분</th>
						<td width="180"><comment id="_NSID_"> <object
							id=LC_O_COMP_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=140 
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						  
						<th width="80">사업자번호</th>
						<td ><comment id="_NSID_"> <object
							id=LC_O_COMP_NO classid=<%=Util.CLSID_EMEDIT%> width=140
							tabindex=1 align="left"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						
					</tr>
					<tr>
					    <th width="80">거래형태</th>
						<td><comment id="_NSID_"> <object id=LC_O_BIZ_TYPE
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">협력사</th>
						<td><comment id="_NSID_"> <object id=EM_O_VEN_CD
							classid=<%= Util.CLSID_EMEDIT %> width=55 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript: venPop(EM_O_VEN_CD , EM_O_VEN_NM , strStrCdPopUp); EM_O_VEN_CD.Focus();"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_O_VEN_NM classid=<%= Util.CLSID_EMEDIT %> width=80
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">사용여부</th>
						<td colspan="3"><comment id="_NSID_"> <object id=LC_O_USE_YN
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=165
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
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
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><object id=GD_MASTER
					width="100%" height=481 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_IO_MASTER">
				</object></comment><script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>

</table>
</td>
</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BO_STR_COND classid=<%= Util.CLSID_BIND %>>
	<param name=DataID value=DS_I_STR_COND>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=STR_CD          ctrl=LC_O_STR_CD          param=BindColVal </c>
            <c>col=COMP_FLAG       ctrl=LC_O_COMP_FLAG       param=BindColVal </c>
            <c>col=COMP_NO         ctrl=LC_O_COMP_NO           param=Text </c>
            <c>col=BIZ_TYPE        ctrl=LC_O_BIZ_TYPE        param=BindColVal </c>
            <c>col=USE_YN          ctrl=LC_O_USE_YN          param=BindColVal </c>
            <c>col=VEN_CD          ctrl=EM_O_VEN_CD          param=Text </c>
            <c>col=VEN_NM          ctrl=EM_O_VEN_NM          param=Text </c>
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

</body>
</html>

