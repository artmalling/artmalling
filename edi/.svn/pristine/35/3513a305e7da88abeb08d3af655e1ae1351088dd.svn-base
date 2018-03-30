package sample.ajax.dao;

import java.util.List;

import kr.fujitsu.ffw.control.ActionForm;
import kr.fujitsu.ffw.model.AbstractDAO2;
import kr.fujitsu.ffw.model.SqlWrapper;

public class SAM_010DAO extends AbstractDAO2 {
/*	
    static int cnt = 0;
    public void clobExample() throws Exception {
        SqlWrapper sql0 = null;
        SqlWrapper sql1 = null;
        SqlWrapper sql2 = null;
        
        //CLOB으로 밀어넣을 데이터를 임시 저장 할 변수
        String str[] = new String[1];
        
        str[0] = "Sun Microsystems, Inc. Binary Code License Agreement";
        str[0]+= "for the JAVA 2 PLATFORM STANDARD EDITION DEVELOPMENT KIT 5.0";
        str[0]+= "SUN MICROSYSTEMS, INC. (SUN) IS WILLING TO LICENSE THE SOFTWARE " +
                "IDENTIFIED BELOW TO YOU ONLY UPON THE CONDITION THAT YOU ACCEPT" +
                " ALL OF THE TERMS CONTAINED IN THIS BINARY CODE LICENSE AGREEMENT " +
                "AND SUPPLEMENTAL LICENSE TERMS (COLLECTIVELY AGREEMENT).  " +
                "PLEASE READ THE AGREEMENT CAREFULLY.  BY DOWNLOADING OR " +
                "INSTALLING THIS SOFTWARE, YOU ACCEPT THE TERMS OF THE AGREEMENT. " +
                "INDICATE ACCEPTANCE BY SELECTING THE ACCEPT BUTTON AT THE BOTTOM " +
                "OF THE AGREEMENT. IF YOU ARE NOT WILLING TO BE BOUND BY ALL " +
                "THE TERMS, SELECT THE DECLINE BUTTON AT THE BOTTOM OF THE " +
                "AGREEMENT AND THE DOWNLOAD OR INSTALL PROCESS WILL NOT CONTINUE. ";
        
        str[0]+= "1. DEFINITIONS. Software means the identified above in binary " +
                "form, any other machine readable materials (including, but not " +
                "limited to, libraries, source files, header files, and data files)," +
                " any updates or error corrections provided by Sun, and any user" +
                " manuals, programming guides and other documentation provided to " +
                "you by Sun under this Agreement. Programs mean Java applets and " +
                "applications intended to run on the Java 2 Platform Standard " +
                "Edition (J2SE platform) platform on Java-enabled general purpose " +
                "desktop computers and servers.";
        
        str[0]+= "2. LICENSE TO USE. Subject to the terms and conditions of this " +
                "Agreement, including, but not limited to the Java Technology " +
                "Restrictions of the Supplemental License Terms, Sun grants you" +
                " a non-exclusive, non-transferable, limited license without license " +
                "fees to reproduce and use internally Software complete and unmodified " +
                "for the sole purpose of running Programs. Additional licenses for " +
                "developers and/or publishers are granted in the Supplemental License Terms.";
        
        str[0]+= "3. RESTRICTIONS. Software is confidential and copyrighted. " +
                "Title to Software and all associated intellectual property rights " +
                "is retained by Sun and/or its licensors. Unless enforcement is " +
                "prohibited by applicable law, you may not modify, decompile, " +
                "or reverse engineer Software.  You acknowledge that Licensed " +
                "Software is not designed or intended for use in the design, " +
                "construction, operation or maintenance of any nuclear facility. " +
                "Sun Microsystems, Inc. disclaims any express or implied warranty " +
                "of fitness for such uses. No right, title or interest in or to any " +
                "trademark, service mark, logo or trade name of Sun or its licensors " +
                "is granted under this Agreement. Additional restrictions for developers " +
                "and/or publishers licenses are set forth in the Supplemental License Terms.";
        
        str[0]+= "4. LIMITED WARRANTY.  Sun warrants to you that for a period of ninety (90)" +
                " days from the date of purchase, as evidenced by a copy of the receipt, the " +
                "media on which Software is furnished (if any) will be free of defects in " +
                "materials and workmanship under normal use.  Except for the foregoing, " +
                "Software is provided AS IS.  Your exclusive remedy and Suns entire liability " +
                "under this limited warranty will be at Suns option to replace Software " +
                "media or refund the fee paid for Software. Any implied warranties on the " +
                "Software are limited to 90 days. Some states do not allow limitations on " +
                "duration of an implied warranty, so the above may not apply to you. This " +
                "limited warranty gives you specific legal rights. You may have others, " +
                "which vary from state to state. ";
        
        str[0]+= "5. DISCLAIMER OF WARRANTY.  UNLESS SPECIFIED IN THIS AGREEMENT, " +
                "ALL EXPRESS OR IMPLIED CONDITIONS, REPRESENTATIONS AND WARRANTIES, " +
                "INCLUDING ANY IMPLIED WARRANTY OF MERCHANTABILITY, FITNESS FOR A " +
                "PARTICULAR PURPOSE OR NON-INFRINGEMENT ARE DISCLAIMED, EXCEPT TO " +
                "THE EXTENT THAT THESE DISCLAIMERS ARE HELD TO BE LEGALLY INVALID. ";
        
        str[0]+= "6. LIMITATION OF LIABILITY.  TO THE EXTENT NOT PROHIBITED BY LAW, " +
                "IN NO EVENT WILL SUN OR ITS LICENSORS BE LIABLE FOR ANY LOST REVENUE, " +
                "PROFIT OR DATA, OR FOR SPECIAL, INDIRECT, CONSEQUENTIAL, INCIDENTAL OR " +
                "PUNITIVE DAMAGES, HOWEVER CAUSED REGARDLESS OF THE THEORY OF LIABILITY, " +
                "ARISING OUT OF OR RELATED TO THE USE OF OR INABILITY TO USE SOFTWARE, " +
                "EVEN IF SUN HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.  " +
                "In no event will Suns liability to you, whether in contract, tort " +
                "(including negligence), or otherwise, exceed the amount paid by you " +
                "for Software under this Agreement.  The foregoing limitations will " +
                "apply even if the above stated warranty fails of its essential purpose." +
                " Some states do not allow the exclusion of incidental or consequential " +
                "damages, so some of the terms above may not be applicable to you. ";
        
        str[0]+= "7. TERMINATION.  This Agreement is effective until terminated.  " +
                "You may terminate this Agreement at any time by destroying all copies " +
                "of Software.  This Agreement will terminate immediately without notice " +
                "from Sun if you fail to comply with any provision of this Agreement.  " +
                "Either party may terminate this Agreement immediately should any Software become, " +
                "or in either partys opinion be likely to become, the subject of a claim " +
                "of infringement of any intellectual property right. Upon Termination, " +
                "you must destroy all copies of Software. ";
        
        str[0]+= "8. EXPORT REGULATIONS. All Software and technical data delivered " +
                "under this Agreement are subject to US export control laws and " +
                "may be subject to export or import regulations in other countries.  " +
                "You agree to comply strictly with all such laws and regulations and " +
                "acknowledge that you have the responsibility to obtain such licenses " +
                "to export, re-export, or import as may be required after delivery to you. ";
        
        str[0]+= "9. TRADEMARKS AND LOGOS. You acknowledge and agree as between " +
                "you and Sun that Sun owns the SUN, SOLARIS, JAVA, JINI, FORTE, " +
                "and iPLANET trademarks and all SUN, SOLARIS, JAVA, JINI, FORTE, " +
                "and iPLANET-related trademarks, service marks, logos and other " +
                "brand designations (Sun Marks), and you agree to comply with the " +
                "Sun Trademark and Logo Usage Requirements currently located at " +
                "http://www.sun.com/policies/trademarks. Any use you make of the " +
                "Sun Marks inures to Suns benefit. ";
        
        str[0]+= "10. U.S. GOVERNMENT RESTRICTED RIGHTS.  If Software is being " +
                "acquired by or on behalf of the U.S. Government or by a U.S. " +
                "Government prime contractor or subcontractor (at any tier), " +
                "then the Governments rights in Software and accompanying " +
                "documentation will be only as set forth in this Agreement; " +
                "this is in accordance with 48 CFR 227.7201 through 227.7202-4 " +
                "(for Department of Defense (DOD) acquisitions) and with 48 CFR " +
                "2.101 and 12.212 (for non-DOD acquisitions). ";
        
        str[0]+= "11. GOVERNING LAW.  Any action related to this Agreement will " +
                "be governed by California law and controlling U.S. federal law.  " +
                "No choice of law rules of any jurisdiction will apply. ";
        
        str[0]+= "12. SEVERABILITY. If any provision of this Agreement is held to " +
                "be unenforceable, this Agreement will remain in effect with the " +
                "provision omitted, unless omission would frustrate the intent " +
                "of the parties, in which case this Agreement will immediately " +
                "terminate. ";
        
        str[0]+= "13. INTEGRATION.  This Agreement is the entire agreement " +
                "between you and Sun relating to its subject matter.  " +
                "It supersedes all prior or contemporaneous oral or written " +
                "communications, proposals, representations and warranties and" +
                " prevails over any conflicting or additional terms of any quote," +
                " order, acknowledgment, or other communication between the parties " +
                "relating to its subject matter during the term of this Agreement.  " +
                "No modification of this Agreement will be binding, unless in writing " +
                "and signed by an authorized representative of each party. ";
        
        str[0]+= "    SUPPLEMENTAL LICENSE TERMS";
        
        str[0]+= "These Supplemental License Terms add to or modify the terms " +
                "of the Binary Code License Agreement. Capitalized terms not " +
                "defined in these Supplemental Terms shall have the same meanings " +
                "ascribed to them in the Binary Code License Agreement . These " +
                "Supplemental Terms shall supersede any inconsistent or conflicting " +
                "terms in the Binary Code License Agreement, or in any license " +
                "contained within the Software. ";
        
        str[0]+= "A. Software Internal Use and Development License Grant. Subject " +
                "to the terms and conditions of this Agreement and restrictions " +
                "and exceptions set forth in the Software README file, including, " +
                "but not limited to the Java Technology Restrictions of these " +
                "Supplemental Terms, Sun grants you a non-exclusive, non-transferable, " +
                "limited license without fees to reproduce internally and use " +
                "internally the Software complete and unmodified for the purpose " +
                "of designing, developing, and testing your Programs. ";
        
        str[0]+= "B. License to Distribute Software. Subject to the terms and " +
                "conditions of this Agreement and restrictions and exceptions " +
                "set forth in the Software README file, including, but not " +
                "limited to the Java Technology Restrictions of these Supplemental" +
                " Terms, Sun grants you a non-exclusive, non-transferable, limited " +
                "license without fees to reproduce and distribute the Software, " +
                "provided that (i) you distribute the Software complete and " +
                "unmodified and only bundled as part of, and for the sole purpose " +
                "of running, your Programs, (ii) the Programs add significant and " +
                "primary functionality to the Software, (iii) you do not distribute " +
                "additional software intended to replace any component(s) of the " +
                "Software, (iv) you do not remove or alter any proprietary legends " +
                "or notices contained in the Software, (v) you only distribute the " +
                "Software subject to a license agreement that protects Suns interests " +
                "consistent with the terms contained in this Agreement, and (vi) you " +
                "agree to defend and indemnify Sun and its licensors from and against " +
                "any damages, costs, liabilities, settlement amounts and/or expenses " +
                "(including attorneys fees) incurred in connection with any claim, " +
                "lawsuit or action by any third party that arises or results from the " +
                "use or distribution of any and all Programs and/or Software.";
        
        str[0]+= "C. License to Distribute Redistributables. Subject to the terms and " +
                "conditions of this Agreement and restrictions and exceptions set " +
                "forth in the Software README file, including but not limited to the " +
                "Java Technology Restrictions of these Supplemental Terms, Sun grants " +
                "you a non-exclusive, non-transferable, limited license without fees to " +
                "reproduce and distribute those files specifically identified as " +
                "redistributable in the Software README file (Redistributables) " +
                "provided that: (i) you distribute the Redistributables complete " +
                "and unmodified, and only bundled as part of Programs, (ii) the " +
                "Programs add significant and primary functionality to the " +
                "Redistributables, (iii) you do not distribute additional " +
                "software intended to supersede any component(s) of the Redistributables " +
                "(unless otherwise specified in the applicable README file), (iv) you do " +
                "not remove or alter any proprietary legends or notices contained in or on " +
                "the Redistributables, (v) you only distribute the Redistributables pursuant" +
                " to a license agreement that protects Suns interests consistent with the " +
                "terms contained in the Agreement, (vi) you agree to defend and indemnify " +
                "Sun and its licensors from and against any damages, costs, liabilities, " +
                "settlement amounts and/or expenses (including attorneys fees) incurred in " +
                "connection with any claim, lawsuit or action by any third party that arises " +
                "or results from the use or distribution of any and all Programs and/or Software.";
        
        str[0]+= "D. Java Technology Restrictions.  You may not create, modify, or change the " +
                "behavior of, or authorize your licensees to create, modify, or change the " +
                "behavior of, classes, interfaces, or subpackages that are in any way " +
                "identified as java, javax, sun or similar convention as specified by " +
                "Sun in any naming convention designation.";
        
        str[0]+= "E. Distribution by Publishers. This section pertains to your " +
                "distribution of the Software with your printed book or magazine " +
                "(as those terms are commonly used in the industry) relating to " +
                "Java technology (Publication). Subject to and conditioned upon " +
                "your compliance with the restrictions and obligations contained " +
                "in the Agreement, in addition to the license granted in Paragraph " +
                "1 above, Sun hereby grants to you a non-exclusive, nontransferable" +
                " limited right to reproduce complete and unmodified copies of the " +
                "Software on electronic media (the Media) for the sole purpose of " +
                "inclusion and distribution with your Publication(s), subject to " +
                "the following terms: (i) You may not distribute the Software on " +
                "a stand-alone basis; it must be distributed with your Publication(s); " +
                "(ii) You are responsible for downloading the Software from the " +
                "applicable Sun web site; (iii) You must refer to the Software as " +
                "JavaTM 2 Platform Standard Edition Development Kit 5.0; (iv) " +
                "The Software must be reproduced in its entirety and without any " +
                "modification whatsoever (including, without limitation, the Binary " +
                "Code License and Supplemental License Terms accompanying the Software" +
                " and proprietary rights notices contained in the Software); (v) The " +
                "Media label shall include the following information: Copyright 2004, " +
                "Sun Microsystems, Inc. All rights reserved. Use is subject to license terms. " +
                "Sun, Sun Microsystems, the Sun logo, Solaris, Java, the Java Coffee " +
                "Cup logo, J2SE , and all trademarks and logos based on Java are " +
                "trademarks or registered trademarks of Sun Microsystems, Inc. " +
                "in the U.S. and other countries. This information must be placed on " +
                "the Media label in such a manner as to only apply to the Sun Software; " +
                "(vi) You must clearly identify the Software as Suns product on the " +
                "Media holder or Media label, and you may not state or imply that Sun " +
                "is responsible for any third-party software contained on the Media; " +
                "(vii) You may not include any third party software on the Media which " +
                "is intended to be a replacement or substitute for the Software; (viii)" +
                " You shall indemnify Sun for all damages arising from your failure to " +
                "comply with the requirements of this Agreement. In addition, you shall" +
                " defend, at your expense, any and all claims brought against Sun by third " +
                "parties, and shall pay all damages awarded by a court of competent " +
                "jurisdiction, or such settlement amount negotiated by you, arising out " +
                "of or in connection with your use, reproduction or distribution of " +
                "the Software and/or the Publication. Your obligation to provide " +
                "indemnification under this section shall arise provided that Sun: " +
                "(i) provides you prompt notice of the claim; (ii) gives you sole " +
                "control of the defense and settlement of the claim; (iii) provides you," +
                " at your expense, with all available information, assistance and authority " +
                "to defend; and (iv) has not compromised or settled such claim without your " +
                "prior written consent; and (ix) You shall provide Sun with a written notice " +
                "for each Publication; such notice shall include the following information: (1) " +
                "title of Publication, (2) author(s), (3) date of Publication, and (4) ISBN " +
                "or ISSN numbers. Such notice shall be sent to Sun Microsystems, Inc., 4150 " +
                "Network Circle, M/S USCA12-110, Santa Clara, California 95054, U.S.A , " +
                "Attention: Contracts Administration.";
        
        str[0]+= "F. Source Code. Software may contain source code that, unless " +
                "expressly licensed for other purposes, is provided solely for " +
                "reference purposes pursuant to the terms of this Agreement. " +
                "Source code may not be redistributed unless expressly provided for " +
                "in this Agreement.";
        
        str[0]+= "G. Third Party Code. Additional copyright notices and license " +
                "terms applicable to portions of the Software are set forth in the " +
                "THIRDPARTYLICENSEREADME.txt file. In addition to any terms and " +
                "conditions of any third party opensource/freeware license identified " +
                "in the THIRDPARTYLICENSEREADME.txt file, the disclaimer of  warranty " +
                "and limitation of liability provisions in paragraphs 5 and 6 of the  " +
                "Binary Code License Agreement shall apply to all Software in this " +
                "distribution.";
        
        str[0]+= "For inquiries please contact: Sun Microsystems, Inc., " +
                "4150 Network Circle, Santa  Clara, California 95054, U.S.A.";
        
        str[0]+= "LFI#141623/Form ID#011801)";

        try {
            begin();
            connect("pot");
            sql0 = new SqlWrapper(); // SEQUNCE를 가져옵니다.
            sql1 = new SqlWrapper(); // CLOB INSERT 구문을 만듭니다.
            sql2 = new SqlWrapper(); // CLOB데이터를 입력합니다.

            sql0.put("select tut_seq.nextval seq from dual");
            System.out.println("=== 셀렉트 시작");
            java.util.Map map = executeQueryByMap(sql0);
            System.out.println("=== 셀렉트 종료");
            //입력 시퀀스를 가져옵니다.
            int seq = Integer.parseInt((String)map.get("seq"));

            // empty_clob()함수를 이용 clob 데이터의 버퍼를 생성합니다.
            // empty_clob()을 이용하지 않으면 오라클은 4000Byte의 버퍼만 잡습니다.
            sql1.put("insert into clobtest(no, title, writer, contents, wdate) " +
                     "values (?, ?, ?, empty_clob(), sysdate)");
            
            sql1.setInt(1, seq);
            sql1.setString(2, "제목없음-" + cnt++);
            sql1.setString(3, "작성자없음" + cnt);
            
            // clob형식의 컬럼을 lock을 걸어 select 해 옵니다.
            // 반드시 clob형식의 컬럼만 select합니다.
            sql2.put("select contents " +
                    "   from clobtest " +
                    "  where no = ? for update");
            
            sql2.setInt(1, seq);
            
            // sql2의 select 개수와 str의 배열의 수는 반드시 같아야 합니다.
            System.out.println("=== 업데이트 시작");
            executeUpdateByCLOB(sql1, sql2, str);
            System.out.println("=== 업데이트 종료");            

        } catch (Exception e) {
            rollback();
            throw e;
        } finally {
            end();
        }
        
    }
 */   
    public StringBuffer getDetailData(ActionForm form) throws Exception {
        StringBuffer sb = null;
        SqlWrapper sql = null;
        
        try {
            sql = new SqlWrapper();
            
            sql.put("SELECT no, title, writer, contents " +
                    "  FROM com.keb_board                    " +
                    " WHERE no = ?                      ");
            
            sql.setInt(1, form.getInt(1, "no"));
            connect("pot"); 
            sb = executeQueryByAjax(sql);
        } catch (Exception e) {
            throw e;
        }
        
        return sb;
    }
    
    public List getListData(ActionForm form) throws Exception {
        List list = null;
        SqlWrapper sql = null;        

        try {
            sql = new SqlWrapper();
            sql.put("SELECT *          " +
                    "  FROM com.keb_board   " +
                    " ORDER BY no DESC ");
            
            connect("pot");
            list = executeQuery(sql);
        } catch (Exception e) {
            throw e;
        } 
        return list;
    }
}
