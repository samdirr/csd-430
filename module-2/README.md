# CSD 430 Module 2 Assignment 2

Samuel Dirr · November 1, 2026

## Red Rising Character Guide

This JSP page introduces five characters from Pierce Brown's first *Red Rising*
novel. The records are grouped into Origins on Mars, Institute allies, and
Institute rival. Each table row has three visible fields: character name, role,
and description. A separate category field in the data file controls grouping.

## Files

- `index.jsp`: documented Java scriptlets, category filtering, and HTML markup.
- `style.css`: all page styling, including keyboard focus, mobile, and print rules.
- `WEB-INF/characters.tsv`: five UTF-8 tab-separated character records and a header.
- `Dirr-Assignment_2_2_CSD430.docx`: screenshot documentation with name, date,
  assignment number, and Java/JavaFX verification.

## Run with Tomcat

Use Java 21 and Apache Tomcat 10.1, matching the environment used for verification.
Copy `index.jsp`, `style.css`, and the entire `WEB-INF` folder into a new
`csd430-module2` directory under Tomcat's `webapps` directory. Start Tomcat if it
is not running, then open:

http://localhost:8080/csd430-module2/index.jsp

Keep `WEB-INF` directly inside the application directory. Its filename and
capitalization matter. No database, JavaScript, Maven dependencies, or JavaFX
libraries are needed by the JSP application. JavaFX verification is included
in the Word document because the assignment explicitly requests it.

A JSP must run through Tomcat; opening it as a local file or publishing it with
GitHub Pages will not execute its Java code.

## How the code works

1. The page directives select UTF-8 and import the Java classes used below them.
2. The first scriptlet creates ordered category lists and reads the TSV data.
   Each record is checked for four fields, and display text is HTML-escaped.
3. A request parameter selects a known category. Missing or unknown values show
   all five records. User-supplied parameter text is never printed back.
4. Java loops select the categories and records; the HTML table tags stay outside
   the scriptlets. JSP expressions insert values into those tags.
5. A server-generated timestamp changes on subsequent requests. Category filters
   are also evaluated by Java on the server.
6. If the file cannot be loaded, the server logs the technical detail and the
   page returns HTTP 500 with a readable error message.

## Data and field descriptions

The first TSV column is grouping metadata. The next three columns supply the
visible character name, story role, and brief record description. To edit the
data, preserve actual tab separators and use one of the three existing category
names. Field definitions, an overall description, and individual record
descriptions also appear on the page.

The descriptions are short original summaries of characters in the first book,
not quotations. Basic character and relationship spoilers are identified on
the page. Sources:

- [Penguin Random House book description](https://www.penguinrandomhouse.com/books/221552/red-rising-by-pierce-brown/9780345539793/)
- [Red Rising character list](https://en.wikipedia.org/wiki/Red_Rising#Characters)
- [Apache Tomcat 10.1 documentation](https://tomcat.apache.org/tomcat-10.1-doc/)

## Submission

Submit `dirr_mod_2_csd430.zip` and put this repository URL in the submission comments:

https://github.com/samdirr/csd-430

The archive includes the JSP, external stylesheet, protected data file, this
README, and the Word screenshot document. It excludes editor settings, server
logs, compiled classes, and local verification tools.
