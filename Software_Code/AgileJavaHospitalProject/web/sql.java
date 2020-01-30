/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package TreatmentFinder;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 *
 * @author fengqu
 */
public class sql {
    
    public static String selectAll = "SELECT * FROM lol.operations";
    
    public static String selectInIndex(String search,String budget)
    {
        Pattern pattern = Pattern.compile("[0-9]*"); 
        if (!pattern.matcher(budget).matches())  //Search without input budget
            if(pattern.matcher(search).matches())
                if(Integer.parseInt(search)<1000)
                    return "SELECT * FROM lol.operations where DRG_Definition LIKE '"+search+"%' order by Average_Total_Payments desc";
                else
                    return "SELECT * FROM lol.operations where Provider_Id = "+Integer.parseInt(search)+" order by Average_Total_Payments desc";
            else
                 return "call lol.findCode(\"" + search + "\")";
        else    //Search with budget
            return "SELECT * FROM lol.operations where DRG_Definition LIKE '%"+search+"%' AND Average_Total_Payments < "+Float.parseFloat(budget)+" order by Average_Total_Payments desc";

    }
    
    

    
}
