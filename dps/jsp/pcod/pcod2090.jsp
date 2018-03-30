<!-- 
/*******************************************************************************
 * 시스템명 : 기준정보 >브랜드코드 > 대표브랜드관리
 * 작 성 일 : 2010.07.13
 * 작 성 자 : FKSS
 * 수 정 자 : 
 * 파 일 명 : pcod2090.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 공통브랜드관리
 * 이    력 : 2010.07.13
 * 
 ******************************************************************************/-->

<%@ page language="java" contentType="text/html;charset=utf-8"
   import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
   request.setCharacterEncoding("utf-8");
%>
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
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"
   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">




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
var top = 80;		//해당화면의 동적그리드top위치
function doInit(){
	
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";


    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    //그리드 초기화
    gridCreate1(); //마스터
    
    initEmEdit(EM_BRAND_CD              ,"000000"        ,NORMAL);    // 조회용 브랜드코드
    initEmEdit(EM_BRAND_NM              ,"GEN"          ,NORMAL);    // 조회용 브랜드명
    initEmEdit(EM_E_MAIL              ,"GEN"        ,NORMAL);    // 조회용 브랜드코드
    
    initEmEdit(EM_TEL_NO1              ,"000"         ,NORMAL);    // 조회용 브랜드코드
    initEmEdit(EM_TEL_NO2              ,"0000"        ,NORMAL);    // 조회용 브랜드코드
    initEmEdit(EM_TEL_NO3              ,"0000"        ,NORMAL);    // 조회용 브랜드코드
    
    initEmEdit(EM_O_VEN, "CODE^6^0", NORMAL);         //협력사(조회)
    initEmEdit(EM_O_VEN_NM, "GEN^40", NORMAL);        //협력사(조회)
    initComboStyle(LC_STR_CD,DS_STR_CD,	"CODE^0^30,NAME^0^140",	1, PK);									//점(조회)
   
    // 20120507 * DHL * 주석처리 -->
    // initComboStyle(LC_BRAND_GB,DS_BRAND_GB, "CODE^0^30,NAME^0^80", 1, NORMAL);  //브랜드 구분(조회)
    // getEtcCode("DS_BRAND_GB", "D", "D100", "N");                        //브랜드구분
    // insComboData( LC_BRAND_GB, "%", "전체",1);
    // LC_BRAND_GB.Index = 0;
    // 20120507 * DHL * 주석처리 <--

 	
 	var	strcd	= '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';								// 로그인 점코드
	var	strOrgFlag='<c:out value="${sessionScope.sessionInfo.ORG_FLAG}"	/>';	
	getStore2("DS_STR_CD", "Y",	"1", "Y", strOrgFlag);													//점
	
	
	LC_STR_CD.BindColVal  =	strcd;
	
	//EM_BRAND_NM.text = "나이키";
	//EM_E_MAIL.text = "000663";
	//EM_BRAND_NM2.text = "나이키";
    
    registerUsingDataset("pcod209","DS_IO_MASTER" );
}

 function gridCreate1(){
     var hdrProperies =   '<FC>id=SEL               name=""            		 	 width=30    EditStyle=CheckBox HeadCheckShow="true" align=center</FC>'
    	 				+ '<FC>id=VEN_CD          	name="협력사코드"            width=70    edit = none align=center</FC>'
	        			+ '<FC>id=VEN_NAME          name="협력사명"              width=135   edit = none align=left</FC>'
	        			+ '<FC>id=PUMBUN_CD         name="브랜드코드"            width=70    edit = none align=center</FC>'
				        + '<FC>id=PUMBUN_NAME       name="브랜드명"              width=135   edit = none align=left</FC>'
				        + '<FC>id=E_MAIL            name="이메일"            	 width=200   edit = none align=left</FC>'
				        + '<FC>id=TEL_NO1            name="매장"            	 width=35   edit = none align=left</FC>'
				        + '<FC>id=TEL_NO2            name="전화"            	 width=40   edit = none align=left</FC>'
				        + '<FC>id=TEL_NO3            name="번호"            	 width=40   edit = none align=left</FC>'
				         ;
  
     initGridStyle(GD_MASTER, "common", hdrProperies, true);
     GD_MASTER.DecRealData = true;
     
     
     GD_MASTER.ColumnProp('REP_PUMBUN_CD', 'Suppress') = "1";
     GD_MASTER.ColumnProp('REP_PUMBUN_NAME', 'Suppress') = "1";
     GD_MASTER.ColumnProp('VEN_CD', 'Suppress') = "2";
     GD_MASTER.ColumnProp('VEN_NAME', 'Suppress') = "2";
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
 * 작 성 자 : FKSS
 * 작 성 일 : 2010-07-13
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    //저장체크
    if (DS_IO_MASTER.IsUpdated ){
    	ret = showMessage(QUESTION, YESNO, "USER-1084");
        if (ret != "1") {
            return false;
        } 
    }
    DS_IO_MASTER.ClearData();

    // 20120507 * DHL * 주석처리 -->
    // var strBrandGb    = LC_BRAND_GB.BindColVal;   //브랜드구분
    // 20120507 * DHL * 주석처리 <--
    var strBrandCd    = EM_BRAND_CD.text;  //브랜드 코드
    var strBrandNm    = EM_BRAND_NM.text;  //브랜드명
    var strVenCd      = EM_O_VEN.text;  
    var strVenNm      = EM_O_VEN_NM.text;  
    var strCd         = LC_STR_CD.BindColVal;
      
    var goTo         = "searchMaster";
    var action       = "O";

    var parameters   = "&strBrandCd="          + encodeURIComponent(strBrandCd)
                     + "&strBrandNm="          + encodeURIComponent(strBrandNm)
                     + "&strVenCd="            + encodeURIComponent(strVenCd)
                     + "&strVenNm="            + encodeURIComponent(strVenNm)
                     + "&strCd="          	   + encodeURIComponent(strCd)

                     ;
	// 20120507 * DHL * 수정  <--

	
	
    TR_MAIN.Action   = "/dps/pcod209.pc?goTo=" + goTo + parameters;
    TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_IO_MASTER=DS_IO_MASTER)"; 
    TR_MAIN.Post();

    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
    if(DS_IO_MASTER.CountRow > 0){
    	//setFocusGrid(GD_MASTER, DS_IO_MASTER, 1, "STD_WEIGHT");
        GD_MASTER.Focus();
    }
    
}

