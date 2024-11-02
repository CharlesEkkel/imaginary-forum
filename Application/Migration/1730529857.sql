CREATE FUNCTION set_updated_at_to_now() RETURNS TRIGGER AS $$BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;$$ language PLPGSQL;
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    email TEXT NOT NULL,
    first_name TEXT NOT NULL,
    middle_name TEXT DEFAULT null,
    last_name TEXT DEFAULT null
);
ALTER TABLE users ADD CONSTRAINT users_email_key UNIQUE(email);
CREATE TABLE threads (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    user_id UUID NOT NULL,
    title TEXT NOT NULL
);
CREATE INDEX threads_created_at_index ON threads (created_at);
CREATE TRIGGER update_threads_updated_at BEFORE UPDATE ON threads FOR EACH ROW EXECUTE FUNCTION set_updated_at_to_now();
CREATE INDEX threads_user_id_index ON threads (user_id);
CREATE TABLE posts (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    user_id UUID NOT NULL,
    thread_id UUID NOT NULL,
    message TEXT DEFAULT '' NOT NULL
);
CREATE INDEX posts_created_at_index ON posts (created_at);
CREATE TRIGGER update_posts_updated_at BEFORE UPDATE ON posts FOR EACH ROW EXECUTE FUNCTION set_updated_at_to_now();
CREATE INDEX posts_user_id_index ON posts (user_id);
CREATE INDEX posts_thread_id_index ON posts (thread_id);
ALTER TABLE posts ADD CONSTRAINT posts_ref_thread_id FOREIGN KEY (thread_id) REFERENCES threads (id) ON DELETE NO ACTION;
ALTER TABLE posts ADD CONSTRAINT posts_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE threads ADD CONSTRAINT threads_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
