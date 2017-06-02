select * from votes
inner join congress_members on votes.politician_id = congress_members.id
where congress_members.name = 'Sen. Olympia Snowe'