/**
 * btn_New()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-23
 * 개     요 : Grid 레코드 추가// 영업시작일자 기준으로 해당 월의 마지막 날까지 레코드 추가
 * return값 : void
 */
function btn_New() {
	   
	   DS_IO_MASTER.Addrow(); 
	   setFocusGrid(GD_MASTER,DS_IO_MASTER, DS_IO_MASTER.RowPosition ,"BRAND_NM");  

}

/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : void
 */
function btn_Delete() {
	
	
	if (!DS_IO_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }    
	 
	   if( showMessage(QUESTION, YESNO, "USER-1023") == 1 ){
			   
			var parameters   = "&strBrandCd=" + encodeURIComponent(EM_E_MAIL.text);  //브랜드 코드;
			
			TR_MAIN.Action="/dps/pcod209.pc?goTo=del" + parameters;
			TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
			TR_MAIN.Post();
			
			btn_Search();
			
			GD_MASTER.Focus(); 
	    }
	 
}

/**
 * btn_Save()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-23
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	 // 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }    
	 
    
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 )
        return;
    
    
    
    var parameters   = "&strEmail=" + encodeURIComponent(EM_E_MAIL.text)
    				 + "&strTel_no1=" + encodeURIComponent(EM_TEL_NO1.text)
    				 + "&strTel_no2=" + encodeURIComponent(EM_TEL_NO2.text)
    				 + "&strTel_no3=" + encodeURIComponent(EM_TEL_NO3.text)
    				 + "&strStrCd=" + encodeURIComponent(LC_STR_CD.BindColVal)
    					;  //브랜드 코드;
    
    TR_MAIN.Action="/dps/pcod209.pc?goTo=save" + parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();

    btn_Search();
}

/**
 * btn_Excel()
 * 작 성 자 :  
 * 작 성 일 :  
 * 개     요 :  
 * return값 : void
 */
function btn_Excel() {
	 
	// 20120507 * DHL 주석처리 -->
    // var strBrandGb    = LC_BRAND_GB.Text;   //브랜드구분
    // 20120507 * DHL 주석처리 <--
    var strBrandCd    = EM_BRAND_CD.text;  //브랜드 코드
    var strBrandNm    = encodeURIComponent(EM_BRAND_NM.text);  //브랜드명

    // 20120507 * DHL 주석처리 -->
    // if (strBrandCd == "") strBrandCd = "전체";
    // 20120507 * DHL 주석처리 <--
    
    if (strBrandNm == "") strBrandNm = "전체";
    
    // 20120507 * DHL 주석처리 -->
    /*
    var parameters = "브랜드구분="+strBrandGb
                   + " -브랜드코드="+strBrandCd
                   + " -브랜드명="+strBrandNm;
    */
    var parameters = "브랜드코드="+strBrandCd
                   + " -브랜드명="+strBrandNm;
    // 20120507 * DHL 주석처리 <--
	
    var strTitle = "${sessionScope.title}";
	
	openExcel2(GD_MASTER, strTitle, parameters, true );
	GD_MASTER.Focus();
}

