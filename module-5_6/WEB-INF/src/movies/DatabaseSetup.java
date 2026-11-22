/*
 * Sam Dirr | CSD430 | Modules 5.3 and 6.3 | November 22, 2026
 * Source: Generated with assistance from OpenAI ChatGPT (https://chatgpt.com/).
 * Course context: Bellevue University Modules 5 and 6 CRUD examples.
 */
package movies;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

/** Creates, populates, or intentionally drops the course table from Java. */
public class DatabaseSetup {
    private static final Object[][] MOVIES = {
        {1, "Toy Story", "John Lasseter", 1995, "Animation", 81},
        {2, "Finding Nemo", "Andrew Stanton", 2003, "Animation", 100},
        {3, "The Incredibles", "Brad Bird", 2004, "Animation", 115},
        {4, "Ratatouille", "Brad Bird", 2007, "Animation", 111},
        {5, "WALL-E", "Andrew Stanton", 2008, "Science Fiction", 98},
        {6, "Up", "Pete Docter", 2009, "Adventure", 96},
        {7, "Inside Out", "Pete Docter", 2015, "Animation", 95},
        {8, "Coco", "Lee Unkrich", 2017, "Fantasy", 105},
        {9, "Soul", "Pete Docter", 2020, "Fantasy", 100},
        {10, "Luca", "Enrico Casarosa", 2021, "Adventure", 95}
    };

    public static void main(String[] arguments) throws SQLException {
        if (arguments.length != 1 || !("create".equals(arguments[0])
                || "populate".equals(arguments[0]) || "drop-confirmed".equals(arguments[0]))) {
            System.err.println("Usage: java movies.DatabaseSetup create|populate|drop-confirmed");
            System.exit(1);
        }
        // Database/account grants are configured externally with samcreateTable.sql.
        try (Connection connection = new MovieDatabaseBean().openConnection()) {
            switch (arguments[0]) {
                case "create":
                    createTable(connection);
                    System.out.println("Table sammoviesdata is available.");
                    break;
                case "populate":
                    populateTable(connection);
                    System.out.println("Inserted 10 movie records.");
                    break;
                default:
                    try (Statement statement = connection.createStatement()) {
                        statement.executeUpdate("DROP TABLE IF EXISTS sammoviesdata");
                    }
                    System.out.println("Dropped sammoviesdata and its records.");
            }
        }
    }

    private static void createTable(Connection connection) throws SQLException {
        String sql = "CREATE TABLE IF NOT EXISTS sammoviesdata ("
                + "movie_id INT NOT NULL, title VARCHAR(150) NOT NULL, "
                + "director VARCHAR(100) NOT NULL, release_year SMALLINT UNSIGNED NOT NULL, "
                + "genre VARCHAR(50) NOT NULL, runtime_minutes SMALLINT UNSIGNED NOT NULL, "
                + "PRIMARY KEY (movie_id)) ENGINE=InnoDB "
                + "DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";
        try (Statement statement = connection.createStatement()) {
            statement.executeUpdate(sql);
        }
    }

    private static void populateTable(Connection connection) throws SQLException {
        String sql = "INSERT INTO sammoviesdata "
                + "(movie_id, title, director, release_year, genre, runtime_minutes) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        connection.setAutoCommit(false);
        // All ten inserts succeed together; duplicate IDs cause rollback, not overwrites.
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            for (Object[] movie : MOVIES) {
                statement.setInt(1, (Integer) movie[0]);
                statement.setString(2, (String) movie[1]);
                statement.setString(3, (String) movie[2]);
                statement.setInt(4, (Integer) movie[3]);
                statement.setString(5, (String) movie[4]);
                statement.setInt(6, (Integer) movie[5]);
                statement.addBatch();
            }
            statement.executeBatch();
            connection.commit();
        } catch (SQLException exception) {
            connection.rollback();
            throw exception;
        } finally {
            connection.setAutoCommit(true);
        }
    }
}
