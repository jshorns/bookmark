CREATE TABLE bookmark_tags (id SERIAL PRIMARY KEY, bookmark_id INT, tag_id INT, FOREIGN KEY (bookmark_id) REFERENCES bookmarks (id), FOREIGN KEY (tag_id) REFERENCES tags (id));
