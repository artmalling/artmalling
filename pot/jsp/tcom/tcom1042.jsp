<!-- 
/*******************************************************************************
 * 시스템명 : 시스템메뉴 > 관리자메뉴> 권한관리
 * 작 성 일 : 2010.12.12
 * 작 성 자 : 정지인
 * 수 정 자 : 
 * 파 일 명 : tcom1041.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 그룹별 프로그램 사용권한(TAB)
 * 이    력 :
  ********************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
<% request.setCharacterEncoding("utf-8"); %> 
<script language = javascript> 
var bfTab2Row = 0;
/**
 * initByGroup()
 * 작 성 자 : ckj
 * 작 성 일 : 2010-06-01
 * 개    요 : TAB 그룹별 프로그램 권한 초기화
 * return값 : void
*/
function initByGroup() 
{   
    // 권한 헤더 초기화  
    DS_O_GRPATH.setDataHeader ('<gauce:dataset name="H_USRPGM"/>');             // 권한리스트
    DS_O_TREE_MAIN_T2.setDataHeader ('<gauce:dataset name="H_TREE_MAIN"/>');    // 트리 

	//그룹가져오기
	selectPgroup("DS_O_PGROUP_T2"); 
	    
    //콤보 초기화 : 시스템구분
    initComboStyle(LC_SUB_SYSTEM_G, DS_O_SUBSYSTEM_T2, "CODE^0^30,NAME^0^80", 1, PK);
    //서브시스템 공통 코드 에서 가져 오기
    getEtcCode("DS_O_SUBSYSTEM_T2",   "D", "TC01", "N"); 

    //콤보 기본값셋팅 = 백화점
    setComboData(LC_SUB_SYSTEM_G, "P");   
    showTreeView('G',"DS_O_TREE_MAIN_T2"); 
     
    // 사용자리스트 그리드 셋팅
    var hdrProperies1 = '<FC>id=GROUP_CD     width=35    align=center    name="그룹"   </FC>'
                      + '<FC>id=GROUP_NAME   width=100   align=left      name="그룹명" </FC>';   
     initGridStyle(GD_PGROUP_G, "common", hdrProperies1, false);

     // 프로그램리스트 그리드 셋팅
     var hdrProperies2 = '<FC>ID=SUB_SYSTEM     width=70     align=Center              name="시스템구분"      edit=None </FC>'
                       + '<FC>ID=PID            width=70     align=Center              name="프로그램ID"     edit=None </FC>'
                       + '<FC>ID=NAME           width=150                              name="프로그램명"     edit=None </FC>'  
                       + '<FC>ID=IS_RET         width=30     EditStyle=CheckBox        name="조회"           edit={IF(IS_RET_GB       ="Y","true","false")}</FC>'
                       + '<FC>ID=IS_NEW         width=30     EditStyle=CheckBox        name="신규"           edit={IF(IS_NEW_GB       ="Y","true","false")}</FC>'
                       + '<FC>ID=IS_DEL         width=30     EditStyle=CheckBox        name="삭제"           edit={IF(IS_DEL_GB       ="Y","true","false")}</FC>'
                       + '<FC>ID=IS_SAVE        width=30     EditStyle=CheckBox        name="저장"           edit={IF(IS_SAVE_GB      ="Y","true","false")}</FC>'
                       + '<FC>ID=IS_EXCEL       width=30     EditStyle=CheckBox        name="엑셀"           edit={IF(IS_EXCEL_GB     ="Y","true","false")}</FC>'
                       + '<FC>ID=IS_PRINT       width=30     EditStyle=CheckBox        name="출력"           edit={IF(IS_PRINT_GB     ="Y","true","false")}</FC>'
                       + '<FC>ID=IS_CONFIRM     width=30     EditStyle=CheckBox        name="확정"           edit={IF(IS_CONFIRM_GB   ="Y","true","false")}</FC>'
	                   //// MARIO OUTLET
	                   + '<FC>ID=LNAME          width=70     align=left                name="대분류"         edit=None </FC>'
	                   + '<FC>ID=MNAME          width=70     align=left                name="중분류"         edit=None </FC>'
	                   //+ '<FC>ID=SNAME          width=100    align=left                name="소분류"         edit=None </FC>'
                       //// MARIO OUTLET
                       ;  
    initGridStyle(GD_GRPATH_G, "common", hdrProperies2, true);
    GD_GRPATH_G.MultiRowSelect  = "true";
}    
 
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- TAB2(그룹별 프로그램 권한) : 서브시스템 LUXCOMBO 상태 변경시   -->
<script language=JavaScript for=LC_SUB_SYSTEM_G event=onSelChange()> 
    showTreeView('G',"DS_O_TREE_MAIN_T2"); 
</script>

<!-- TAB2(그룹별 프로그램 권한) :  그룹 리스트 클릭시   -->
<script language=JavaScript for=DS_O_PGROUP_T2 event=OnRowPosChanged(row)>  

    if(row < 1) return; 
    if(bfTab2Row == row && DS_O_PGROUP_T2.CountRow >0) return;
    
    if( DS_O_GRPATH.IsUpdated ) 
    {
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 )
        { 
            DS_O_PGROUP_T2.RowPosition = bfTab2Row;
            return;
         }
     }
     DS_O_PGROUP_T2.UndoAll();
     bfTab2Row = row;

     showUsrpgm( 'G', DS_O_PGROUP_T2.NameValue(row, "GROUP_CD"), DS_O_GRPATH); 
     setLastGroupSelected( DS_O_PGROUP_T2.NameValue(row, "GROUP_CD") );   
