SELECT
	album.albumID,
    album.title,
    album.cover,
    album.type,
    album.release_date
FROM
		album
WHERE (YEAR(album.release_date) = 1977) ; 
        