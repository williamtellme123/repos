set define '^'
set verify off
prompt ...wwv_flow_theme_18

Rem  Copyright (c) Oracle Corporation 2003. All Rights Reserved.
Rem
Rem    NAME
Rem      wwv_flow_theme_6.sql
Rem
Rem    DESCRIPTION
Rem      Package used to create Theme.
Rem
Rem    NOTES
Rem			 This package is called when creating an application to create the theme.
Rem
Rem    MODIFIED    (MM/DD/YYYY)
Rem       cbackstr  06/23/2006 - Created

create or replace package wwv_flow_theme_18
as
    -- Create Theme
    procedure create_theme (p_flow_id in number, p_create_tabs in number, p_sidebar in varchar2, p_set_defaults in varchar2 default 'Y');
end wwv_flow_theme_18;
/
show errors;
