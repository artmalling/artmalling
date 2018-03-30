<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 마진코드> 마진조회
 * 작 성 일 : 2010.03.15
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pcod3020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 마진을 조회한다.
 * 이    력 :
 *        2010.03.15 (이재득) 신규작성
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
var strVenCd        = "";
var strVenNm        = "";
var strPumbunCd     = "";
var strPumbunNm     = "";
var strMgFlag       = "";
var strRepVenCd     = "";     
var strRepVenNm     = "";
var strRepPumbunCd  = "";
var strRepPumbunNm  = "";
var strEventCd      = "";
var strEventNm      = "";
var strEventDT      = "";
var g_strPid           = "<%=pageName%>";                 // PID

/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화
    DS_I_MAR_COND.setDataHeader(
    		 'STR_CD:STRING(2)'
            +',MG_FLAG:STRING(1)'
            +',REP_PUMBUN_CD:STRING(6)'
            +',REP_VEN_CD:STRING(6)'
            +',VEN_CD:STRING(6)'
            +',VEN_NM:STRING(40)'
            +',PUMBUN_CD:STRING(6)'
            +',PUMBUN_NM:STRING(40)'
            +',EVENT_CD:STRING(11)'
            +',EVENT_DT:STRING(8)');   
    DS_I_MAR_COND.ClearData();
    DS_I_MAR_COND.Addrow();
    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    //그리드 초기화
    gridCreate1(); //마스터

    // EMedit에 초기화    
    initEmEdit(EM_O_VEN_CD, "CODE^6^0", NORMAL);         //협력사코드
    initEmEdit(EM_O_VEN_NM, "GEN^40", NORMAL);           //협력사명
    initEmEdit(EM_O_PUMBUN_CD, "CODE^6^0", NORMAL);      //브랜드코드
    initEmEdit(EM_O_PUMBUN_NM, "GEN^40", NORMAL);        //브랜드명 
    initEmEdit(EM_O_REP_VEN_CD, "CODE^6^0", NORMAL);     //대표협력사코드
    initEmEdit(EM_O_REP_VEN_NM, "GEN^40", READ);         //대표협력사명  
    initEmEdit(EM_O_REP_PUMBUN_CD, "CODE^6^0", NORMAL);  //대표브랜드코드
    initEmEdit(EM_O_REP_PUMBUN_NM, "GEN^40", READ);      //대표브랜드명       
    initEmEdit(EM_O_EVENT_CD, "CODE^11^#", NORMAL);      //행사코드
    initEmEdit(EM_O_EVENT_NM, "GEN^40", READ);           //행사명  
    initEmEdit(EM_O_EVENT_DT,  "TODAY",   NORMAL);         // 조회기간1
    
    //콤보 초기화 
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^110", 1, PK);    //점
    initComboStyle(LC_O_MG_FLAG,DS_O_MG_FLAG, "CODE^0^30,NAME^0^100", 1, NORMAL);  //마진구분
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )     
    getEtcCode("DS_O_MG_FLAG", "D", "P016", "Y");     //마진구분(조회)  
    getEtcCode("DS_I_MG_FLAG", "D", "P016", "N");     //마진구분  
        
    //점콤보 가져오기 ( gauce.js )     
    getStore("DS_O_STR_CD", "Y", "", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_O_STR_CD.Index < 0){
        LC_O_STR_CD.Index= 0;
    }
    setComboData(LC_O_MG_FLAG,"%");
    
    LC_O_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}          name="NO"              width=30    align=center  </FC>'
    	             + '<FG>                     name="브랜드"'
                     + '<FC>id=PUMBUN_CD         name="코드"            width=60    align=center  </FC>'
                     + '<FC>id=PUMBUN_NAME       name="명"              width=130   align=left    </FC>'
                     + '</FG>'
                     + '<FC>id=FLOOR_NM	         name="층"              width=60   align=center    </FC>'
                     + '<FC>id=MG_FLAG           name="마진구분"         width=110    align=left    EditStyle=Lookup    Data="DS_I_MG_FLAG:CODE:NAME" </FC>'
                     + '<FG>                     name="마진코드"'
                     + '<FC>id=EVENT_FLAG        name="행사구분"         width=55    align=center  </FC>'
                     + '<FC>id=EVENT_RATE        name="행사율"           width=55    align=center  </FC>'
                     + '</FG>'
                     + '<FC>id=NORM_MG_RATE      name="정상;마진율"      width=55    align=right   </FC>'
                     + '<FC>id=EVENT_MG_RATE     name="행사;마진율"      width=55    align=right   </FC>' 
                     + '<FC>id=REMARK            name="행사구분명"       width=200    align=left   </FC>' 
                     + '<FC>id=RENTB_MGAPP_NAME  name="수수료구분 "      width=70   align=left    </FC>'
                     + '<FC>id=BAS_AMT           name="기준금액"        width=100  align=right    </FC>'
                     + '<FC>id=APP_S_DT          name="적용시작일"       width=90    align=center   Mask="XXXX/XX/XX"</FC>'
                     + '<FC>id=APP_E_DT          name="적용종료일"       width=90    align=center   Mask="XXXX/XX/XX"</FC>'
                     + '<FG>                     name="행사"'
                     + '<FC>id=EVENT_CD          name="코드"            width=110   align=center  </FC>'
                     + '<FC>id=EVENT_NAME        name="명"              width=120   align=left    </FC>'
                     + '</FG>'
                     + '<FG>                     name="협력사"'                     
                     + '<FC>id=VEN_CD            name="코드"            width=60    align=center  </FC>'   
                     + '<FC>id=VEN_NAME          name="명"              width=150   align=left    </FC>'
                     + '</FG>';
                     
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
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	DS_IO_MASTER.ClearData();
	DS_I_MAR_COND.UserStatus(1) = '1';
	
	strStrCd        = LC_O_STR_CD.Text;
	strVenCd        = EM_O_VEN_CD.Text;
    strVenNm        = EM_O_VEN_NM.Text;
    strPumbunCd     = EM_O_PUMBUN_CD.Text;
    strPumbunNm     = EM_O_PUMBUN_NM.Text;
	strMgFlag       = LC_O_MG_FLAG.Text;
	strRepVenCd     = EM_O_REP_VEN_CD.Text;     
	strRepVenNm     = EM_O_REP_VEN_NM.Text;
	strEventCd      = EM_O_EVENT_CD.Text;
	strEventNm      = EM_O_EVENT_NM.Text;
	strRepPumbunCd  = EM_O_REP_PUMBUN_CD.Text;
	strRepPumbunNm  = EM_O_REP_PUMBUN_NM.Text;
	strEventDT      = EM_O_EVENT_DT.Text;
	
	var goTo       = "searchMaster" ;    
    var action     = "O";
    TR_MAIN.Action="/dps/pcod302.pc?goTo="+goTo;  
    TR_MAIN.KeyValue="SERVLET(I:DS_I_MAR_COND=DS_I_MAR_COND,"+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	 if (strRepPumbunCd == "")
		 strRepPumbunCd = "전체";
     if (strRepPumbunNm == "")
    	 strRepPumbunNm = "전체";
	 if (strVenCd == "")
         strVenCd = "전체";
	 if (strVenNm == "")
		 strVenNm = "전체";
	 if (strRepVenCd == "")
         strRepVenCd = "전체";
     if (strRepVenNm == "")
         strRepVenNm = "전체";
	 if (strPumbunCd == "")
		 strPumbunCd = "전체";
     if (strPumbunNm == "")
    	 strPumbunNm = "전체";
     if (strEventCd == "")
         strEventCd = "전체";
     if (strEventNm == "")
         strEvnetNm = "전체";
     if (strEventCd == "")
    	 strEventCd = "전체";
     if (strEventDT == "")
         strEventDT = "전체";
       
     var parameters = "점="+strStrCd                   
                    + " -협력사코드="+strVenCd
                    + " -협력사명="+strVenNm                    
                    + " -브랜드코드="+strPumbunCd
                    + " -브랜드명="+strPumbunNm
    	            + " -마진구분="+strMgFlag
                    + " -대표협력사코드="+strRepVenCd                   
                    + " -대표협력사명="+strRepVenNm
                    + " -대표브랜드코드="+strRepPumbunCd
                    + " -대표브랜드명="+strRepPumbunNm  
                    + " -행사코드="+strEventCd  
                    + " -행사명="+strEventNm
                    + " -적용기준일="+strEventDT;
       
   //openExcel2(GD_MASTER, "마진조회", parameters, true );
   openExcel5(GD_MASTER, "마진조회", parameters, true , "",g_strPid );

   
   GD_MASTER.Focus();
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.03.15
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

