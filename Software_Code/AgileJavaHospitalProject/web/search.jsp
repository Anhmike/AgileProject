<%@page import="java.util.ArrayList"%>
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
        <link rel="stylesheet" href="style.css">
         <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"  crossorigin="anonymous">
         <script src='https://api.tiles.mapbox.com/mapbox-gl-js/v1.7.0/mapbox-gl.js'></script>
        <link href='https://api.tiles.mapbox.com/mapbox-gl-js/v1.7.0/mapbox-gl.css' rel='stylesheet' />
        <link rel="stylesheet" href="//cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css"/>
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src='//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js'></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
        <title>Search Results</title>
    </head>
    <body>
        <h1>Search Results</h1>

        <div class="container-fluid">
            <div class="row">
            <div class="col-lg-7">
        <table id="myTable" class="table table-sm table-striped">
  <thead class="thead-dark">
    <tr>
      <th scope="col">Procedure</th>
      <th scope="col">Provider Name</th>
      <th scope="col">Address</th>
      <th scope="col">Zip code</th>
      <th scope="col">Average Cost</th>
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
                out.print("<td>" + obj.getProviderStreetAddress() + ", " + obj.getProviderCity() + ", " + obj.getProviderState() + "</td>");
                out.print("<td>" + obj.getProviderZipCode() + "</td>");
                out.print("<td>" + obj.getTotalPayments() + "</td>");
                out.print("<td>" + obj.getDistance() + "</td>");
               out.print("</tr>");
            }

        %>
        </tbody>
      </table>
            </div>
        <div class="col-lg-4">
             <div id="map">
        </div>
            </div>
       </div>
    </body>
    <script>
        $(document).ready( function () {
            $('#myTable').DataTable();
        } );


        mapboxgl.accessToken = 'pk.eyJ1IjoidGVhbTE1YWdpbGUiLCJhIjoiY2s1djVyOTJnMDh2czNsbGIxaG05NnI5bSJ9.xY_RVRU92qjmMJ0QCkrodw';
        var map = new mapboxgl.Map({
                  container: 'map',
                  style: 'mapbox://styles/mapbox/light-v10',
                  center: [ -99.943118, 32.664761],
                  zoom: 12
                });


        var locations = {
  "type": "FeatureCollection",
  "features": [
    <%
        ArrayList<ArrayList<String>> listOLists = new ArrayList<ArrayList<String>>();
        ArrayList<String> singleList = new ArrayList<String>();
        singleList.add("-99.943118");
        singleList.add("32.664761");
        listOLists.add(singleList);

        ArrayList<String> singleList2 = new ArrayList<String>();

        singleList2.add("-99.518098");
        singleList2.add("32.750025");
        listOLists.add(singleList2);

        ArrayList<String> singleList3 = new ArrayList<String>();

        singleList3.add("-97.366715");
        singleList3.add("32.874170");
        listOLists.add(singleList3);

        ArrayList<String> singleList4 = new ArrayList<String>();

        singleList4.add("-96.730170");
         singleList4.add("32.811848");
        listOLists.add(singleList4);

        for(int i = 0; i< listOLists.size(); i++)
        {
    %>

     {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [
    <% out.print(listOLists.get(i).get(0)); %>,
    <% out.print(listOLists.get(i).get(1)); %>        ]}
      },
      <%  }%>
  ]
};



    map.on('load', function (e) {
      /* Add the data to your map as a layer */
      map.addLayer({
        "id": "locations",
        "type": "symbol",
        /* Add a GeoJSON source containing place coordinates and information. */
        "source": {
          "type": "geojson",
          "data": locations
        },
        'layout': {
        'icon-image': 'hospital-15'
        }
        });

// Center the map on the coordinates of any clicked symbol from the 'symbols' layer.
    map.on('click', 'locations', function(e) {
    map.flyTo({ center: e.features[0].geometry.coordinates, zoom: 15 });
    });

    // Change the cursor to a pointer when the it enters a feature in the 'symbols' layer.
    map.on('mouseenter', 'locations', function() {
    map.getCanvas().style.cursor = 'pointer';
    });

    // Change it back to a pointer when it leaves.
    map.on('mouseleave', 'locations', function() {
    map.getCanvas().style.cursor = '';
    });
        });
        </script>
</html>
