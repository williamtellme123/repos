-- -----------------------------------------------------------------------------
-- E X T E R N A L T A B L E    T X T (TAB DELIMITED)
-- -----------------------------------------------------------------------------
-- 1. First physically create the directory c:\temp
-- -----------------------------------------------------------------------------
-- 2. Then login as system and do:
-- A. CREATE OR REPLACE DIRECTORY TMP AS 'C:\temp';
-- -----------------------------------------------------------------------------
CREATE OR REPLACE DIRECTORY tmp  AS   'C:\temp';
-- -----------------------------------------------------------------------------
-- B. GRANT READ, WRITE ON DIRECTORY TMP TO SAMPLECODE
-- -----------------------------------------------------------------------------
GRANT READ, WRITE ON DIRECTORY tmp TO SAMPLECODE;
-- -----------------------------------------------------------------------------
-- 3. Create the external table
-- -----------------------------------------------------------------------------
DROP TABLE invoices_external;
SELECT COUNT(*) FROM invoices_external;
CREATE TABLE invoices_external
(
    invoice_id     CHAR(6),
    invoice_date   CHAR(13),
    invoice_amt    CHAR(9),
    account_number CHAR(11)
)
ORGANIZATION EXTERNAL
(
    TYPE oracle_loader DEFAULT 
      DIRECTORY tmp ACCESS 
      PARAMETERS (records delimited BY newline SKIP 2 fields 
      ( invoice_id CHAR(6), invoice_date CHAR(13), 
      invoice_amt CHAR(9), account_number CHAR(11)))
      -- make sure there are no extra lines that might be interpreted as null later when loading into PK
      LOCATION ('load_invoices.txt')
);
SELECT * FROM invoices_external;
-- create table with correct data types
CREATE TABLE invoices_revised
(
    invoice_id     INTEGER,
    invoice_date   DATE,
    invoice_amt    NUMBER,
    account_number VARCHAR2(13)
);
INSERT INTO invoices_revised 
         (invoice_id, invoice_date,invoice_amt,account_number)
  SELECT  invoice_id, to_date(invoice_date,'mm/dd/yyyy'), 
          to_number(invoice_amt), account_number
  FROM invoices_external;
SELECT * FROM invoices_revised;  
-- -----------------------------------------------------------------------------
-- E X T E R N A L T A B L E      C S V 1
-- -----------------------------------------------------------------------------
-- 1. First physically create the directory c:\temp
-- -----------------------------------------------------------------------------
-- 2. Then login as system and do:
-- A. CREATE OR REPLACE DIRECTORY TMP AS 'C:\temp';
-- -----------------------------------------------------------------------------
CREATE OR REPLACE DIRECTORY tmp AS   'C:\temp';
-- -----------------------------------------------------------------------------
-- B. GRANT READ, WRITE ON DIRECTORY TMP TO CRUISES;
-- -----------------------------------------------------------------------------
GRANT READ, WRITE ON DIRECTORY tmp TO samplecode;
-- -----------------------------------------------------------------------------
-- 3. Create the external table
DROP TABLE song_test;
CREATE TABLE song_test
  (sid      NUMBER,
   aid      number,
   title    VARCHAR2(175),
   wrt      VARCHAR2(175),
   secs     NUMBER)
ORGANIZATION EXTERNAL
(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY TMP
    ACCESS PARAMETERS
    (RECORDS DELIMITED BY NEWLINE
    FIELDS TERMINATED BY ","
    OPTIONALLY ENCLOSED BY '"'
    MISSING FIELD VALUES ARE NULL
    REJECT ROWS WITH ALL NULL FIELDS
      ( sid,
        aid,
        title,
        wrt,
        secs
      )
    )
  LOCATION ('songs.csv')
)
REJECT LIMIT UNLIMITED;
SELECT * FROM song_test;
-- -----------------------------------------------------------------------------
-- E X T E R N A L T A B L E      C S V 2
-- -----------------------------------------------------------------------------
-- 1. First physically create the directory c:\temp
-- -----------------------------------------------------------------------------
-- 2. Then login as system and do:
--    A. CREATE OR REPLACE DIRECTORY TMP AS 'C:\temp';
-- -----------------------------------------------------------------------------
CREATE OR REPLACE DIRECTORY tmp AS   'C:\temp';
-- -----------------------------------------------------------------------------
--    B. GRANT READ, WRITE ON DIRECTORY TMP TO CRUISES;
-- -----------------------------------------------------------------------------
GRANT READ, WRITE ON DIRECTORY tmp TO samplecode;
DROP TABLE song_ext;
CREATE TABLE song_ext
  (
    song_id   NUMBER,
    artist_id NUMBER,
    title     VARCHAR2(100),
    writer    VARCHAR2(100),
    seconds   NUMBER
  );
