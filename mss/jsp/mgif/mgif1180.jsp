<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 마스터 관리> 상품권상태내역조회
 * 작 성 일 : 2011.04.06
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif118.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2016.11.01 류현민 프로그램 작성 
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
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

 var btnSearchClick = false;
 var btnSaveClick = false;
 var strToday;
 var strCurRow = 0;
 var strAppDt = replaceStr(addDate('D', +1, getTodayFormat("yyyymmdd")), "-","");
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-14
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 120;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID

function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
 	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
 	
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');

	gridCreate(); //마스터	 

    
    initComboStyle(LC_SEL_IN_STR,DS_O_MAIN_STR_CD, 		   "CODE^0^30,NAME^0^80",  1, PK);      //점구분
    initComboStyle(LC_SEL_STAT_FLAG, DS_STAT_FLAG, 		   "CODE^0^30,NAME^0^80",  1, NORMAL);  //상태
    initComboStyle(LC_SEL_GIFT_TYPE_CD,DS_GIFT_TYPE_CD,    "CODE^0^50,NAME^0^100", 1, NORMAL);         //상품권 종류
    initComboStyle(LC_SEL_GIFT_AMT_TYPE,DS_GIFT_AMT_TYPE,  "CODE^0^50,NAME^0^100", 1, NORMAL);         //금종

    
    initEmEdit(EM_S_DT_S, "SYYYYMMDD", PK);     //시작일
    initEmEdit(EM_E_DT_E, "TODAY",     PK);     //종료일
    initEmEdit(EM_GIFT_NO, "GEN^18", NORMAL);   // 상품권번호



    getStore("DS_O_MAIN_STR_CD",    "N", "","N");  //입고점 구분
    
    getEtcCode("DS_STAT_FLAG","D",  "M074", "Y");   //상태
    getEtcCode("DS_POUT_FLAG","D",  "M007", "Y");   //불출구분
    getEtcCode("DS_POUT_TYPE","D",  "M014", "Y");   //불출유형
    getEtcCode("DS_SALE_FLAG","D",  "M067", "Y");   //판매구분 
    getEtcCode("DS_DRAWL_FLAG","D", "M076", "Y");   //회수구분 
    getEtcCode("DS_DRAWL_FLAG","D", "M076", "Y");   //회수구분 
    


    
    getEtcCodeSub_Type();      //상품권 종류
    getEtcCodeSub_Amt();	   //금종

    //그리드 초기화
    LC_SEL_IN_STR.Index = 0;
    LC_SEL_STAT_FLAG.Index = 0;
    LC_SEL_GIFT_TYPE_CD.Index = 0;
    
    }
