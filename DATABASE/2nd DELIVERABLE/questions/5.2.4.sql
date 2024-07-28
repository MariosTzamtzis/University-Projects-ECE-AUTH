SELECT 
	review.reviewID,
	review.rating,
    review.name AS review_name,
	review.details, 
    user.userid,
	user.username, 
	album.title AS album_title
FROM review
JOIN album ON review.reviewID = album.albumID
JOIN user ON review.userID = user.userID
WHERE album.title = 'The Wall';