/**
 * btn_Print()
 * 작 성 자 :  
 * 작 성 일 :  
 * 개     요 :  
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 :  
 * 개     요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * setBrandCd()
  * 작 성 자 : 
  * 작 성 일 : 2010-03-10
  * 개    요 : 브랜드를 조회함
  * return값 : void
  */
 function setBrandCd(evnFlag, selInGb,codeObj, nameObj){
 
    if( evnFlag == 'POP'){
    	getBrandPop(codeObj,nameObj,'N')
        codeObj.Focus();        
        return;
    }
    
    if( codeObj.Text == ""){
        nameObj.Text = "";
        return;
    }
    
    setStrBrdNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj, 1);
 } 
 
 /**
  * setVenCode()
  * 작 성 자 : 정진영
  * 작 성 일 : 2010-02-28
  * 개    요 : 협력사 팝업을 실행한다.
  * return값 : void
 **/
 function setVenCode(evnFlag, svcFlag, codeObj, nameObj){
     
     if( evnFlag == 'POP'){
     	venPop(codeObj,nameObj,'',svcFlag=='I'?'Y':'');
         codeObj.Focus();
         if(svcFlag=="I"){
             searchVenmst(EM_I_VEN);
             return;
         }
         return;
     }

     if( codeObj.Text =="" ){
         nameObj.Text = "";
         return;
     }
     
     setVenNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj , svcFlag=='I'?1:0,'',svcFlag=='I'?'Y':'');
 	
     if(svcFlag=="I"){
         searchVenmst(EM_I_VEN);
         return;
     }
 }

 /**
  * setPumbunCode()
  * 작 성 자 : 정진영
  * 작 성 일 : 2010-02-28
  * 개    요 : 브랜드 팝업을 실행한다.
  * return값 : void
 **/
 function setPumbunCode(evnFlag, svcFlag, codeObj, nameObj){
     
     if( evnFlag == 'POP'){
     	strPbnPop(codeObj,nameObj,'N')
         codeObj.Focus();        
         return;
     }
     
     if( codeObj.Text == ""){
         nameObj.Text = "";
         return;
     }
     
     setStrPbnNmWithoutPop("DS_SEARCH_NM", codeObj, nameObj , 'N', 0);
 }

 
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

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>
    old_Row = row;
</script>

<script language=JavaScript for=DS_IO_MASTER event=CanRowPosChange(row)>

return true;
</script>
<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,olddata)>

</script>
<script language=JavaScript for=GD_MASTER event=CanColumnPosChange(row,colid)>

</script>
<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>

</script>

<script language=JavaScript for=EM_BRAND_CD event=OnKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
	setPumbunCode('NAME','S',EM_BRAND_CD,EM_BRAND_NM);
</script>



<script language=JavaScript for=EM_O_REC_PUMBUN event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
       return;
    setRecPumbunCode('NAME',EM_O_REC_PUMBUN,EM_O_REC_PUMBUN_NM);
</script>
<script language=JavaScript for=EM_I_REC_PUMBUN event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setRecPumbunCode('NAME',EM_I_REC_PUMBUN,EM_I_REC_PUMBUN_NM);
</script>
<script language=JavaScript for=EM_O_VEN event=OnKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setVenCode('NAME','S',EM_O_VEN,EM_O_VEN_NM);
</script>
<script language=JavaScript for=EM_I_VEN event=OnKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
    setVenCode('NAME','I',EM_I_VEN,EM_I_VEN_NM);
</script>
<script language=JavaScript for=EM_O_PUMBUN event=OnKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
    setPumbunCode('NAME','S',EM_O_PUMBUN,EM_O_PUMBUN_NM);
</script>

