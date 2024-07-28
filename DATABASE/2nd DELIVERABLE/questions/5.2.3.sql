SELECT
    album.title AS album_title,
    album.release_date,
    album.type AS album_type,
    album.cover AS album_cover,
    album.genre AS album_genre,
    album.RecordLabel,
    artist.name AS artist_name,
    artist.isGroup,
    artist.country
FROM
		album
JOIN artisttoalbum ON album.albumID = artisttoalbum.albumID
JOIN artist ON artisttoalbum.artistID = artist.artistID
WHERE 
			artist.name = "Pink Floyd";