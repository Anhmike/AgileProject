/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package TreatmentFinder;
import java.sql.*;
import java.util.List;
import static junit.framework.Assert.*;
import org.junit.Test;
import org.junit.*;


/**
 *
 * @author Robert
 */
public class DatabaseTest {
    
    public DatabaseTest() {
        
    }
    
    public static void setUpClass() {
    }
    
    public static void tearDownClass() {
    }
    
    public void setUp() {
    }
    

    public void tearDown() {
    }

    @Test
    public void testdbConnect() {
        Database test = new Database();
        Connection con = test.dbConnect();
        assertNotNull("Connection to database test", con);
    }
    
    @Test
    public void testdbQuery() {
        Database test = new Database();
        List<String> result = test.dbQuery("SELECT * FROM lol.operations");
        assertFalse("Query Database test", result.isEmpty());
    }
}
