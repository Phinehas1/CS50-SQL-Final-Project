# Design Document

By Phinehas Doe

## Scope

The purpose of my database is to be able to store and view ratings and total plays of my favorite artists whether it's an album or an individual song.
Within my scope are: Artists, songs, albums, platforms, and ratings.

There are a few things I’ve deliberately chosen not to include in this database to keep it focused:

- Users or listeners – No data is stored about individual users, their preferences, or behavior.
- Playlists or custom groupings – Songs are not grouped into user-created playlists or compilations.
- Interactive features – No support for commenting, sharing, liking, or user engagement tools.

## Functional Requirements
The database allows the user to:

* View all songs and albums by artists
* See which platforms songs are available on
* View and compare ratings for individual songs or albums
* Search songs by title, album, or artist

These core features were chosen because they match how I sometimes explore music myself. Whether I’m trying to see which album a song belongs to, or just browsing by rating to queue up favorites, this setup fits how I already engage with my favorite artists like TV Girl or Tame Impala.
Actions beyond the scope of the user:

* Leaving comments or feedback
* Interacting with other users


## Representation

    Entities are captured in SQLite tables with the following schema.

### Entities

The following entities are present in my database:

* artists

* albums

* songs

* platforms

* ratings

I structured the database around these entities because they reflect how music is commonly organized and consumed. Artists create albums and songs, which are published on platforms and receive ratings. Breaking this into individual tables makes the relationships between them clear, and leaves room for growth + change if I decide to expand things later.

---------------------------------------------------------------------------------------------
#### The artists table includes:

* id, which is the unique identifier for each artist. It is an INTEGER and serves as the table’s PRIMARY KEY.

* name, which is the name of the artist as TEXT. It has a NOT NULL constraint, as every artist entry must include a name.

* genre, which captures the musical genre the artist belongs to, stored as TEXT. This field is optional but can be useful for filtering artists.

* year_formed, which records the year the artist or band was established. It is stored as an INTEGER, representing a four-digit year (e.g., 2014).

#### The albums table includes:

* id, the unique identifier for each album as an INTEGER. It serves as the table’s PRIMARY KEY.

* name, which is the name of the album as TEXT.

* release_date, which stores the release date of the album as TEXT. Although SQLite has no dedicated date type, ISO-8601 format strings (e.g., YYYY-MM-DD) are commonly used.

* artist_id, which links the album to its artist as an INTEGER. It is a FOREIGN KEY referencing the id column in the artists table, maintaining referential integrity.

#### The songs table includes:

* id, which is the unique identifier for each song as an INTEGER. It serves as the table’s PRIMARY KEY.

* name, the song title as TEXT, used to identify and search for songs.

* duration, which records the song's length in seconds as an INTEGER. This allows for efficient time calculations and sorting.

* total_plays, which stores how many times the song has been streamed across platforms, recorded as an INTEGER.

* album_id, which associates the song with a particular album. This is a FOREIGN KEY referencing the albums(id) column.

* artist_id, which links the song to its artist. It is also a FOREIGN KEY, referencing artists(id).

#### The platforms table includes:

* id, the unique identifier for each platform as an INTEGER, and serves as the PRIMARY KEY.

* name, the name of the platform (e.g., Spotify, Apple Music) as TEXT.

* url, which stores the platform’s web address as TEXT. Useful for linking to the song or album pages directly.

#### The ratings table includes:

* id, which is the unique identifier for each rating entry as an INTEGER, serving as the PRIMARY KEY.

* rating, which stores a user's rating of a song as TEXT.

* song_id, which associates a rating with a specific song. It is a FOREIGN KEY referencing songs(id).

I chose to store the rating as TEXT (“5 stars” or “Excellent”) instead of numeric initially because I find it more expressive. Of course that being said, I could easily switch this to a numeric scale if I wanted to sort more precisely later.
------------------------------------------------------------------------------------------

Why did you choose the constraints you did?

    - Primary keys ensure uniqueness.

    - Foreign keys maintain relationships

    - Indexes on search-heavy columns (like song name, artist name) improve performance.


### Relationships

One artist can have zero to many albums. An artist might not have released any albums yet or may have several. Each album is linked to one and only one artist, so every album is clearly tied to a specific artist.

One artist can also have zero to many songs. This includes standalone singles or songs that are part of an album. Every song must have one and only one artist, making sure each song is properly credited.

An album might just be a draft or have a full set of tracks — either way, it links back to one artist. No matter what, each song is part of one and only one album, even if it was also released separately.

In a few cases, the relationships could be more complex — for example, some songs appear on both a studio album and a deluxe re-release. For now, I’ve simplified this by assigning each song to just one album, though I may revisit this in future versions.

## Optimizations

* Which optimizations (e.g., indexes, views) did you create? Why?

I created indexes on songs.name and albums.name to speed up common searches

I added an index on artists.genre for quick filtering.

These optimizations reflect how I expect to use the database. I often look up songs by name or genre, so those fields made the most sense to index. If I later add user data or behavior tracking, It would probably be best to create new indexes to support that also.

## Limitations


* What are the limitations of your design?

    -There is no tracking of listener behavior or user history.
    -The rating is text-based (not numerically sortable unless extended).

* What might your database not be able to represent very well?

    -Songs appearing on multiple albums (e.g., deluxe editions or live versions)
    -User accounts, playlists, or interactions
    -Lyrics or song credits (e.g., producer, writer)

Overall, this project was a great way to practice thinking through data structure and normalization. I focused on a subject I enjoy (music I listen to often), and I tried to design it with practical and common use cases in mind. If I were to expand it, I could add user profiles, track song progress, or pull data from real APIs.
