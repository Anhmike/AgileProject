
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="TreatmentFinder.Database"%>
<%@page import="TreatmentFinder.Procedure"%>

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
        <h1>Search Results</h1>
        
        <div class="container">
        <table class="table table-striped">
  <thead class="thead-dark">
    <tr>
      <th scope="col">Procedure</th>
      <th scope="col">Provider Name</th>
      <th scope="col">Provider Address</th>
      <th scope="col">Provider City</th>
      <th scope="col">Provider State</th>
      <th scope="col">Provider Zip code</th>
      <th scope="col">Average Total Payments</th>
    </tr>
  </thead>
  <tbody>

        <% 
            String search = "call lol.findCode(\"" + request.getParameter("desc") + "\")";
            Database test = new Database();
            List<Procedure> result = test.dbQuery(search);
                        for(Procedure obj : result)
            {
                out.print("<tr>");
                out.print("<td>" + obj.getDRG() + "</td>");
                out.print("<td>" + obj.getProviderName() + "</td>");
                out.print("<td>" + obj.getProviderStreetAddress() + "</td>");
                out.print("<td>" + obj.getProviderCity() + "</td>");
                out.print("<td>" + obj.getProviderState() + "</td>");
                out.print("<td>" + obj.getProviderZipCode() + "</td>");
                out.print("<td>" + obj.getTotalPayments() + "</td>");
               out.print("</tr>");
            }

        %>
        </tbody>
      </table>
       </div>

    </body>
</html>
