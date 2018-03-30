<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권폐기> 폐기등록
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif5010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 상품권을 폐기 등록 합니다.
 * 이    력 :
 *        2011.01.18 (김성미) 신규작성
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
<script language="javascript"  src="/<%=dir%>/js/common.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"      type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js"  type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"><!--

var strToday = getTodayFormat("yyyymmdd");

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
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
    DS_IO_GIFTCARDNO.setDataHeader('<gauce:dataset name="H_GIFTCARDNO"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_S_DRAWL_DT_FROM, "SYYYYMMDD", PK);			//회수기간 from
    initEmEdit(EM_S_DRAWL_DT_TO, "TODAY", PK);         			//회수기간 to
    initEmEdit(EM_I_DUSE_DT,"TODAY",PK);						//폐기일자 (등록)
    initEmEdit(EM_I_REMARK, "GEN^200",NORMAL);      			// 비고(등록)
    
    initEmEdit(EM_GIFT_S_NO, "NUMBER3^18", NORMAL);				//시작 번호
    initEmEdit(EM_GIFT_E_NO, "NUMBER3^18", NORMAL);				//종료번호
    
    
    
    //콤보 초기화
    initComboStyle(LC_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);						//조회점
    initComboStyle(LC_SEL_GIFT_TYPE_CD,DS_SEL_GIFT_TYPE_CD, "CODE^0^30,NAME^0^100", 1, NORMAL);		// [조회용] 상품권 종류
    initComboStyle(LC_SEL_GIFT_AMT_CD,DS_SEL_GIFT_AMT_CD, "CODE^0^40,NAME^0^80", 1, NORMAL);		// [조회용] 상품권 종류 에 따른 금종
    initComboStyle(LC_I_STR_CD,DS_I_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);							//회수점 등록
    
    //조회용 점 가져오기
    getStore("DS_O_STR_CD", "Y", "", "Y");
    getStore("DS_I_STR_CD", "Y", "", "N");
    
    //점코드 셋팅
    LC_STR_CD.index = 0;
    LC_I_STR_CD.index = 0;
    
    //상품권 종류 가져오기
    getGiftTypeCd();
    
    LC_STR_CD.Focus();
    
    //종료시 데이터 변경 체크 (common.js)
    registerUsingDataset("mgif501", "DS_IO_MASTER");
    
}

