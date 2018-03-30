<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 > 수불손익> 월손익계산
 * 작 성 일 : 2010.05.11
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : pstk501.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 매출회계전표생성
 * 이    력 :
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button"%>
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
<script language="javascript"   src="/<%=dir%>/js/common.js"        type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/gauce.js"         type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/global.js"        type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/message.js"       type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/popup.js"         type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/popup_dps.js"     type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var rtnVal            = false;
var intSearchCnt      = 0;                             // 조회버튼클릭 여부(0일 경우 마스터조회 건수)
var bfListRowPosition = 0;                             // 이전 List Row Position
var strToday          = "";                            // 현재날짜
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-11
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

 function doInit(){

     strToday = getTodayDB("DS_O_RESULT");
     
     // Input Data Set Header 초기화
     DS_I_SEARCH.setDataHeader('<gauce:dataset name="H_SEARCH"/>');
     DS_I_SEARCH.AddRow();
     // Output Data Set Header 초기화
   
     // EMedit에 초기화
     initEmEdit(EM_YYYYMM,       "THISMN",   READ);         // 손익년월
     initEmEdit(EM_CALC_DT,    "TODAY", NORMAL);            // 손익계산일자

     //콤보 초기화
     initComboStyle(LC_STR_CD,DS_IO_STR_CD,        "CODE^0^30,NAME^0^140", 1, NORMAL);    // 점(조회)
     initComboStyle(LC_STK_PROFIT_FLAG,DS_O_STK_PROFIT_FLAG,  "CODE^0^30,NAME^0^120", 1, NORMAL);    // 브랜드/단품손익구분
     
     getStore("DS_IO_STR_CD",     "Y", "", "N");
     getEtcCode("DS_O_STK_PROFIT_FLAG",  "D", "PA01", "N");            // 브랜드/단품손익구분

     LC_STR_CD.index   = 0;
     LC_STK_PROFIT_FLAG.index   = 0;
     EM_YYYYMM.Focus(); 
     EM_CALC_DT.Text = setDateAdd("D", 0, EM_CALC_DT.Text);

   
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
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-11
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
}

/**
 * btn_New()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-11
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-11
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자     : 김경은
 * 작 성 일     : 
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
function btn_Save() {

	
    
}


/**
 * btn_Excel()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-11
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-11
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-05-11
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/


 
 /**
  * checkValidation()
  * 작 성 자     : 김경은
  * 작 성 일     : 2010-05-11
  * 개    요        : 조회조건 값 체크 
  * return값 : void
  */
 function checkValidation(Gubun) {

      
      // 저장버튼 클릭시 Validation Check
      if(Gubun == "Save"){
    	  if(LC_STR_CD.Text.BindColVal == "" ){
              showMessage(EXCLAMATION, OK, "USER-1002", "점");
              LC_STR_CD.Focus();
              return false;
          }
    	  if(EM_YYYYMM.Text.length == 0){                                // 매입/매출년월
              showMessage(INFORMATION, OK, "USER-1002", "손익년월");
              EM_YYYYMM.Focus();
              return false;
          }
    	  
          if(EM_CALC_DT.Text.length == 0 ){
              showMessage(EXCLAMATION, OK, "USER-1002", "계산일자");
              EM_CALC_DT.Focus();
              return false;
          }
          return true;
      }
  }


  /**
   * process()
   * 작 성 자     : 김경은
   * 작 성 일     : 2010-06-10
   * 개    요        : 처리버튼 클릭시
   * return값 : void
   */
 function process(){

	    if(!checkValidation("Save"))
	        return;
 
	    
	  //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1204") == 1 ){    // validation 체크
        	DS_I_SEARCH.UseChangeInfo = "false";

        	DS_I_SEARCH.NameValue(DS_I_SEARCH.CountRow,"STR_CD")          = LC_STR_CD.BindColVal;
        	DS_I_SEARCH.NameValue(DS_I_SEARCH.CountRow,"PROFIT_FLAG")     = LC_STK_PROFIT_FLAG.BindColVal;
        	DS_I_SEARCH.NameValue(DS_I_SEARCH.CountRow,"CLOSE_TASK_FLAG") = "PSTK";
        	DS_I_SEARCH.NameValue(DS_I_SEARCH.CountRow,"CLOSE_UNIT_FLAG") = "45";
        	DS_I_SEARCH.NameValue(DS_I_SEARCH.CountRow,"CLOSE_YM")        = EM_YYYYMM.Text;
        	
            TR_MAIN.Action="/dps/pstk501.pt?goTo=save"; 
            TR_MAIN.KeyValue="SERVLET(I:DS_I_SEARCH=DS_I_SEARCH)"; //조회는 O
            
            searchSetWait("B"); // 프로그래스바

            TR_MAIN.Post();

        }


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
    searchDoneWait();
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    searchDoneWait();
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_I_SEARCH event=OnColumnChanged(row,colid)>
    switch (colid) {
    case "PAY_YM":
        break;
    }
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>



<!-- 기준년월 KillFocus -->
<script language=JavaScript for=EM_YYYYMM event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    
    checkDateTypeYM(EM_YYYYMM);


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
<comment id="_NSID_"><object id="DS_IO_STR_CD"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_COMMON"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SEARCH"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STK_PROFIT_FLAG"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

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


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<table width="100%"  border="0" cellspacing="0" cellpadding="0">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

  <tr>
    <td class="PT01 PB03"><table width="50%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80">손익계산구분</th>
            <td>
                    <comment id="_NSID_">
                        <object id=LC_STK_PROFIT_FLAG classid=<%= Util.CLSID_LUXECOMBO %> width=100% tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>

            </td>
          </tr> 
          <tr>
            <th width="80">점</th>
            <td>
                    <comment id="_NSID_">
                        <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=100% tabindex=1 align="absmiddle">
                        </object>
                    </comment><script>_ws_(_NSID_);</script>

            </td>
          </tr> 
          <tr>
            <th >손익년월</th>
            <td>
                  <comment id="_NSID_">
                      <object id=EM_YYYYMM classid=<%=Util.CLSID_EMEDIT%>  width=75 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',EM_YYYYMM)"  align="absmiddle"/>
            </td>
          </tr>         
          <tr>
            <th >계산일자</th>
            <td>
                  <comment id="_NSID_">
                      <object id=EM_CALC_DT classid=<%=Util.CLSID_EMEDIT%>  width=142 tabindex=1 align="absmiddle">
                      </object>
                  </comment>
                  <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_CALC_DT)"  align="absmiddle"/>
            </td>            
          </tr>

         <tr>
             <td colspan=2 align="Right">
               <img src="/<%=dir%>/imgs/btn/process.gif" id="IMG_porcess" align="absmiddle" onclick="javascript:process();" /> 
             </td>
         </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>

</table>
<comment id="_NSID_">
    <object id=BD_SEARCH classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_I_SEARCH>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
            <c>Col=STR_CD              Ctrl=LC_STR_CD             param=BindColVal</c>
            <c>Col=PAY_YM              Ctrl=EM_YYYYMM             param=Text</c>            
            <c>Col=TERM_S_DT           Ctrl=EM_CALC_DT          param=Text</c>           
            
        '>
    </object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>

