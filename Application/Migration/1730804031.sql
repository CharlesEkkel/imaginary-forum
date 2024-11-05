ALTER TABLE comments ADD COLUMN thread_id UUID NOT NULL;
CREATE INDEX comments_thread_id_index ON comments (thread_id);
ALTER TABLE comments ADD CONSTRAINT comments_ref_thread_id FOREIGN KEY (thread_id) REFERENCES threads (id) ON DELETE NO ACTION;
