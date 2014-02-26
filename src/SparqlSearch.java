

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.io.ByteArrayOutputStream; 

import org.openjena.*;

import java.io.File.*;
import java.io.FileInputStream.*;
import java.io.FileNotFoundException.*;
import java.io.IOException.*;
import java.io.InputStream.*;
import java.util.ArrayList;

import com.hp.hpl.jena.datatypes.xsd.XSDDatatype.*;  
import com.hp.hpl.jena.graph.*;
import com.hp.hpl.jena.rdf.model.Model.*;
import com.hp.hpl.jena.rdf.model.ModelFactory.*;  
import com.hp.hpl.jena.rdf.model.Property.*;
import com.hp.hpl.jena.rdf.model.Resource.*;
    import com.hp.hpl.jena.query.ResultSet;
import com.hp.hpl.jena.query.Query;
import com.hp.hpl.jena.query.QueryFactory;
import com.hp.hpl.jena.query.QuerySolution;
import com.hp.hpl.jena.query.QueryExecution.*;
import com.hp.hpl.jena.query.ResultSetFormatter.*;
import com.hp.hpl.jena.sparql.engine.http.QueryEngineHTTP;
import com.hp.hpl.jena.sparql.resultset.*;  
import com.hp.hpl.jena.query.QueryExecutionFactory;
import com.hp.hpl.jena.query.QueryExecution;

	public class SparqlSearch  extends HttpServlet { 
	  protected void doGet(HttpServletRequest request, 
	      HttpServletResponse response) throws ServletException, IOException 
	  {
	    // reading the user input
	    String country= request.getParameter("country");    
	       
  	
	    String rslt="";
	    String queryStr;
	    String service="http://dbpedia.org/sparql";
	    	        
	    Query query;
	    queryStr = "PREFIX dbo:<http://dbpedia.org/ontology/>"
	             + "PREFIX :<http://dbpedia.org/resource/>" 
	    	     + "select ?person where {?person dbo:birthPlace :"+country+".} LIMIT 25"; 
	    	        		
	    	       //queryStr = "select distinct ?Concept where {[] a ?Concept} LIMIT 10"; 
	    	       query=QueryFactory.create(queryStr);
	    	       // query = QueryFactory.create(queryStr);
	    	        // Remote execution.
	    	        QueryExecution qexec = QueryExecutionFactory.sparqlService(service, query);
	    	      
	    	         ResultSet rs = qexec.execSelect();
	    	     
	    	         while(rs.hasNext()){
	    	        	 QuerySolution s =rs.nextSolution();
	    	        	 System.out.println(s.getResource("?person").toString());
	    	        	
	    	        	 rslt = rslt + " " + s.getResource("?person").toString();
	    	        	 
	    	           } 
	    	         
	    	          	         
	    	         System.out.println(queryStr);
	    	   
	    	         qexec.close();
	    	   
                     request.setAttribute("rslt",rslt);
                     request.setAttribute("queryStr", queryStr);
                     request.setAttribute("service", service);
	    	         
	    	         request.getRequestDispatcher("MainSearch.jsp").forward(request, response);
	    	         

	  }  
	}
