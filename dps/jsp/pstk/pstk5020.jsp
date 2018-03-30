<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 재고수불 >  
 * 작 성 일 : 2010.05.12
 * 작 성 자 : 
 * 수 정 자 : 
 * 파 일 명 : pstk5020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.05.12 
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

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
//엑셀 다운을 위한 조회조건 전역 선언
 var excelStrCd;
 var excelDeptCd;
 var excelTeamCd;
 var excelPcCd;
 var excelFromYm;
 var excelToYm;
 var excelFlag1;
 var excelFlag2;
 var excelCheckBox1;
 var excelCheckBox2;
 var excelCheckBox3;
 var excelTemp;
 
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    
	initTab('TAB_MAIN');
    
	// Output Data Set Header 초기화
    // 조회구분 조직별(A)
	DS_O_MASTER1.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_O_MASTER2.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_O_MASTER3.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
 	// 조회구분 품목별(B)
    DS_O_MASTER4.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
 	// 조회구분 월별(C)
 	DS_O_MASTER5.setDataHeader('<gauce:dataset name="H_SEL_MONTH"/>');
    
    
    //그리드 초기화
    gridCreate1(); // 조직별(A)-PC별(1)
    gridCreate2(); // 조직별(A)-파트별(2)
    gridCreate3(); // 조직별(A)-팀별(3)
    gridCreate4(); // 품목별(B)
    gridCreate5(); // 월별(C)
    
    initEmEdit(EM_O_FROM_YM,     "THISMN",    PK);     // 시작년월
    initEmEdit(EM_O_TO_YM,       "THISMN",    PK);     // 종료년월
    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^150", 1, PK);  	// 점(조회)
    initComboStyle(LC_O_DEPT_CD,DS_O_DEPT_CD, "CODE^0^30,NAME^0^110", 1, PK);  	// 팀    
    initComboStyle(LC_O_TEAM_CD,DS_O_TEAM_CD, "CODE^0^30,NAME^0^110", 1, PK);  	// 파트
    initComboStyle(LC_O_PC_CD,DS_O_PC_CD, "CODE^0^30,NAME^0^110", 1, PK);  		// PC
    
    initComboStyle(LC_O_FLAG1,DS_O_FLAG1, "CODE^0^30,NAME^0^80", 1, PK);  		// 조회구분1
    initComboStyle(LC_O_FLAG2,DS_O_FLAG2, "CODE^0^30,NAME^0^80", 1, PK); 		// 조회구분2
    
    // 로딩시 값을 가겨오지 않는 콤보 데이셋 초기화    
    DS_O_DEPT_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_TEAM_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
    DS_O_PC_CD.setDataHeader('CODE:STRING(2),NAME:STRING(40)');

    // 조회구분1 콤보구성
    getEtcCode("DS_O_FLAG1", "D", "P000", "N");
    insComboData(LC_O_FLAG1, "A", "조직별", 1);
    insComboData(LC_O_FLAG1, "B", "품목별", 2);
    insComboData(LC_O_FLAG1, "C", "월별", 3);
    LC_O_FLAG1.Index = 0;
    
 	// 조회구분2 콤보구성
    getEtcCode("DS_O_FLAG2", "D", "P000", "N");
    insComboData(LC_O_FLAG2, "1", "PC별", 1);
    insComboData(LC_O_FLAG2, "2", "파트별", 2);
    insComboData(LC_O_FLAG2, "3", "팀별", 3);
    LC_O_FLAG2.Index = 0;
    
    //점콤보 가져오기 ( gauce.js )     
    getStore("DS_O_STR_CD", "Y", "", "N");    
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD, '<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); 
    
    LC_O_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}   name="NO"           width=30     align=center   edit=none  sumtext="" SubSumText=""                                        SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=DEPT_NM    name="팀명"       width=100    align=left   edit=none   suppress=2 SubSumText={decode(curlevel,1,"",2,"팀합계")}   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>' 
                     + '<FC>id=TEAM_NM    name="파트명"         width=100    align=left    edit=none   suppress=2 SubSumText={decode(curlevel,1,"파트합계",2,"")}   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=ORG_CD     name="PC코드"       width=100    align=left    edit=none   suppress=1 SubSumText=""   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=PC_NM      name="PC명"         width=100    align=left    edit=none   suppress=1 SubSumText=""   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     
                     + '<FG> name="직매입" '
                     + '<FC>id=JIK_TOT_SALE_AMT         name="총매출"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=JIK_NET_SALE_AMT_EXP_VAT         name="순매출(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=JIK_SALE_PROF_AMT_EXP_VAT         name="매출이익(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=JIK_RATE         name="이익율"              width=60     align=right  edit=none   sumtext={decode(subsum(JIK_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(JIK_SALE_PROF_AMT_EXP_VAT)/subsum(JIK_NET_SALE_AMT_EXP_VAT)*100),2))}  SubSumText={decode(subsum(JIK_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(JIK_SALE_PROF_AMT_EXP_VAT)/subsum(JIK_NET_SALE_AMT_EXP_VAT)*100),2))} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '</FG> ' 
                     
                     + '<FG> name="특정매입" '
                     + '<FC>id=TUK_TOT_SALE_AMT         name="총매출"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=TUK_NET_SALE_AMT_EXP_VAT         name="순매출(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=TUK_SALE_PROF_AMT_EXP_VAT         name="매출이익(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=TUK_RATE         name="이익율"              width=60     align=right  edit=none   sumtext={decode(subsum(TUK_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(TUK_SALE_PROF_AMT_EXP_VAT)/subsum(TUK_NET_SALE_AMT_EXP_VAT)*100),2))}  SubSumText={decode(subsum(TUK_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(TUK_SALE_PROF_AMT_EXP_VAT)/subsum(TUK_NET_SALE_AMT_EXP_VAT)*100),2))} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '</FG> ' 
                     
                     + '<FG> name="수수료" '
                     + '<FC>id=SU_TOT_SALE_AMT         name="총매출"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SU_NET_SALE_AMT_EXP_VAT         name="순매출(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SU_SALE_PROF_AMT_EXP_VAT         name="매출이익(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SU_RATE         name="이익율"              width=60     align=right  edit=none   sumtext={decode(subsum(SU_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(SU_SALE_PROF_AMT_EXP_VAT)/subsum(SU_NET_SALE_AMT_EXP_VAT)*100),2))} SubSumText={decode(subsum(SU_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(SU_SALE_PROF_AMT_EXP_VAT)/subsum(SU_NET_SALE_AMT_EXP_VAT)*100),2))} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '</FG> ' 
                     
                     + '<FG> name="총계" '
                     + '<FC>id=SUM_TOT_SALE_AMT         name="총매출"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SUM_NET_SALE_AMT_EXP_VAT         name="순매출(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SUM_SALE_PROF_AMT_EXP_VAT         name="매출이익(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SUM_RATE         name="이익율"              width=60     align=right  edit=none   sumtext={decode(subsum(SUM_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(SUM_SALE_PROF_AMT_EXP_VAT)/subsum(SUM_NET_SALE_AMT_EXP_VAT)*100),2))}  SubSumText={decode(subsum(SUM_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(SUM_SALE_PROF_AMT_EXP_VAT)/subsum(SUM_NET_SALE_AMT_EXP_VAT)*100),2))} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '</FG> ' 
                     ; 
                                          
    initGridStyle(GD_MASTER1, "common", hdrProperies, true);
                     
    GD_MASTER1.ViewSummary = "1";
    DS_O_MASTER1.SubSumExpr  = "2:DEPT_NM,1:TEAM_NM" ; 
    GD_MASTER1.ColumnProp("DEPT_NM", "sumtext")        = "총합계";
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}         name="NO"              width=30     align=center   edit=none  sumtext="" SubSumText=""                                        SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=DEPT_NM      name="팀명"          width=100    align=left   edit=none   suppress=2 SubSumText={decode(curlevel,1,"팀합계")}   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>' 
                     + '<FC>id=ORG_CD      name="파트코드"            width=100    align=left    edit=none   suppress=1 SubSumText=""   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=TEAM_NM      name="파트명"            width=100    align=left    edit=none   suppress=1 SubSumText=""   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     
                     + '<FG> name="직매입" '
                     + '<FC>id=JIK_TOT_SALE_AMT         name="총매출"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=JIK_NET_SALE_AMT_EXP_VAT         name="순매출(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=JIK_SALE_PROF_AMT_EXP_VAT         name="매출이익(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=JIK_RATE         name="이익율"              width=60     align=right  edit=none   sumtext={decode(subsum(JIK_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(JIK_SALE_PROF_AMT_EXP_VAT)/subsum(JIK_NET_SALE_AMT_EXP_VAT)*100),2))} SubSumText={decode(subsum(JIK_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(JIK_SALE_PROF_AMT_EXP_VAT)/subsum(JIK_NET_SALE_AMT_EXP_VAT)*100),2))} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '</FG> ' 
                     
                     + '<FG> name="특정매입" '
                     + '<FC>id=TUK_TOT_SALE_AMT         name="총매출"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=TUK_NET_SALE_AMT_EXP_VAT         name="순매출(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=TUK_SALE_PROF_AMT_EXP_VAT         name="매출이익(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=TUK_RATE         name="이익율"              width=60     align=right  edit=none   sumtext={decode(subsum(TUK_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(TUK_SALE_PROF_AMT_EXP_VAT)/subsum(TUK_NET_SALE_AMT_EXP_VAT)*100),2))}  SubSumText={decode(subsum(TUK_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(TUK_SALE_PROF_AMT_EXP_VAT)/subsum(TUK_NET_SALE_AMT_EXP_VAT)*100),2))} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '</FG> ' 
                     
                     + '<FG> name="수수료" '
                     + '<FC>id=SU_TOT_SALE_AMT         name="총매출"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SU_NET_SALE_AMT_EXP_VAT         name="순매출(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SU_SALE_PROF_AMT_EXP_VAT         name="매출이익(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SU_RATE         name="이익율"              width=60     align=right  edit=none   sumtext={decode(subsum(SU_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(SU_SALE_PROF_AMT_EXP_VAT)/subsum(SU_NET_SALE_AMT_EXP_VAT)*100),2))}  SubSumText={decode(subsum(SU_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(SU_SALE_PROF_AMT_EXP_VAT)/subsum(SU_NET_SALE_AMT_EXP_VAT)*100),2))} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '</FG> ' 
                     
                     + '<FG> name="총계" '
                     + '<FC>id=SUM_TOT_SALE_AMT         name="총매출"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SUM_NET_SALE_AMT_EXP_VAT         name="순매출(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SUM_SALE_PROF_AMT_EXP_VAT         name="매출이익(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '<FC>id=SUM_RATE         name="이익율"              width=60     align=right  edit=none   sumtext={decode(subsum(SUM_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(SUM_SALE_PROF_AMT_EXP_VAT)/subsum(SUM_NET_SALE_AMT_EXP_VAT)*100),2))} SubSumText={decode(subsum(SUM_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(SUM_SALE_PROF_AMT_EXP_VAT)/subsum(SUM_NET_SALE_AMT_EXP_VAT)*100),2))} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")}</FC>'
                     + '</FG> ' 
                     ; 
                                          
    initGridStyle(GD_MASTER2, "common", hdrProperies, true);
                     
    GD_MASTER2.ViewSummary = "1";
    DS_O_MASTER2.SubSumExpr  = "1:DEPT_NM" ; 
    GD_MASTER2.ColumnProp("DEPT_NM", "sumtext")        = "총합계";
}

