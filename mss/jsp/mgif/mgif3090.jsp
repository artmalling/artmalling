<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 판매/회수> 상품권재사용등록
 * 작 성 일 : 2011.04.18
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif3090.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.04.18 (김정민) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>
<%     
    request.setCharacterEncoding("utf-8");
%>
<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
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

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"><!--


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

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_REG_DT, "YYYYMMDD", PK);    //일자(조회) 
    initEmEdit(EM_GIFTCARD_NO, "NUMBER3^18^0", NORMAL);    //상품권코드
    
    EM_REG_DT.Text    = getTodayFormat("YYYYMMDD");   // 일자(조회)
 
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);                  //본사점(조회) 
    
    // 공통에서 가져오기
    getStore("DS_STR_CD", "Y", "1", "N");   //점(조회)
 
    getEtcCode("DS_STAT_FLAG", "D", "M074", "N", "N");   //상품권상태
    LC_STR_CD.Index = 0;                //점(조회)    
    
    LC_STR_CD.Focus();
    
    //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif309", "DS_O_MASTER");
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}         name="NO"            width=25   align=center Edit=none </FC>'
                     + '<FC>id=CHK_ID           name="삭제"       width=50   align=center   EditStyle=CheckBox  HeadCheckShow=true }</FC>'
                     + '<FC>id=GIFT_TYPE_CD     name="상품권종류"      width=100  align=center Show=false Edit=none </FC>'
                     + '<FC>id=GIFT_TYPE_NAME   name="상품권종류"      width=100  align=left Edit=none sumtext="합계"  </FC>'
                     + '<FC>id=GIFT_AMT_CD      name="금종"           width=80   align=center Show=false Edit=none </FC>'
                     + '<FC>id=GIFT_AMT_NAME    name="금종"           width=80   align=left Edit=none </FC>' 
                     + '<FC>id=GIFTCERT_AMT     name="상품권금액"      width=100  align=right Edit=none </FC>'
                     + '<FC>id=GIFTCARD_NO      name="상품권코드"      width=150   align=center Edit=none </FC>'
                     + '<FC>id=ISSUE_TYPE      name="발행형태"      width=150   align=center Edit=none show=false </FC>' 
                     + '<FC>id=QTY              name="수량"           width=70   align=right Edit=none sumtext=@sum </FC>'
                     + '<FC>id=STAT_FLAG        name="상품권상태"      width=100  align=left EDITSTYLE=LOOKUP DATA="DS_STAT_FLAG:CODE:NAME" Edit=none  </FC>'
                     + '<FC>id=SALE_DT          name="판매일자"        width=100  align=center Edit=none  MASK="XXXX/XX/XX" </FC>'
                     + '<FC>id=SALE_STR          name="판매점"        width=100  align=center Edit=none  show=false </FC>';
    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    DS_O_MASTER.UseChangeInfo = false;
    GD_MASTER.ViewSummary = "1";
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
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() { 
    DS_O_MASTER.ClearData(); 
    
    LC_STR_CD.Index = 0;     //점(조회)
    EM_REG_DT.Text    = getTodayFormat("YYYYMMDD");   // 일자(조회)
    EM_GIFTCARD_NO.Focus();
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() { 
	 if (DS_O_MASTER.IsUpdated) {//변경 데이터가 있을때만 저장 
		 
     var strToday = getTodayFormat("YYYYMMDD"); 
	 
      if(EM_REG_DT.Text < strToday) {
    	  showMessage(INFORMATION, OK, "USER-1000", "재사용 등록일자는 오늘보다<br>작을 수 없습니다.");
    	  EM_REG_DT.Text = getTodayFormat("YYYYMMDD");
          setTimeout("EM_REG_DT.Focus();", 50); 
          return;
      }
         
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(INFORMATION, YESNO, "USER-1010") != 1 ){
          GD_MASTER.Focus();
          return;
    }
		var strStrCD = LC_STR_CD.BindColVal;
		var strRegDt = EM_REG_DT.Text;
		 
	    //저장
	    var goTo = "save"; 
	    var parameters = "&strStrCD="  + encodeURIComponent(strStrCD) 
	                   + "&strRegDt="  + encodeURIComponent(strRegDt); 
	
	    TR_MAIN.Action = "/mss/mgif309.mg?goTo=" + goTo + parameters;  
	    TR_MAIN.KeyValue = "SERVLET(I:DS_O_MASTER=DS_O_MASTER)";
	    TR_MAIN.Post(); 
	    
	    DS_O_MASTER.ClearData();
	    btn_Search();
    } 
	else {
       showMessage(INFORMATION, OK, "USER-1028");
       return;
    } 
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

/**
 * delRow()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-24
 * 개    요 : 행삭제
 * return값 : void
 */

function delRow() {
    if(DS_O_MASTER.CountRow == 0){
        showMessage(INFORMATION, OK, "USER-1019");
           return;
       }
    for(var i=DS_O_MASTER.CountRow; i>=0; i--) {
    //	alert(i);
    	if(DS_O_MASTER.NameValue(i,"CHK_ID") == "T") {
    	//	alert(DS_O_MASTER.RowPosition);
    		DS_O_MASTER.DeleteRow(i);
    	}
    }
    //DS_O_MASTER.DeleteRow(DS_O_MASTER.RowPosition);
 
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * getGiftCardNo()
  * 작 성 자 : 김정민
  * 작 성 일 : 2011-04-18
  * 개    요 : 상품권 코드에대한 정보 조회 
  * return값 : void
  */
 function getGiftCardNo() {
     
     var strGiftCardNo = EM_GIFTCARD_NO.Text;
      
     var goTo       = "getGiftCardNo"; 
     var action     = "O";
     var parameters = "&strGiftCardNo="   + encodeURIComponent(strGiftCardNo); 
   //  alert(strGiftTypeCd); 
     TR_MAIN.Action   = "/mss/mgif309.mg?goTo=" + goTo + parameters;
     TR_MAIN.KeyValue = "SERVLET(" + action + ":DS_O_RESULT=DS_O_RESULT)";
     TR_MAIN.Post();
  //   alert(DS_O_RESULT.CountRow);
     if(DS_O_RESULT.CountRow == "0") {
    	 showMessage(INFORMATION, OK, "USER-1000", strGiftCardNo + "상품권의 상태가 판매/가판매 상태가 아닙니다.");
    	 EM_GIFTCARD_NO.Text = "";
         setTimeout("EM_GIFTCARD_NO.Focus();", 50); 
         return;
     }
     else {
    	 
    	 if(DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"ACDT_FLAG") == "Y") {
    		 showMessage(INFORMATION, OK, "USER-1000", strGiftCardNo + "의 상품권은 사고상태 입니다.");
             EM_GIFTCARD_NO.Text = "";
             setTimeout("EM_GIFTCARD_NO.Focus();", 50); 
             return;
    	 }
    	 
    	 for(var i=1; i<=DS_O_MASTER.CountRow; i++) {
             if(DS_O_MASTER.NameValue(i,"GIFTCARD_NO") == DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"GIFTCARD_NO")) {
                 showMessage(INFORMATION, OK, "USER-1000", strGiftCardNo + "의 상품권 번호가 중복됩니다.");
                 EM_GIFTCARD_NO.Text = "";
                 setTimeout("EM_GIFTCARD_NO.Focus();", 50); 
                 return;
             }
         }
    	
    	 DS_O_MASTER.AddRow();
    	 
    	 DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"CHK_ID")         = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"CHK_ID");
         DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"GIFT_TYPE_CD")   = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"GIFT_TYPE_CD");
         DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"GIFT_TYPE_NAME") = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"GIFT_TYPE_NAME");
         DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"GIFT_AMT_TYPE")  = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"GIFT_AMT_TYPE");
         DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"GIFT_AMT_NAME")  = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"GIFT_AMT_NAME");
         DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"GIFTCERT_AMT")   = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"GIFTCERT_AMT");
         DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"GIFTCARD_NO")    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"GIFTCARD_NO");
         DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"ISSUE_TYPE")    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"ISSUE_TYPE");
         DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"QTY")            = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"QTY");
         DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STAT_FLAG")      = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"STAT_FLAG");
         DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"SALE_DT")        = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"SALE_DT");
         DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"SALE_STR")        = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition,"SALE_STR");
         
         EM_GIFTCARD_NO.Text = "";
         setTimeout("EM_GIFTCARD_NO.Focus();", 50); 
     }
     
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

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!-- MASTER 정렬 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //정렬
    if (row == 0){
        sortColId(eval(this.DataID), row, colid);
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=EM_GIFTCARD_NO
	event=onKeyDown(kcode,scode)>
    if (EM_GIFTCARD_NO.Text.length == 13 || EM_GIFTCARD_NO.Text.length == 16 || EM_GIFTCARD_NO.Text.length == 18){
    	getGiftCardNo();
    } 
</script>

<script language=javascript for=GD_MASTER
	event=OnHeadCheckClick(Col,Colid,bCheck)>
//헤더 전체 체크/체크해제 컨트롤
    var strFlag = "T";
    if(Colid == "CHK_ID"){
        if(bCheck == "0") strFlag = "F"
        for(var i=1; i<=DS_O_MASTER.CountRow; i++){
        	DS_O_MASTER.NameString(i, Colid) = strFlag;
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
<!-- 검색용 -->
<comment id="_NSID_">
<object id="DS_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_STAT_FLAG" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ================ 공통 -->
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
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

<DIV id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="PT01 PB01">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">점</th>
						<td width="150"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
							tabindex=1 width=140 align="absmiddle"> </object> </comment> <script>_ws_(_NSID_);</script>
						</td>
						<th width="100" class="point">재사용등록일자</th>
						<td><comment id="_NSID_"> <object id=EM_REG_DT
							classid=<%=Util.CLSID_EMEDIT%> width=120 tabindex=1
							align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
						</object></comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('G',EM_REG_DT)" align="absmiddle"
							onblur="javascript:checkDateTypeYMD(this);" /></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="PB05">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width=50%>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80">상품권코드</th>
						<td colspan=3><comment id="_NSID_"><object
							id=EM_GIFTCARD_NO classid=<%=Util.CLSID_EMEDIT%> width=200
							tabindex=1 align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script>&nbsp;
						</td>
					</tr>
				</table>
				</td>
				<td class="right"><img src="/<%=dir%>/imgs/btn/del_row.gif"
					width="52" height="18" onClick="javascript:delRow();" />
			</tr>
		</table>
		</td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->
	<tr>
		<td class="dot"></td>
	</tr>
	<!--  그리드의 구분dot & 여백  -->
	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><OBJECT id=GD_MASTER
					width=100% height=472 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_O_MASTER">
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

