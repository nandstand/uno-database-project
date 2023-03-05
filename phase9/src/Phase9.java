// Christian Fuller
// CSCI 4125
// Phase 9


import java.util.*;
import java.io.*;
import java.sql.*;

public class Phase9 {
    public static void main(String[] args) {

        String delete = "DELETE FROM Dependent";
        String query = "SELECT * FROM Dependent";
        String insert = "INSERT INTO Dependent VALUES(?, ?, ?)";

        try {

            // get csv file
            if (args.length == 0){
                System.out.println("You forget to pass a table name!");
                return;
            }

            String tableName = args[0];
            File infile = new File(String.format("%s.csv", tableName));



            // set up / establish oracle database connection
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection(
                    "jdbc:oracle:thin:@dbserver.cs.uno.edu:1521/ORCL", "cfuller1", "QZF45JFd");


            // delete records from dependent table
            PreparedStatement prepared = connection.prepareStatement(delete);
            prepared.executeUpdate();


            // read from csv and insert into database using prepared statement
            Scanner input = new Scanner(infile);
            prepared = connection.prepareStatement(insert);

            while (input.hasNextLine()) {

                String line = input.nextLine();
                String[] tokens = line.split(",");

                String buyerSSN = String.format("%s", tokens[0].trim());
                String dependentName = String.format("%s", tokens[1].trim());
                int dependentAge = Integer.parseInt(tokens[2].trim());

                prepared.setString(1, buyerSSN);
                prepared.setString(2, dependentName);
                prepared.setInt(3, dependentAge);

                prepared.executeUpdate();

            }



            // query dependent table and print each record to console
            prepared = connection.prepareStatement(query);
            ResultSet result = prepared.executeQuery();


            while (result.next()) {
                System.out.print(result.getString(1) + " ");
                System.out.print(result.getString(2) + " ");
                System.out.print(result.getString(3));
                System.out.print("\n");
            }

            connection.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

