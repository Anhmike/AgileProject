/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package TreatmentFinder;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Robert
 */
public class HelperTest {
    
    public HelperTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of distance method, of class Helper.
     */
    @Test
    public void testDistance() {
        System.out.println("distance");
        double lat1 = 0.0;
        double lat2 = 0.0;
        double lon1 = 0.0;
        double lon2 = 0.0;
        double el1 = 0.0;
        double el2 = 0.0;
        double expResult = 0.0;
        double result = Helper.distance(lat1, lat2, lon1, lon2, el1, el2);
        assertEquals(expResult, result, 0.0);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
    
}