function gridCreate(){
    var hdrProperies = '<FC>id={currow}          name="NO"             width=40     edit=none align=center </FC>'
                     + '<FC>id=GIFT_TYPE_NAME    name="상품권종류"     width=80     edit=none align=left   </FC>'
                     + '<FC>id=GIFT_AMT_TYPE     name="금종"           width=80     edit=none align=left   </FC>'
                     + '<FC>id=GIFTCARD_NO       name="상품권번호"     width=130    edit=none align=center </FC>'
                     + '<FC>id=STAT_FLAG         name="상태"           width=75     edit=none align=center EditStyle=Lookup  Data="DS_STAT_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=IN_DT             name="입고일자"       width=90     edit=none align=center Mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=POUT_DT           name="불출일자"       width=90     edit=none align=center Mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=ORG_NAME          name="불출부서"       width=110    edit=none align=center </FC>'
                     + '<FC>id=POUT_FLAG         name="불출구분"       width=80     edit=none align=center EditStyle=Lookup  Data="DS_POUT_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=POUT_TYPE         name="불출유형"       width=100    edit=none align=center EditStyle=Lookup  Data="DS_POUT_TYPE:CODE:NAME" </FC>'
                     + '<FC>id=SALE_DT           name="판매일자"       width=90     edit=none align=center Mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=SALE_FLAG         name="판매구분"       width=110     edit=none align=center EditStyle=Lookup  Data="DS_SALE_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=SALE_PART_NM      name="판매부서"       width=110    edit=none align=center </FC>'
                     + '<FC>id=DRAWL_DT          name="회수일자"       width=90     edit=none align=center Mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=DRAWL_FLAG        name="회수구분"       width=110     edit=none align=center EditStyle=Lookup  Data="DS_DRAWL_FLAG:CODE:NAME"</FC>'
                     + '<FC>id=ACDT_FLAG         name="사고여부"       width=80     edit=none align=center </FC>'
                     + '<FC>id=ACDT_REG_DT       name="사고일자"       width=90     edit=none align=center Mask="XXXX/XX/XX" </FC>'
                     + '<FC>id=ACDT_NO           name="사고번호"       width=80     edit=none align=center </FC>'
                     + '<FC>id=ACDT_PROC_FLAG    name="사고처리구분"   width=80     edit=none align=center </FC>'
                     + '<FC>id=ACDT_RSN_CD       name="사고사유"       width=80     edit=none align=center </FC>'
                     ;
				     
                    
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    
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
 * 작 성 자 : 장형욱
 * 작 성 일 : 2010-03-29
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
	
	if( EM_S_DT_S.TEXT == ''){
        // (점)은/는 반드시 선택해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1002", "날짜");
        EM_S_DT_S.Focus();
        return;
        }
    if( EM_E_DT_E.TEXT == ''){
            // (점)은/는 반드시 선택해야 합니다.
            showMessage(EXCLAMATION, OK, "USER-1002", "날짜");
            EM_E_DT_E.Focus();
            return;
        }

    var goTo        = "searchMaster"; 
    var strGiftType = LC_SEL_GIFT_TYPE_CD.BindColval;
    var strStatFlag = LC_SEL_STAT_FLAG.BindColval;
    var strAmtType  = LC_SEL_GIFT_AMT_TYPE.BindColval;
    var strSdts     = EM_S_DT_S.TEXT;
    var strEdte     = EM_E_DT_E.TEXT;
    var strGiftNo   = EM_GIFT_NO.Text; //상품권 번호
    
    var parameters  = "&strGiftType="	+encodeURIComponent(strGiftType)
    			    + "&strStatFlag="	+encodeURIComponent(strStatFlag)
    			    + "&strSdts="		+encodeURIComponent(strSdts)
    			    + "&strEdte="		+encodeURIComponent(strEdte)
    			    + "&strAmtType="    +encodeURIComponent(strAmtType)
    			    + "&strGiftNo=" 	+encodeURIComponent(strGiftNo) 
    			  ;
                  
    TR_MAIN.Action  = "/mss/mgif118.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue= "SERVLET(O:DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    setPorcCount("SELECT", GD_MASTER);
    
   
}

/**
 * btn_Excel()
 * 작 성 자 : 강진
 * 작 성 일 : 2012.05.23
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	 
	 var strGiftType = LC_SEL_GIFT_TYPE_CD.BindColval;
	    var strStatFlag = LC_SEL_STAT_FLAG.BindColval;
	    var strAmtType  = LC_SEL_GIFT_AMT_TYPE.BindColval;
	    var strSdts     = EM_S_DT_S.TEXT;
	    var strEdte     = EM_E_DT_E.TEXT;
    
	 var parameters = "";
		 parameters  = "상품권 종류="+strGiftType     
		             + " -상태="+ strStatFlag
		             + " -금종="+ strAmtType
			    	 + " -조회기간="+ strSdts
			    	 + "~"+ strEdte
			    	 
			    	 ;
	//openExcel2(GD_MASTER, "상품권상태조회", parameters, true );
	openExcel5(GD_MASTER, "상품권상태조회", parameters, true , "",g_strPid );
}

 
/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  *	getEtcCodeSub_Type()
  *	작 성 자 : 김정민
  *	작 성 일 : 2011-04-14
  *	개	  요 : 상품권종류 
  *	return값 : void
  */
function getEtcCodeSub_Type() {
	var	goTo = "getEtcCodeSub_Type"; 
	  
	TR_MAIN.Action = "/mss/mgif118.mg?goTo=" + goTo; 
	TR_MAIN.KeyValue = "SERVLET(O:DS_GIFT_TYPE_CD=DS_GIFT_TYPE_CD)";
	TR_MAIN.StatusResetType= "2";
	TR_MAIN.Post();
	
    insComboData( LC_SEL_GIFT_TYPE_CD,  "%", "전체",1);

}

/**
 * getEtcCodeSub_Amt()
 * 작 성 자	: 김정민
 * 작 성 일	: 2011-04-14
 * 개	 요	: 금종 
 * return값	: void
 */
function getEtcCodeSub_Amt() {
	
	var	strGiftTypeCd =	LC_SEL_GIFT_TYPE_CD.BindColVal;
	 
	var	goTo = "getEtcCodeSub_Amt";	
	var	parameters = "&strGiftTypeCd="	 + encodeURIComponent(strGiftTypeCd); 
  //  alert(strGiftTypeCd);
 
	TR_MAIN.Action = "/mss/mgif118.mg?goTo=" + goTo	+ parameters; 
	TR_MAIN.KeyValue = "SERVLET(O:DS_GIFT_AMT_TYPE=DS_GIFT_AMT_TYPE)";
	TR_MAIN.StatusResetType= "2";
	TR_MAIN.Post();
	
    insComboData( LC_SEL_GIFT_AMT_TYPE,  "%", "전체",1);

	
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
<script	language=JavaScript	for=GD_MASTER event=OnClick(row,colid)>
	//정렬
	if (row	== 0){
		sortColId(eval(this.DataID), row, colid);
	}
</script>
<script	language=JavaScript	for=DS_O_MASTER	event=OnRowPosChanged(row)>
	if(clickSORT)return;
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 회원ID onKillFocus() -->

<script	language=JavaScript	for=LC_SEL_GIFT_TYPE_CD	event=OnSelChange()>
	getEtcCodeSub_Amt();
	LC_SEL_GIFT_AMT_TYPE.Index = 0;			//금종	
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
<!-- Output용 -->
<comment id="_NSID_"><object id="DS_GIFT_AMT_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


<!-- Intput용 -->
<comment id="_NSID_"><object id="DS_O_MAIN_STR_CD" classid=<%=Util.CLSID_DATASET%>>	<param name=UseFilter value=true></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_STAT_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_POUT_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_POUT_TYPE" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SALE_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DRAWL_FLAG" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_GIFT_TYPE_CD"	classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- 공통 -->
<comment id="_NSID_"><object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

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
<body onLoad="doInit();" class="PL10 PT15 ">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
 <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">입고점</th>
            <td width="140">
               <comment id="_NSID_">
                 <object id=LC_SEL_IN_STR classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">입고기간</th>
                        <td width="230">
                           <comment id="_NSID_">
			                   <object id=EM_S_DT_S classid=<%=Util.CLSID_EMEDIT%> width="70" onblur="javascript:checkDateTypeYMD(this);" align="absmiddle"> 
			                   </object>
			                </comment><script>_ws_(_NSID_);</script>
			                <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_DT_S)" /> ~ 
			                <comment id="_NSID_">
			                   <object id=EM_E_DT_E classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width="70" align="absmiddle">
			                   </object>
			                </comment><script>_ws_(_NSID_);</script>
			                <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_E_DT_E)" align="absmiddle" />
                        </td>
            <th width="80">상품권종류</th>
            <td >
               <comment id="_NSID_">
                 <object id=LC_SEL_GIFT_TYPE_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th >상태</th>
            <td>
               <comment id="_NSID_">
                 <object id=LC_SEL_STAT_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >금종</th>
            <td>
               <comment id="_NSID_">
                 <object id=LC_SEL_GIFT_AMT_TYPE classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
            <th >상품권번호</th>
            <td colspan="3">
               <comment id="_NSID_">
                 <object id=EM_GIFT_NO classid=<%= Util.CLSID_EMEDIT %> width=140 tabindex=1 align="absmiddle"></object>
               </comment><script>_ws_(_NSID_);</script>
            </td>
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
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=770 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_O_MASTER">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>