<!-- 브랜드코드 변경시 -->
<script language=JavaScript for=EM_O_PUMBUN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_O_PUMBUN_NM.Text = "";
        return;
    }   
    setStrPbnNmWithoutPop( "DS_O_PUMBUN_CD", this, EM_O_PUMBUN_NM, 'Y', '0');
</script>

<!-- 대표협력사코드 변경시 -->
<script language=JavaScript for=EM_O_REP_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_O_REP_VEN_NM.Text = "";
        return;
    }   
    setRepVenNmWithoutPop( "DS_O_REP_VEN_CD", this, EM_O_REP_VEN_NM, '1');
</script>

<!-- 대표브랜드코드 변경시 -->
<script language=JavaScript for=EM_O_REP_PUMBUN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_O_REP_PUMBUN_NM.Text = "";
        return;
    }   
    setRepPumbunNmWithoutPop( "DS_O_REP_PUMBUN_CD", this, EM_O_REP_PUMBUN_NM, 'Y', '1');
</script>

<!-- 행사코드 변경시 -->
<script language=JavaScript for=EM_O_EVENT_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_O_EVENT_NM.Text = "";
        return;
    }   
    setEventNmWithoutPop( "DS_O_EVENT_CD", this, EM_O_EVENT_NM, '1');
</script>

