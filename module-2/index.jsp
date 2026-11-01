<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.BufferedReader,java.io.InputStream,java.io.InputStreamReader,java.io.IOException" %>
<%@ page import="java.nio.charset.StandardCharsets,java.util.LinkedHashMap,java.util.List,java.util.ArrayList,java.util.Map" %>
<%@ page import="java.time.ZonedDateTime,java.time.ZoneId,java.time.format.DateTimeFormatter" %>
<%--
    Samuel Dirr | CSD 430 | Module 2 Assignment 2 | November 1, 2026
    Purpose: Read five Red Rising character records and display a grouped table.
    Java statements belong in scriptlets; HTML markup stays outside scriptlets.
    JSP expressions insert individual values into the surrounding HTML.
--%>
<%
    // LinkedHashMap preserves the intended order of the topical categories.
    Map<String, List<String[]>> groups = new LinkedHashMap<>();
    groups.put("Origins on Mars", new ArrayList<>());
    groups.put("Institute allies", new ArrayList<>());
    groups.put("Institute rival", new ArrayList<>());

    int totalRecords = 0;
    boolean dataAvailable = true;

    // Read the UTF-8 tab-separated data file. WEB-INF prevents direct downloads.
    // File columns: category, character name, role, and record description.
    try (InputStream data = application.getResourceAsStream("/WEB-INF/characters.tsv")) {
        if (data == null) {
            throw new IOException("Character data file is missing.");
        }
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(data, StandardCharsets.UTF_8))) {
            reader.readLine(); // Skip the field-name header.
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.isBlank()) {
                    continue;
                }
                String[] record = line.split("\t", -1);
                if (record.length != 4 || !groups.containsKey(record[0])) {
                    throw new IOException("Invalid character record or category.");
                }
                // Escape text before inserting it into HTML, including future edits.
                for (int field = 1; field < record.length; field++) {
                    record[field] = record[field].replace("&", "&amp;")
                            .replace("<", "&lt;").replace(">", "&gt;")
                            .replace("\"", "&quot;").replace("'", "&#39;");
                }
                groups.get(record[0]).add(record);
                totalRecords++;
            }
        }
    } catch (IOException exception) {
        // Log the technical detail on the server; show a readable message below.
        application.log("Unable to load Red Rising character data.", exception);
        response.setStatus(500);
        dataAvailable = false;
    }

    // Accept only known categories. An absent or unrecognized value shows all rows.
    String selectedCategory = request.getParameter("category");
    if (selectedCategory == null || !groups.containsKey(selectedCategory)) {
        selectedCategory = "all";
    }
    int displayedRecords = selectedCategory.equals("all")
            ? totalRecords : groups.get(selectedCategory).size();
    String generatedAt = ZonedDateTime.now(ZoneId.of("America/Chicago"))
            .format(DateTimeFormatter.ofPattern("MMMM d, uuuu 'at' h:mm:ss a z", java.util.Locale.US));
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="A guide to five characters in Pierce Brown's Red Rising, grouped by their place in the story.">
    <title>Red Rising Character Guide | CSD 430</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <a class="skip-link" href="#characters">Skip to character table</a>
    <header class="masthead">
        <div class="container hero">
            <p class="eyebrow">A reader's companion · Book one</p>
            <h1>Red Rising<span>Character Guide</span></h1>
            <p class="byline">A novel by Pierce Brown · Science fiction · 2014</p>
            <p class="introduction">On a future Mars divided by a color-based hierarchy,
                a young miner named Darrow challenges the people who control his world.</p>
        </div>
    </header>
    <main class="container">
        <section class="overview" aria-labelledby="about-heading">
            <p class="section-label">01 / About the records</p>
            <h2 id="about-heading">Five characters. One divided world.</h2>
            <p>This guide introduces five characters from the first novel. Each record
                describes one character and their place in Darrow's story. The topical
                groups cover his origins on Mars, his Institute allies, and an Institute rival.</p>
            <p class="note">Contains basic character and relationship spoilers for the first book.</p>
        </section>

        <section class="directory" aria-labelledby="characters">
            <div class="section-heading">
                <div>
                    <p class="section-label">02 / The characters</p>
                    <h2 id="characters">People behind the rising</h2>
                </div>
                <p class="record-count"><%= displayedRecords %> of <%= totalRecords %> records</p>
            </div>

            <!-- This form requests a freshly rendered JSP page; no JavaScript is needed. -->
            <form class="filter" method="get" action="index.jsp">
                <label for="category">Explore a category</label>
                <select id="category" name="category">
                    <option value="all" <%= selectedCategory.equals("all") ? "selected" : "" %>>All categories</option>
                    <% for (String categoryName : groups.keySet()) { %>
                    <option value="<%= categoryName %>" <%= selectedCategory.equals(categoryName) ? "selected" : "" %>><%= categoryName %></option>
                    <% } %>
                </select>
                <button type="submit">Show characters</button>
                <a href="index.jsp">Reset</a>
            </form>

            <% if (dataAvailable) { %>
            <div class="table-scroll" role="region" aria-label="Character table" tabindex="0">
                <table aria-describedby="field-descriptions">
                    <caption>Red Rising character records grouped by their place in the story</caption>
                    <thead>
                        <tr>
                            <th scope="col">Character name</th>
                            <th scope="col">Role</th>
                            <th scope="col">Description</th>
                        </tr>
                    </thead>
                    <%
                        // Open a separate table body for each displayed topical group.
                        for (Map.Entry<String, List<String[]>> group : groups.entrySet()) {
                            if (selectedCategory.equals("all") || selectedCategory.equals(group.getKey())) {
                    %>
                    <tbody>
                        <tr class="category-row">
                            <th scope="rowgroup" colspan="3"><%= group.getKey() %></th>
                        </tr>
                        <% for (String[] character : group.getValue()) { %>
                        <tr class="character-row">
                            <th scope="row"><%= character[1] %></th>
                            <td><%= character[2] %></td>
                            <td><%= character[3] %></td>
                        </tr>
                        <% } %>
                    </tbody>
                    <%
                            }
                        }
                    %>
                </table>
            </div>
            <% } else { %>
            <p class="error" role="alert">The character records could not be loaded. Please try again later.</p>
            <% } %>
        </section>

        <section class="field-guide" aria-labelledby="fields-heading">
            <p class="section-label">03 / Reading the table</p>
            <h2 id="fields-heading">Field descriptions</h2>
            <dl id="field-descriptions">
                <div><dt>Character name</dt><dd>The character's name, including a familiar nickname when useful.</dd></div>
                <div><dt>Role</dt><dd>A short label describing the character's function in the first book.</dd></div>
                <div><dt>Description</dt><dd>A brief explanation of the character's connection to Darrow or the setting.</dd></div>
            </dl>
            <p class="sources">Book information:
                <a href="https://www.penguinrandomhouse.com/books/221552/red-rising-by-pierce-brown/9780345539793/">Penguin Random House</a>.
                Character reference: <a href="https://en.wikipedia.org/wiki/Red_Rising#Characters">Red Rising character list</a>.
                Descriptions are original summaries.</p>
        </section>
    </main>
    <footer class="container footer">
        <p>Samuel Dirr · CSD 430 · Module 2 Assignment 2</p>
        <p>Page generated <%= generatedAt %></p>
    </footer>
</body>
</html>
