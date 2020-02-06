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
    
    @Test
    public void testGetResult() {
        Helper test = new Helper();
        String search = "023";
        String searchBy = "code";
        String price = "500000";
        List<Procedure> resultTest = test.getResult(search, price, searchBy);
        assertNotNull("testing result set to see if null", resultTest);
        assertEquals(resultTest.get(0).getProviderId(), 260104);
    }
    
    
    @Test 
    public void testGetCoordinates() { 
         Helper test = new Helper();
         String location = "1108 Ross Clark Circle, Dothan, Alabama 36301, United States";
         String longitude = "";
         String latitude = "";
         JSONArray coords = test.getCoordinates(location, latitude, longitude);
         double expectedArr[] = {-85.36300799999304,31.21586106118295};
         JSONArray expected = new JSONArray(expectedArr);
         
         assertNotNull("Checking geocoded coordinates are not null", coords);
         assertEquals("Checking first coordinate geocoded is within 0.1 of expected result",coords.getDouble(0), expected.getDouble(0), 0.1);
         assertEquals("Checking second coordinate geocoded is within 0.1 of expected result",coords.getDouble(1), expected.getDouble(1), 0.1);
    }
    
    @Test
    public void testGetListInRange() { 
        Helper test = new Helper();
        String search = "023";
        String searchBy = "code";
        String price = "500000";
        String location = "535 Market St, San Francisco";
        String lon = "";
        String lat = "";
        String maxDist = "50";
        List<Procedure> filteredList = test.getListInRange(search, price, searchBy, location, lat, lon, maxDist);
        
        assertNotNull("checking filtered list is not null", filteredList);
        assertEquals(filteredList.get(0).getProviderId(), 50008);
    }
    
}
