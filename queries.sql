-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

SELECT songs.name, songs.total_plays, artists.name, ratings.rating
FROM "songs"
JOIN "ratings"                                      --This query could be commonly used to find the top rated songs to listen to
ON ratings.song_id = songs.id
JOIN "artists"
ON songs.artist_id = artists.id
WHERE ratings.rating > 4
ORDER BY ratings.rating DESC;

-- Find all songs released by a specific artist
SELECT songs.name, albums.name AS album_name, songs.total_plays
FROM songs
JOIN artists ON songs.artist_id = artists.id
LEFT JOIN albums ON songs.album_id = albums.id
WHERE artists.name = 'Tame Impala'
ORDER BY songs.total_plays DESC;

-- Get a list of all albums along with artist names and release dates
SELECT albums.name AS album, artists.name AS artist, albums.release_date
FROM albums
JOIN artists ON albums.artist_id = artists.id
ORDER BY albums.release_date DESC;

-- Calculate the average rating per song
SELECT songs.name, AVG(CAST(rating AS FLOAT)) AS avg_rating
FROM songs
JOIN ratings ON ratings.song_id = songs.id
GROUP BY songs.id
ORDER BY avg_rating DESC;

-- Get all songs from albums released in a given year (e.g., 2020)
SELECT songs.name, albums.name AS album, artists.name AS artist
FROM songs
JOIN albums ON songs.album_id = albums.id
JOIN artists ON songs.artist_id = artists.id
WHERE albums.release_date LIKE '2020%';