DECLARE
  F UTL_FILE.FILE_TYPE;
  V_SID VARCHAR2(100);
  V_AID VARCHAR2(100);
  V_SONG VARCHAR2(100);
  V_WRT  VARCHAR2(75);
  V_SECS VARCHAR2(100);
  V_LINE VARCHAR2(1000);
BEGIN
  F := UTL_FILE.FOPEN ('TMP', 'songs.csv', 'R');
IF UTL_FILE.IS_OPEN(F) THEN
  LOOP
    BEGIN
      UTL_FILE.GET_LINE(F, V_LINE, 1000);
      IF V_LINE IS NULL THEN
        EXIT;
      END IF;
      V_SID  := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 1);
      V_AID  := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 2);
      V_SONG := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 3);
      V_WRT  := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 4);
      V_SECS := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 5);
      INSERT INTO song_ext VALUES(to_number(V_SID), to_number(V_AID), V_SONG, V_WRT,to_number(V_SECS));
      COMMIT;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      EXIT;
    END;
  END LOOP;
END IF;
UTL_FILE.FCLOSE(F);
END;
/
SELECT * FROM song_ext;
-- -----------------------------------------------------------------------------
-- J A V A S O U R C E   P U L L    R E S T F U L   W E B S E R V I C E  
-- -----------------------------------------------------------------------------
-- 1. First grant permission to user DASHBOARD
-- -----------------------------------------------------------------------------
EXECUTE DBMS_JAVA.GRANT_PERMISSION( 'DASHBOARD', 'SYS:java.net.SocketPermission', '171.70.67.174:80', 'connect,resolve' );
-- -----------------------------------------------------------------------------
-- 2. Next create JAVA SOURCE
-- -----------------------------------------------------------------------------
DROP JAVA SOURCE DASHBOARD.GET_EDCS_REAL_TIME;
CREATE OR REPLACE AND RESOLVE JAVA SOURCE NAMED DASHBOARD.GET_EDCS_REAL_TIME as import java.io.IOException;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.*;

