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
public class ProcedureTest {
    private Procedure test;
    public ProcedureTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
        test= new Procedure("023", 
                                                10001, 
                                                "Ninewells", 
                                                "6 The Logan, Liff Dundee", 
                                                "Dundee", 
                                                "Scotland", 
                                                62324, 
                                                "June", 
                                                234234, 
                                                1234.5678, 
                                                4321.8765);
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of getDRG method, of class Procedure.
     */
    @Test
    public void testGetDRG() {
        System.out.println("getDRG");
        assertEquals(test.getDRG(),"023");
    }

    /**
     * Test of getProviderId method, of class Procedure.
     */
    @Test
    public void testGetProviderId() {
        System.out.println("getProviderId");
        assertEquals(test.getProviderId(),10001);
    }

    /**
     * Test of getProviderName method, of class Procedure.
     */
    @Test
    public void testGetProviderName() {
        System.out.println("getProviderName");
        assertEquals(test.getProviderName(),"Ninewells");
    }

    /**
     * Test of getProviderStreetAddress method, of class Procedure.
     */
    @Test
    public void testGetProviderStreetAddress() {
        System.out.println("getProviderStreetAddress");
        assertEquals(test.getProviderStreetAddress(),"6 The Logan, Liff Dundee");
    }

    /**
     * Test of getProviderCity method, of class Procedure.
     */
    @Test
    public void testGetProviderCity() {
        System.out.println("getProviderCity");
        assertEquals(test.getProviderCity(),"Dundee");
    }

    /**
     * Test of getProviderState method, of class Procedure.
     */
    @Test
    public void testGetProviderState() {
        System.out.println("getProviderState");
        assertEquals(test.getProviderState(),"Scotland");
    }

    /**
     * Test of getProviderZipCode method, of class Procedure.
     */
    @Test
    public void testGetProviderZipCode() {
        System.out.println("getProviderZipCode");
        assertEquals(test.getProviderZipCode(),62324);
    }

    /**
     * Test of getHRR method, of class Procedure.
     */
    @Test
    public void testGetHRR() {
        System.out.println("getHRR");
        assertEquals(test.getHRR(),"June");
    }

    /**
     * Test of getTotalPayments method, of class Procedure.
     */
    @Test
    public void testGetTotalPayments() {
        System.out.println("getTotalPayments");
        assertEquals(test.getTotalPayments(),234234,0);
    }

    /**
     * Test of getLongitude method, of class Procedure.
     */
    @Test
    public void testGetLongitude() {
        System.out.println("getLongitude");
        assertEquals(test.getLongitude(),1234.5678,0);
    }

    /**
     * Test of getLatitude method, of class Procedure.
     */
    @Test
    public void testGetLatitude() {
        System.out.println("getLatitude");
        assertEquals(test.getLatitude(),4321.8765,0);                      
    }
    
    /**
     * Test of setDRG method, of class Procedure.
     */
    @Test
    public void testSetDRG() {
        System.out.println("setDRG");
        test.setDRG("789");
       assertEquals(test.getDRG(), "789");
    }

    /**
     * Test of setProviderId method, of class Procedure.
     */
    @Test
    public void testSetProviderId() {
        System.out.println("setProviderId");
        test.setProviderId(12345);
        assertEquals(test.getProviderId(), 12345);
    }

    /**
     * Test of setProviderName method, of class Procedure.
     */
    @Test
    public void testSetProviderName() {
        System.out.println("setProviderName");
        test.setProviderName("ABC");
        assertEquals(test.getProviderName(), "ABC");
    }

    /**
     * Test of setProviderStreetAddress method, of class Procedure.
     */
    @Test
    public void testSetProviderStreetAddress() {
        System.out.println("setProviderStreetAddress");
        test.setProviderStreetAddress("456 EDF Road");
        assertEquals(test.getProviderStreetAddress(), "456 EDF Road");
    }

    /**
     * Test of setProviderCity method, of class Procedure.
     */
    @Test
    public void testSetProviderCity() {
        System.out.println("setProviderCity");
        test.setProviderCity("Edinburgh");
        assertEquals(test.getProviderCity(), "Edinburgh");
    }

    /**
     * Test of setProviderState method, of class Procedure.
     */
    @Test
    public void testSetProviderState() {
        System.out.println("setProviderState");
        test.setProviderState("California");
        assertEquals(test.getProviderState(), "California");
    }

    /**
     * Test of setpProviderZipCode method, of class Procedure.
     */
    @Test
    public void testSetpProviderZipCode() {
        System.out.println("setpProviderZipCode");
        test.setpProviderZipCode(90210);
        assertEquals(test.getProviderZipCode(), 90210);
    }

    /**
     * Test of setHRR method, of class Procedure.
     */
    @Test
    public void testSetHRR() {
        System.out.println("setHRR");
        test.setHRR("CA-Edinburgh");
        assertEquals(test.getHRR(), "CA-Edinburgh");
    }

    /**
     * Test of setTotalPayments method, of class Procedure.
     */
    @Test
    public void testSetTotalPayments() {
        System.out.println("setTotalPayments");
        test.setTotalPayments(7891);
        assertEquals(test.getTotalPayments(), 7891, 0);
    }

    /**
     * Test of setLongitude method, of class Procedure.
     */
    @Test
    public void testSetLongitude() {
        System.out.println("setLongitude");
        test.setLongitude(3455.55);
        assertEquals(test.getLongitude(), 3455.55, 0);
    }

    /**
     * Test of setLatitude method, of class Procedure.
     */
    @Test
    public void testSetLatitude() {
        System.out.println("setLatitude");
        test.setLatitude(-3455.55);
        assertEquals(test.getLatitude(), -3455.55, 0);
    }

    /**
     * Test of setDistance method, of class Procedure.
     */
    @Test
    public void testSetDistance() {
        System.out.println("setDistance");
        test.setDistance(10.22);
        assertEquals(test.getDistance(), 10.22, 0);
    }
    
}
