/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package TreatmentFinder;
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
        boolean connected = test.dbConnect();
        assertTrue("Connection to database test", connected);
    }
}
