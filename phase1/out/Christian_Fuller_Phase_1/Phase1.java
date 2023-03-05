/*
Christian Fuller
CSCI 4125
Source submission for Phase 1
*/

import java.util.*;
import java.io.*;

public class Phase1 {
    public static void main(String[] args) {
        try {
            // io setup
            FileWriter out = new FileWriter("out.txt");
            File in = new File("phase1.csv");
            Scanner sc = new Scanner(in);

            // main loop
            while (sc.hasNextLine()) {
                String line = sc.nextLine();
                out.write(evalDataTypes(line)); // split into tokens and evaluate types
                if (sc.hasNextLine())
                    out.write("\n");
            }
            // io close
            out.close();
            sc.close();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }  // end main



    private static String evalDataTypes(String line) {
        String[] tokens = line.split(","); // split tokens using comma as delimiter
        LinkedList<String> types = new LinkedList<String>();

        for (String token : tokens) {
            token = token.trim();
            if (checkIfNumeric(token)) // uses Integer.parseInt()
                types.add("Integer");
            else
                types.add("String");
        }
        return String.join(", ", types);
    } // end evalDataTypes



    private static boolean checkIfNumeric(String s) {
        try {
            Integer.parseInt(s);
        } catch (NumberFormatException e) {
            return false;
        }
        return true;
    } // end checkIfNumeric
}
