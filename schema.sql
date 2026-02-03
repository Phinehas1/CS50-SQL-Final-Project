-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it
CREATE TABLE "artists" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "genre" TEXT,
    "year_formed" INTEGER,
    PRIMARY KEY ("id")
);

CREATE TABLE "albums" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "release_date" TEXT NOT NULL,
    "artist_id" INTEGER,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("artist_id") REFERENCES "artists"("id")
);

CREATE TABLE "songs" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "duration" INT NOT NULL,
    "total_plays" INTEGER,
    "album_id" INTEGER,
    "artist_id" INTEGER,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("album_id") REFERENCES "albums"("id"),
    FOREIGN KEY ("artist_id") REFERENCES "artists"("id")
);

CREATE TABLE "platforms" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

CREATE TABLE "ratings" (
    "id" INTEGER,
    "rating" NUMERIC NOT NULL,
    "song_id" INTEGER,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("song_id") REFERENCES "songs"("id")
);

CREATE INDEX "song_name_search" ON "songs" ("name");
CREATE INDEX "album_name_search" ON "albums" ("name");
CREATE INDEX "artist_search" ON "artists" ("name", "genre");
