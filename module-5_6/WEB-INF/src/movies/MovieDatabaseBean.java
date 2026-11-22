/*
 * Sam Dirr | CSD430 | Modules 5.3 and 6.3 | November 22, 2026
 * Source: Generated with assistance from OpenAI ChatGPT (https://chatgpt.com/).
 * Course context: Bellevue University Modules 5 and 6 CRUD examples.
 */
package movies;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/** Reads movie primary keys and individual records through JDBC. */
public class MovieDatabaseBean implements Serializable {
    private static final long serialVersionUID = 1L;
    // Course credentials for a local MySQL instance only.
    private static final String URL = "jdbc:mysql://localhost:3306/CSD430"
            + "?sslMode=DISABLED&allowPublicKeyRetrieval=true&serverTimezone=UTC";

    public MovieDatabaseBean() { }

    public Connection openConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException exception) {
            throw new SQLException("MySQL Connector/J is missing from WEB-INF/lib.", exception);
        }
        return DriverManager.getConnection(URL, "student1", "pass");
    }

    /** Returns every key in numeric order for the JSP dropdown menu. */
    public List<Integer> getMovieIds() throws SQLException {
        List<Integer> movieIds = new ArrayList<>();
        String sql = "SELECT movie_id FROM sammoviesdata ORDER BY movie_id";
        try (Connection connection = openConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet results = statement.executeQuery()) {
            while (results.next()) {
                movieIds.add(results.getInt("movie_id"));
            }
        }
        return movieIds;
    }

    /** Uses a parameterized query and closes all JDBC resources on every request. */
    public MovieBean findMovie(int movieId) throws SQLException {
        String sql = "SELECT movie_id, title, director, release_year, genre, "
                + "runtime_minutes FROM sammoviesdata WHERE movie_id = ?";
        try (Connection connection = openConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, movieId);
            try (ResultSet results = statement.executeQuery()) {
                if (!results.next()) {
                    return null;
                }
                MovieBean movie = new MovieBean();
                movie.setMovieId(results.getInt("movie_id"));
                movie.setTitle(results.getString("title"));
                movie.setDirector(results.getString("director"));
                movie.setReleaseYear(results.getInt("release_year"));
                movie.setGenre(results.getString("genre"));
                movie.setRuntimeMinutes(results.getInt("runtime_minutes"));
                return movie;
            }
        }
    }
}