function gridCreate3(){
    var hdrProperies = '<FC>id={currow}         name="NO"              width=30     align=center   edit=none  sumtext="" </FC>'
                     + '<FC>id=ORG_CD      name="팀코드"            width=100    align=left    edit=none    sumtext=""   </FC>'
                     + '<FC>id=DEPT_NM      name="팀명"            width=100    align=left    edit=none    sumtext=""   </FC>'
                     
                     + '<FG> name="직매입" '
                     + '<FC>id=JIK_TOT_SALE_AMT         name="총매출"              width=100     align=right  edit=none   sumtext=@sum  </FC>'
                     + '<FC>id=JIK_NET_SALE_AMT_EXP_VAT         name="순매출(세제외)"              width=100     align=right  edit=none   sumtext=@sum  </FC>'
                     + '<FC>id=JIK_SALE_PROF_AMT_EXP_VAT         name="매출이익(세제외)"              width=100     align=right  edit=none   sumtext=@sum  </FC>'
                     + '<FC>id=JIK_RATE         name="이익율"              width=60     align=right  edit=none   sumtext={decode(subsum(JIK_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(JIK_SALE_PROF_AMT_EXP_VAT)/subsum(JIK_NET_SALE_AMT_EXP_VAT)*100),2))} SubSumText={decode(subsum(JIK_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(JIK_SALE_PROF_AMT_EXP_VAT)/subsum(JIK_NET_SALE_AMT_EXP_VAT)*100),2))} </FC>'
                     + '</FG> ' 
                     
                     + '<FG> name="특정매입" '
                     + '<FC>id=TUK_TOT_SALE_AMT         name="총매출"              width=100     align=right  edit=none   sumtext=@sum  </FC>'
                     + '<FC>id=TUK_NET_SALE_AMT_EXP_VAT         name="순매출(세제외)"              width=100     align=right  edit=none   sumtext=@sum  </FC>'
                     + '<FC>id=TUK_SALE_PROF_AMT_EXP_VAT         name="매출이익(세제외)"              width=100     align=right  edit=none   sumtext=@sum  </FC>'
                     + '<FC>id=TUK_RATE         name="이익율"              width=60     align=right  edit=none   sumtext={decode(subsum(TUK_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(TUK_SALE_PROF_AMT_EXP_VAT)/subsum(TUK_NET_SALE_AMT_EXP_VAT)*100),2))} SubSumText={decode(subsum(TUK_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(TUK_SALE_PROF_AMT_EXP_VAT)/subsum(TUK_NET_SALE_AMT_EXP_VAT)*100),2))} </FC>'
                     + '</FG> ' 
                     
                     + '<FG> name="수수료" '
                     + '<FC>id=SU_TOT_SALE_AMT         name="총매출"              width=100     align=right  edit=none   sumtext=@sum  </FC>'
                     + '<FC>id=SU_NET_SALE_AMT_EXP_VAT         name="순매출(세제외)"              width=100     align=right  edit=none   sumtext=@sum  </FC>'
                     + '<FC>id=SU_SALE_PROF_AMT_EXP_VAT         name="매출이익(세제외)"              width=100     align=right  edit=none   sumtext=@sum  </FC>'
                     + '<FC>id=SU_RATE         name="이익율"              width=60     align=right  edit=none   sumtext={decode(subsum(SU_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(SU_SALE_PROF_AMT_EXP_VAT)/subsum(SU_NET_SALE_AMT_EXP_VAT)*100),2))} SubSumText={decode(subsum(SU_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(SU_SALE_PROF_AMT_EXP_VAT)/subsum(SU_NET_SALE_AMT_EXP_VAT)*100),2))} </FC>'
                     + '</FG> ' 
                     
                     + '<FG> name="총계" '
                     + '<FC>id=SUM_TOT_SALE_AMT         name="총매출"              width=100     align=right  edit=none   sumtext=@sum  </FC>'
                     + '<FC>id=SUM_NET_SALE_AMT_EXP_VAT         name="순매출(세제외)"              width=100     align=right  edit=none   sumtext=@sum  </FC>'
                     + '<FC>id=SUM_SALE_PROF_AMT_EXP_VAT         name="매출이익(세제외)"              width=100     align=right  edit=none   sumtext=@sum  </FC>'
                     + '<FC>id=SUM_RATE         name="이익율"              width=60     align=right  edit=none   sumtext={decode(subsum(SUM_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(SUM_SALE_PROF_AMT_EXP_VAT)/subsum(SUM_NET_SALE_AMT_EXP_VAT)*100),2))} SubSumText={decode(subsum(SUM_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(SUM_SALE_PROF_AMT_EXP_VAT)/subsum(SUM_NET_SALE_AMT_EXP_VAT)*100),2))} </FC>'
                     + '</FG> ' 
                     ; 
                                          
    initGridStyle(GD_MASTER3, "common", hdrProperies, true);
    GD_MASTER4.ViewSummary = "1";
    GD_MASTER3.ColumnProp("ORG_CD", "sumtext")        = "총합계";
}
																													
