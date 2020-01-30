
<%@page import="TreatmentFinder.sql"%>
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
        <h1>Hello World!</h1>

        
        <table class="table">
  <thead class="thead-dark">
    <tr>
      <th scope="col">#</th>
      <th scope="col">First</th>
      <th scope="col">Last</th>
      <th scope="col">Handle</th  
    </tr>
  </thead>
  <tbody>
        
        <%  
            String search = request.getParameter("desc");
            String budget = request.getParameter("budget");
            out.print("<td>" + search+budget + "</td>");
            Database test = new Database();
            List<Procedure> result = test.dbQuery(sql.selectInIndex(search, budget));
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

    </body>
</html>
