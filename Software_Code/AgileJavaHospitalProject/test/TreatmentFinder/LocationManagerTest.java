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
        LocationManager test = new LocationManager();
        JSONArray coords1 = test.getUserCoordinates("6 The Logan, Liff, Scotland");
        
        
        assertEquals(coords1.getDouble(0), -3.085410, 1);
        assertEquals(coords1.getDouble(1), 56.486791, 1);
    }

    /**
     * Test of findProvidersInRange method, of class LocationManager.
     */
    @Test
    public void testFindProvidersInRange() {
        Database testDb = new Database();
        LocationManager testLocation = new LocationManager();
        List<Procedure> test = testDb.dbQuery("call lol.searchByDesc('Heart Transplant', 500000)");
        JSONArray coords = testLocation.getUserCoordinates("1719 Towne Drive, West Chester PA");
        List<Procedure> procedures = testLocation.findProvidersInRange(test, 50, coords);
        
        assertEquals(procedures.get(0).getTotalPayments(), 304934.0, 1);
    }
    
}
