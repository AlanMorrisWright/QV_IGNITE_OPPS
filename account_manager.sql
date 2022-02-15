select
opp.opportunity_reference_id_c,
us.name as Account_Manager
from ods_sfdc_opportunity opp
left join
  ods_sfdc_account_team_member tm
  on
    tm.accountid_sfdc = opp.accountid_sfdc
left join
  ods_sfdc_user us
  on
    us.user_id = tm.userid
where
lower(nvl(tm.is_account_owner_c, '!!null')) = 'true' and
lower(nvl(tm.isdeleted, '!!null')) <> 't' and
tm.teammemberrole = 'Account Manager';
