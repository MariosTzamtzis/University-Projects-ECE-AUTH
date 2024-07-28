SELECT 
		album.title AS AlbumTitle,
		2023 - YEAR(release_date) AS years_ago
FROM album
ORDER BY years_ago