public class GET_EDCS_REAL_TIME {
    public static void main(String[] args) {
        // test input "761225";
        int[]         edcs_1_RecordNums         = new int[0];               // 1
        String[]     edcs_2_EDCSNums            = new String[0];            // 2
        int[]         edcs_3_Revs             = new int[0];                  // 3
        String[]     edcs_4_FileNames        = new String[0];            // 4
        String[]     edcs_5_Titles            = new String[0];            // 5
        String[]     edcs_6_Types            = new String[0];            // 6
        String[]     edcs_7_Status            = new String[0];            // 7
        String[]     edcs_8_StatusDate        = new String[0];            // 8
        String[]     edcs_9_AppDate            = new String[0];            // 9
        String[]     edcs_10_AppBy            = new String[0];            // 10
            
        // public static String thisConnectionStr = "jdbc:oracle:thin:@10.88.137.249:1521:gatedwhs";
        String thisConnectionStr = "jdbc:oracle:thin:@66.187.221.77:1526:gatepwhs";
        String thisDBusr = "dashboard";
        String thisDBpw = "dwetl1sg00d";
        int myCount = 0;
        int newSize = 0;
        
        Connection conn = null;
        String thisEDCS = null;
        String thisEDCSs = null;
        
        thisEDCS = args[0];

        //thisEDCS = "811064";
        thisEDCSs = thisEDCS;
        thisEDCS = "EDCS-" + thisEDCS + ":*";
        URL url = null;
        // System.out.println("setting the URL");
        BufferedReader in = null;
        String myurl = "http://wwwin-eng.cisco.com/cgi-bin/edcs/getedcs.cgi?SEARCHTYPE=DOC&KEY=DOCNO&VALUE="+thisEDCS;
        // http://wwwin-eng.cisco.com/cgi-bin/edcs/getedcs.cgi?SEARCHTYPE=DOC&KEY=DOCNO&VALUE=EDCS-811064:*
        try {
            url = new URL(myurl);
        } catch (MalformedURLException e1) {
            e1.printStackTrace();
        }
        try {
        in = new BufferedReader(
                new InputStreamReader(
                url.openStream()));
        } catch (IOException e2) {
            e2.printStackTrace();
        }            
        String replyString;                    
        // System.out.println("got the URL");
        try {
            while((replyString = in.readLine()) != null){    
                // this_sList_array = replyString.split("\\|");
                if (myCount == edcs_1_RecordNums.length){ 
                    // Arrays are full. Make new, bigger arrays,
                    newSize++;  // Size of new array.
                    
                    // 1 irecNum ---------------------
                    // get and set from Loop control variable 
                    int[] temp1 = new int[newSize];  // The new array.
                    System.arraycopy(edcs_1_RecordNums, 0, temp1, 0, edcs_1_RecordNums.length);
                    edcs_1_RecordNums = temp1;  // Set old array to refer to new array.
                    edcs_1_RecordNums[myCount] = myCount; 
                    // 2 ilistEDCSWatchNums ---------------------
                    // get and set from parameter
                    String[] temp2 = new String[newSize];  // The new array.
                    System.arraycopy(edcs_2_EDCSNums, 0, temp2, 0, edcs_2_EDCSNums.length);
                    edcs_2_EDCSNums = temp2;  // Set old array to refer to new array.
                    edcs_2_EDCSNums[myCount] = thisEDCSs;
                    // 3 rev number   ---------------------
                    // get
                    int iRevIdxStart = replyString.indexOf("REV=");
                    int iRevIdxStop = replyString.indexOf("|FILESIZE=");
                    String sthisRev = replyString.substring(iRevIdxStart+4, iRevIdxStop);
                    int thisRev = Integer.parseInt(sthisRev);
                    // set 
                    int[] temp3 = new int[newSize];  // The new array.
                    System.arraycopy(edcs_3_Revs, 0, temp3, 0, edcs_3_Revs.length);
                    edcs_3_Revs = temp3;  // Set old array to refer to new array.
                    edcs_3_Revs[myCount] = thisRev;
                    // --------------------------------------------
                    // add from here down
                    // 4 File Name   ---------------------
                    // get 
                    int iFNIdxStart = replyString.indexOf("FILENAME=");
                    int iFNIdxStop = replyString.indexOf("|DOCNO=");
                    String thisFileName = replyString.substring(iFNIdxStart+9, iFNIdxStop);
                    // set
                    String[] temp4 = new String[newSize];  // The new array.
                    System.arraycopy(edcs_4_FileNames, 0, temp4, 0, edcs_4_FileNames.length);
                    edcs_4_FileNames = temp4;  // Set old array to refer to new array.
                    edcs_4_FileNames[myCount] = thisFileName;
                    // 5 Title   ---------------------
                    // get 
                    int iTITLEIdxStart = replyString.indexOf("TITLE=");
                    int iTITLEIdxStop = replyString.indexOf("|STATUS=");
                    String thisFileTitle = replyString.substring(iTITLEIdxStart+6, iTITLEIdxStop);
                    //set 
                    String[] temp5 = new String[newSize];  // The new array.
                    System.arraycopy(edcs_5_Titles, 0, temp5, 0, edcs_5_Titles.length);
                    edcs_5_Titles = temp5;  // Set old array to refer to new array.
                    edcs_5_Titles[myCount] = thisFileTitle;
                    // 6 Type   ---------------------
                    // get 
                    // public String[] edcs_5_Types        = new String[0];            // 6
                    int iTYPEIdxStart = replyString.indexOf("FORMAT=");
                    int iTYPEIdxStop = replyString.indexOf("|AUTHOR=");
                    String thisFileType = replyString.substring(iTYPEIdxStart+7, iTYPEIdxStop);
                    //set 
                    String[] temp6 = new String[newSize];  // The new array.
                    System.arraycopy(edcs_6_Types, 0, temp6, 0, edcs_6_Types.length);
                    edcs_6_Types = temp6;  // Set old array to refer to new array.
                    edcs_6_Types[myCount] = thisFileType;
                    // 7 Status  ---------------------
                    // get 
                    int iSTATIdxStart = replyString.indexOf("STATUS=");
                    int iSTATIdxStop = replyString.indexOf("|REV=");
                    String thisStatus = replyString.substring(iSTATIdxStart+7, iSTATIdxStop);
                    // set 
                    String[] temp7 = new String[newSize];  // The new array.
                    System.arraycopy(edcs_7_Status, 0, temp7, 0, edcs_7_Status.length);
                    edcs_7_Status = temp7;  // Set old array to refer to new array.
                    edcs_7_Status[myCount] = thisStatus;
                    // 8 Status Date ---------------------
                    // get 
                    int iSDATEIdxStart = replyString.indexOf("DATE=");
                    int iSDATEIdxStop = replyString.indexOf("|FORMAT");
                    String thisStatusDate = replyString.substring(iSDATEIdxStart+5, iSDATEIdxStop);
                    // set 
                    String[] temp8 = new String[newSize];  // The new array.
                    System.arraycopy(edcs_8_StatusDate, 0, temp8, 0, edcs_8_StatusDate.length);
                    edcs_8_StatusDate = temp8;  // Set old array to refer to new array.
                    edcs_8_StatusDate[myCount] = thisStatusDate;
                    // 9 Approved Date ---------------------
                    // get 
                    int iADATEIdxStart = replyString.indexOf("APPROVE_DATE=");
                    int iADATEIdxStop = replyString.indexOf("|APPROVER");
                    String thisAppDate = replyString.substring(iADATEIdxStart+13, iADATEIdxStop);
                    // set 
                    String[] temp9 = new String[newSize];  // The new array.
                    System.arraycopy(edcs_9_AppDate, 0, temp9, 0, edcs_9_AppDate.length);
                    edcs_9_AppDate = temp9;  // Set old array to refer to new array.
                    edcs_9_AppDate[myCount] = thisAppDate;
                    // 10 Approved by ---------------------
                    // get 
                    // public String[] edcs_9_AppBy        = new String[0];            // 10
                    int iABYIdxStart = replyString.indexOf("APPROVER=");
                    int iABYIdxStop = replyString.length();
                    String thisAppBy = replyString.substring(iABYIdxStart+9, iABYIdxStop);
                    // set 
                    String[] temp10 = new String[newSize];  // The new array.
                    System.arraycopy(edcs_10_AppBy, 0, temp10, 0, edcs_10_AppBy.length);
                    edcs_10_AppBy = temp10;  // Set old array to refer to new array.
                    edcs_10_AppBy[myCount] = thisAppBy;
                    
                    myCount++;
       
                } // if 
            } // while
                
        } catch (IOException e3) {
                e3.printStackTrace();
        }
        try {
                in.close();
        } catch (IOException e4) {
                e4.printStackTrace();
        }
    
        // --------------------------------------------------------------------
        // update database
        // load the Oracle JDBC driver
        try {
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        } catch (SQLException e5) {
            e5.printStackTrace();
        }
        try {
            conn = DriverManager.getConnection(thisConnectionStr,thisDBusr, thisDBpw);
        } catch (SQLException e6) {
            e6.printStackTrace();
        }
        java.sql.Date sqlDate1 = null;
        java.sql.Date sqlDate2 = null;
        PreparedStatement pstmt = null;
        for (int i = 0 ; i < edcs_1_RecordNums.length; i++)
          {
            String sSQL = "insert into edcs_test3 (            " +
                            "            record_number         " +
                            "        ,   edcs_number         " +
                            "        ,   rev                 " +
                            "        ,   file_name             " +
                            "        ,   file_title         " +
                            "        ,   file_type             " +
                            "        ,   status             " +
                            "        ,   status_date         " +
                            "        ,   approved_date         " +
                            "        ,   app_by                " +
                            "                            )    " +
                            "   values (?,?,?,    ?,?,?,   ?" +
                            ", to_date( ? , 'MM/DD/YYYY')" +
                            ", to_date( ? , 'MM/DD/YYYY')" +
                            ", ? " +
                            " )                     ";
            // set up statDate 
            
            String date2 = null;
            if (edcs_9_AppDate[i] != null && !edcs_9_AppDate[i].equals(""))
            {
                    date2 = edcs_9_AppDate[i];
            }
            else {
                    date2 = "";
            }
            try {
                pstmt = conn.prepareStatement(sSQL);
            } catch (Exception e9) {
                e9.printStackTrace();
            }
            try {
                pstmt.setInt(1, edcs_1_RecordNums[i]);
                  pstmt.setString(2, edcs_2_EDCSNums[i]);
                  pstmt.setInt(3, edcs_3_Revs[i]);
                  pstmt.setString(4,edcs_4_FileNames[i]);
                  pstmt.setString(5,edcs_5_Titles[i]);
                  pstmt.setString(6,edcs_6_Types[i]);
                  pstmt.setString(7,edcs_7_Status[i]);
                  pstmt.setString(8,edcs_8_StatusDate[i]);
                pstmt.setString(9,date2);
                // set appBy 
                if (edcs_10_AppBy[i] != null && !edcs_10_AppBy[i].equals(""))
                    pstmt.setString(10,edcs_10_AppBy[i]);
                else
                    pstmt.setString(10,"");
                    
            } catch (SQLException e10) {
                System.out.println(" e10 exception");
                e10.printStackTrace();
            }
            try {
                pstmt.executeUpdate();
            } catch (SQLException e11) {
                System.out.println(" e11 exception");
                System.out.println(e11.getMessage());
                e11.printStackTrace();
            }
              try {
                pstmt.close();
            } catch (Exception e12) {
                System.out.println(" e11 exception");
                System.out.println(e12.getMessage());
                e12.printStackTrace();
            }
          } // for
        //        for (int i = 0 ; i < edcs_1_RecordNums.length; i++)
        //          {
        //              System.out.println("No: " + edcs_1_RecordNums[i] + "  EDCS num:  " + edcs_2_EDCSNums[i] + "   Rev: " + edcs_3_Revs[i]);
        //          }
        //            
        System.out.println("main is done");
     }//main
}
/
-- -----------------------------------------------------------------------------
-- 3. Next create stored procedure 
-- -----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE DASHBOARD.EDCSSP_REALTIME(
    id IN VARCHAR2)
