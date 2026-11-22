<%--
Sam Dirr | CSD430 | Modules 5.3 and 6.3 | November 22, 2026
Purpose: Display database keys in a JSP dropdown and retrieve one movie via a JavaBean.
Source: OpenAI ChatGPT (https://chatgpt.com/), with Bellevue CRUD examples as course context.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List,java.util.ArrayList,java.sql.SQLException,movies.MovieBean" %>
<jsp:useBean id="movieDatabase" class="movies.MovieDatabaseBean" scope="page" />
<%!
    // Encode database text before inserting it into HTML text nodes.
    private String escapeText(String value) {
        if (value == null) { return ""; }
        return value.replace("&", "&amp;").replace("<", "&lt;")
                .replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&#39;");
    }
%>
<%
    List<Integer> movieIds = new ArrayList<>();
    MovieBean selectedMovie = null;
    Integer selectedId = null;
    String message = "";
    String requestedId = request.getParameter("movieId");
    boolean databaseAvailable = true;

    // Validate manually supplied parameters as well as dropdown submissions.
    if (requestedId != null) {
        try {
            if (!requestedId.matches("[1-9][0-9]{0,9}")) {
                throw new NumberFormatException();
            }
            selectedId = Integer.valueOf(requestedId);
        } catch (NumberFormatException exception) {
            response.setStatus(400);
            message = "Please select a valid movie ID from the dropdown.";
        }
    }
    try {
        movieIds = movieDatabase.getMovieIds();
        if (selectedId != null) {
            selectedMovie = movieDatabase.findMovie(selectedId);
            if (selectedMovie == null) {
                response.setStatus(404);
                message = "No movie was found for that ID. Please select an available movie.";
            }
        }
    } catch (SQLException exception) {
        application.log("Unable to read the CSD430 movie database", exception);
        response.setStatus(503);
        databaseAvailable = false;
        message = "The movie database is unavailable. Please check the local MySQL setup and try again.";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Read a Movie | Sam Dirr</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<main>
    <p><a href="index.jsp">Project home</a></p>
    <h1>Find a Movie</h1>
    <p>Sam Dirr | CSD430 | Modules 5.3 and 6.3</p>
    <p>This movie collection stores a unique ID, title, director, release year,
       genre, and running time for each record. Select an ID to view one movie.</p>
<% if (!message.isEmpty()) { %>
    <p class="notice" role="alert"><%= escapeText(message) %></p>
<% } %>
<% if (databaseAvailable && !movieIds.isEmpty()) { %>
    <form method="get" action="read.jsp">
        <label for="movieId">Movie ID</label>
        <select name="movieId" id="movieId" required>
            <option value="" disabled <%= selectedId == null ? "selected" : "" %>>Choose a movie ID</option>
<% for (Integer movieId : movieIds) { %>
            <option value="<%= movieId %>" <%= movieId.equals(selectedId) ? "selected" : "" %>><%= movieId %></option>
<% } %>
        </select>
        <button type="submit">View Movie</button>
    </form>
<% } else if (databaseAvailable) { %>
    <p>No movie records are available. Populate the table before using this form.</p>
<% } %>
<% if (selectedMovie != null) { %>
    <h2>Selected Movie</h2>
    <div class="table-container">
        <table>
            <caption>Complete record for movie ID <%= selectedMovie.getMovieId() %></caption>
            <thead>
                <tr>
                    <th scope="col">Movie ID</th>
                    <th scope="col">Title</th>
                    <th scope="col">Director</th>
                    <th scope="col">Release Year</th>
                    <th scope="col">Genre</th>
                    <th scope="col">Runtime (minutes)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= selectedMovie.getMovieId() %></td>
                    <td><%= escapeText(selectedMovie.getTitle()) %></td>
                    <td><%= escapeText(selectedMovie.getDirector()) %></td>
                    <td><%= selectedMovie.getReleaseYear() %></td>
                    <td><%= escapeText(selectedMovie.getGenre()) %></td>
                    <td><%= selectedMovie.getRuntimeMinutes() %></td>
                </tr>
            </tbody>
        </table>
    </div>
<% } %>
    <h2>Field Descriptions</h2>
    <dl>
        <dt>Movie ID</dt><dd>The primary key that uniquely identifies a movie.</dd>
        <dt>Title</dt><dd>The name of the movie.</dd>
        <dt>Director</dt><dd>The director listed for the movie.</dd>
        <dt>Release Year</dt><dd>The year the movie was released.</dd>
        <dt>Genre</dt><dd>The category assigned to the movie.</dd>
        <dt>Runtime</dt><dd>The length of the movie in minutes.</dd>
    </dl>
</main>
</body>
</html>
