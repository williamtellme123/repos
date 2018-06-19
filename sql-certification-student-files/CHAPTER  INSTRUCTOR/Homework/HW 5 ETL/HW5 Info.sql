

/*
Have some source
Have business rules
May have data from somewhere else

-- Source Field 1
Begin source field 1: SF1
  Transform it into something we can use
  once we have in select statement
  We now what transformation looks like
  we build a target table for this data type


-- Repeat SF1 instructions for every remainging field

select from dual;

*/

  Insert into target_table
  ( 
      TF1
      ,TF2
--      ,TF3
--      ,TF4
  )
  select 
        transformation(SF1)
        ,transformation(SF2)
--        ,transformation(SF3)
--        ,transformation(SF4)
  from source_table;


case
     when     
          then
     when
          then
     when
          then
end          













*/