AS
  LANGUAGE JAVA NAME 'GET_EDCS_REAL_TIME.main(java.lang.String[])';
/
-- -----------------------------------------------------------------------------
-- 4. Call stored procedure 
-- -----------------------------------------------------------------------------
CALL DASHBOARD.EDCSSP_REALTIME ('824098');

-- -----------------------------------------------------------------------------
-- T R I G G E R S     F O R     H I S T O R Y     T A B L E S   
-- -----------------------------------------------------------------------------
DROP TRIGGER KM_TRACKER.IC_ARTIFACT_HISTORY_TRIGR;
CREATE OR REPLACE TRIGGER KM_TRACKER."IC_ARTIFACT_HISTORY_TRIGR" AFTER
  INSERT OR
  UPDATE OR
  DELETE ON ic_artifact FOR EACH row DECLARE history_action VARCHAR2(15 byte);
  BEGIN
    IF inserting THEN
      history_action := 'INSERTING';
    elsif updating THEN
      history_action := 'UPDATING';
    ELSE
      history_action := 'DELETING';
    END IF;
    IF inserting OR updating THEN
      INSERT
      INTO ic_artifact_history
        (
          entered_by ,
          entered_date ,
          history_action ,
          ic_key ,
          watch_flag ,
          last_modified_by ,
          last_modified_date
        )
        VALUES
        (
          NVL(v('APP_USER'),USER) ,
          sysdate ,
          history_action ,
          :new.ic_key ,
          :new.watch_flag ,
          :new.last_modified_by ,
          :new.last_modified_date
        );
    ELSE
      -- deleting
      INSERT
      INTO ic_artifact_history
        (
          entered_by ,
          entered_date ,
          history_action ,
          ic_key ,
          watch_flag ,
          last_modified_by ,
          last_modified_date
        )
        VALUES
        (
          NVL(v('APP_USER'),USER) ,
          sysdate ,
          history_action ,
          :old.ic_key ,
          :old.watch_flag ,
          :old.last_modified_by ,
          :old.last_modified_date
        );
    END IF;
  END;
  /
  -- -------------------------------------------------------------------
  DROP TRIGGER KM_TRACKER.IC_ARTIFACT_KEY_HISTORY_TRIGR;
