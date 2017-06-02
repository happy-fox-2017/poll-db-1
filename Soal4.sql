select cm.name, cm.party, cm.location, cm.grade_1996, cm.grade_current, cm.years_in_congress,cm.dw1_score,count(*) as [number_of_votes] from congress_members cm
inner join votes vs on vs.politician_id = cm.id
group by cm.name, cm.party, cm.location, cm.grade_1996, cm.grade_current, cm.years_in_congress,cm.dw1_score

order by number_of_votes desc LIMIT 3