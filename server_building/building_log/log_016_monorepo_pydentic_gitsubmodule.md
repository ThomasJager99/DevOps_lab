
📅 Date: 2025-10-16 → 2025-10-18
🔧 Tools: Python, Pydantic, MySQL, JSON, Git Submodules

⸻

How It Started

I hit a point where my project needed more than raw input() checks.
Validation logic was scattered between main.py, connectors, and random if/else.
Time to clean it up.

At the same time, my teacher asked to create a separate repo for homeworks, but I already use a monorepo. I finally decided to try something I wanted a long time:

create a second repo and attach it as git submodule.

So now advanced_python lives inside my main PythonJourney repo.

________________

The Problem

User input validation became too complicated:

- keyword must be validated
- genre must exist in DB
- years must be within allowed range

I needed one system that handles all validation in one place.

Also, performing validation directly against the DB was slow.
Each user input triggered a DB read.

________________

The Fix:

1.Created a separate module dedicated only to validation.
All checks now run through Pydantic.

2.Extracted genres from the Sakila database and saved them into genre.json.

3.Created a cache module to load genres once and keep them in a dict
so validation is instant.

4.Added custom validators in Pydantic:

- keyword validation
- genre existence check (compared using cache dict)
- year range validation

5. Updated main.py to send user input through Pydantic first, then run DB query.

________________

What I Learned:

- Validation belongs between user input and DB, not inside DB logic.
- Pydantic simplifies input handling and makes code cleaner.
- Cache is faster than querying the DB on every input.
- Git submodules are perfect when you want to keep a monorepo but split projects.

________________

✍ Personal Note
Not a huge feature, but this was the first time when the structure finally felt right.
