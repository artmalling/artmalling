<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품 지급/취소 > 행사별 사은품현황내역
 * 작 성 일 : 2016/12/30
 * 작 성 자 : 윤지영
 * 수 정 자 : 
 * 파 일 명 : MCAE4400.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 행사별 사은품현황내역을 조회한다.
 * 이    력 :
 *        2016.12.30 (윤지영) 신규작성 
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
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
    type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript"> 
/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
var g_select =false;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 
 /**
 * doInit()
 * 작 성 자 : 윤지영
 * 작 성 일 : 2016-12-30
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 120;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID 
 function doInit(){
    
    //Master 그리드 세로크기자동조정  2013-07-17
	var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
    //그리드 초기화
    gridCreate1();     
    
    // EMedit에 초기화
    initEmEdit(EM_S_DATE,       "SYYYYMMDD",    PK);            //지급일자S
    initEmEdit(EM_E_DATE,       "YYYYMMDD",     PK);            //지급일자E
    initEmEdit(EM_S_EVENT_CD,   "NUMBER3^11^0", PK);        //행사명
    initEmEdit(EM_S_EVENT_NAME, "GEN^40",       READ);          //행사코드

    //콤보 초기화
    initComboStyle(LC_S_STR_CD,DS_S_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);  //점
     
    EM_E_DATE.Text          = getTodayFormat("YYYYMMDD");     //지급일자E
    
    getStore("DS_S_STR_CD", "Y", "1", "N");   //점(조회) 
    LC_S_STR_CD.Index = 0;
    LC_S_STR_CD.Focus();
 }

 /**
 * gridCreate()
 * 작 성 자 : 윤지영
 * 작 성 일 : 2016-12-30
 * 개    요 : 그리드SET
 * return값 : void
 */
 function gridCreate1(){ 
    var hdrProperies ='<FC>id={currow}          name="NO"          	width=30   	align=center</FC>'
			        + '<FC>id=STR_CD            name="점"          	width=100   align=left	 EDITSTYLE=LOOKUP   DATA="DS_S_STR_CD:CODE:NAME" </FC>'
			        + '<G> name="행사정보"'
			        + '<FC>id=EVENT_CD          name="행사코드"       	width=120  	align=center </FC>'
			        + '<FC>id=EVENT_NAME        name="행사명"       	width=180  	align=left	 </FC>'
			        + '</G>'
			        + '<G> name="영수증정보"'
			        + '<FC>id=SEQ_NO        	name="영수증순번"    width=80  	align=center  </FC>'
                    + '<FC>id=SALE_DT        	name="매출일자"      width=110  	align=center Mask="XXXX/XX/XX" </FC>'
                    + '<FC>id=POS_NO        	name="POS/PDA"     width=80  	align=center </FC>'
                    + '<FC>id=TRAN_NO        	name="거래번호"     width=90  	align=center </FC>'
                    + '<FC>id=APPR_NO        	name="승인번호"    width=110  	align=center  </FC>'
                    + '<FC>id=APPR_AMT        	name="승인금액"    width=110  	align=right  </FC>'
                    + '<FC>id=CARD_NO        	name="카드번호"    width=110  	align=left  </FC>'
                    + '<FC>id=CARD_PUBLISH     	name="카드사"      width=110  	align=left  </FC>'
                    + '</G>'
                    + '<FC>id=GIFT_SLIP_NO      name="사은품지급번호"    width=110  	align=center  </FC>'
                    + '<FC>id=SKU_NAME          name="사은품명"      	width=170  	align=left 	 </FC>';

                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    //GD_MASTER.ViewSummary = "1";       
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
 * 작 성 자 : 윤지영
 * 작 성 일 : 2016-12-30
 * 개    요 : 조회시 호출
 * return값 : void
 */
 function btn_Search() { 
	
	DS_MASTER.ClearData();
	 
	if (EM_S_DATE.Text > EM_E_DATE.Text){ 
        showMessage(INFORMATION, OK, "USER-1008", "지급시작일자", "지급종료일자");
        EM_S_E_DT.Focus();
        return;
    }
	
	if (EM_S_EVENT_NAME.Text == ""){ 
        showMessage(INFORMATION, OK, "USER-1000", "행사코드를 입력해주세요.");
        EM_S_EVENT_CD.Focus();
        return;
    }
     
    // 조회조건 셋팅
    var strStrCd        = LC_S_STR_CD.BindColVal;
    var strSdt          = EM_S_DATE.Text;
    var strEdt          = EM_E_DATE.Text;
    var strEventCd      = EM_S_EVENT_CD.Text;
   
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="  + encodeURIComponent(strStrCd)
                   + "&strSdt="    + encodeURIComponent(strSdt)
                   + "&strEdt="    + encodeURIComponent(strEdt)
                   + "&strEventCd="+ encodeURIComponent(strEventCd);
    TR_MAIN.Action="/mss/mcae440.mc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    
    g_select =true;
    TR_MAIN.Post();
    g_select = false;
    
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

 }

 /**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
 function btn_Excel() {

	var ExcelTitle = "카드사은행사지급리스트" 
    
	var strStrCd    = LC_S_STR_CD.BindColVal;
	var strEventCd  = EM_S_EVENT_CD.Text; 
	var strSdate    = EM_S_DATE.Text;
	var strEdate    = EM_E_DATE.Text;
	
	var params = "점:"    + strStrCd
	               + " 행사코드:"  + strEventCd
	               + " 기간:"    + strSdate
	               + "~"    + strEdate;
	
	//openExcel2(GD_MASTER, ExcelTitle, params, true );
	openExcel5(GD_MASTER, ExcelTitle, params, true , "",g_strPid );
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
 * getSEvent()
 * 작 성 자 : 김성미
 * 작 성 일 : 2011-01-26
 * 개    요 :  조회용 이벤트 팝업
 * return값 : void
 */
 function getSEvent(){
    
    // 조회 이벤트 조건 검색시 점코드 필수 
    if(LC_S_STR.BindColVal.length == 0){
        showMessage(EXCLAMATION, OK, "USER-1001", "점");
        return;
    }
    mssEventPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NM,'','','Y', LC_STR.BindColVal
            , EM_S_S_DT.Text, EM_S_E_DT.Text ,'02');
    
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
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //정렬
    if (row == 0){
        sortColId(eval(this.DataID), row, colid);
    }    
</script> 

<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return;
    if (row > 0 && g_select==false) {  
        
    //    setTimeout("getDetail()",50);
    //    GD_DETAIL.SetColumn("RANK");
    }    
</script>  
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=EM_S_EVENT_CD event=onKillFocus()>
  //  if (EM_O_EVENT_CD.Text.length > 0 ) { 
      if(!this.Modified)
                return;
                
            if(this.text==''){
                EM_S_EVENT_NAME.Text = "";
                return;
            }
         
            if(LC_S_STR_CD.BindColVal == "%"){
                showMessage(EXCLAMATION, OK, "USER-1001", "점코드");
                LC_S_STR_CD.Focus();
                return;
            }
        
        setMssEvtMstNmWithoutPop('DS_O_RESULT', 'SEL_STR_EVT_NAME', EM_S_EVENT_CD, EM_S_EVENT_NAME, LC_S_STR_CD.BindColVal, '4');
        if (DS_O_RESULT.CountRow == 1 ) {  
            EM_S_EVENT_CD.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_CD");
            EM_S_EVENT_NAME.Text = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "EVENT_NM");
        } else {
            //1건 이외의 내역이 조회 시 팝업 호출 
//             mssEventMstPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NAME,LC_S_STR_CD.BindColVal, '4');
             mssEventMstPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NAME,LC_S_STR_CD.BindColVal,  '4/5/6','05');
        }
  //  }  
     