</script> 

<!-- TAB1(사용자별 프로그램 권한) :  메뉴 TREE 클릭시  -->
<script language=JavaScript for=TV_MAIN_G event=OnClick(row,colid)>
    setLastProgramSelected("G", DS_O_TREE_MAIN_T2.NameValue(DS_O_TREE_MAIN_T2.RowPosition, "CODE"));
</script>

<!-- TAB2(그룹별 프로그램 권한) : 그룹 GRID 더블 클릭시 : 사용자 정보 팝업으로 보여주기   -->
<script language=JavaScript for=GD_PGROUP_G event=OnDblClick(row,colid)> 
 
    window.showModalDialog("/pot/tcom104.tc?goTo=usrJojikPop"
		    		      , DS_O_PGROUP_T2.NameValue(row, "GROUP_CD")
				          , "dialogWidth:800px;dialogHeight:450px;scroll:no;" +
				            "resizable:no;help:no;unadorned:yes;center:yes;status:no"); 
</script>

<!-- TAB2  : 헤더클릭시 정렬  -->
<script language=JavaScript for=GD_PGROUP_G event=OnClick(row,colid)>
    if( row < 1)
        sortColId( eval(this.DataID), row , colid );
</script> 
<script language=JavaScript for=GD_GRPATH_G event=OnClick(row,colid)>
    if( row < 1)
        sortColId( eval(this.DataID), row , colid );
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
<!-- 콤보 시스템구분 -->
<comment id="_NSID_"><object id="DS_O_SUBSYSTEM_T2"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- 그룹리스트 -->
<comment id="_NSID_"><object id="DS_O_PGROUP_T2"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> <!-- 그룹  담고 있는 데이타셋 -->
<!-- 사용자 조회 -->
<comment id="_NSID_"><object id="DS_O_USRMST_T2"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> 
<!-- 트리 -->
<comment id="_NSID_"><object id="DS_O_TREE_MAIN_T2"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> <!-- TREE 표현할 데이타셋 -->
<!-- 프로그램 권한 리스트 -->
<comment id="_NSID_"><object id="DS_O_GRPATH"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script> 

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->

<body>

<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
 
    <tr><td class="PT03"  width="100%" >
        <table width="100%" border="0" cellpadding="0" cellspacing="0" height="100%">
        <tr> 
        <!-- 그룹리스트 start -->
        <td valign="top" width="150">
            <table  width="150" border="0" cellpadding="0" cellspacing="0" class="BD4A">
            <tr><td> 
                 <comment id="_NSID_"><OBJECT id=GD_PGROUP_G width="100%" height="522" classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_O_PGROUP_T2">
                    </OBJECT></comment><script>_ws_(_NSID_);</script> 
            </td></tr>
            </table>       
        </td>
        <!-- 그룹리스트 end --> 
        <td>&nbsp;</td>
        
        <!-- tree start -->
        <td valign="top" width="180" >  
        <Table width="100" border="0" cellpadding="0" cellspacing="0" align="center">
            <tr>
                <Td>
                    <comment id="_NSID_">
                    <object id=LC_SUB_SYSTEM_G classid=<%= Util.CLSID_LUXECOMBO %> height=100 width=120 align="absmiddle"></object>
                    </comment><script>_ws_(_NSID_);</script> 
                </td>
                <td valign ="left">
                    <img src="./imgs/btn/btn_addprogram.gif"  style="cursor:hand" align=center onclick="addProgram('G')" > </td> 
            </tr> 
            
            <tr><td colspan=2></td></tr>
            <Tr>
                <TD colspan=2 width="180" align=center valign="top" class="BD2A" >
	                <comment id="_NSID_">
	                  <object id=TV_MAIN_G classid=<%=Util.CLSID_TREEVIEW%>  width=180  height=503>
	                    <param name=DataID          value="DS_O_TREE_MAIN_T2">
	                    <param name=TextColumn      value="TXT">
	                    <param name=LevelColumn     value="LVL">
	                    <param name=UseImage        value="false">
	                    <param name=ExpandOneClick  value="true">
	                    <param name=BorderStyle     value="0">
	                  </object>
	                  </comment><script>_ws_(_NSID_);</script>
                </TD>
            </Tr>
        </table>        
        </td>
        <!-- tree end --> 
        <td>&nbsp;</td>
        
        <!-- 프로그램리스트 start -->
        <td  valign="top" width="100%"  style="padding-right:5px;">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="BD4A">
            <tr><td >
                <comment id="_NSID_">
                    <object id=GD_GRPATH_G classid=<%=Util.CLSID_GRID%> height=523 width=100% >
                        <param name=DataID      value="DS_O_GRPATH">
                    </object>
                </comment><script>_ws_(_NSID_);</script>
            </td></tr>
            </table>
        </td>
        <!-- 프로그램리스트 end -->
        </tr>
        </table>
 
    </td></tr>
    </table> 
</body>
