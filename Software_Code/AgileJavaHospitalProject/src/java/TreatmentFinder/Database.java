package TreatmentFinder;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 * Class to handle Database operations
 * @author Robert
 */
public class Database {
 /**
 * @return a connection to the database if successful, otherwise will return null
 */
    public Connection dbConnect() {
        Connection connect = null;
        String result = "";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connect = DriverManager
                    .getConnection("jdbc:mysql://51.137.144.220/lol?" + "user=root&password=password");
        }
        catch (Exception e) {
            
    }
        return connect;
}
 /**
  * Aim for this method is to have a list of a new class type - eg Procedure
  * This would then allow for this to be iterated in the .jsp file and have the
  * desired attributes printed out/processed further.
 * @param query the desired DB query as a string
 * @return A list object of strings that are hospital names
 */
    public List<String> dbQuery(String query) {
        List<String> result = new ArrayList<String>();
        Connection connect = dbConnect();
        try {
            Statement stmt = connect.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next())
            {
                String name = rs.getString("Provider_Name");
                result.add(name);
            }
            rs.close();
            stmt.close();
        }
        catch (Exception e) {
            
        }
        return result;
    }
}