CREATE OR REPLACE TRIGGER KM_TRACKER."IC_ARTIFACT_KEY_HISTORY_TRIGR" before
  INSERT ON ic_artifact_history REFERENCING NEW AS NEW FOR EACH row BEGIN
  SELECT ic_artifact_hist_key_seq.nextval INTO :new.pk_key FROM dual;
END;
/
-- ----------------------------------------------------------------------
DROP TRIGGER KM_TRACKER.IC_ARTIFACT_MOD_TRIGR;
CREATE OR REPLACE TRIGGER KM_TRACKER."IC_ARTIFACT_MOD_TRIGR" before
  INSERT OR
  UPDATE ON ic_artifact FOR EACH row BEGIN IF inserting THEN
  SELECT 'IC-' || TO_CHAR(ic_artifact_seq.nextval) INTO :new.ic_key FROM dual;
  :new.last_modified_by   := NVL(v('APP_USER'),USER);
  :new.last_modified_date := sysdate;
elsif updating THEN
  :new.last_modified_by   := NVL(v('APP_USER'),USER);
  :new.last_modified_date := sysdate;
END IF;
END;
/
-- -----------------------------------------------------------------------
DROP TRIGGER KM_TRACKER.IC_HISTORY_KEY_TRIGR;
CREATE OR REPLACE TRIGGER KM_TRACKER."IC_HISTORY_KEY_TRIGR" before
  INSERT ON ic_history REFERENCING NEW AS NEW FOR EACH row BEGIN
  SELECT ic_history_key_seq.nextval INTO :new.pk_key FROM dual;
