/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package TreatmentFinder;

import java.util.List;
import org.json.JSONArray;

/**
 *
 * @author melvinabraham
 */
public class Helper {
    /**
 * Calculate distance between two points in latitude and longitude taking
 * into account height difference. If you are not interested in height
 * difference pass 0.0. Uses Haversine method as its base.
 * 
 * lat1, lon1 Start point lat2, lon2 End point el1 Start altitude in meters
 * el2 End altitude in meters
 * @returns Distance in Meters
 */
    public static double distance(double lat1, double lat2, double lon1,
        double lon2, double el1, double el2) {

    final int R = 6371; // Radius of the earth

    double latDistance = Math.toRadians(lat2 - lat1);
    double lonDistance = Math.toRadians(lon2 - lon1);
    double a = Math.sin(latDistance / 2) * Math.sin(latDistance / 2)
            + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
            * Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);
    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    double distance = R * c * 1000; // convert to meters

    double height = el1 - el2;

    distance = Math.pow(distance, 2) + Math.pow(height, 2);

    return Math.sqrt(distance);
}
    
    public List<Procedure> getResult(String search, String price, String searchBy) { 
        Database newDB = new Database();
        double priceNum = Double.parseDouble(price);
        String query;
        if (searchBy.equals("code")) {
            query = "call lol.searchByCode(\"" + search +"\","+ priceNum + ")";
        }
        else {
            query = "call lol.searchByDesc(\"" + search +"\","+ priceNum + ")";
        }
        
         List<Procedure> result = newDB.dbQuery(query);
         
         return result;
    }
    
    public JSONArray getCoordinates(String location, String latitude, String longitude) {
        JSONArray coordinates;
        LocationManager lManager = new LocationManager();
        if( location != null && !location.isEmpty()) {
                 coordinates = lManager.getUserCoordinates(location);
            }
            else {
                double lat = Double.parseDouble(latitude);
                double lon = Double.parseDouble(longitude);
                
                double[] coArr = {lon, lat};
                coordinates = new JSONArray(coArr);
            }
        
        return coordinates;
    }
    
    public List<Procedure> getListInRange(String search, String price, String searchBy, String location, String lat, String lon, String maxDist) { 
        LocationManager lManager = new LocationManager();
        int maxDistNum = Integer.parseInt(maxDist);
        List<Procedure> allResult = getResult(search, price, searchBy);
        JSONArray coordinates = getCoordinates(location, lat, lon);
        List<Procedure> filteredResult = lManager.findProvidersInRange(allResult, maxDistNum, coordinates);
        
        return filteredResult;
    }
    
}
