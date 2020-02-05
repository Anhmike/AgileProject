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
        Database db = new Database();
        Connection con = db.dbConnect();
        String query="call lol.searchByDesc('Heart Transplant', 500000)";
        List<Procedure> result = db.dbQuery(query);
        assertEquals(result.get(0).getProviderId(), 40114);
        
    }
}