END;
/
-- -------------------------------------------------------------------------
DROP TRIGGER KM_TRACKER.IC_HISTORY_TRIGR;
CREATE OR REPLACE TRIGGER KM_TRACKER."IC_HISTORY_TRIGR" AFTER
  INSERT OR
  UPDATE OR
  DELETE ON ic FOR EACH row DECLARE history_action VARCHAR2(25 byte);
  BEGIN
    IF inserting THEN
      history_action := 'INSERTING';
    elsif updating THEN
      history_action := 'UPDATING';
    ELSE
      history_action := 'DELETING';
    END IF;
    IF inserting OR updating THEN
      INSERT
      INTO ic_history
        (
          entered_by ,
          entered_date ,
          history_action ,
          ic_key ,
          src_version ,
          src_origin ,
          src_title ,
          team ,
          sme ,
          src_technology_type ,
          src_pass_through_flag ,
          src_status ,
          src_status_date ,
          src_project_name ,
          src_underlying_technology ,
          src_components ,
          src_edcs_doc_num ,
          src_edcs_approved_date ,
          src_edcs_error ,
          src_remedy_ticket_num ,
          src_url ,
          src_space_name ,
          src_path ,
          src_file_name ,
          src_file_type ,
          src_location ,
          src_date_captured ,
          src_3rd_party_origin_flag ,
          src_3rd_party_company ,
          src_referenced_doc ,
          src_derived_from ,
          src_related_doc ,
          src_3rdparty_content_flag ,
          src_3rdparty_content_details ,
          src_remediation_unique_id ,
          src_st_project_name ,
          src_st_views ,
          src_st_label ,
          src_exp_date ,
          wf_status ,
          wf_status_date ,
          wf_owner ,
          wf_issue_flag ,
          wf_comment ,
          fg_title ,
          fg_file_name ,
          fg_file_type ,
          fg_edcs_doc_num ,
          fg_edcs_rev ,
          fg_edcs_status ,
          fg_edcs_status_date ,
          fg_edcs_approved_date ,
          fg_edcs_error ,
          fg_delivered_technology ,
          fg_3rd_party_content_flag ,
          fg_3rd_party_content_details ,
          fg_referenced_docs ,
          fg_derived_from ,
          fg_related_docs ,
          fg_release ,
          fg_watch_flag ,
          rts_location ,
          rts_file_name ,
          comments ,
          misc_1 ,
          misc_2 ,
          misc_3 ,
          last_modified_by ,
          last_modified_date ,
          src_tag1 ,
          src_tag2 ,
          wf_target_release ,
          sme_email ,
          src_wf_owner ,
          src_wf_id ,
          dsgn_src_form
        )
        VALUES
        (
          NVL(v('APP_USER'),USER) ,
          sysdate ,
          history_action ,
          :new.ic_key ,
          :new.src_version ,
          :new.src_origin ,
          :new.src_title ,
          :new.team ,
          :new.sme ,
          :new.src_technology_type ,
          :new.src_pass_through_flag ,
          :new.src_status ,
          :new.src_status_date ,
          :new.src_project_name ,
          :new.src_underlying_technology ,
          :new.src_components ,
          :new.src_edcs_doc_num ,
          :new.src_edcs_approved_date ,
          :new.src_edcs_error ,
          :new.src_remedy_ticket_num ,
          :new.src_url ,
          :new.src_space_name ,
          :new.src_path ,
          :new.src_file_name ,
          :new.src_file_type ,
          :new.src_location ,
          :new.src_date_captured ,
          :new.src_3rd_party_origin_flag ,
          :new.src_3rd_party_company ,
          :new.src_referenced_doc ,
          :new.src_derived_from ,
          :new.src_related_doc ,
          :new.src_3rdparty_content_flag ,
          :new.src_3rdparty_content_details ,
          :new.src_remediation_unique_id ,
          :new.src_st_project_name ,
          :new.src_st_views ,
          :new.src_st_label ,
          :new.src_exp_date ,
          :new.wf_status ,
          :new.wf_status_date ,
          :new.wf_owner ,
          :new.wf_issue_flag ,
          :new.wf_comment ,
          :new.fg_title ,
          :new.fg_file_name ,
          :new.fg_file_type ,
          :new.fg_edcs_doc_num ,
          :new.fg_edcs_rev ,
          :new.fg_edcs_status ,
          :new.fg_edcs_status_date ,
          :new.fg_edcs_approved_date ,
          :new.fg_edcs_error ,
          :new.fg_delivered_technology ,
          :new.fg_3rd_party_content_flag ,
          :new.fg_3rd_party_content_details ,
          :new.fg_referenced_docs ,
          :new.fg_derived_from ,
          :new.fg_related_docs ,
          :new.fg_release ,
          :new.fg_watch_flag ,
          :new.rts_location ,
          :new.rts_file_name ,
          :new.comments ,
          :new.misc_1 ,
          :new.misc_2 ,
          :new.misc_3 ,
          :new.last_modified_by ,
          :new.last_modified_date ,
          :new.src_tag1 ,
          :new.src_tag2 ,
          :new.wf_target_release ,
          :new.sme_email ,
          :new.src_wf_owner ,
          :new.src_wf_id ,
          :new.dsgn_src_form
        );
    ELSE
      -- deleting
      INSERT
      INTO ic_history
        (
          entered_by ,
          entered_date ,
          history_action ,
          ic_key ,
          src_version ,
          src_origin ,
          src_title ,
          team ,
          sme ,
          src_technology_type ,
          src_pass_through_flag ,
          src_status ,
          src_status_date ,
          src_project_name ,
          src_underlying_technology ,
          src_components ,
          src_edcs_doc_num ,
          src_edcs_approved_date ,
          src_edcs_error ,
          src_remedy_ticket_num ,
          src_url ,
          src_space_name ,
          src_path ,
          src_file_name ,
          src_file_type ,
          src_location ,
          src_date_captured ,
          src_3rd_party_origin_flag ,
          src_3rd_party_company ,
          src_referenced_doc ,
          src_derived_from ,
          src_related_doc ,
          src_3rdparty_content_flag ,
          src_3rdparty_content_details ,
          src_remediation_unique_id ,
          src_st_project_name ,
          src_st_views ,
          src_st_label ,
          src_exp_date ,
          wf_status ,
          wf_status_date ,
          wf_owner ,
          wf_issue_flag ,
          wf_comment ,
          fg_title ,
          fg_file_name ,
          fg_file_type ,
          fg_edcs_doc_num ,
          fg_edcs_rev ,
          fg_edcs_status ,
          fg_edcs_status_date ,
          fg_edcs_approved_date ,
          fg_edcs_error ,
          fg_delivered_technology ,
          fg_3rd_party_content_flag ,
          fg_3rd_party_content_details ,
          fg_referenced_docs ,
          fg_derived_from ,
          fg_related_docs ,
          fg_release ,
          fg_watch_flag ,
          rts_location ,
          rts_file_name ,
          comments ,
          misc_1 ,
          misc_2 ,
          misc_3 ,
          last_modified_by ,
          last_modified_date ,
          src_tag1 ,
          src_tag2 ,
          wf_target_release ,
          sme_email ,
          src_wf_owner ,
          src_wf_id ,
          dsgn_src_form
        )
        VALUES
        (
          NVL(v('APP_USER'),USER) ,
          sysdate ,
          history_action ,
          :old.ic_key ,
          :old.src_version ,
          :old.src_origin ,
          :old.src_title ,
          :old.team ,
          :old.sme ,
          :old.src_technology_type ,
          :old.src_pass_through_flag ,
          :old.src_status ,
          :old.src_status_date ,
          :old.src_project_name ,
          :old.src_underlying_technology ,
          :old.src_components ,
          :old.src_edcs_doc_num ,
          :old.src_edcs_approved_date ,
          :old.src_edcs_error ,
          :old.src_remedy_ticket_num ,
          :old.src_url ,
          :old.src_space_name ,
          :old.src_path ,
          :old.src_file_name ,
          :old.src_file_type ,
          :old.src_location ,
          :old.src_date_captured ,
          :old.src_3rd_party_origin_flag ,
          :old.src_3rd_party_company ,
          :old.src_referenced_doc ,
          :old.src_derived_from ,
          :old.src_related_doc ,
          :old.src_3rdparty_content_flag ,
          :old.src_3rdparty_content_details ,
          :old.src_remediation_unique_id ,
          :old.src_st_project_name ,
          :old.src_st_views ,
          :old.src_st_label ,
          :old.src_exp_date ,
          :old.wf_status ,
          :old.wf_status_date ,
          :old.wf_owner ,
          :old.wf_issue_flag ,
          :old.wf_comment ,
          :old.fg_title ,
          :old.fg_file_name ,
          :old.fg_file_type ,
          :old.fg_edcs_doc_num ,
          :old.fg_edcs_rev ,
          :old.fg_edcs_status ,
          :old.fg_edcs_status_date ,
          :old.fg_edcs_approved_date ,
          :old.fg_edcs_error ,
          :old.fg_delivered_technology ,
          :old.fg_3rd_party_content_flag ,
          :old.fg_3rd_party_content_details ,
          :old.fg_referenced_docs ,
          :old.fg_derived_from ,
          :old.fg_related_docs ,
          :old.fg_release ,
          :old.fg_watch_flag ,
          :old.rts_location ,
          :old.rts_file_name ,
          :old.comments ,
          :old.misc_1 ,
          :old.misc_2 ,
          :old.misc_3 ,
          :old.last_modified_by ,
          :old.last_modified_date ,
          :old.src_tag1 ,
          :old.src_tag2 ,
          :old.wf_target_release ,
          :old.sme_email ,
          :old.src_wf_owner ,
          :old.src_wf_id ,
          :old.dsgn_src_form
        );
    END IF;
  END;
  /
  -- -----------------------------------------------------------------------
  DROP TRIGGER KM_TRACKER.IC_MOD_TRIGR;
CREATE OR REPLACE TRIGGER KM_TRACKER."IC_MOD_TRIGR" before
  INSERT OR
 UPDATE ON ic FOR EACH row BEGIN 
    IF inserting THEN
      :new.last_modified_by   := NVL(v('APP_USER'),USER);
      :new.last_modified_date := sysdate;
    ELSIF updating THEN
      :new.last_modified_by   := NVL(v('APP_USER'),USER);
      :new.last_modified_date := sysdate;
    END IF;
END;
/