<!-- 적용기준일 -->
<script language=JavaScript for=EM_O_EVENT_DT event=onKillFocus()>
    if(!checkDateTypeYMD(this,getRawData(addDate('D',0,getTodayFormat('YYYYMMDD')))))
        return;
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
<object id="DS_O_MG_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
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
<object id="DS_O_REP_PUMBUN_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_VEN_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PUMBUN_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_REP_VEN_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_EVENT_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_I_MG_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_MAR_COND" classid=<%= Util.CLSID_DATASET %>></object>
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
<body onLoad="doInit();" class="PL10 PT15">
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
						<th width="80" class="point">점</th>						
						<td width="165"><comment id="_NSID_"> <object id=LC_O_STR_CD
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=150
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">협력사</th>						
						<td width="166"><comment id="_NSID_"> <object id=EM_O_VEN_CD
							classid=<%= Util.CLSID_EMEDIT %> width=55 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript: venPop(EM_O_VEN_CD,EM_O_VEN_NM); EM_O_VEN_CD.Focus();"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_O_VEN_NM classid=<%= Util.CLSID_EMEDIT %> width=80
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">브랜드</th>						
						<td><comment id="_NSID_"> <object id=EM_O_PUMBUN_CD
							classid=<%= Util.CLSID_EMEDIT %> width=55 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript: strPbnPop(EM_O_PUMBUN_CD,EM_O_PUMBUN_NM , 'Y'); EM_O_PUMBUN_CD.Focus();"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_O_PUMBUN_NM classid=<%= Util.CLSID_EMEDIT %> width=82
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>  
					<tr>
						<th width="80">마진구분</th>
						<td><comment id="_NSID_"> <object id=LC_O_MG_FLAG
							classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=150
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">대표협력사</th>
						<td><comment id="_NSID_"> <object
							id=EM_O_REP_VEN_CD classid=<%= Util.CLSID_EMEDIT %> width=55
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript: repVenPop(EM_O_REP_VEN_CD,EM_O_REP_VEN_NM ); EM_O_REP_VEN_CD.Focus();"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_O_REP_VEN_NM classid=<%= Util.CLSID_EMEDIT %> width=80
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">대표브랜드</th>
						<td><comment id="_NSID_"> <object
							id=EM_O_REP_PUMBUN_CD classid=<%= Util.CLSID_EMEDIT %> width=55
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript: repPumbunPop(EM_O_REP_PUMBUN_CD,EM_O_REP_PUMBUN_NM , 'Y'); EM_O_REP_PUMBUN_CD.Focus();"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_O_REP_PUMBUN_NM classid=<%= Util.CLSID_EMEDIT %> width=82
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
					<tr>
						<th width="80">행사코드</th>
						<td colspan="3"><comment id="_NSID_"> <object id=EM_O_EVENT_CD
							classid=<%= Util.CLSID_EMEDIT %> width=143 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript: eventPop(EM_O_EVENT_CD,EM_O_EVENT_NM); EM_O_EVENT_CD.Focus();"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_O_EVENT_NM classid=<%= Util.CLSID_EMEDIT %> width=259
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">적용기준일</th>
						<td><comment id="_NSID_"> <object
                            id=EM_O_EVENT_DT classid=<%=Util.CLSID_EMEDIT%> width=138
                            align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
                            src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                            onclick="javascript:openCal('G',EM_O_EVENT_DT)" align="absmiddle" /></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PT5">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><OBJECT id=GD_MASTER
					width="100%" height=455 classid=<%=Util.CLSID_GRID%>>
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
<object id=BO_MAR_COND classid=<%= Util.CLSID_BIND %>>
	<param name=DataID value=DS_I_MAR_COND>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
            <c>col=STR_CD           ctrl=LC_O_STR_CD          param=BindColVal </c>
            <c>col=MG_FLAG          ctrl=LC_O_MG_FLAG         param=BindColVal </c>
            <c>col=REP_PUMBUN_CD    ctrl=EM_O_REP_PUMBUN_CD   param=Text </c>
            <c>col=REP_VEN_CD       ctrl=EM_O_REP_VEN_CD      param=Text </c>
            <c>col=VEN_CD           ctrl=EM_O_VEN_CD          param=Text </c>
            <c>col=VEN_NM           ctrl=EM_O_VEN_NM          param=Text </c>
            <c>col=PUMBUN_CD        ctrl=EM_O_PUMBUN_CD       param=Text </c>
            <c>col=PUMBUN_NM        ctrl=EM_O_PUMBUN_NM       param=Text </c>
            <c>col=EVENT_CD         ctrl=EM_O_EVENT_CD        param=Text </c>
            <c>col=EVENT_DT         ctrl=EM_O_EVENT_DT        param=Text </c>            
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>

</body>
</html>

