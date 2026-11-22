/*
 * Sam Dirr | CSD430 | Modules 5.3 and 6.3 | November 22, 2026
 * Source: Generated with assistance from OpenAI ChatGPT (https://chatgpt.com/).
 * Course context: Bellevue University Modules 5 and 6 CRUD examples.
 */
package movies;

import java.io.Serializable;

/** Holds all six fields of one movie record for the JSP display. */
public class MovieBean implements Serializable {
    private static final long serialVersionUID = 1L;
    private int movieId;
    private String title;
    private String director;
    private int releaseYear;
    private String genre;
    private int runtimeMinutes;

    public MovieBean() { }

    public int getMovieId() { return movieId; }
    public void setMovieId(int movieId) { this.movieId = movieId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDirector() { return director; }
    public void setDirector(String director) { this.director = director; }
    public int getReleaseYear() { return releaseYear; }
    public void setReleaseYear(int releaseYear) { this.releaseYear = releaseYear; }
    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }
    public int getRuntimeMinutes() { return runtimeMinutes; }
    public void setRuntimeMinutes(int runtimeMinutes) { this.runtimeMinutes = runtimeMinutes; }
}
