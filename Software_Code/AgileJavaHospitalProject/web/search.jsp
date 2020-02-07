
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
        <script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script><script src='//cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js'></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/scroller/2.0.1/js/dataTables.scroller.min.js" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/51b16e748f.js" crossorigin="anonymous"></script>
        <link rel="apple-touch-icon" sizes="180x180" href="img/apple-touch-icon.png">
        <link rel="icon" type="image/png" sizes="32x32" href="img/favicon-32x32.png">
        <link rel="icon" type="image/png" sizes="16x16" href="img/favicon-16x16.png">
        <link rel="manifest" href="img/site.webmanifest">
	<title>Search Results</title>
        </head>
    <body>
        
         <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container">
              <a class="navhead navbar-brand" href="index.jsp"><h4>Treatment <span class="accent">Finder</span></h4></a>
            </div>
        </nav>
       
        <div class="container">
            <br/>
        <h1>Your Results for: <%= request.getParameter("desc") %></h1>

     <!--   <div class="row">
            <div class="col">
                <h5>You have searched for: <%= request.getParameter("desc") %> </h5>
            </div>
        </div>-->
        <div class="row no-gutters">
         <div class="col-lg-5">
        <!--Start of table code-->
         <table id="myTable" class="table table-sm table-striped">
        <thead class="thead-dark">
          <tr>
            <th scope="col" style="width:35%">Provider Name</th>
            <th scope="col">Average Cost</th>
            <th scope="col" >Distance</th>
          </tr>
        </thead>
        <tbody>

        <%
            String sort = request.getParameter("budget");
            String price = request.getParameter("price");
            String search = request.getParameter("desc");
            String searchBy = request.getParameter("searchBy");
            String lat = request.getParameter("browser-location-lat");
            String lon = request.getParameter("browser-location-lon");
            String loc = request.getParameter("location");
            String maxDist = request.getParameter("max-distance");
            Helper controlHelper = new Helper();
            
            if(maxDist == "") { 
                maxDist = "100";
            }
            
            
            
           
            List<Procedure> display = controlHelper.getListInRange(search, price, searchBy, loc, lat, lon, maxDist);
              if(display.isEmpty())
            {
                String error="1";
                out.print("<script language='javascript'>\n");
                out.print("window.document.location.href='index.jsp?desc="+search+"&price="+price+"&location="+loc+"&distance="+maxDist+"&error="+error+"';\n");
                out.print("</script>\n");
                

            } else {
             for(int i=0; i<display.size(); i++)
            {
                out.print("<tr class='clickable' id=\"" + i + "\"" + "onclick='displayHospital(this.id)'>");
                //out.print("<td>" + display.get(i).getDRG() + "</td>");
                out.print("<td>" + display.get(i).getProviderName() + "</td>");
                out.print("<td>" + "$" + display.get(i).getTotalPayments() + "</td>");
                out.print("<td data-order='" + Math.round(display.get(i).getDistance()) + "'>" + Math.round(display.get(i).getDistance()) + " miles</td>");
                
                out.print("</tr>");
            }
              }

        %>
        </tbody>
      </table>
        </div>
        <!--End of table code-->
        
        <!--Start of map code-->
        <div class="col-lg-7">
            <div id="map"></div>
        </div>
        </div>
        </div>
        <br>
        
        <footer class="footer bg-light">
            <div class="container">
                <div class="row">
              <p class="p-0 m-0">© Team 15 2020</p>
              <div class="float-right">
                <i class="fab fa-twitter-square fa-2x fa-fw align-middle"></i><i class="fab fa-facebook fa-2x fa-fw align-middle"></i><i class="fab fa-instagram fa-2x fa-fw align-middle"></i>
              </div>
                </div>
            </div>
        </footer>
    </body>
    <script>
        var table;
        var displayList = [
        <% for(int i = 0; i< display.size(); i++) { %>
            {
            name: <% out.print("\"" + display.get(i).getProviderName() + "\"");%>,
            address: <% out.print("\"" + display.get(i).getProviderStreetAddress() + ", " + display.get(i).getProviderCity() + "\"");%>,
            state: <% out.print("\"" + display.get(i).getProviderState() + "\"");%>,
            zipcode: <% out.print("\"" + display.get(i).getProviderZipCode() + "\"");%>,
            },
        <%  } %>
        ];
        
        $(document).ready( function () {
            table = $('#myTable').DataTable({
                "lengthMenu": [5, 10, 15, 20, 50],
                scrollY: 400,
                scroller: true,
                "iDisplayLength": -1,
                info: false,
                "order": [[ 2, 'asc' ]]
                }
             );
        } );
        
        mapboxgl.accessToken = 'pk.eyJ1IjoidGVhbTE1YWdpbGUiLCJhIjoiY2s1djVyOTJnMDh2czNsbGIxaG05NnI5bSJ9.xY_RVRU92qjmMJ0QCkrodw';
        var map = new mapboxgl.Map({
                  container: 'map',
                  style: 'mapbox://styles/mapbox/light-v10',
                  center: {lng: <% out.print(controlHelper.getCoordinates(loc, lat, lon).getDouble(0));%>, lat: <% out.print(controlHelper.getCoordinates(loc, lat, lon).getDouble(1));%>},
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
        
        map.resize();
    });
    /* Add the data to your map as a layer */
    
        
    // Center the map on the coordinates of any clicked symbol from the 'symbols' layer.
    map.on('click', 'locations', function(e) {
        map.flyTo({ center: e.features[0].geometry.coordinates, zoom: 15 });
        $("#exampleModalCenter").modal();
        var index = e.features[0].properties.index;
        createPopUp(e.features[0]);
      
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
        
  function createPopUp(currentFeature) {
  var popUps = document.getElementsByClassName('mapboxgl-popup');
  /** Check if there is already a popup on the map and if so, remove it */
  if (popUps[0]) popUps[0].remove();

  var popup = new mapboxgl.Popup({ closeOnClick: false })
    .setLngLat(currentFeature.geometry.coordinates)
    .setHTML('<div class="popup-header"><p><strong>' + (displayList[currentFeature.properties.index].name).toProperCase() + '</strong></p></div>' +
      '<p>' + displayList[currentFeature.properties.index].address.toProperCase() + ", " + displayList[currentFeature.properties.index].state + '</p>' + '<p>' + displayList[currentFeature.properties.index].zipcode + '</p>')
    .addTo(map);
    }
        
    String.prototype.toProperCase = function () {
        return this.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
    };

    function displayHospital(id) {
        map.flyTo({ center: locations.features[id].geometry.coordinates, zoom: 15 });
    } 
        
        
        </script>
</html>