<!-- 
/*******************************************************************************
 * 시스템명 : 상품권관리 > 상품권 판매/회수> 일괄회수 등록
 * 작 성 일 : 2011.01.18
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : mgif3080.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 백화점의 각 점정보를 관리한다
 * 이    력 :
 *        2011.01.18 (김성미) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=euc-kr" import="common.util.Util, 
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
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>

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
    
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화
    initEmEdit(EM_DRAWL_DT, "YYYYMMDD", PK);    //회수일자
   // initEmEdit(EM_STR_CD, "GEN", PK);           //점코드
    //initEmEdit(EM_STR_NAME, "GEN", PK);         //점명
    //initEmEdit(EM_COMP_NO, "GEN", PK);          //사업자번호
    /*  initEmEdit(EM_CORP_NO, "GEN", PK);          //법인번호
    initEmEdit(EM_COMP_NAME, "GEN", PK);        //상호명
    initEmEdit(EM_REP_NAME, "GEN", PK);         //대표자명
    initEmEdit(EM_BIZ_STAT, "GEN", PK);         //업태
    initEmEdit(EM_BIZ_CAT, "GEN", PK);          //종목
    initEmEdit(EM_POST_NO, "POST", PK);         //우편번호
    initEmEdit(EM_ADDR, "GEN", PK);             //주소
    initEmEdit(EM_DTL_ADDR, "GEN", PK);         //상세주소
    initEmEdit(EM_REP_TEL_NO, "GEN", PK);       //대표전화
    initEmEdit(EM_DISP_NO, "NUMBER^2^0", NORMAL);   //조회순서
    initEmEdit(EM_APP_S_DT, "YYYYMMDD", PK);    //적용시작일
    initEmEdit(EM_APP_E_DT, "YYYYMMDD", PK);    //적용종료일
*/
    //콤보 초기화
   // initComboStyle(LC_I_STR_CD,DS_O_FCL_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);      //시설구분(조회)
  //  initComboStyle(LC_I_IPCHUL_FLG,DS_O_STR_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);  //점구분(조회)
  //  initComboStyle(LC_O_MNG_FLAG,DS_O_MNG_FLAG, "CODE^0^30,NAME^0^80", 1, NORMAL);  //운영구분(조회)

  /*  initComboStyle(LC_I_CORP_FLAG,DS_I_CORP_FLAG, "CODE^0^30,NAME^0^80", 1, PK);    //법인구분
    initComboStyle(LC_I_FCL_FLAG,DS_I_FCL_FLAG, "CODE^0^30,NAME^0^80", 1, PK);      //시설구분
    initComboStyle(LC_I_STR_FLAG,DS_I_STR_FLAG, "CODE^0^30,NAME^0^80", 1, PK);      //점구분
    initComboStyle(LC_I_AREA_FLAG,DS_I_AREA_FLAG, "CODE^0^30,NAME^0^80", 1, PK);    //지역구분
    initComboStyle(LC_I_MNG_FLAG,DS_I_MNG_FLAG, "CODE^0^30,NAME^0^80", 1, PK);      //운영구분
    initComboStyle(LC_I_USE_YN,DS_I_USE_YN, "CODE^0^30,NAME^0^80", 1, PK);          //사용여부
    */
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}    name="NO"         width=25   align=center</FC>'
                     + '<FC>id=STR_CD      name=""     width=20   align=center HeadCheckShow="true" EditStyle="CheckBox"</FC>'
                     + '<FC>id=STR_CD      name="금종"     width=90   align=center</FC>'
                     + '<FC>id=STR_NAME    name="금종명"       width=100  align=center</FC>'
                     + '<FC>id=STR_FLAG    name="상품권금액"     width=100   align=center</FC>'
                     + '<FC>id=STR_FLAG    name="상품권코드"     width=120   align=center</FC>'
                     + '<FC>id=STR_FLAG    name="수량"     width=80   align=center</FC>'
                     + '<FC>id=STR_FLAG    name="상품권상태"     width=80   align=center</FC>'
                     + '<FC>id=STR_FLAG    name="판매일자"     width=80   align=center</FC>'
                     + '<FC>id=STR_FLAG    name="회수일자"     width=80   align=center</FC>';
                     
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
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

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
<comment id="_NSID_"><object id="DS_O_FCL_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_STR_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_MNG_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_I_CORP_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_FCL_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_STR_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_AREA_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_MNG_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_USE_YN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
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
            <th width="80" class="point">점</th>
            <td width="200" >
                <comment id="_NSID_">
                  <object id=EM_STR_CD classid=<%=Util.CLSID_EMEDIT%>   width=50 tabindex=1>
                  </object></comment><script>_ws_(_NSID_);</script>
                  <comment id="_NSID_">
                  <object id=EM_STR_NM classid=<%=Util.CLSID_EMEDIT%>   width=90 tabindex=1>
                  </object></comment><script>_ws_(_NSID_);</script>
              </td>
            <th width="80" class="point">일자</th>
            <td>
                <comment id="_NSID_">
                  <object id=EM_DRAWL_DT classid=<%=Util.CLSID_EMEDIT%>   width=70 tabindex=1 align="absmiddle">
                  </object></comment><script>_ws_(_NSID_);</script>
                    <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_DRAWL_DT)" align="absmiddle" />
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
    <td class="PT01 PB03">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
      <tr>
      <td>
          <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=505 classid=<%=Util.CLSID_GRID%>>
              <param name="DataID" value="DS_O_MASTER">
          </OBJECT></comment><script>_ws_(_NSID_);</script>
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

