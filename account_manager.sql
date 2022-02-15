with x as (
  select distinct 
  opp.opportunity_reference_id_c,
  us.name as Account_Manager
  from
  ods_sfdc_opportunity opp
  left join
  ods_sfdc_account_team_member tm on tm.accountid_sfdc = opp.accountid_sfdc
  left join ods_sfdc_user us on us.user_id = tm.userid
  where
  opp.opportunity_reference_id_c = 'OPP-0002729722' and
  lower(nvl(tm.is_account_owner_c, '!!null')) = 'true' and
  lower(nvl(tm.isdeleted, '!!null')) <> 't' and
  tm.teammemberrole = 'Account Manager'
)
select * from x;
select opportunity_reference_id_c, count(*) from x group by opportunity_reference_id_c having count(*)>1;


with opp_am as (
  select distinct 
  opp.opportunity_reference_id_c,
  us.name as Account_Manager
  from
  ods_sfdc_opportunity opp
  left join
  ods_sfdc_account_team_member tm on tm.accountid_sfdc = opp.accountid_sfdc
  left join ods_sfdc_user us on us.user_id = tm.userid
  where
  lower(nvl(tm.is_account_owner_c, '!!null')) = 'true' and
  lower(nvl(tm.isdeleted, '!!null')) <> 't' and
  tm.teammemberrole = 'Account Manager'
)
,opp_am_agg as (
  select
  opportunity_reference_id_c,
  listagg(account_manager, '; ') within group (order by opportunity_reference_id_c, account_manager) as account_manager_agg
  from opp_am
  group by opportunity_reference_id_c
)
select * from opp_am_agg
where opportunity_reference_id_c in ('x'
,'OPP-0005621258','OPP-0005581752','OPP-0005583192','OPP-0005350026','OPP-0005640717','OPP-0005697676','OPP-0005422374','OPP-0005703239'
,'OPP-0005491521','OPP-0005638381','OPP-0005598452','OPP-0005447458','OPP-0005058443','OPP-0005114555','OPP-0005403611','OPP-0005171922'
,'OPP-0005136202','OPP-0005044379','OPP-0005714241','OPP-0005594353','OPP-0005593000','OPP-0005614817','OPP-0005621137','OPP-0005490186'
,'OPP-0002458553','OPP-0005714284')
;
