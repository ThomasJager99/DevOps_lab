title: "First School Project: Kino Search"

date: 2025-09-24

tags: [python, mysql, mongodb, school-project, learning]

summary: "My first real Python project — a console movie search app built with MySQL and MongoDB. Graded 1 (Sehr Gut)."

---

# 🎬 Kino Search — My First School Project  
*Graded 1 (Sehr Gut)*

> *“It started as a simple console movie search app.  
Then it became my first real experience of building something that actually works.”*

---

### I. The Beginning

This was my first school project — a console application for movie search.  
I built it completely from scratch: no templates, no frameworks, no IDE automation.  
Just a terminal, a clean `.venv`, and a few libraries.

```bash
cd Projects/movie_search/
python -m venv .venv
source .venv/bin/activate
pip install pymysql pymongo python-dotenv tabulate

That’s where it all started — the moment when theory turned into practice.

⸻

II. Connecting the Databases

I created a .env file for database credentials and added it to .gitignore.
My first test script didn’t work — the school’s MySQL server was down.
Later it came back online, and my connection finally succeeded.

Then I connected MongoDB to handle logs.
A simple test created a document with my name and returned an ID.
That was the first “alive” moment of the project.

⸻

III. SQL vs NoSQL

Working with both databases side by side taught me a lot:
	•	MySQL — explicit open/close, manual sessions.
	•	MongoDB — persistent client, automatic connection pooling.

Different rules, different personalities, one task: make them cooperate.

⸻

IV. Refactoring the Code

After a few tests the code became messy — too many prints, repeated connections.
I cleaned everything up:
	•	Added _mysql_conn() encapsulation.
	•	Moved credentials and factories into config.py.
	•	Created log_writer.py for Mongo logging.
	•	Made each module communicate through config.py.

Now MySQL opens and closes cleanly for every query,
and MongoDB stays persistent through one global client.

⸻

V. Organizing the Project

To keep things under control, I expanded my PyCharm task markers:
TODO, WIP, BUG, NOTE, QUESTION.
Small detail, but it keeps focus on what matters.

⸻

VI. What I Learned
	•	How to manage two databases in one project.
	•	Why context managers matter for clean SQL sessions.
	•	How to refactor config and connection logic properly.
	•	How structure makes learning faster and calmer.

⸻

VII. Closing Thoughts

Kino Search was my first real experience of putting theory into code —
a simple console app, but a complete working system.
It was later graded 1 (Sehr Gut) — and that feels like a solid start.