<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>

    //헤더 전체 체크/체크해제 컨트롤
    if (bCheck == '1'){ // 전체체크
        for(var i=1; i<=DS_IO_MASTER.CountRow; i++){
            DS_IO_MASTER.NameValue(i, "SEL") = 'T';
        }
    }else{  // 전체체크해제
        for (var i=1; i<=DS_IO_MASTER.CountRow; i++){
            DS_IO_MASTER.NameValue(i, "SEL") = 'F';
        }
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
<comment id="_NSID_"><object id="DS_STR_CD"			classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- 검색용 -->

<!-- 
<comment id="_NSID_">
<object id="DS_BRAND_GB"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
 -->

<comment id="_NSID_">
<object id=DS_I_CONDITION classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_I_COMMON classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_MASTER"  classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_SEARCH_NM" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
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
<table width="100%"  border="0" cellspacing="0" cellpadding="0">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
 
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
            <!-- 
            <th width="80" class="point">브랜드구분</th>
            <TD width="180">
                     <comment id="_NSID_">
                        <object id=LC_BRAND_GB classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1  align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>

            </TD>
             -->
            <th width="70" class="point">점</th>
			<td width="120"><comment id="_NSID_"> <object
					id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=110
					tabindex=1 align="absmiddle"> </object> </comment>
				<script>
					_ws_(_NSID_);
				</script>
			</td>
			
            <th width="80">브랜드</th>
            <td width="200">
              <comment id="_NSID_">
                <object id=EM_BRAND_CD classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  onclick="javascript:strPbnPop(EM_BRAND_CD,EM_BRAND_NM, 'Y');"  align="absmiddle" />
              <comment id="_NSID_">
                <object id=EM_BRAND_NM classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1 align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
            </td>
            <th width="80">협력사</th>
			<td width="200"><comment id="_NSID_"> <object id=EM_O_VEN
				classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
				align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
				src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
				onclick="javascript:setVenCode('POP','S',EM_O_VEN,EM_O_VEN_NM)"
				align="absmiddle" /> <comment id="_NSID_"> <object
				id=EM_O_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
				align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
            
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  
  <tr>
    <td class="dot"></td>
  </tr>

  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td><table width="800" border="0" cellspacing="0" cellpadding="0"  class="BD4A">
          <tr>
            <td width="1000">
                <comment id="_NSID_">
                    <OBJECT id=GD_MASTER width=100% height=495 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_IO_MASTER">
                    </OBJECT>
                </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
        <td valign="top" align="left" width=100%>
            	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
            		<tr>
						<td colspan=2 aligh=left></td>
					</tr>
					<tr>
				      <th width="80" >이메일</th>
				            <td width="200">
				              <comment id="_NSID_">
				                <object id=EM_E_MAIL classid=<%=Util.CLSID_EMEDIT%> width=200 tabindex=1 align="absmiddle"></object>
				              </comment><script> _ws_(_NSID_);</script>
					</td>
					</tr>
					<tr>
				      <th width="80" >매장전화번호</th>
				            <td width="200">
				              <comment id="_NSID_">
				                <object id=EM_TEL_NO1 classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=1 align="absmiddle"></object>
				              </comment><script> _ws_(_NSID_);</script>-
				              <comment id="_NSID_">
				                <object id=EM_TEL_NO2 classid=<%=Util.CLSID_EMEDIT%> width=35 tabindex=1 align="absmiddle"></object>
				              </comment><script> _ws_(_NSID_);</script>-
				              <comment id="_NSID_">
				                <object id=EM_TEL_NO3 classid=<%=Util.CLSID_EMEDIT%> width=35 tabindex=1 align="absmiddle"></object>
				              </comment><script> _ws_(_NSID_);</script>
					</td>
					</tr>
					<tr>
						<td colspan=2 aligh=left>
<pre>

※사용방법
한건 변경시 변경할 브랜드 선택 후 이메일정보 입력 저장
여러건 변경할시 리스트 왼쪽 체크박스를 선택하여 변경할 메일 주소 입력 저장
	
※주의사항
이메일정보를 잘못입력시 다른사람에게 매출정보가 발송되오니 정확히 입력바랍니다. 
	
매장전화번호는 PDA결제시 영수증에 해당브랜드 매장전화번호를 출력합니다.  

</pre>
						</td>
					</tr>
				 </table>
            </td>
        
      </tr>
    </table>
   </td>
 </tr>
  
</table>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_"> <object id=BO_MASTER	classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
        <c>Col=E_MAIL              Ctrl=EM_E_MAIL               param=Text</c>
        <c>Col=TEL_NO1             Ctrl=EM_TEL_NO1               param=Text</c>
        <c>Col=TEL_NO2             Ctrl=EM_TEL_NO2               param=Text</c>
        <c>Col=TEL_NO3             Ctrl=EM_TEL_NO3               param=Text</c>
        '>
</object> </comment><script>_ws_(_NSID_);</script> 
</body>
</html>

