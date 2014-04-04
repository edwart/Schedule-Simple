CREATE TABLE job (
	jobid INTEGER PRIMARY KEY,
	name TEXT NOT NULL,
	command  TEXT NOT NULL,
	node TEXT
);
CREATE TABLE dependencies (
	parentjobid INTEGER,
	childjobid INTEGER PRIMARY KEY
);
CREATE TABLE conditions (
	conditionid INTEGER PRIMARY KEY,
	name TEXT NOT NULL,
	jobid INTEGER NOT NULL
);
CREATE TABLE run (
	runid INTEGER PRIMARY KEY,
	jobid INTEGER NOT NULL,
	started TEXT NOT NULL,
	finished TEXT,
	pid INTEGER,
	status INTEGER,
	stdout TEXT,
	stderr TEXT
);
CREATE TABLE queue (
	jobid INTEGER PRIMARY KEY,
	added TEXT NOT NULL,
);


