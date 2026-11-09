<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDate,java.time.ZoneId,java.time.format.DateTimeParseException,java.util.ArrayList,java.util.List,java.util.Arrays" %>
<%--
    Samuel Dirr | November 8, 2026 | CSD 430 Assignment 3.2
    AI assistance: OpenAI Codex generated this code and assisted with testing.
    Reference: Bellevue University, M3_Code_Examples, Form_01.jsp and Form_04.jsp.
    Purpose: Validate posted restaurant feedback and display one record in an HTML table.
    Java statements stay in scriptlets. HTML tags stay outside scriptlets.
--%>
<%
    // Set encoding before reading parameters; prevent caching of guest responses.
    request.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("X-Content-Type-Options", "nosniff");
    response.setHeader("Content-Security-Policy", "default-src 'self'; style-src 'self'; form-action 'self'; frame-ancestors 'none'; base-uri 'none'");
    boolean posted = "POST".equals(request.getMethod());
    String[] names = {"customerName", "visitDate", "meal", "serviceRating", "comments"};
    String[] labels = {"Customer name", "Visit date", "Meal ordered", "Service rating", "Comments"};
    String[] descriptions = {"Guest providing this feedback", "Date of the restaurant visit", "Meal selected by the guest", "Service quality on a scale from 1 to 5", "Details about the meal or service"};
    String[] values = new String[names.length];
    List<String> errors = new ArrayList<>();

    // Reject missing, duplicate, blank, or oversized values even if HTML checks are bypassed.
    if (posted) {
        int[] limits = {80, 10, 40, 1, 1000};
        for (int i = 0; i < names.length; i++) {
            String[] supplied = request.getParameterValues(names[i]);
            values[i] = supplied == null || supplied.length == 0 ? "" : supplied[0].strip();
            if (supplied == null || supplied.length != 1 || values[i].isEmpty()) {
                errors.add(labels[i] + ": provide exactly one nonblank value.");
            } else if (values[i].length() > limits[i]) {
                errors.add(labels[i] + ": maximum length is " + limits[i] + " characters.");
            }
        }

        // Validate real calendar dates and use the course's local timezone for today.
        if (!values[1].isEmpty()) {
            try {
                LocalDate visit = LocalDate.parse(values[1]);
                if (!values[1].matches("[0-9]{4}-[0-9]{2}-[0-9]{2}") || visit.getYear() < 1
                        || visit.isAfter(LocalDate.now(ZoneId.of("America/Chicago")))) {
                    errors.add("Visit date: choose a valid date no later than today.");
                }
            } catch (DateTimeParseException exception) {
                errors.add("Visit date: enter a valid calendar date in YYYY-MM-DD format.");
            }
        }
        List<String> meals = Arrays.asList("Herb roasted chicken", "Garden pasta", "Grilled salmon", "House burger", "Other");
        if (!values[2].isEmpty() && !meals.contains(values[2])) {
            errors.add("Meal ordered: select one of the available meals.");
        }
        if (!values[3].isEmpty() && !values[3].matches("[1-5]")) {
            errors.add("Service rating: select a rating from 1 to 5.");
        }
        if (!errors.isEmpty()) {
            response.setStatus(400);
        } else {
            // Convert the rating to a readable description, then HTML-escape every value.
            String[] ratings = {"Poor", "Fair", "Good", "Very good", "Excellent"};
            values[3] = values[3] + " - " + ratings[Integer.parseInt(values[3]) - 1];
            for (int i = 0; i < values.length; i++) {
                values[i] = values[i].replace("&", "&amp;").replace("<", "&lt;")
                    .replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#39;");
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Feedback Summary | Table &amp; Thyme</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <main class="container">
        <header>
            <p class="eyebrow">Table &amp; Thyme / Guest feedback</p>
            <h1>Your visit, in review.</h1>
            <p>A summary of the meal and service information you provided.</p>
        </header>
        <section class="panel" aria-labelledby="result-title">
            <% if (!posted) { %>
            <h2 id="result-title">Start with the feedback form</h2>
            <p>No feedback has been submitted. Complete the form to view your visit summary.</p>
            <% } else if (!errors.isEmpty()) { %>
            <h2 id="result-title">Please check your feedback</h2>
            <p>The feedback could not be accepted. Correct the following fields and submit again.</p>
            <ul class="errors">
                <% for (String error : errors) { %>
                <li><%= error %></li>
                <% } %>
            </ul>
            <% } else { %>
            <h2 id="result-title">Thank you for sharing</h2>
            <p id="record-description">This record describes one guest's restaurant visit, including the meal, service rating, and written feedback.</p>
            <div class="table-wrap">
                <table aria-describedby="record-description">
                    <caption>Restaurant feedback record</caption>
                    <thead><tr><th scope="col">Field</th><th scope="col">Description</th><th scope="col">Your response</th></tr></thead>
                    <tbody>
                        <% for (int i = 0; i < labels.length; i++) { %>
                        <tr><th scope="row"><%= labels[i] %></th><td><%= descriptions[i] %></td><td class="response"><%= values[i] %></td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <p class="muted">Your feedback is displayed for this request only. It is not saved to a database or sent to a restaurant.</p>
            <% } %>
            <a class="button-link" href="feedback.html">Return to feedback form</a>
        </section>
        <footer>Samuel Dirr · CSD 430 · Assignment 3.2</footer>
    </main>
</body>
</html>
