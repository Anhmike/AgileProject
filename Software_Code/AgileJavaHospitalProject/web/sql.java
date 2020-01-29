/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package TreatmentFinder;

/**
 *
 * @author fengqu
 */
public class sql {
    
    public static String selectAll = "SELECT * FROM lol.operations";
    
    public static String selectInIndex(String healthCare,int budget)
    {
        if (healthCare.equals("Heart"))
            return "SELECT * FROM lol.operations where DRG_Definition LIKE '001%' AND Average_Total_Payments < "+budget+" order by Average_Total_Payments desc";
        
        
        else
            return "";
    }
    
    
    public static String selectByCode(int code)
    {
        return "SELECT * FROM lol.operations where Provider_Id = "+code;
    }
    
    
}
