CREATE OR REPLACE PROCEDURE partial_export AS
    l_dp_handle        NUMBER;
    l_last_job_state   VARCHAR2 (30)  := 'UNDEFINED';
    l_job_state        VARCHAR2 (30)  := 'UNDEFINED';
    l_sts              ku$_status;
    l_job_name         VARCHAR2 (100);
    l_dirname          VARCHAR2 (100);
    l_filename         VARCHAR2 (100);
BEGIN
--    l_filename := 'myexpfile.dmp';
--    -- sets the job name
--    l_job_name := 'BZ' || SYSDATE;
--    l_dp_handle :=
--    DBMS_DATAPUMP.OPEN (operation        => 'EXPORT',
--    job_mode         => 'TABLE',
--    remote_link      => NULL,
--    job_name         => l_job_name,
--    VERSION          => 'LATEST'
--    );
--    --specify the database directory  and the filename for the export file
--    DBMS_DATAPUMP.add_file (handle         => l_dp_handle,
--    filename       => l_filename,
--    DIRECTORY      => 'TMP'
--    );
--    DBMS_DATAPUMP.add_file (handle         => l_dp_handle,
--    filename       => l_filename || '.LOG',
--    DIRECTORY      => 'TMP',
--    filetype       => DBMS_DATAPUMP.ku$_file_type_log_file
--    );
--    --specify the tables that I want to export. (CLIENTES,FORNECEDORES)
--    DBMS_DATAPUMP.metadata_filter (handle      => l_dp_handle,
--    NAME        => 'NAME_EXPR',
--    VALUE       => 'IN (''CLIENTES'', ''FORNECEDORES'')'
--    );
--    -- set subset data export. exports only rows that id_empresa equals 2050
--    DBMS_DATAPUMP.data_filter (handle          => l_dp_handle,
--    NAME            => 'SUBQUERY',
--    VALUE           => 'WHERE ID_EMPRESA=2050',
--    table_name      => 'CLIENTES'
--    );
--    -- set subset data export. exports only rows that id_empresa equals 2050
--    DBMS_DATAPUMP.data_filter (handle          => l_dp_handle,
--    NAME            => 'SUBQUERY',
--    VALUE           => 'WHERE ID_EMPRESA=2050',
--    table_name      => 'FORNECEDORES'
--    );
--    DBMS_DATAPUMP.start_job (l_dp_handle);
--    DBMS_DATAPUMP.detach (l_dp_handle);
END;