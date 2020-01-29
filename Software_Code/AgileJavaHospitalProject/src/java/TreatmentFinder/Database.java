
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
    public List<hospital> dbQuery(String query) {
        List<hospital> result = new ArrayList<hospital>();
        Connection connect = dbConnect();
        
                                
        try {
            Statement stmt = connect.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            

            while (rs.next())
            {
                            
                hospital hospital = new hospital();
                String name = rs.getString("Provider_Name");
                int id = rs.getInt("Provider_Id");
                String DRG = rs.getString("DRG_Definition");
                String street = rs.getString("Provider_Street_Address");
                String city = rs.getString("Provider_City");
                String state = rs.getString("Provider_State");
                String zipCode = rs.getString("Provider_Zip_Code");
                String HRR = rs.getString("HRR_Description");
                String charges = rs.getString("Average_Total_Payments");
                hospital.setDRG(DRG);
                hospital.setProviderId(id);
                hospital.setProviderName(name);
                hospital.setProviderStreetAddress(street);
                hospital.setProviderCity(city);
                hospital.setProviderState(state);
                hospital.setpProviderZipCode(zipCode);
                hospital.setHRR(HRR);
                hospital.setTotalPayments(charges);

                result.add(hospital);
            }
            rs.close();
            stmt.close();
            
            

        }
        catch (Exception e) {
            
        }
        
        return result;
    }
}

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
 * @return A list object of strings that are Procedure names
 */
    public List<Procedure> dbQuery(String query) {
        List<Procedure> result = new ArrayList<Procedure>();
        Connection connect = dbConnect();
        
                                
        try {
            Statement stmt = connect.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            

            while (rs.next())
            {
                            
                
                String name = rs.getString("Provider_Name");
                int id = rs.getInt("Provider_Id");
                String DRG = rs.getString("DRG_Definition");
                String street = rs.getString("Provider_Street_Address");
                String city = rs.getString("Provider_City");
                String state = rs.getString("Provider_State");
                int zipCode = rs.getInt("Provider_Zip_Code");
                String HRR = rs.getString("HRR_Description");
                float charges = rs.getFloat("Average_Total_Payments");
                
                Procedure proc1 = new Procedure(DRG,id, name, street, city, state, zipCode, HRR, charges );


                result.add(proc1);
            }
            rs.close();
            stmt.close();
            
            

        }
        catch (Exception e) {
            
        }
        
        return result;
    }
}

