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

    @BeforeClass
    public static void setUpClass() throws Exception {
    }

    @AfterClass
    public static void tearDownClass() throws Exception {
    }

    @Before
    public void setUp() throws Exception {
    }

    @After
    public void tearDown() throws Exception {
    }
    

    @Test
    public void testdbConnect() {
        Database test = new Database();
        Connection con = test.dbConnect();
        assertNotNull("Connection to database test", con);
    }
    

    /**
     * Test of dbQuery method, of class Database.
     */
    @Test
    public void testDbQuery() {
        System.out.println("Testing the database query");
        String query = "SELECT * FROM lol.operations";
        //Setup test procedure
        Procedure test= new Procedure("023 - CRANIOTOMY W MAJOR DEVICE IMPLANT OR ACUTE CNS PDX W MCC OR CHEMOTHE",
                                     10001,
                                     "SOUTHEAST ALABAMA MEDICAL CENTER",
                                     "1108 ROSS CLARK CIRCLE",
                                     "DOTHAN",
                                     "AL",
                                     36301,
                                     "AL - Dothan",
                                     25823.71429f);
        
        Database instance = new Database();
         
        List<Procedure> result = instance.dbQuery(query);
        //assertEquals(test.equals(result.get(0)));/
        assertEquals(test.getDRG(),result.get(0).getDRG());
        // TODO review the generated test code and remove the default call to fail.

    }
}
