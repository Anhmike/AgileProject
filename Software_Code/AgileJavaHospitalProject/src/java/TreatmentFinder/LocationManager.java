/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package TreatmentFinder;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Provides methods to aid with finding locations/distances needed for sorting search
 * @author Robert
 */
public class LocationManager {
    /*
    * @param userInput location user has entered to be forward geocoded to get coordinates
    @returns coordinates as a JSON Array
    */
    public JSONArray getUserCoordinates(String userInput) {
        JSONArray coordinates =null;
        try {
            URLConnection connection = new URL("https://api.mapbox.com/geocoding/v5/mapbox.places/" + URLEncoder.encode(userInput, "UTF-8") + ".json?access_token=pk.eyJ1IjoidGVhbTE1YWdpbGUiLCJhIjoiY2s1djVyOTJnMDh2czNsbGIxaG05NnI5bSJ9.xY_RVRU92qjmMJ0QCkrodw").openConnection();
            connection.setRequestProperty("Accept-Charset", "UTF-8");
            InputStream resp = connection.getInputStream();
            
            Scanner sc = new Scanner(resp);
            //Reading line by line from scanner to StringBuffer
            StringBuffer sb = new StringBuffer();
            while(sc.hasNext()){
                sb.append(sc.nextLine());
            }
            
            JSONObject jsonObject = new JSONObject(sb.toString());
            coordinates = jsonObject.getJSONArray("features").getJSONObject(0).getJSONObject("geometry").getJSONArray("coordinates");
        } catch (IOException ex) {
            Logger.getLogger(LocationManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        return coordinates;
    }
    
    /*
    @param result list of results from DB query
    @param maxDistance maximum distance user has specified they are willing to travel
    @param coordsList coordinates from geocoder
    @return list of results in the specified distance sorted by distance
    */
    public List<Procedure> findProvidersInRange(List<Procedure> result, int maxDistance, JSONArray coordsList) { 
        List<Procedure> display = new ArrayList();
        
        if(maxDistance == 0)
            {
                maxDistance = 100;
            }
        
        for(Procedure obj : result)
                {
                    double miles = Helper.distance(coordsList.getDouble(1), obj.getLatitude(), coordsList.getDouble(0), obj.getLongitude(), 0.0, 0.0) / 1609;
                    if(miles < maxDistance)
                    {
                        obj.setDistance(miles);
                        display.add(obj);
                    }
                    
                }
        
        Collections.sort(display, new Comparator<Procedure>() {
            @Override
            public int compare(Procedure u1, Procedure u2) {
                Double num = u1.getDistance();
              return num.compareTo(u2.getDistance());
            }
          });
        return display;
    }
    
}
