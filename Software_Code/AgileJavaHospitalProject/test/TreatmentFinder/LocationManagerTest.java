/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package TreatmentFinder;

import java.util.List;
import org.json.JSONArray;
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
public class LocationManagerTest {
    
    public LocationManagerTest() {
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
     * Test of getUserCoordinates method, of class LocationManager.
     */
    @Test
    public void testGetUserCoordinates() {
        System.out.println("getUserCoordinates");
        String userInput = "";
        LocationManager instance = new LocationManager();
        JSONArray expResult = null;
        JSONArray result = instance.getUserCoordinates(userInput);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of findProvidersInRange method, of class LocationManager.
     */
    @Test
    public void testFindProvidersInRange() {
        System.out.println("findProvidersInRange");
        List<Procedure> result_2 = null;
        int maxDistance = 0;
        JSONArray coordsList = null;
        LocationManager instance = new LocationManager();
        List<Procedure> expResult = null;
        List<Procedure> result = instance.findProvidersInRange(result_2, maxDistance, coordsList);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
    
}
