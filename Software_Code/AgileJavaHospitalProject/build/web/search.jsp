
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
        <script src="https://kit.fontawesome.com/51b16e748f.js" crossorigin="anonymous"></script>
        <title>Search Results</title>
        </head>
    <body>
        
        
        <main role="main">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navhead navbar-brand" href="index.html"><h4><i class="fas fa-chevron-left accent"></i>  Treatment <span class="accent">Finder</span></h4></a>
        </nav>
        <div class="container-fluid">
        <h1>Search Results</h1>

        <div id="exampleModalCenter" class="modal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 id="modalProvName" class="modal-title"></h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <p id="modalAddress"></p>
              <p id="modalZipCode"></p>
            </div>
            <div class="modal-footer">
              <button id="modalClose" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
          </div>
        </div>
      </div>

        <div class="row">
        <div class="col-lg-4">
         <h5>You have searched for: <%= request.getParameter("desc") %> </h5>
         
        <!--Start of table code-->
         <table id="myTable" class="table table-sm table-striped">
        <thead class="thead-dark">
          <tr>
            <th scope="col">Procedure</th>
            <th scope="col">Provider Name</th>
            <th scope="col">Average Cost</th>
            <th scope="col">Distance</th>
          </tr>
        </thead>
        <tbody>

        <%
            String sort = request.getParameter("budget");
            String price = request.getParameter("price");
            String search = request.getParameter("desc");
            String searchBy = request.getParameter("searchBy");
            
            JSONArray coordinates = null;   

            int maxDistance = Integer.parseInt(request.getParameter("max-distance"));
            Database test = new Database();
            
            List<Procedure> result = null;
            
            if(searchBy.equals("code")) {
                result = test.dbQuery("call lol.searchByCode(\"" + search +"\","+ price + ")");
            }
            else {
                result = test.dbQuery("call lol.searchByDesc(\"" + search +"\","+ price + ")");
            }
  
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
             for(int i=0; i<display.size(); i++)
            {
                out.print("<tr>");
                out.print("<td>" + display.get(i).getDRG() + "</td>");
                out.print("<td><button type='submit' id=\"" + i + "\"" + "onclick='displayHospital(this.id)' class='findOnMap'>" + display.get(i).getProviderName() + "</button></td>");
                out.print("<td>" + "$" + display.get(i).getTotalPayments() + "</td>");
                out.print("<td>" + Math.round(display.get(i).getDistance()) + " miles" + "</td>");
                
                out.print("</tr>");
            }
        %>
        </tbody>
      </table>
        </div>
        <!--End of table code-->
        
        <!--Start of map code-->
        <div class="col-lg-8">
            <div id="map"></div>
        </div>
        </div>
        </div>
    </main>
        <br>
    <footer class="py-5 bg-light">
        <div class="container">
            <div class="row">
              <h6>© Team 15 2020</h6>
              <div class="float-right">
                <i class="fab fa-twitter-square fa-2x fa-fw"></i><i class="fab fa-facebook fa-2x fa-fw"></i><i class="fab fa-instagram fa-2x fa-fw"></i>
              </div>
            </div>
        </div>
    </footer>
    </body>
    <script>
        var table;
        var displayList = [
        <%
       for(int i = 0; i< display.size(); i++)
        {
        %>
        {
        name: <% out.print("\"" + display.get(i).getProviderName() + "\"");%>,
        address: <% out.print("\"" + display.get(i).getProviderStreetAddress() + ", " + display.get(i).getProviderCity() + ", " + display.get(i).getProviderState() + "\"");%>,
        zipcode: <% out.print("\"" + display.get(i).getProviderZipCode() + "\"");%>,
        },
        <%  }%>
    ]
        $(document).ready( function () {
            table = $('#myTable').DataTable({"lengthMenu": [5, 10, 15, 20, 50]});
        } );
        mapboxgl.accessToken = 'pk.eyJ1IjoidGVhbTE1YWdpbGUiLCJhIjoiY2s1djVyOTJnMDh2czNsbGIxaG05NnI5bSJ9.xY_RVRU92qjmMJ0QCkrodw';
        var map = new mapboxgl.Map({
                  container: 'map',
                  style: 'mapbox://styles/mapbox/light-v10',
                  center: {lng: <% out.print(coordinates.get(0));%>, lat: <% out.print(coordinates.get(1));%>},
                  zoom: 9
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
    <% out.print(display.get(i).getLatitude()); %>        ],
      
        
        },
        "properties": {
    "index" : <% out.print(i); %>
    }
    },
      <%  }%>
  ]
};
    map.on('load', function (e) {
    map.loadImage(
    'img/marker.png',
    function(error, image) {
    if (error) throw error;
    map.addImage('marker', image);
    });
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
        'icon-image': 'marker',
        'icon-size': 0.05
        }
        });
        
    // Center the map on the coordinates of any clicked symbol from the 'symbols' layer.
    map.on('click', 'locations', function(e) {
        map.flyTo({ center: e.features[0].geometry.coordinates, zoom: 15 });
        $("#exampleModalCenter").modal();
        var index = e.features[0].properties.index;

        $("#modalProvName").text(displayList[index].name);
        $("#modalAddress").text(displayList[index].address);
        $("#modalZipCode").text(displayList[index].zipcode);
        table.search(displayList[index].name).draw();


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
   
   function displayHospital(id) {
        map.flyTo({ center: locations.features[id].geometry.coordinates, zoom: 15 });
    } 
  </script>  
</html>