function gridCreate4(){
    var hdrProperies = '<FC>id={currow}         name="NO"              width=30     align=center   edit=none  sumtext="" SubSumText=""                                        SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=DEPT_NM      name="팀명"          width=100    align=left   edit=none   suppress=2 SubSumText={decode(curlevel,3,"팀합계")}   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>' 
                     + '<FC>id=TEAM_NM      name="파트명"            width=100    align=left    edit=none   suppress=2 SubSumText={decode(curlevel,3,"",2,"파트합계")}   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=PC_NM      name="PC명"            width=100    align=left    edit=none   suppress=2 SubSumText={decode(curlevel,3,"",2,"",1,"PC합계")}   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     
                     + '<FG> name="품목" '
                     + '<FC>id=PUMMOK_CD      name="코드"            width=100    align=left    edit=none   suppress=1 SubSumText=""   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=PUMMOK_NAME      name="명"            width=100    align=left    edit=none   suppress=1 SubSumText=""   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '</FG> '
                     
                     + '<FG> name="직매입" '
                     + '<FC>id=JIK_TOT_SALE_AMT         name="총매출"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=JIK_NET_SALE_AMT_EXP_VAT         name="순매출(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=JIK_SALE_PROF_AMT_EXP_VAT         name="매출이익(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=JIK_RATE         name="이익율"              width=60     align=right  edit=none   sumtext={decode(subsum(JIK_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(JIK_SALE_PROF_AMT_EXP_VAT)/subsum(JIK_NET_SALE_AMT_EXP_VAT)*100),2))} SubSumText={decode(subsum(JIK_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(JIK_SALE_PROF_AMT_EXP_VAT)/subsum(JIK_NET_SALE_AMT_EXP_VAT)*100),2))} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '</FG> ' 
                     
                     + '<FG> name="특정매입" '
                     + '<FC>id=TUK_TOT_SALE_AMT         name="총매출"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=TUK_NET_SALE_AMT_EXP_VAT         name="순매출(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=TUK_SALE_PROF_AMT_EXP_VAT         name="매출이익(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=TUK_RATE         name="이익율"              width=60     align=right  edit=none   sumtext={decode(subsum(TUK_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(TUK_SALE_PROF_AMT_EXP_VAT)/subsum(TUK_NET_SALE_AMT_EXP_VAT)*100),2))} SubSumText={decode(subsum(TUK_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(TUK_SALE_PROF_AMT_EXP_VAT)/subsum(TUK_NET_SALE_AMT_EXP_VAT)*100),2))} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '</FG> ' 
                     
                     + '<FG> name="수수료" '
                     + '<FC>id=SU_TOT_SALE_AMT         name="총매출"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=SU_NET_SALE_AMT_EXP_VAT         name="순매출(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=SU_SALE_PROF_AMT_EXP_VAT         name="매출이익(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=SU_RATE         name="이익율"              width=60     align=right  edit=none   sumtext={decode(subsum(SU_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(SU_SALE_PROF_AMT_EXP_VAT)/subsum(SU_NET_SALE_AMT_EXP_VAT)*100),2))} SubSumText={decode(subsum(SU_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(SU_SALE_PROF_AMT_EXP_VAT)/subsum(SU_NET_SALE_AMT_EXP_VAT)*100),2))} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '</FG> ' 
                     
                     + '<FG> name="총계" '
                     + '<FC>id=SUM_TOT_SALE_AMT         name="총매출"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=SUM_NET_SALE_AMT_EXP_VAT         name="순매출(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=SUM_SALE_PROF_AMT_EXP_VAT         name="매출이익(세제외)"              width=100     align=right  edit=none   sumtext=@sum  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '<FC>id=SUM_RATE         name="이익율"              width=60     align=right  edit=none   sumtext={decode(subsum(SUM_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(SUM_SALE_PROF_AMT_EXP_VAT)/subsum(SUM_NET_SALE_AMT_EXP_VAT)*100),2))} SubSumText={decode(subsum(SUM_NET_SALE_AMT_EXP_VAT),0,0.00,round((subsum(SUM_SALE_PROF_AMT_EXP_VAT)/subsum(SUM_NET_SALE_AMT_EXP_VAT)*100),2))} SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD",3,"#FFF7B1")}</FC>'
                     + '</FG> ' 
                     ; 
                                          
    initGridStyle(GD_MASTER4, "common", hdrProperies, true);
                     
    GD_MASTER4.ViewSummary = "1";
    DS_O_MASTER4.SubSumExpr  = "3:DEPT_NM, 2:TEAM_NM, 1:PC_NM" ;
    GD_MASTER4.ColumnProp("DEPT_NM", "sumtext")        = "총합계";
}