</script>

<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
    EM_S_EVENT_CD.Text = "";
    EM_S_EVENT_NAME.Text = "";
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
<comment id="_NSID_"><object id="DS_S_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!-- 공통 -->
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


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
	          <th width="60" class="point">점</th>
	          <td width="120" >
	              <comment id="_NSID_">
                      <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1  height=100 width=120 align="absmiddle">
                      </object>
                  </comment><script>_ws_(_NSID_);</script>   
	          </td>
	          <th width="60" class="point">지급일자</th>
	          <td width="200" > 
	              <comment id="_NSID_">
	                      <object id=EM_S_DATE classid=<%= Util.CLSID_EMEDIT %> width=70 tabindex=1 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
	                      </object>
	              </comment><script>_ws_(_NSID_);</script>
	              <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_S_DATE)" />
	              ~
	              <comment id="_NSID_">
                          <object id=EM_E_DATE classid=<%= Util.CLSID_EMEDIT %> width=70 tabindex=1 align="absmiddle" onblur="javascript:checkDateTypeYMD(this);">
                          </object>
                  </comment><script>_ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('G',EM_E_DATE)" />
	          </td>  
	          <th width="60" >행사코드</th>
              <td ><comment id="_NSID_"> <object
                  id=EM_S_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=70
                  tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
              <img id=IMG_EVENT src="/<%=dir%>/imgs/btn/detail_search_s.gif"
                  class="PR03" onclick="javascript: mssEventMstPop('SEL_STR_EVENT_POP',EM_S_EVENT_CD,EM_S_EVENT_NAME,LC_S_STR_CD.BindColVal,  '4/5/6','05');"
                  align="absmiddle" /> <comment id="_NSID_"> <object
                  id=EM_S_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%> width=135
                  tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
              </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="5"></td>
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
                <comment id="_NSID_"><object id=GD_MASTER width=100% height=437 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_MASTER">
                </object></comment><script>_ws_(_NSID_);</script>
            </td>  
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr> 
</table>
</DIV>
</body>
</html>