function gridCreate1(){
    
	var hdrProperies = '<FC>id={currow}      name="NO"			width=25	align=center</FC>'
					+ '<FC>id=CHECK1         name=""			width=20	align=center EditStyle=CheckBox HeadCheckShow="true" </FC>'
					+ '<FC>id=DRAWL_STR      name="회수점코드"	SHOW=FALSE	edit=none</FC>'
					+ '<FC>id=DRAWL_STR_NM   name="회수점"		width=90	edit=none align=left  sumtext="합계"</FC>'
					+ '<FC>id=GIFT_TYPE_CD   name="상품권종류코드" SHOW=FALSE</FC>'
					+ '<FC>id=GIFT_TYPE_NAME name="상품권종류"	width=140	edit=none  align=left</FC>'
					+ '<FC>id=GIFT_AMT_TYPE  name="금종코드"		SHOW=FALSE</FC>'
					+ '<FC>id=GIFT_AMT_NAME  name="금종명"		width=80	edit=none  align=left</FC>'
					+ '<FC>id=GIFTCERT_AMT   name="상품권금액"	width=80	edit=none align=light  </FC>'
					+ '<FC>id=GIFTCARD_NO    name="상품권코드"	width=150	edit=none  align=center  </FC>'
					+ '<FC>id=QTY            name="수량"			width=50	align=light edit=none sumtext=@sum</FC>'
					+ '<FC>id=STAT_FLAG      name="상품권상태코드" SHOW=FALSE</FC>'
					+ '<FC>id=STAT_FLAG_NM   name="상품권상태"	width=70 	edit=none  align=left  </FC>'
					+ '<FC>id=DRAWL_DT       name="회수일자"		width=80 	edit=none  align=center mask="XXXX/XX/XX"  </FC>'   
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
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	 
	 if (DS_IO_MASTER.IsUpdated) {
		 if(DS_IO_MASTER.CountRow != "0") {
			 if (showMessage(Question, YesNo, "USER-1059") != "1") { //아니요 
		          //   DS_O_DETAIL.RowPosition = gv_preRownoDetail;
		             return;
		         }    
		 } 
     }
 
    //클리어
    LC_I_STR_CD.index = 0;
    
    // 조회조건 셋팅
    var strStrCd        = LC_STR_CD.BindColVal;           //점코드
    var strDrawlDtFrom          = EM_S_DRAWL_DT_FROM.Text;  //회수일자 FROM
    var strDrawlDtTo          = EM_S_DRAWL_DT_TO.Text;      //회수일자TO
    var strGiftTypeCd          = LC_SEL_GIFT_TYPE_CD.BindColVal;   //상품권 종류
    var strGiftAmtCd          = LC_SEL_GIFT_AMT_CD.BindColVal;   //금종
    
    if(strDrawlDtFrom > strDrawlDtTo) {
        showMessage(INFORMATION, OK, "USER-1015");
        EM_S_DRAWL_DT_FROM.Focus();
        return;
    }
    
    DS_IO_MASTER.ClearData();
    
    var goTo       = "getGiftDuseMst" ;    
    var action     = "O";     
    var parameters = "&strStrCd="      + encodeURIComponent(strStrCd)
                   + "&strDrawlDtFrom="+ encodeURIComponent(strDrawlDtFrom)
                   + "&strDrawlDtTo="  + encodeURIComponent(strDrawlDtTo)
                   + "&strGiftTypeCd=" + encodeURIComponent(strGiftTypeCd)
                   + "&strGiftAmtCd="  + encodeURIComponent(strGiftAmtCd);
    
    TR_MAIN.Action="/mss/mgif501.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    // 조회결과 Return
    setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	 
	 if (DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == "1" || DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == "3") {
         if (showMessage(Question, YesNo, "USER-1059") != "1") { //아니요 
          //   DS_O_DETAIL.RowPosition = gv_preRownoDetail;
             return;
         }      
     }
	EM_I_DUSE_DT.Text = getTodayFormat("YYYYMMDD"); 
	EM_I_REMARK.Text = "";
	LC_I_STR_CD.Index = 0;
	
    DS_IO_MASTER.ClearData();
    GD_MASTER.ColumnProp('CHECK1','HeadCheck')= false;
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
	
	if(DS_IO_MASTER.CountRow == "0") {
		//저장할 내용이 없습니다
        showMessage(StopSign, OK, "USER-1028");
        return;
	}
	
	var strDuseDt          = EM_I_DUSE_DT.Text;  //폐기일자
    var strRemark          = EM_I_REMARK.Text;   //비고
	
    if (strToday > strDuseDt ) {
    	showMessage(StopSign, OK, "USER-1011","폐기일자");
    	EM_I_DUSE_DT.Text = strToday;
    	EM_I_DUSE_DT.focus();
        return;
    }
    
    var cnt = 0;
    for(var i=1; i<=DS_IO_MASTER.CountRow; i++) {
    	if(DS_IO_MASTER.NameValue(i,"CHECK1") == "T") {
    		cnt = cnt+1;
    	}
    } 
    
    if(cnt == "0") {
    	//저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1000", "저장할 데이터가 없습니다.<br>체크 후 저장해주세요");
        return;
    }
    
	//변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(STOPSIGN, YESNO, "USER-1010") != 1 ) 
        return;
         
    //모든데이타 다 저장
   // DS_IO_MASTER.UseChangeInfo = false;
    
    var goTo       = "save" ;    
    var action     = "I";     
    var parameters = "&strDuseDt="+encodeURIComponent(strDuseDt)
                   + "&strRemark="+encodeURIComponent(strRemark);
    
    TR_MAIN.Action="/mss/mgif501.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //비고 초기화
    EM_I_REMARK.text = "";
    btn_New();
    //btn_Search();   
    
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
  * getGiftTypeCd()
  * 작 성 자 : 신익수
  * 작 성 일 : 2010-03-11
  * 개    요 : 상품권 종류 가져오기 
  * return값 : void
  */
 function getGiftTypeCd () {
     TR_MAIN.Action    = "/mss/mgif404.mg?goTo=getGiftTypeCd";
     TR_MAIN.KeyValue= "SERVLET(O:DS_SEL_GIFT_TYPE_CD=DS_SEL_GIFT_TYPE_CD)";
     TR_MAIN.Post();
     
     LC_SEL_GIFT_TYPE_CD.index = 0;
     
     //getGiftAmcCd();
 }
 
 /**
  * getGiftAmcCd()
  * 작 성 자 : 신익수
  * 작 성 일 : 2010-03-11
  * 개    요 : 상품권 종류에 따른  금종 조회
  * return값 : void
  */
 function getGiftAmcCd () {
   // LC_SEL_GIFT_AMT_CD.Enable = true;
      
    var strGiftTypeCd        = LC_SEL_GIFT_TYPE_CD.BindColVal;
    
    var goTo       = "getGiftAmtCd" ;    
    var action     = "O";     
    var parameters = "&strGiftTypeCd="+encodeURIComponent(strGiftTypeCd);
    
    TR_MAIN.Action="/mss/mgif404.mg?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_SEL_GIFT_AMT_CD=DS_SEL_GIFT_AMT_CD)"; //조회는 O
    TR_MAIN.Post();
    
    LC_SEL_GIFT_AMT_CD.index = 0;
 }
 
 /**
  * delRow()
  * 작 성 자 : 신익수
  * 작 성 일 : 2011-03-18
  * 개    요 :  
  * return값 : void
  */
  function delRow() {

      if(DS_IO_MASTER.CountRow == 0){
          showMessage(INFORMATION, OK, "USER-1019");
          return;
      }
       
      DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition); 
  }

  /**
   * onSingle()
   * 작 성 자 : 
   * 작 성 일 : 2011-05-09
   * 개    요 : 한장씩 판매 등록
   * return값 : void
   */ 
  function onSingle(){
      if(CHK_SINGLE.checked){
          EM_GIFT_S_NO.Text = "";
          EM_GIFT_S_NO.Enable = false;
      }else{
          EM_GIFT_E_NO.Text = "";
          EM_GIFT_S_NO.Enable = true;
      }
  }
  
  /**
   * getConf()
   * 작 성 자 : 
   * 작 성 일 : 2011-04-26
   * 개    요 : 시작번호 조회
   * return값 : void
   */
  function getConf (strFlag) {
	// 조회조건 셋팅
	    var strStrCd        = LC_I_STR_CD.BindColVal;           //등록할 점코드
	    var strGiftCardSNo   = EM_GIFT_S_NO.Text;           //상품권 시작 번호
	    var strGiftCardENo   = EM_GIFT_E_NO.Text;           //상품권 시작 번호
	    
	    DS_IO_GIFTCARDNO.ClearData();
	    
	    if(CHK_SINGLE.checked){
	    	strGiftCardSNo = strGiftCardENo; 
	    }
	    
	    
	    
	    var goTo       = "getGiftDuseGiftNo" ;    
	    var action     = "O";     
	    var parameters = "&strStrCd="      + encodeURIComponent(strStrCd)
	                   + "&strGiftCardSNo="+ encodeURIComponent(strGiftCardSNo)
	                   + "&strGiftCardENo="+ encodeURIComponent(strGiftCardENo)
	                   ;
	    
	    TR_MAIN.Action="/mss/mgif501.mg?goTo="+goTo+parameters;  
	    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_GIFTCARDNO=DS_IO_GIFTCARDNO)"; //조회는 O
	    TR_MAIN.Post();
	    
	    //해당 데이타를 화면에 ADDROW 해준다.
	    if(DS_IO_GIFTCARDNO.CountRow > 0 ) {
	        LC_I_STR_CD.index = 0;
	        
	        EM_GIFT_S_NO.text = "";
	        EM_GIFT_E_NO.text = "";
	        
	        var intRowCount   = DS_IO_MASTER.CountRow;
	        if(intRowCount > 0){
	            for(var i=1; i <= intRowCount; i++){
	                 // 중복체크
	                 var dupRow = checkDupKey(DS_IO_MASTER, "GIFTCARD_NO");
	                 
	                 if (DS_IO_MASTER.NameValue(i, "GIFTCARD_NO") == DS_IO_GIFTCARDNO.NameValue(i, "GIFTCARD_NO")) {
	                 
	                     showMessage(StopSign, Ok,  "USER-1044", i);
	                     
	                     EM_GIFT_S_NO.text = "";
	                     EM_GIFT_E_NO.text = "";
	                     
	                     return false;
	                 }
	           }
	        }
	        GD_MASTER.ReDraw = "false";
	        for(var i=1; i <= DS_IO_GIFTCARDNO.CountRow; i++){
		      //데이타 추가
	            DS_IO_MASTER.Addrow();
	            
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DRAWL_STR")    = DS_IO_GIFTCARDNO.NameValue(i, "DRAWL_STR"); //점코드 
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DRAWL_STR_NM") = DS_IO_GIFTCARDNO.NameValue(i, "DRAWL_STR_NM");  
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GIFT_TYPE_CD") = DS_IO_GIFTCARDNO.NameValue(i, "GIFT_TYPE_CD");  
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GIFT_TYPE_NAME") = DS_IO_GIFTCARDNO.NameValue(i, "GIFT_TYPE_NAME"); 
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GIFT_AMT_TYPE") = DS_IO_GIFTCARDNO.NameValue(i, "GIFT_AMT_TYPE"); 
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GIFT_AMT_NAME") = DS_IO_GIFTCARDNO.NameValue(i, "GIFT_AMT_NAME"); 
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GIFTCERT_AMT") = DS_IO_GIFTCARDNO.NameValue(i, "GIFTCERT_AMT"); 
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "GIFTCARD_NO") = DS_IO_GIFTCARDNO.NameValue(i, "GIFTCARD_NO");  
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "QTY") = DS_IO_GIFTCARDNO.NameValue(i, "QTY");  
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STAT_FLAG") = DS_IO_GIFTCARDNO.NameValue(i, "STAT_FLAG");  
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STAT_FLAG_NM") = DS_IO_GIFTCARDNO.NameValue(i, "STAT_FLAG_NM");  
	            DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DRAWL_DT") = DS_IO_GIFTCARDNO.NameValue(i, "DRAWL_DT");  
	        }
	        GD_MASTER.ReDraw = "true";
	        
	    } else {
	        showMessage(INFORMATION, OK, "USER-1000", "해당 데이타가 없습니다.");
	        EM_GIFT_S_NO.text = "";
            EM_GIFT_E_NO.text = "";
	        return false;
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
   /* showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }*/
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=EM_GIFT_E_NO event=onKillFocus()>
if(!this.Modified)
    return;
if( EM_GIFT_E_NO.Text ==""){
       return;
   }

if(EM_GIFT_E_NO.Text.length == 13 && EM_GIFT_E_NO.Text.length == 16 && EM_GIFT_E_NO.Text.length == 18){
	//개별 등록 일경우는 그냥 추가 
	if(!CHK_SINGLE.checked){

	    if(EM_GIFT_S_NO.Text == ""){
	        showMessage(EXCLAMATION , OK, "USER-1000", "시작번호를 먼저 스캔해 주세요.");
	        this.Text = "";
	        setTimeout("EM_GIFT_S_NO.Focus();",100);
	        return;
	    }
	    if(EM_GIFT_E_NO.Text < EM_GIFT_S_NO.Text){
	        showMessage(EXCLAMATION , OK, "USER-1000", "상품권번호를 확인해 주세요.");
	        this.Text = "";
	        setTimeout("EM_GIFT_E_NO.Focus();",100);
	        return;
	    }
	    
	    getConf(this);
	} else {

		getConf(this);
	}
}
</script>


<!-- 체크 박스 체크  -->   
<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>
//헤더 전체 체크/체크해제 컨트롤
    if (bCheck == '1'){ // 전체체크
    	GD_MASTER.Redraw = false;
        for(var i=1; i<=DS_IO_MASTER.CountRow; i++){
            DS_IO_MASTER.NameValue(i, "CHECK1") = 'T';
        }
        GD_MASTER.Redraw = true;
    }else{  // 전체체크해제
    	GD_MASTER.Redraw = false;
        for (var i=1; i<=DS_IO_MASTER.CountRow; i++){
            DS_IO_MASTER.NameValue(i, "CHECK1") = 'F';
        }
        GD_MASTER.Redraw = true;
    }
</script>

<!-- 상품권 종류 변경시 -->
<script language=JavaScript for=LC_SEL_GIFT_TYPE_CD event=OnSelChange>
    if(LC_SEL_GIFT_TYPE_CD.BindColVal != ""){
        //금종 조회
        getGiftAmcCd();
    }
    
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //그리드 정렬기능
    if( row < 1) {
        sortColId( eval(this.DataID), row , colid );
    }
    if(row > 0) GD_MASTER.ColumnProp('CHECK1','HeadCheck')= false;
</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_O_STR_CD"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_STR_CD"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_GIFTCARDNO"           classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_SEL_GIFT_TYPE_CD"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script> 
<comment id="_NSID_"><object id="DS_SEL_GIFT_AMT_CD"          classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- 공통함수용 -->
<comment id="_NSID_"><object id="DS_I_COMMON"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"         classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"            classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
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
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" >점</th>
            <td width="150">
              <comment id="_NSID_">
                <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=150 align="absmiddle"></object>
              </comment>
              <script>_ws_(_NSID_);</script> 
            </td>
            <th width="80" class="POINT">회수일자</th>
            <td width="230">
               <comment id="_NSID_">
                   <object id=EM_S_DRAWL_DT_FROM classid=<%=Util.CLSID_EMEDIT%> width="82" onblur="javascript:checkDateTypeYMD(this);" align="absmiddle"> 
                   </object>
                </comment><script>_ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_DRAWL_DT_FROM)" /> ~ 
                <comment id="_NSID_">
                   <object id=EM_S_DRAWL_DT_TO classid=<%=Util.CLSID_EMEDIT%> onblur="javascript:checkDateTypeYMD(this);" width="82" align="absmiddle">
                   </object>
                </comment><script>_ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_DRAWL_DT_TO)" align="absmiddle" />
            </td>
            <th width="80" >상품권 종류</th>
            <td>
                <comment id="_NSID_"> 
                        <object id=LC_SEL_GIFT_TYPE_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=140 align="absmiddle"> 
                        </object> 
                    </comment>
                    <script>_ws_(_NSID_);</script>
            </td>
        </tr>
          <tr>
            <th >금종</th>
            <td colspan=5>
                <comment id="_NSID_"> 
                        <object id=LC_SEL_GIFT_AMT_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
                            width=150 align="absmiddle"> 
                        </object> 
                    </comment>
                    <script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr><td class="dot"></td></tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr>
    <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
             <th class="point" width="80" >폐기일자</th>
            <td width="150">
                <comment id="_NSID_">
                   <object id=EM_I_DUSE_DT classid=<%=Util.CLSID_EMEDIT%> width="122" onblur="javascript:checkDateTypeYMD(this);" align="absmiddle"> 
                   </object>
                </comment><script>_ws_(_NSID_);</script>
                <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_I_DUSE_DT)" />
            </td>
            <th  width="80">비고</th>
            <td colspan=4>
                <comment id="_NSID_">
                <object id=EM_I_REMARK classid=<%=Util.CLSID_EMEDIT%> width=460 align="absmiddle" onKeyup="javascript:checkByteStr(this, 200, 'Y');" > </object> 
                 </comment><script>_ws_(_NSID_);</script> 
            </td>
          </tr>  
            <tr>
             <th class="point" width="80">회수점</th>
            <td width="150">
                <comment id="_NSID_">
                   <object id=LC_I_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=150 align="absmiddle">
                   </object>
               </comment><script>_ws_(_NSID_);</script> 
            </td>
            <th width="80">상품권코드</th>
            <td width="316" valign = "middle" >
               <comment id="_NSID_">
                  <object id=EM_GIFT_S_NO classid=<%=Util.CLSID_EMEDIT%>   width=140 align="absmiddle" tabindex=1>
                  </object></comment><script>_ws_(_NSID_);</script>
                  ~
                 <comment id="_NSID_">
                  <object id=EM_GIFT_E_NO classid=<%=Util.CLSID_EMEDIT%>   width=140  align="absmiddle" tabindex=1>
                  </object></comment><script>_ws_(_NSID_);</script>
                  
            </td>
            <td width="80" >
                <input type="checkbox" id=CHK_SINGLE align="absmiddle" onclick="javascript:onSingle();" tabindex=1 > 개별등록
            </td>
            <td colspan=2 align="right">
            <img src="/<%=dir%>/imgs/btn/del_row.gif"   id="IMG_DEL" width="52" height="18" align="left"  onclick="javascript:delRow();" />
            </td> 
          </tr>
        </table>
    </td>
  </tr> 
 
  <!--  그리드의 구분dot & 여백  -->
  <tr height=5><td></td></tr>
  <tr><td class="dot"></td></tr>
  <!--  그리드의 구분dot & 여백  -->
  <tr>
    <td class="PT01 PB03">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
      <td>
          
          <comment id="_NSID_">
          <OBJECT id=GD_MASTER width=100% height=408 classid=<%=Util.CLSID_GRID%>>
               <param name="DataID" value="DS_IO_MASTER">
               <Param Name="ViewSummary"   value="1" >
             </OBJECT>
           </comment>
           <script>_ws_(_NSID_);</script>
      </td>  
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

