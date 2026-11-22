Sam Dirr
CSD430 Modules 5.3 and 6.3
Movie Database READ Application
November 22, 2026

PURPOSE
Select a database primary key from a JSP dropdown and display the matching movie
in a six-column HTML table. Java runs inside scriptlets; HTML markup stays outside
them. The JSP uses MovieDatabaseBean for JDBC access and MovieBean for record data.

REQUIREMENTS
JDK 17 or later, Apache Tomcat 10.1, and local MySQL on port 3306.
MySQL Connector/J 8.0.33 is included in WEB-INF/lib and was verified with the local
MySQL 9.6 server. Its upstream license notices are retained inside the JAR.
The local course connection uses database CSD430, username student1, password pass.
The table name is sammoviesdata, matching the database assignment.

DATABASE
If continuing from the database assignment, do not repopulate or drop your table.
For a fresh installation, an administrator runs sql/samcreateTable.sql to establish
the database, table, account, and permissions. Existing account passwords are
preserved; the administrator must ensure student1 uses the required password pass.
Run sql/sampopulateTable.sql once to insert ten movies.
Permissions are granted by the SQL administrator, never by the JavaBean.

BUILD AND DEPLOY
The compiled Java classes are included with the complete Java source.
To rebuild, open Terminal in this project folder and run:
    sh build.sh
Copy this project folder into your Tomcat webapps directory as module-5_6.
Start Tomcat and visit:
    http://localhost:8080/module-5_6/index.jsp
Use your configured Tomcat port if it differs from 8080.
Select Find a Movie, choose an ID, and press View Movie.

JAVA TABLE MANAGEMENT FOR THE INSTRUCTOR
From this project folder, after the database and account permissions exist:
    java -cp 'WEB-INF/classes:WEB-INF/lib/*' movies.DatabaseSetup create
    java -cp 'WEB-INF/classes:WEB-INF/lib/*' movies.DatabaseSetup populate
The first command preserves an existing table. Populate is intended for an empty
table and rolls back the insertion if a duplicate key or other SQL error occurs.
The following command removes the table and ALL its movie records:
    java -cp 'WEB-INF/classes:WEB-INF/lib/*' movies.DatabaseSetup drop-confirmed
Only run it when intentionally deleting the table. Then create and populate can
rebuild it. The SQL equivalents are also included in the sql folder.
On Windows, replace the classpath colon with a semicolon.

SOURCE FILES
index.jsp                          Module deliverable links
read.jsp                           Key dropdown, validation, and movie table
styles.css                         Responsive presentation
WEB-INF/src/movies/MovieBean.java   Six-field JavaBean
WEB-INF/src/movies/MovieDatabaseBean.java
                                   JDBC key listing and prepared record query
WEB-INF/src/movies/DatabaseSetup.java
                                   Java create/populate/drop entry point
sql/samcreateTable.sql              Database/account setup and table creation
sql/sampopulateTable.sql            Ten records and verification queries
sql/samdropTable.sql                Intentional table deletion

SOURCE CREDIT
Generated with assistance from OpenAI ChatGPT, November 22, 2026:
https://chatgpt.com/
Course context: Bellevue University Modules 5 and 6 CRUD examples.
MySQL Connector/J is an Oracle dependency, not student-authored code.
