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
        //Point 1
        //56.457025, -2.995702
        double lon1 = -2.995702;
        double lat1 = 56.457025;
        double el1 = 0.0;
        
        //Point 2
        //56.486758, -3.085351
        double lon2 = -3.085351;
        double lat2 = 56.486758;
        double el2 = 0.0;
        
        
        double expResult =  6420.0;
        double result = Helper.distance(lat1, lat2, lon1, lon2, el1, el2);
        assertEquals(expResult, result,5.0);


    }
    
}
