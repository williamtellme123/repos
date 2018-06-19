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
      
      dbms_output.put_line('V_SID: ' ||  V_SID);
      dbms_output.put_line('V_AID: ' ||  V_AID);
      dbms_output.put_line('V_SONG: ' ||  V_SONG);
      dbms_output.put_line('V_WRT: ' ||  V_WRT);
      dbms_output.put_line('V_SECS: ' ||  V_SECS);
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
create table song_ext
(song_id    number,
 artist_id  number,
 title      varchar2(100),
 writer     varchar2(100),
 seconds    number);
select * from song_ext;