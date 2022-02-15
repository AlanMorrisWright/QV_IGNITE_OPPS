with x as (
  select
  to_char(closedate, 'YYYY') as closedate,
  stagename,
  case
    when stagename is null then 0
    when stagename = 'Identify' then 1
    when stagename = 'Qualify' then 2
    when stagename = 'Propose' then 3
    when stagename = 'Negotiate' then 4
    when stagename = 'Closed Won' then 5
    when stagename = 'Implemented' then 6
    when stagename = 'Closed No Deal' then 7
    when stagename = 'Closed Lost' then 8
    else 9 end
  as stage_id
  from
  ods_sfdc_opportunity
)
select
  count(*) as records,
  stage_id, stagename,
    closedate
  from x
  group by
  stagename, stage_id, closedate
  order by stage_id;

/*
 96307	1	Identify
 14861	2	Qualify
 11262	3	Propose
  8299	4	Negotiate
518934	5	Closed Won
 80157	6	Implemented
267658	7	Closed No Deal
168148	8	Closed Lost
    72	9	Closed Moved
    38	9	Create
 52373	9	Entered in Error
117714	9	invalid
     1	9	Pre-Qualified

notes
'Closed Moved', 'Create', 'Entered in Error' & 'Pre-Qualified' can be ignored as mostly used 2015/2016, some in 2014, 2017-18
only 13% of 'closed won' and 'implemented' are 'implemented' - therefore class both these as 'closed won'
stagename is never null
*/
