-- Apps and their themes
select a.application_name, a.alias, a.compatibility_mode, a.pages, a.installation_scripts,
       listagg(t.theme_number, ',') within group (order by t.theme_number) as theme_numbers,
       listagg(t.theme_name, ',') within group (order by t.theme_name) as theme_names
  from apex_applications a, apex_application_themes t
 where a.application_id = t.application_id
group by a.application_name, a.alias, a.compatibility_mode, a.pages, a.installation_scripts; 


-- Plugins
select p.plugin_type, p.display_name, p.name,
       count(a.application_name) as nbr_app_using_plugin,
       listagg(a.application_name, ',') within group (order by a.application_name) as applications
from apex_appl_plugins p, apex_applications a
where p.application_id = a.application_id
group by p.plugin_type, p.display_name, p.name
order by 1,2;



create user mymusic identified by mymusic;
grant all privileges to mymusic;
alter user music identified by music;

alter user music account unlock;