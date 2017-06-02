<!-- Release 1  -->

<!-- 1. Hitung jumlah vote untuk Sen. Olympia Snowe yang memiliki id 524. -->
SELECT COUNT(id) FROM votes WHERE politician_id=524

<!-- 2. Sekarang lakukan JOIN yang menggunakan id `524`. Query kedua tabel votes dan congress_members. -->
SELECT * FROM votes CROSS JOIN congress_members ON congress_members.id = votes.politician_id WHERE congress_members.name = 'Sen. Olympia Snowe'

<!-- 3. Sekarang gimana dengan representative Erik Paulsen? Berapa banyak vote yang dia dapatkan? -->
SELECT COUNT(id) FROM votes WHERE politician_id=339


<!-- 4. Buatlah daftar peserta Congress yang mendapatkan vote terbanyak. Jangan sertakan field `created_at` dan `updated_at`. -->
SELECT congress_members.id, congress_members.name, congress_members.party, congress_members.location, congress_members.grade_1996, congress_members.grade_current, congress_members.years_in_congress, congress_members.dw1_score, COUNT(*) AS highest_votes FROM congress_members CROSS JOIN votes ON congress_members.id = votes.politician_id GROUP BY congress_members.id ORDER BY highest_votes DESC LIMIT 3;


<!-- 5. Sekarang buatlah sebuah daftar semua anggota Congress yang setidaknya mendapatkan beberapa vote dalam 3 urutan dari yang paling sedikit. Dan juga jangan sertakan field-field yang memiliki tipe date. -->
SELECT congress_members.name, congress_members.party, congress_members.location, congress_members.grade_1996, congress_members.grade_current, congress_members.years_in_congress, congress_members.dw1_score, COUNT(*) AS lowest_votes FROM congress_members CROSS JOIN votes ON congress_members.id = votes.politician_id GROUP BY congress_members.id ORDER BY lowest_votes ASC LIMIT 3;
