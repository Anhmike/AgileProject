
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="TreatmentFinder.Database"%>
<%@page import="TreatmentFinder.hospital"%>
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
        <% 
            Database test = new Database();
            List<hospital> Hospital;

            Hospital = test.dbQuery("SELECT * FROM lol.operations");

            
            for(hospital obj : Hospital)
            {
                out.print("<p> Id:"+obj.getProviderId() +" Name:"+ obj.getProviderName()+ " TotalPayments:"+ obj.getTotalPayments() + "</p>");
            }
            /*
            Iterator iterator = hospital.iterator();
            
            while(iterator.hasNext()) {
               out.print("<p>" + iterator.next() + "<p>");
            }
            */
        %>
    </body>
</html>
