SELECT *
FROM
    album
JOIN artisttoalbum ON artisttoalbum.albumID = album.albumID
JOIN artist ON artist.artistID = artisttoalbum.artistID
WHERE
    artist.name = 'John Lennon' OR FIND_IN_SET('John Lennon', artist.groupMembers) > 0;
