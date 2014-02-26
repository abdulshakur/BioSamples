<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.io.Serializable.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.driver.*"%>
<%@ page import="oracle.sql.*"%>
<%@ page import="java.io.ByteArrayOutputStream.*"%> 

<%@ page import="java.io.File.*"%>
<%@ page import="java.io.FileInputStream.*"%>
<%@ page import="java.io.FileNotFoundException.*"%>
<%@ page import="java.io.IOException.*"%>
<%@ page import="java.io.InputStream.*"%>
    
<%@ page import="com.hp.hpl.jena.datatypes.xsd.XSDDatatype.*"%>  
<%@ page import="com.hp.hpl.jena.graph.*"%>
<%@ page import="com.hp.hpl.jena.query.QueryExecution.*"%>
<%@ page import="com.hp.hpl.jena.query.QueryExecutionFactory.*"%>  
<%@ page import="com.hp.hpl.jena.query.QueryFactory.*"%>
<%@ page import="com.hp.hpl.jena.rdf.model.Model.*"%>
<%@ page import="com.hp.hpl.jena.rdf.model.ModelFactory.*"%>  
<%@ page import="com.hp.hpl.jena.rdf.model.Property.*"%>
<%@ page import="com.hp.hpl.jena.rdf.model.Resource.*"%>
<%@ page import="com.hp.hpl.jena.sparql.resultset.*"%>
<%@ page import="com.hp.hpl.jena.query.ResultSetFormatter.*"%>  
<%@ page import="com.hp.hpl.jena.rdf.model.RDFNode"%>
<%@ page import="com.hp.hpl.jena.rdf.model.*"%>
<%@ page import="com.hp.hpl.jena.ontology.*"%>
<%@ page import="com.hp.hpl.jena.rdf.model.*"%>
<%@ page import="com.hp.hpl.jena.util.*"%>
<%@ page import="com.hp.hpl.jena.util.iterator.Filter.*"%>
<%@ page import="com.hp.hpl.jena.sparql.core.DatasetImpl.*"%>
<%@ page import="com.hp.hpl.jena.query.*"%>
<%@ page import =" java.io.ByteArrayOutputStream.*"%> 
        



<html>

<head>
<meta charset="utf-8">
<title>Similarity-based Information Retrieval in Biosamples Linked Data</title>

 <div align="center"> 
<H1>Similarity-based Information Retrieval in Biosamples Linked Data</H1>

</div>
<style type="text/css">



body {
	background:url(../../images/background.png) top left;
	font: .8em "Lucida Sans Unicode", "Lucida Grande", sans-serif;
	
}

h2{ 
	margin-bottom:10px;
}

#wrapper{
	width:720px;
	margin:40px auto 0;
	
}

#wrapper h1{
	color:#FFF;
	text-align:center;
	margin-bottom:20px;
}

#wrapper a{
	display:block;
	font-size:1.2em;
	padding-top:20px;
	color:#FFF;
	text-decoration:none;
	text-align:center;
	
	}

#tabContainer {
	width:650px;
	height:600px;
	padding:15px;
	background-color:#2e2e2e;
	-moz-border-radius: 4px;
	border-radius: 4px; 
}

.tabs{
	height:30px;
}

.tabs > ul{
	font-size: 1em;
	list-style:none;
	}

