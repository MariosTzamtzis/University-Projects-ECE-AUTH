SELECT
	album.albumID, 
    album.title AS album_title, 
    album.release_date, 
    album.RecordLabel AS RecordLabel,
    artist.name AS artist_name,
    artist.groupMembers AS GroupMembers
FROM
	album
JOIN artisttoalbum  ON album.albumID = artisttoalbum.albumID
RIGHT JOIN artist ON artisttoalbum.artistID = artist.artistID
WHERE
		album.type <> 'SINGLE';
