# CSD 430 Assignment 3.2 Restaurant Feedback

Samuel Dirr | November 8, 2026

This application gathers one restaurant visit record with five required fields:
customer name (text), visit date (date), meal (select), service rating (radio),
and comments (textarea). It uses five input types and a separate JSP response.

## Files

- `feedback.html`: labeled input form using POST.
- `feedback-result.jsp`: documented Java scriptlets, server validation, and results table.
- `style.css`: external stylesheet shared by both pages.
- `Dirr-Assignment_3_2_CSD430.docx`: screenshots, verification, and source acknowledgment.

## Run

Use the existing Java 21 and Apache Tomcat 10.1 installation. Copy the HTML,
JSP, and CSS into `webapps/csd430-module3` under Tomcat. Start Tomcat, then open:

http://localhost:8080/csd430-module3/feedback.html

The local verification server used port 8083 to avoid changing the existing
server. JSP requires Tomcat; opening the file directly or using GitHub Pages
will not execute the Java code. No database, Maven build, or JavaFX library is
required by the web application. JavaFX is verified separately in the Word
file because the assignment requests Java and JavaFX screenshots.

## Processing and security

The form's `name` attributes match the JSP request parameters. The JSP sets UTF-8
before reading input, rejects missing, blank, duplicate, oversized, or invalid
values, and returns HTTP 400 with field-specific errors. Dates must be valid
and no later than the current date in America/Chicago. Meals and ratings must
match the offered options. Valid values are HTML-escaped before display.
The table includes field names, descriptions, and the user's responses, with
an overall record description above it. HTML tags remain outside Java scriptlets.
JSP expressions insert values into the HTML. The stylesheet is external.

The application does not store feedback, authenticate users, or send messages.
POST keeps values out of the URL but does not encrypt them; a real deployment
handling personal data would need HTTPS. The results use `Cache-Control: no-store`.

## Verification

Tested November 8, 2026 on Java 21.0.11 and Tomcat 10.1.61:

- Browser form POST renders five table rows in the separate JSP.
- Invalid dates, future dates, blank/missing inputs, duplicate parameters,
  unknown meals, invalid ratings, and oversized comments are rejected.
- HTML injection is escaped and accented UTF-8 text is preserved.
- Direct navigation to the JSP displays a helpful prompt.
- The form fits a 390-pixel mobile viewport.
- JavaFX 21.0.12 controls rendered and a button event ran successfully.

## Sources and assistance

Bellevue University. (2024). M3_Code_Examples [Course code examples].
Professor Darrell Payne's Form_01.jsp and Form_04.jsp illustrate POST,
request.getParameter(), and multiple form controls. This assignment adapts
those concepts to separate pages and keeps all HTML tags outside scriptlets.

OpenAI. (2026). Codex [AI coding assistant]. https://openai.com/codex/
AI assistance used November 8, 2026 to generate the HTML, JSP, CSS, README,
and Word documentation, and to perform local tests. Samuel Dirr supplied the
assignment requirements and selected restaurant feedback as the topic.
The sample restaurant and feedback are fictional demonstration content.

## Submission

Use `dirr_mod_3_csd430.zip`, following the instructor's filename example.
The archive contains this module folder, including the source files and Word
screenshot document. Add this repository URL to the submission comments:

https://github.com/samdirr/csd-430