function gridCreate5(){
    var hdrProperies	= '<FC> id=CURROW		name="NO"			width=35	align=center Value={CurRow} </FC>'
			+ '<FC> id=ORG_NAME		name="조직명"		width=100	align=left SumText="합계" </FC>'
			+ '<R>'
	        + '<G>					name=$xkeyname_$$'
			+ '<C> ID=TOT_SALE_AMT_$$	name="총매출"			width=110	align=right	SumText=@sum </C>'
			+ '<C> ID=NET_SALE_AMT_EXP_VAT_$$	name="순매출(세제외)"			width=110	align=right	SumText=@sum </C>'
			+ '<C> ID=SALE_PROF_AMT_EXP_VAT_$$	name="매출이익(세제외)"			width=110	align=right	SumText=@sum </C>'
			+ '<C> ID=RATE_$$	name="이익율"			width=60	align=right	SumText={decode(subsum(NET_SALE_AMT_EXP_VAT_$$),0,0.00,round((subsum(SALE_PROF_AMT_EXP_VAT_$$)/subsum(NET_SALE_AMT_EXP_VAT_$$)*100),2))} </C>'
	        + '</G>'
	        + '</R>'
	        ;
	
	initGridStyle(GD_MASTER5,"COMMON",hdrProperies);
	GD_MASTER5.Editable    = false;
	GD_MASTER5.ViewSummary = "1";    //합계 보이기
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
 * 작 성 일 : 2010.05.12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() { 
    
	var strStrCd      = LC_O_STR_CD.BindColVal;
    var strDeptCd     = LC_O_DEPT_CD.BindColVal;
    var strTeamCd     = LC_O_TEAM_CD.BindColVal;
    var strPcCd       = LC_O_PC_CD.BindColVal;   
    var strFromYm     = EM_O_FROM_YM.Text;   
    var strToYm       = EM_O_TO_YM.Text;   
    var strFlag1      = LC_O_FLAG1.BindColVal;
    var strFlag2      = LC_O_FLAG2.BindColVal;
    var strCheckBox1  = CB_JIK.checked?"1":"";  // 직매입 :1
    var strCheckBox2  = CB_TUK.checked?"2":"";  // 특정	 :2
    var strCheckBox3  = CB_SU.checked?"3":"";	// 수수료 :3
    var strTempDs	  = "";
    var strTempGd	  = "";
	 
	if (isNull(strFromYm)==true ) {
        showMessage(Information, OK, "USER-1003","매출시작년월");
        EM_O_FROM_YM.focus();
        return false;
    }
	 
	if (isNull(strToYm)==true ) {
        showMessage(Information, OK, "USER-1003","매출종료년월");
        EM_O_TO_YM.focus();
        return false;
    }
	 
	if(strFromYm > strToYm) {
		showMessage(Information, OK, "USER-1021","매출시작년월","매출종료년월");
		EM_O_FROM_YM.focus();
        return false;
	} 
	
	if(strFlag1 == "C") {
		if(strCheckBox1 == "" && strCheckBox2 == "" && strCheckBox3 == "") {
			showMessage(Information, OK, "USER-1000","직매입/특정/수수료 중 하나 이상을 선택하십시요.");
			return false;
		}
	}
		
	DS_O_MASTER1.ClearData();
	DS_O_MASTER2.ClearData();
	DS_O_MASTER3.ClearData();
	DS_O_MASTER4.ClearData();
	DS_O_MASTER5.ClearData();
    
	setSearchValue2Excel();
    
    if(strFlag1 == "A") {
    	switch(strFlag2){
			case "1":
				strTempDs = "DS_O_MASTER1";  
				strTempGd = "GD_MASTER1";
			break;
			case "2":
				strTempDs = "DS_O_MASTER2";
				strTempGd = "GD_MASTER2";
			break;
			case "3":
				strTempDs = "DS_O_MASTER3";
				strTempGd = "GD_MASTER3";
			break;
		}
	} else if(strFlag1 == "B") {
		strTempDs = "DS_O_MASTER4";
		strTempGd = "GD_MASTER4";
	} else {
		strTempDs = "DS_O_MASTER5";
		strTempGd = "GD_MASTER5";
	}
    
    var goTo = "";
    
	if(strFlag1 == "C") {
    	goTo       = "searchMonth" ;
	} else {
		goTo       = "search" ;
	}
    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
                    +"&strDeptCd="+encodeURIComponent(strDeptCd)
                    +"&strTeamCd="+encodeURIComponent(strTeamCd)
                    +"&strPcCd="+encodeURIComponent(strPcCd)
                    +"&strFromYm="+encodeURIComponent(strFromYm)
                    +"&strToYm="+encodeURIComponent(strToYm)
                    +"&strFlag1="+encodeURIComponent(strFlag1)
                    +"&strFlag2="+encodeURIComponent(strFlag2)
                    +"&strCheckBox1="+encodeURIComponent(strCheckBox1)
                    +"&strCheckBox2="+encodeURIComponent(strCheckBox2)
                    +"&strCheckBox3="+encodeURIComponent(strCheckBox3)
                    ;   
    
    TR_MAIN.Action="/dps/pstk502.pt?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER="+strTempDs+")"; //조회는 O
    TR_MAIN.Post();
    
    
    setPorcCount("SELECT", eval(strTempGd));     
    
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
     
 }
/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {  
    
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : DB에 저장 / 수정 
 * return값 : void
*/
function btn_Save() {    
     
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {
	 
	var parameters = " 점="+nvl(excelStrCd,'전체')                    
                   + " -팀="+nvl(excelDeptCd,'전체')    
                   + " -파트="+nvl(excelTeamCd,'전체')     
                   + " -PC="+nvl(excelPcCd,'전체')
                   + " -매출년월="+excelFromYm+"~"+excelToYm
                   + " -구분="+excelFlag1+"("+excelFlag2+")"
                   + " "+excelTemp
                   ;
	
	if(LC_O_FLAG1.BindColVal == "A") {
		switch(LC_O_FLAG2.BindColVal){
			case "1":
				openExcelS(GD_MASTER1, "월별 매출 및 이익", parameters, true );
				GD_MASTER1.Focus();
			break;
			case "2":
				openExcelS(GD_MASTER2, "월별 매출 및 이익", parameters, true );
				GD_MASTER2.Focus();
			break;
			case "3":
				openExcelS(GD_MASTER3, "월별 매출 및 이익", parameters, true );
				GD_MASTER3.Focus();
			break;
		}
	} else if(LC_O_FLAG1.BindColVal == "B") {
		openExcelS(GD_MASTER4, "월별 매출 및 이익", parameters, true );
		GD_MASTER4.Focus();
	} else {
		openExcelS(GD_MASTER5, "월별 매출 및 이익", parameters, true );
		GD_MASTER5.Focus();
	}
		
    
}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2010.05.12
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 
 /**
  * setSearchValue2Excel()
  * 작 성 자 : 
  * 작 성 일 : 2010.05.12
  * 개    요 : 엑셀다운시 조회조건 입력을 위한 값 바인드
  * return값 : void
  */
 function setSearchValue2Excel(){
     excelStrCd    = LC_O_STR_CD.Text;
     excelDeptCd   = LC_O_DEPT_CD.Text;
     excelTeamCd   = LC_O_TEAM_CD.Text;
     excelPcCd     = LC_O_PC_CD.Text;
     excelFromYm   = EM_O_FROM_YM.Text;
     
     excelFromYm = EM_O_FROM_YM.Text.substring(0,4);
     excelFromYm += "-";
     excelFromYm += EM_O_FROM_YM.Text.substring(4,2);
     excelToYm = EM_O_TO_YM.Text.substring(0,4);
     excelToYm += "-";
     excelToYm += EM_O_TO_YM.Text.substring(4,2);
     
     excelFlag1   = LC_O_FLAG1.Text;
     excelFlag2	  = LC_O_FLAG2.Text;
     excelCheckBox1 = CB_JIK.checked?"직매입":"";
     excelCheckBox2 = CB_TUK.checked?"특정":"";
     excelCheckBox3 = CB_SU.checked?"수수료":"";
     excelTemp = "";
     
    if(excelCheckBox1 != "") excelTemp += "-직매입"
     
    if(excelTemp != "" && excelCheckBox2 != "") excelTemp += ", "
    
	if(excelCheckBox2 != "") excelTemp += "특정"
    
	if(excelTemp != "" && excelCheckBox3 != "") excelTemp += ", "
		    
	if(excelCheckBox3 != "") excelTemp += "수수료"
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
<!--------------------- 3. Excelupload  --------------------------------------->

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_O_MASTER1
    event=OnDataError(row,colid)>

</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=LC_O_STR_CD event=OnSelChange>
    
    DS_O_DEPT_CD.ClearData();
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    if (this.BindColVal == '%'){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);
        setComboData(LC_O_DEPT_CD, "%");
        return;     
    }
    
    getDept("DS_O_DEPT_CD", "Y", LC_O_STR_CD.BindColVal, "Y");
    if(DS_O_DEPT_CD.CountRow < 1){
        insComboData(LC_O_DEPT_CD, "%", "전체", 1);       
    }
    LC_O_DEPT_CD.Index = 0;

</script>

<script language=JavaScript for=LC_O_DEPT_CD event=OnSelChange>
    
    DS_O_TEAM_CD.ClearData();
    DS_O_PC_CD.ClearData();
    if (this.BindColVal == '%'){
        insComboData(LC_O_TEAM_CD, "%", "전체", 1);
        setComboData(LC_O_TEAM_CD, "%");
        return;     
    }
    
    getTeam("DS_O_TEAM_CD", "Y", LC_O_STR_CD.BindColVal,
                LC_O_DEPT_CD.BindColVal, "Y");

    if(DS_O_TEAM_CD.CountRow < 1){
        insComboData(LC_O_TEAM_CD, "%", "전체", 1);       
    }
    LC_O_TEAM_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_TEAM_CD event=OnSelChange>
    
    DS_O_PC_CD.ClearData();
    if (this.BindColVal == '%'){
        insComboData(LC_O_PC_CD, "%", "전체", 1);
        setComboData(LC_O_PC_CD, "%");
        return;     
    }
    getPc("DS_O_PC_CD", "Y", LC_O_STR_CD.BindColVal,
                LC_O_DEPT_CD.BindColVal, LC_O_TEAM_CD.BindColVal, "Y");

    if(DS_O_PC_CD.CountRow < 1){
        insComboData(LC_O_PC_CD, "%", "전체", 1);       
    }
    LC_O_PC_CD.Index = 0;
</script>

<script language=JavaScript for=LC_O_PC_CD event=OnSelChange>
    
</script>

<script language=JavaScript for=LC_O_FLAG1 event=OnSelChange>
	
	DS_O_FLAG2.ClearData();
	
	if(LC_O_FLAG1.BindColVal == "A") {
    	insComboData(LC_O_FLAG2, "1", "PC별", 1);
    	insComboData(LC_O_FLAG2, "2", "파트별", 2);
    	insComboData(LC_O_FLAG2, "3", "팀별", 3);
    	LC_O_FLAG2.Index = 0;
    	
    	CB_JIK.checked 	= false;
    	CB_TUK.checked 	= false;
    	CB_SU.checked 	= false;
    	CB_JIK.disabled	= true;
    	CB_TUK.disabled	= true;
    	CB_SU.disabled	= true;
    	
    } else if(LC_O_FLAG1.BindColVal == "B") {
    	insComboData(LC_O_FLAG2, "1", "대", 1);
    	insComboData(LC_O_FLAG2, "2", "중", 2);
    	insComboData(LC_O_FLAG2, "3", "소", 3);
    	LC_O_FLAG2.Index = 0;
    	CB_JIK.checked 	= false;
    	CB_TUK.checked 	= false;
    	CB_SU.checked 	= false;
    	CB_JIK.disabled	= true;
    	CB_TUK.disabled	= true;
    	CB_SU.disabled	= true;
    } else {
    	insComboData(LC_O_FLAG2, "1", "PC별", 1);
    	insComboData(LC_O_FLAG2, "2", "파트별", 2);
    	insComboData(LC_O_FLAG2, "3", "팀별", 3);
    	LC_O_FLAG2.Index = 0;
    	CB_JIK.disabled	= false;
    	CB_TUK.disabled	= false;
    	CB_SU.disabled	= false;
    }

</script>

<script language=JavaScript for=LC_O_FLAG2 event=OnSelChange>
	
	DS_O_MASTER1.ClearData();
	DS_O_MASTER2.ClearData();
	DS_O_MASTER3.ClearData();
	DS_O_MASTER4.ClearData();
	DS_O_MASTER5.ClearData();

	if(LC_O_FLAG1.BindColVal == "A") {
	
		switch(LC_O_FLAG2.BindColVal){
			case "1":
				setTabItemIndex('TAB_MAIN',1);      
			break;
			case "2":
				setTabItemIndex('TAB_MAIN',2);      
			break;
			case "3":
				setTabItemIndex('TAB_MAIN',3);      
			break;
		}
	} else if(LC_O_FLAG1.BindColVal == "B") {
		setTabItemIndex('TAB_MAIN',4);
	} else {
		setTabItemIndex('TAB_MAIN',5);
	}
	
	
</script>

 
<!-- 년월 -->
<script language=JavaScript for=EM_O_FROM_YM event=onKillFocus()>
    if(!checkDateTypeYM(this))
        return;
</script>
<script language=JavaScript for=EM_O_TO_YM event=onKillFocus()>
    if(!checkDateTypeYM(this))
        return;
</script>
<!-- Grid Master oneClick event 처리 -->
<!-- 
<script language=JavaScript for=GD_MASTER1 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GD_MASTER2 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GD_MASTER3 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<script language=JavaScript for=GD_MASTER4 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
 -->
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
<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER1" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_MASTER2" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_MASTER3" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_MASTER4" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_MASTER5" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
	<!-- 크로스탭 -->
	<object id="DS_CROSSTAB" classid=<%=Util.CLSID_DATASET%>>
	    <param name=DataID     value=DS_O_MASTER5> <!--DataSet-->
	    <param name=Logical    value="true">  <!--크로스 탭을 쓴건지 여부-->
	    <param name=GroupExpr  value="ORG_NAME,SALE_YM,TOT_SALE_AMT:NET_SALE_AMT_EXP_VAT:SALE_PROF_AMT_EXP_VAT:RATE">
	    <param name=SyncLoad   value="true">
	</object>
</comment>
<script> _ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_SEARCH_NM" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DEPT_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_TEAM_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PC_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_FLAG1" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_FLAG2" classid=<%= Util.CLSID_DATASET %>></object>
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
<div id="testdiv" class="testdiv" >

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
	<td class="PT01 PB03">
      	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
           	<tr>
       			<td>
       				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
         				<tr>
           					<th class="point" width="100">점</th>
				            <td>
				                 <comment id="_NSID_">
				                    <object id=LC_O_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=110 tabindex=1 align="absmiddle">
				                    </object>
				                </comment><script>_ws_(_NSID_);</script>
				            </td>
				            <th width="110">팀</th>
				            <td><comment id="_NSID_"> <object id=LC_O_DEPT_CD
				                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=110 tabindex=1
				                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
				            </td>
				            <th width="110">파트</th>
				            <td><comment id="_NSID_"> <object id=LC_O_TEAM_CD
				                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=110 tabindex=1
				                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
				            </td> 
				            <th width="110">PC</th>
				            <td><comment id="_NSID_"> <object id=LC_O_PC_CD
				                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=110 tabindex=1
				                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
				            </td>
         				</tr>
         				<tr>
         					<th class="point" width="100">매출년월</th>
				            <td colspan = "7">
				            	<comment id="_NSID_"> <object
				                id=EM_O_FROM_YM classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
				                align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
				                src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
				                onclick="javascript:openCal('M',EM_O_FROM_YM)" align="absmiddle" />
				               ~ <comment id="_NSID_"> <object
				                id=EM_O_TO_YM classid=<%=Util.CLSID_EMEDIT%> width=100 tabindex=1
				                align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
				                src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
				                onclick="javascript:openCal('M',EM_O_TO_YM)" align="absmiddle" />
				            </td> 
				        </tr>
				        <tr>
				        	<th class="point" width="110">조회구분</th>
				        	<td >
				            	<comment id="_NSID_"> <object id=LC_O_FLAG1
					                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=110 tabindex=1
					                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>   
			            	</td>
				            <th class="point" width="110">조회구분</th>
				        	<td >
				            	<comment id="_NSID_"> <object id=LC_O_FLAG2
					                classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=110 tabindex=1
					                align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>     
			            	</td> 
			            	<td colspan = "5">
			            	   <input type="checkbox" id="CB_JIK" >직매입
				               <input type="checkbox" id="CB_TUK" >특정
				               <input type="checkbox" id="CB_SU"  >수수료
				            </td>                      
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
    	<td class="PB03">
    		<div id=TAB_MAIN  width="100%" height=460 TitleWidth=90 TitleAlign="center" MenuDisplay=false>
            	<menu TitleName="조직PC별"      DivId="tab_page1" Enable='false' />
                <menu TitleName="조직파트별"      DivId="tab_page2" Enable='false' />
                <menu TitleName="조직팀별"    DivId="tab_page3" Enable='false' />
                <menu TitleName="품목별"        DivId="tab_page4" Enable='false' />
                <menu TitleName="월별"          DivId="tab_page5" Enable='false' />
            </div>
            <div id=tab_page1 width="100%" >      
	        	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
	            	<tr>
	                	<td>
		                    <comment id="_NSID_">
		                        <OBJECT id=GD_MASTER1 width=100% height=450 classid=<%=Util.CLSID_GRID%>>
		                            <param name="DataID" value="DS_O_MASTER1">
		                            <Param Name="ViewSummary"   value="1" >
		                        </OBJECT>
		                    </comment><script>_ws_(_NSID_);</script>
	                	</td>
	            	</tr>
	        	</table>
        	</div>
        	<div id=tab_page2 width="100%" >      
	        	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
	            	<tr>
	                	<td>
		                    <comment id="_NSID_">
		                        <OBJECT id=GD_MASTER2 width=100% height=450 classid=<%=Util.CLSID_GRID%>>
		                            <param name="DataID" value="DS_O_MASTER2">
		                            <Param Name="ViewSummary"   value="1" >
		                        </OBJECT>
		                    </comment><script>_ws_(_NSID_);</script>
	                	</td>
	            	</tr>
	        	</table>
        	</div>
        	<div id=tab_page3 width="100%" >      
	        	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
	            	<tr>
	                	<td>
		                    <comment id="_NSID_">
		                        <OBJECT id=GD_MASTER3 width=100% height=450 classid=<%=Util.CLSID_GRID%>>
		                            <param name="DataID" value="DS_O_MASTER3">
		                            <Param Name="ViewSummary"   value="1" >
		                        </OBJECT>
		                    </comment><script>_ws_(_NSID_);</script>
	                	</td>
	            	</tr>
	        	</table>
        	</div>
        	<div id=tab_page4 width="100%" >      
	        	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
	            	<tr>
	                	<td>
		                    <comment id="_NSID_">
		                        <OBJECT id=GD_MASTER4 width=100% height=450 classid=<%=Util.CLSID_GRID%>>
		                            <param name="DataID" value="DS_O_MASTER4">
		                            <Param Name="ViewSummary"   value="1" >
		                        </OBJECT>
		                    </comment><script>_ws_(_NSID_);</script>
	                	</td>
	            	</tr>
	        	</table>
        	</div>
        	<div id=tab_page5 width="100%" >      
	        	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
	            	<tr>
	                	<td>
		                    <comment id="_NSID_">
		                        <OBJECT id=GD_MASTER5 width=100% height=450 classid=<%=Util.CLSID_GRID%>>
		                            <param name="DataID" value="DS_CROSSTAB">
		                        </OBJECT>
		                    </comment><script>_ws_(_NSID_);</script>
	                	</td>
	            	</tr>
	        	</table>
        	</div>
     	</td>
  	</tr>	
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>

