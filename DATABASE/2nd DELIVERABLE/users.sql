# Create Simple User that can view albums, save lists, create personal lists, write reviews, and rate other users' lists.
CREATE USER 'simpleuser'@'localhost' IDENTIFIED BY 'simplepassword';
CREATE USER 'simpleuser'@'%' IDENTIFIED BY 'simplepassword';
GRANT SELECT, INSERT, UPDATE ON database_name.albums TO 'simpleuser'@'localhost';
GRANT SELECT, INSERT, UPDATE ON database_name.lists TO 'simpleuser'@'localhost';
GRANT SELECT, INSERT, UPDATE ON database_name.reviews TO 'simpleuser'@'localhost';


# Create Developer - General Admins that has extensive privileges to manage albums, songs, reviews, lists, genres, artists, and record labels. Additionally, they oversee database interventions.
CREATE USER 'adminuser'@'localhost' IDENTIFIED BY 'adminpassword';
CREATE USER 'adminuser'@'%' IDENTIFIED BY 'adminpassword';
GRANT SELECT, INSERT, UPDATE, DELETE ON database_name.albums TO 'adminuser'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON database_name.songs TO 'adminuser'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON database_name.reviews TO 'adminuser'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON database_name.lists TO 'adminuser'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON database_name.genres TO 'adminuser'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON database_name.artists TO 'adminuser'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON database_name.record_labels TO 'adminuser'@'localhost';


# Create Read-Write User that has the ability to select and insert data across the database but lacks delete and update privileges.
CREATE USER 'readwriteuser'@'localhost' IDENTIFIED BY 'readwritepassword';
CREATE USER 'readwriteuser'@'%' IDENTIFIED BY 'readwritepassword';
GRANT SELECT, INSERT ON database_name.* TO 'readwriteuser'@'localhost';

# Create Read User, which is for read-only purposes, allowing viewing of all database tables without modification rights.
CREATE USER 'readonlyuser'@'localhost' IDENTIFIED BY 'readonlypassword';
CREATE USER 'readonlyuser'@'%' IDENTIFIED BY 'readonlypassword';
GRANT SELECT ON database_name.* TO 'readonlyuser'@'localhost';