.tabs > ul > li{
	
	margin:0 2px 0 0;
	padding:7px 10px;
	display:block;
	float:left;
	color:#FFF;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
	-moz-border-radius-topleft: 4px;
	-moz-border-radius-topright: 4px;
	-moz-border-radius-bottomright: 0px;
	-moz-border-radius-bottomleft: 0px;
	border-top-left-radius:4px;
	border-top-right-radius: 4px;
	border-bottom-right-radius: 0px;
	border-bottom-left-radius: 0px; 
	background: #C9C9C9; /* old browsers */
	background: -moz-linear-gradient(top, #0C91EC 0%, #257AB6 100%); /* firefox */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#0C91EC), color-stop(100%,#257AB6)); /* webkit */

}

.tabs > ul > li:hover{
	background: #FFFFFF; /* old browsers */
	background: -moz-linear-gradient(top, #FFFFFF 0%, #F3F3F3 10%, #F3F3F3 50%, #FFFFFF 100%); /* firefox */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#FFFFFF), color-stop(10%,#F3F3F3), color-stop(50%,#F3F3F3), color-stop(100%,#FFFFFF)); /* webkit */
	cursor:pointer;
	color: #333;
}

.tabs > ul > li.tabActiveHeader{
	background: #FFFFFF; /* old browsers */
	background: -moz-linear-gradient(top, #FFFFFF 0%, #F3F3F3 10%, #F3F3F3 50%, #FFFFFF 100%); /* firefox */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#FFFFFF), color-stop(10%,#F3F3F3), color-stop(50%,#F3F3F3), color-stop(100%,#FFFFFF)); /* webkit */
	cursor:pointer;
	color: #333;
	font-weight:bold;

}

.tabscontent {
	-moz-border-radius-topleft: 0px;
	-moz-border-radius-topright: 4px;
	-moz-border-radius-bottomright: 4px;
	-moz-border-radius-bottomleft: 4px;
	border-top-left-radius: 0px;
	border-top-right-radius: 4px;
	border-bottom-right-radius: 4px;
	border-bottom-left-radius: 4px; 
	padding:10px 10px 25px;
	background: #FFFFFF; /* old browsers */
	background: -moz-linear-gradient(top, #FFFFFF 0%, #FFFFFF 90%, #e4e9ed 100%); /* firefox */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#FFFFFF), color-stop(90%,#FFFFFF), color-stop(100%,#e4e9ed)); /* webkit */
	margin:0;
	color:#333;
	height:530px;
	
}

</style>

<script type="text/javascript">

window.onload=function() {

  // get tab container
  var container = document.getElementById("tabContainer");
    // set current tab
    var navitem = container.querySelector(".tabs ul li");
    //store which tab we are on
    var ident = navitem.id.split("_")[1];
    navitem.parentNode.setAttribute("data-current",ident);
    //set current tab with class of activetabheader
    navitem.setAttribute("class","tabActiveHeader");

    //hide two tab contents we don't need
    var pages = container.querySelectorAll(".tabpage");
    for (var i = 1; i < pages.length; i++) {
      pages[i].style.display="none";
    }

    //this adds click event to tabs
    var tabs = container.querySelectorAll(".tabs ul li");
    for (var i = 0; i < tabs.length; i++) {
      tabs[i].onclick=displayPage;
    }
}

// on click of one of tabs
function displayPage() {
  var current = this.parentNode.getAttribute("data-current");
  //remove class of activetabheader and hide old contents
  document.getElementById("tabHeader_" + current).removeAttribute("class");
  document.getElementById("tabpage_" + current).style.display="none";

  var ident = this.id.split("_")[1];
  //add class of activetabheader to new active tab and show contents
  this.setAttribute("class","tabActiveHeader");
  document.getElementById("tabpage_" + ident).style.display="block";
  this.parentNode.setAttribute("data-current",ident);
}


function GetResult()
{
    document.form1.buttonName.value = "button 1"
   
    form1.submit();
      
}    



</script>
 
</head>
<body >
 <form  NAME="form1" action="SparqlServlet">
     
<div id="wrapper">
  <div id="tabContainer">
    <div class="tabs">
      <ul>
        <li id="tabHeader_1">String Based Search</li>
        <li id="tabHeader_2">Ontology Based Search</li>
        <li id="tabHeader_3">Zooma Based Search</li>
        <li id="tabHeader_4">Help</li>
      </ul>
    </div>
    <div class="tabscontent">
      <div class="tabpage" id="tabpage_1">
        <h2>String Based Search</h2>
         <p>...................</p>
 <%        
     
 Model model = ModelFactory.createDefaultModel();
 Resource programmers =
    model.createResource("http://example.org/wcjava/uri/programmers");
 Property enjoy =
    model.createProperty("http://example.org/wcjava/uri/enjoy");
 Resource java =
    model.createResource("http://example.org/wcjava/uri/java");
 model.add(programmers, enjoy, java);
 model.write(new java.io.FileOutputStream("out2.n3"), "N3");
       
 
  
 %> 
 
           Please enter a country :

		  <input type="text" name="country"size="20px">
		 	
          
           Select Output Type :
          <select name="menu" id="menu">
          <option value="xml">XML</option>
          <option value="json">JSON</option>
          <option value="text">Text</option>
          <option value="csv">CSV</option>
          <option value="tsv">TSV</option>
          </select>
          
          <BR>
          <BR>
          Query Search String :
          <textarea rows="4" cols="50" name='test' id='test'><%=(String)request.getAttribute("queryStr") %> </textarea>
          <BR>
          <BR>
          Query Search Output:
         <textarea rows="8" cols="50" name='test' id='test'><%=(String)request.getAttribute("rslt") %> </textarea>
                

      
       
            
         
         
          <input type="submit" value="submit">	          
           
          <BR>
      
         
      </div>
      <div class="tabpage" id="tabpage_2">
        <h2>Ontology Based Search</h2>
        <p>...................</p>
      </div>
      <div class="tabpage" id="tabpage_3">
        <h2>Zooma Based Search</h2>
        <p>...................</p>
      </div>
      <div class="tabpage" id="tabpage_4">
        <h2>Help</h2>
        <p>...................</p>
      </div>
    </div>
  </div>
  </form>
</body>
</html>