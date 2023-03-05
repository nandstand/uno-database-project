/*
Christian Fuller
CSCI 4125
Source submission for Phase 3, Task 2
*/


import java.util.*;
import java.io.*;

public class Phase3 {
    public static void main(String[] args){
        //Make sure you didn't forget to pass the table name
        if (args.length == 0){
            System.out.println("You forget to pass a table name!");
            return;
        }

        String tableName = args[0]; // store the table name in a variable

        try{
            File infile = new File(String.format("%s.csv", tableName)); // In this project, the table names will match the input .csv files.
            FileWriter outfile = new FileWriter(String.format("%s.sql", tableName)); // We will also name our output .sql files accordingly.

            Scanner input = new Scanner(infile);
            while (input.hasNextLine()){ //read through the file line-by-line
                String line = input.nextLine();
                String output = getSQLInsert(tableName, line); // I created a separate method to generate my insert statements.
                outfile.write(output);
            }
            outfile.close();
        } catch (FileNotFoundException e){
            System.out.println(e.getMessage());
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    } // end main

    public static String getSQLInsert(String tableName, String line){
        String insertTemplate = "INSERT INTO %s VALUES(%s);\n"; //I used placeholders to simply place my table name and correctly formatted values into an insert statement.
        LinkedList<String> values = new LinkedList<>(); // list to contain formatted tokens

        String[] tokens = line.split(","); // split tokens using comma as delimiter

        for (String token : tokens) {
            token = token.trim();
            if (checkIfNumeric(token)) {
                values.add(token); // token is numeric, no formatting needed
            } else if (token.equals("NULL")) {
                values.add(token); // token is NULL, no formatting needed
            } else {
                values.add(String.format("'%s'", token)); // token is String, wrap in single quotes
            }
        }

        String formattedValues = String.join(", ", values);
        return String.format(insertTemplate, tableName, formattedValues);
    } // end getSQLInsert

    private static boolean checkIfNumeric(String s) {
        try {
            Integer.parseInt(s);
        } catch (NumberFormatException e) {
            return false;
        }
        return true;
    } // end checkIfNumeric
}
