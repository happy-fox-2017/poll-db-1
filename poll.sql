<!-- Release 1  -->

<!-- 1. Hitung jumlah vote untuk Sen. Olympia Snowe yang memiliki id 524. -->
<!-- 2. Sekarang lakukan JOIN tanpa menggunakan id `524`. Query kedua tabel votes dan congress_members. -->
<!-- 3. Sekarang gimana dengan representative Erik Paulsen? Berapa banyak vote yang dia dapatkan? -->
<!-- 4. Buatlah daftar peserta Congress yang mendapatkan vote terbanyak. Jangan sertakan field `created_at` dan `updated_at`. -->
<!-- 5. Sekarang buatlah sebuah daftar semua anggota Congress yang setidaknya mendapatkan beberapa vote dalam urutan dari yang paling sedikit. Dan juga jangan sertakan field-field yang memiliki tipe date. -->

<!-- Release 2  -->

<!-- 1. Siapa anggota Congress yang mendapatkan vote terbanyak? List nama mereka dan jumlah vote-nya. Siapa saja yang memilih politisi tersebut? List nama mereka, dan jenis kelamin mereka. -->
<!-- 2. Berapa banyak vote yang diterima anggota Congress yang memiliki grade di bawah 9 (gunakan field `grade_current`)? Ambil nama, lokasi, grade_current dan jumlah vote. -->
<!-- 3. Apa saja 10 negara bagian yang memiliki voters terbanyak? List semua orang yang melakukan vote di negara bagian yang paling populer. (Akan menjadi daftar yang panjang, kamu bisa gunakan hasil dari query pertama untuk menyederhanakan query berikut ini.) -->
<!-- 4. List orang-orang yang vote lebih dari dua kali. Harusnya mereka hanya bisa vote untuk posisi Senator dan satu lagi untuk wakil. Wow, kita dapat si tukang curang! Segera laporkan ke KPK!! -->
<!-- 5. Apakah ada orang yang melakukan vote kepada politisi yang sama dua kali? Siapa namanya dan siapa nama politisinya? -->

/*---------------------------------------------*/
--1
SELECT congress_members.id,
       congress_members.name,
       COUNT(votes.id)
FROM congress_members
INNER JOIN votes ON congress_members.id = votes.politician_id
WHERE congress_members.id = 524;
/*output: vote = 22*/


--2
SELECT congress_members.id,
       congress_members.name,
       COUNT(votes.id)
FROM congress_members
INNER JOIN votes ON congress_members.id = votes.politician_id
WHERE congress_members.name = 'Sen. Olympia Snowe';
/* output: vote = 22*/


--3
SELECT congress_members.id,
       congress_members.name,
       COUNT(votes.id)
FROM congress_members
INNER JOIN votes ON congress_members.id = votes.politician_id
WHERE congress_members.name = 'Rep. Erik Paulsen';
/*output: vote = 21*/


--4
SELECT congress_members.id,
       congress_members.name,
       congress_members.party,
       congress_members.location,
       congress_members.grade_1996,
       congress_members.grade_current,
       congress_members.years_in_congress,
       congress_members.dw1_score,
       COUNT(votes.id) AS votes_count
FROM congress_members
LEFT JOIN votes ON congress_members.id = votes.politician_id
GROUP BY congress_members.id
ORDER BY votes_count DESC
LIMIT 3;
/* output: 5 baris vote terbanyak*/


--5
SELECT congress_members.id,
       congress_members.name,
	   congress_members.party,
       congress_members.location,
       congress_members.grade_1996,
       congress_members.grade_current,
       congress_members.years_in_congress,
       congress_members.dw1_score,
	     COUNT(votes.id) AS votes_count
FROM congress_members
LEFT JOIN votes ON congress_members.id = votes.politician_id
GROUP BY congress_members.id
ORDER BY votes_count ASC
LIMIT 3;
/* output: 5 baris vote tersedikit*/



--     Release 2

--1
/*terbanyak: Rep. Dan Benishek, count 32*/
SELECT voters.first_name,
       voters.last_name,
       voters.gender
FROM voters
LEFT JOIN votes ON voters.id = votes.voter_id
WHERE votes.politician_id = 224;


--2
SELECT congress_members.id,
       congress_members.name,
  	   congress_members.location,
  	   congress_members.grade_current,
  	   COUNT(votes.id) AS votes_count
FROM congress_members
LEFT JOIN votes ON congress_members.id = votes.politician_id
WHERE congress_members.grade_current < 9
GROUP BY congress_members.id;


--3
--10 states terbanyak
SELECT congress_members.location,
       COUNT(votes.id) AS votes_count
FROM congress_members
LEFT JOIN votes ON congress_members.id = votes.politician_id
GROUP BY congress_members.location
ORDER BY votes_count DESC
LIMIT 10;

--list pemilih di sepuluh daerah terbanyak
SELECT voters.first_name,
       voters.last_name,
       congress_members.location
FROM voters
INNER JOIN votes ON voters.id = votes.voter_id
INNER JOIN congress_members ON congress_members.id = votes.politician_id
WHERE congress_members.location = 'CA' OR
      congress_members.location = 'TX' OR
	  congress_members.location = 'NY' OR
	  congress_members.location = 'TL' OR
	  congress_members.location = 'FL' OR
	  congress_members.location = 'PA' OR
	  congress_members.location = 'IL' OR
	  congress_members.location = 'OH' OR
	  congress_members.location = 'MI' OR
	  congress_members.location = 'NC' OR
	  congress_members.location = 'GA'
ORDER BY voters.first_name, voters.last_name;


--4
SELECT voters.first_name,
       voters.last_name,
       COUNT (votes.voter_id) AS vote_count
FROM voters
INNER JOIN votes ON voters.id = votes.voter_id
GROUP BY voters.first_name, voters.last_name
HAVING vote_count > 2;
