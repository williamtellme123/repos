CREATE OR REPLACE procedure KM_TRACKER_1_SCHEMA.setup_edcs_classes is 

    v_create_trigger    VARCHAR2(4000);
    CRLF                VARCHAR2(2) :=CHR(10);
    v_trigger_name      VARCHAR2(100);

BEGIN    
  

        begin
            execute immediate ' drop trigger edcs_classes_trigger ';
                exception
            when others then null;
        end;
        
        commit;
        
        begin
            execute immediate ' truncate table edcs_classes ';
                exception
            when others then null;
        end;
        
        commit;    
      
    
        begin
            execute immediate 'drop sequence edcs_classes_seq';
                exception
            when others then null;
        end;   
        
        commit;    

 
        insert into edcs_classes (class_id, parent_id, class_name) values (0,0, 'NULL');
                        
        begin
            execute immediate 'create sequence edcs_classes_seq start with 1';
                exception
            when others then null;
        end;   

        commit;

        BEGIN
                v_trigger_name   := ' edcs_classes_trigger ';
                v_create_trigger := ' CREATE OR REPLACE TRIGGER ' || v_trigger_name || ' ' || CRLF;
                v_create_trigger := v_create_trigger || ' BEFORE INSERT ON edcs_classes referencing new as new for each row ' || CRLF;
                v_create_trigger := v_create_trigger || ' BEGIN ' || CRLF;
                v_create_trigger := v_create_trigger || '  select edcs_classes_seq.nextval into :new.class_id from dual; ' || CRLF; 
                v_create_trigger := v_create_trigger || ' END; ' || CRLF;
        END;
               
        DBMS_OUTPUT.put_line(v_create_trigger);
        execute IMMEDIATE v_create_trigger;

        commit; 

END;
/        
   

/*--        create or replace trigger edcs_classes_trigger
--            before insert
--            on edcs_classes             referencing new as new
--            for each row
--        begin
--            select edcs_classes_seq.nextval into :new.class_id from dual;
--        end;


--        begin
--            
--             execute immediate 'create or replace edcs_classes_trigger'
--                || ' before insert'
--                || ' on edcs_classes'
--                || ' for each row'
--                || ' begin'
--                     ||   'select edcs_classes_seq.nextval into :new.class_id from dual;'
--                || ' end;';

            
            --            
            --            
            --            execute immediate 'create or replace trigger edcs_classes_trigger 
            --                before insert
            --                    on edcs_classes             referencing new as new
            --                    for each row
            --                begin
            --                    select edcs_classes_seq.nextval into :new.class_id from dual
            --                end';
          --  dbms_output.put_line (sqlcode||sqlerrm);
        --end;
   */     

         
--         begin
--            execute immediate 'create table edcs_classes  (
--               class_id                 integer primary key,
--               parent_id                references edcs_classes,
--               class_name               varchar(100)
--                )';
--         end;   
   --            
            --            execute immediate 'create or replace trigger edcs_classes_trigger 
            --                before insert
            --                    on edcs_classes             referencing new as new
            --                    for each row
            --                begin
            --                    select edcs_classes_seq.nextval into :new.class_id from dual
            --                end';

-- purge recyclebin;
--   ;
--    DROP SEQUENCE edcs_classes_seq;
--    CREATE SEQUENCE edcs_classes_seq START WITH 1 INCREMENT BY 1 NOCACHE;
--    create or replace trigger edcs_classes_trigger 
--            before insert
--                on edcs_classes             referencing new as new
--                for each row
--            begin
--                select edcs_classes_seq.nextval into :new.class_id from dual;
--            end;
--    commit;
--END;
--    
--    
    
    
    
    
    
    
    
    -- --------------------------------------------
    edcs_classes_seq := 'edcs_classes_seq';
    
        
        begin
            execute immediate 'drop table edcs_classes  cascade constraints';
            exception
            when others then null;
        end;
        
        
        begin
            execute immediate 'purge recyclebin';
            execute immediate 'create table edcs_classes  (
                   class_id                 integer primary key,
                   parent_id                references edcs_classes,
                   class_name               varchar(100)
            )';
            exception
            when others then null;
        end;
        
        begin
            execute immediate 'DROP SEQUENCE edcs_classes_seq';
             exception
            when others then null;
        end;
    
        begin
            execute immediate 'CREATE SEQUENCE edcs_classes_seq START WITH '||to_char(edcs_classes_seq_with)||' INCREMENT BY 1 NOCACHE';
              exception
            when others then null;

        end;
    
        begin
            execute immediate 'create or replace trigger edcs_classes_trigger 
                            before insert
                                on edcs_classes             referencing new as new
                                for each row
                            begin
                                select edcs_classes_seq.nextval into :new.class_id from dual;
                            end';
        end;
                            
    commit;
END;
/
