
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="TreatmentFinder.Helper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.Scanner"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.net.URL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="TreatmentFinder.Database"%>

<%@page import="TreatmentFinder.Procedure"%>

<%@page import="TreatmentFinder.sql"%>

<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"  crossorigin="anonymous">

        <title>Search Results</title>
    </head>
    <body>
        <h1>Hello World!</h1>

        
        <table class="table">
  <thead class="thead-dark">
    <tr>
      <th scope="col">#</th>
      <th scope="col">First</th>
      <th scope="col">Last</th>
      <th scope="col">Handle</th>
    </tr>
  </thead>
  <tbody>

        <% 
            String search = "call lol.findCode(\"" + request.getParameter("desc") + "\")";
            int maxDistance = Integer.parseInt(request.getParameter("max-distance"));
            Database test = new Database();
            List<Procedure> result = test.dbQuery(search);
            List<Procedure> display = new ArrayList();
            
            if(request.getParameter("options").equals("1")) { 
                String inputLocation = request.getParameter("location");
                
                
                URLConnection connection = new URL("https://api.mapbox.com/geocoding/v5/mapbox.places/" + URLEncoder.encode(inputLocation, "UTF-8") + ".json?access_token=pk.eyJ1IjoidGVhbTE1YWdpbGUiLCJhIjoiY2s1djVyOTJnMDh2czNsbGIxaG05NnI5bSJ9.xY_RVRU92qjmMJ0QCkrodw").openConnection();
                connection.setRequestProperty("Accept-Charset", "UTF-8");
                InputStream resp = connection.getInputStream();
                
                    Scanner sc = new Scanner(resp);
                //Reading line by line from scanner to StringBuffer
                StringBuffer sb = new StringBuffer();
                while(sc.hasNext()){
                   sb.append(sc.nextLine());
                }

                
                JSONObject jsonObject = new JSONObject(sb.toString());
                JSONArray coordinates = jsonObject.getJSONArray("features").getJSONObject(0).getJSONObject("geometry").getJSONArray("coordinates");
                
//                  lat1, lon1 Start point lat2, lon2 End point el1 Start altitude in meters
//  el2 End altitude in meters
                
               
                for(Procedure obj : result)
                {
                    if(maxDistance == 0)
                    {
                        maxDistance = 100;
                    }
                    
                    ArrayList temp = new ArrayList();
                    temp.add(obj.getProviderId());
                    double miles = Helper.distance(coordinates.getDouble(1), obj.getLatitude(), coordinates.getDouble(0), obj.getLongitude(), 0.0, 0.0) / 1609;
                    temp.add(String.valueOf(miles));
                    if(miles < maxDistance)
                    {
                        obj.setDistance(miles);
                        display.add(obj);
                    }
                    
                }
                
            }
            
            Collections.sort(display, new Comparator<Procedure>() {
            @Override
            public int compare(Procedure u1, Procedure u2) {
                Double num = u1.getDistance();
              return num.compareTo(u2.getDistance());
            }
          });
            
             //Now sorts by distance/ shows distance, but kind of ugly should refactor
             for(Procedure obj : display)
            {
                out.print("<tr>");
                out.print("<td>" + obj.getDRG() + "</td>");
                out.print("<td>" + obj.getProviderName() + "</td>");
                out.print("<td>" + obj.getProviderStreetAddress() + "</td>");
                out.print("<td>" + obj.getProviderCity() + "</td>");
                out.print("<td>" + obj.getProviderState() + "</td>");
                out.print("<td>" + obj.getProviderZipCode() + "</td>");
                out.print("<td>" + obj.getTotalPayments() + "</td>");
                out.print("<td>" + obj.getDistance() + "</td>");
               out.print("</tr>");
            }

        %>
        </tbody>

    </body>
</html>
