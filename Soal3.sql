Select count(*) from congress_members
inner join votes on congress_members.id = votes.politician_id
where congress_members.name = 'Rep. Erik Paulsen'