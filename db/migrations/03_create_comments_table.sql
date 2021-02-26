CREATE TABLE comments
(id SERIAL PRIMARY KEY,
text VARCHAR(240),
bookmark_id INT,
FOREIGN KEY (bookmark_id) REFERENCES bookmarks (id));
