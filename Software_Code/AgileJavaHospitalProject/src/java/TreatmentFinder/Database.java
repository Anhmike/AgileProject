package TreatmentFinder;
import java.sql.*;
/**
 *
 * @author Robert
 */
public class Database {
    public boolean dbConnect() {
        Connection connect = null;
        String result = "";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connect = DriverManager
                    .getConnection("jdbc:mysql://51.137.144.220/lol?" + "user=root&password=password");

            return true;
        }
        catch (Exception E) {
            return false;
    }
}
    public void queryDB() {
//            Statement stmt = connect.createStatement();
//            ResultSet rs = stmt.executeQuery("SELECT * FROM lol.operations");
//            while (rs.next())
//            {
//              String name = rs.getString("Provider_Name");
//              result = result + " " + name;
//            }
//            rs.close();
//            stmt.close();
    }
}
