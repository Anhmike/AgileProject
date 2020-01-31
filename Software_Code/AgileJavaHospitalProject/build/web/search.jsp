
<%@page import="TreatmentFinder.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>

<!DOCTYPE html>
<html>
    <head>
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
      <th scope="col">Distance</th>
    </tr>
  </thead>
  <tbody>

        <%


	    
            String sort = request.getParameter("budget");
            String price = request.getParameter("price");
            String search = request.getParameter("desc");
            JSONArray coordinates = null;
            //String search = "call lol.findCode(\"" + request.getParameter("desc") + "\")";
	    

            int maxDistance = Integer.parseInt(request.getParameter("max-distance"));
            Database test = new Database();
            
            List<Procedure> result = null;

            result = test.dbQuery("call lol.sortLowToHigh(\"" +search+"\","+ price + ")");
           
            //List<Procedure> result = test.dbQuery("SELECT * FROM lol.operations where DRG_Definition LIKE '%"+search+"%'");
            List<Procedure> display = new ArrayList();
            LocationManager lm = new LocationManager();
            String loc = request.getParameter("location");
            String inputLocation = "";
            if( loc != null && !loc.isEmpty()) {
                 coordinates = lm.getUserCoordinates(loc);
            }
            else {
                double lat = Double.parseDouble(request.getParameter("browser-location-lat"));
                double lon = Double.parseDouble(request.getParameter("browser-location-lon"));
                
                double[] coArr = {lon, lat};
                coordinates = new JSONArray(coArr);
            }
                display = lm.findProvidersInRange(result, maxDistance, coordinates);
             //Now sorts by distance/ shows distance, but kind of ugly should refactor
             for(Procedure obj : display)
            {
                out.print("<tr>");
                out.print("<td>" + obj.getDRG() + "</td>");
                out.print("<td>" + obj.getProviderName() + "</td>");
                out.print("<td>" + obj.getProviderStreetAddress() + ", " + obj.getProviderCity() + ", " + obj.getProviderState() + "</td>");
                out.print("<td>" + obj.getProviderZipCode() + "</td>");
                out.print("<td>" + "$" + obj.getTotalPayments() + "</td>");
                out.print("<td>" + Math.round(obj.getDistance()) + " miles" + "</td>");
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
                  center: {lng: <% out.print(coordinates.get(0));%>, lat: <% out.print(coordinates.get(1));%>},
                  zoom: 12
                });
        var locations = {
  "type": "FeatureCollection",
  "features": [
    <%
       for(int i = 0; i< display.size(); i++)
        {
    %>

     {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [
     <% out.print(display.get(i).getLongitude()); %>,
    <% out.print(display.get(i).getLatitude()); %>        ]}
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
