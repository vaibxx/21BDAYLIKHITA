-- Run this SQL in your Supabase SQL Editor to set up the database and storage!

-- 1. Create the entries table
CREATE TABLE IF NOT EXISTS public.entries (
    id TEXT PRIMARY KEY,
    day_index INTEGER NOT NULL,
    label TEXT,
    log TEXT,
    photo_url TEXT,
    ts BIGINT NOT NULL
);

-- 2. Allow anonymous access to the entries table (for our simple static site)
ALTER TABLE public.entries ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read access to entries" ON public.entries
    FOR SELECT USING (true);

CREATE POLICY "Allow public insert to entries" ON public.entries
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Allow public update to entries" ON public.entries
    FOR UPDATE USING (true);

CREATE POLICY "Allow public delete from entries" ON public.entries
    FOR DELETE USING (true);

-- 3. Create the images storage bucket
INSERT INTO storage.buckets (id, name, public) 
VALUES ('images', 'images', true)
ON CONFLICT (id) DO NOTHING;

-- 4. Allow anonymous access to the images bucket
CREATE POLICY "Allow public read access to images" ON storage.objects
    FOR SELECT USING (bucket_id = 'images');

CREATE POLICY "Allow public upload to images" ON storage.objects
    FOR INSERT WITH CHECK (bucket_id = 'images');

CREATE POLICY "Allow public update to images" ON storage.objects
    FOR UPDATE USING (bucket_id = 'images');

CREATE POLICY "Allow public delete from images" ON storage.objects
    FOR DELETE USING (bucket_id = 'images');
