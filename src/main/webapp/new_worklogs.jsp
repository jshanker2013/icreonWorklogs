<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.icreon.*" %>
<%@ page import="com.icreon.worklogs.daoImpl.*" %>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="com.icreon.login.service.GetProjects" %>
<!DOCTYPE html>
<html lang="en-US">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Icreon Worklogs</title>


    <link rel="stylesheet" href="resources/css/footer-distributed-with-search.css">



    <link rel="stylesheet" href="resources/css/components.css">
    <link rel="stylesheet" href="resources/css/icons.css">
    <link rel="stylesheet" href="resources/css/responsee.css">

    <link href="resources/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template-->
    <link href="resources/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <!-- Page level plugin CSS-->
    <link href="resources/resources/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
    <!-- Custom styles for this template-->
    <link href="resources/resources/css/sb-admin.css" rel="stylesheet">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/jasny-bootstrap/3.1.3/css/jasny-bootstrap.min.css">



    <!--     <link rel="Stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" /> -->
    <link rel="Stylesheet" href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css" />

    <style>
        div.sticky {
            position: -webkit-sticky;
            position: sticky;
            top: 0;

            padding: 10px;
            font-size: 10px;
        }
    </style>
    <style>
        .footer {
            position: fixed;
            left: 0;
            bottom: 0;
            width: 100%;
            background-color: #6b1381;
            color: white;
            text-align: center;
        }
    </style>

    <style>
        .expand_hover{
            max-width: 200px;
            text-overflow: ellipsis;
            cursor: pointer;
            word-break: break-all;
            overflow:hidden;
            white-space:nowrap;
        }
        .expand_hover:hover{
            overflow: visible;
            white-space: normal;
            height:auto;  /* just added this line */
        }
    </style>

    <style>
        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
        }

        .topnav {
            overflow: hidden;
            background-color: #333;
        }

        .topnav a {
            float: left;
            color: #f2f2f2;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
            font-size: 17px;
        }

        .topnav a:hover {
            background-color: #ddd;
            color: black;
        }

        .topnav a.active {
            background-color: #6b1381;
            color: white;
        }

        /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }

        /* Modal Content */
        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 25%;
        }

        /* The Close Button */
        .close {
            color: #aaaaaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }

    </style>
</head>
<body class="size-1140">

<%
    if ((session.getAttribute("username") == null) || (session.getAttribute("username") == "")) {
        out.println("<script type=\"text/javascript\">");
        out.println("alert('Please login first to visit this page.');");
        out.println("location='logout';");
        out.println("</script>");



    }
%>



<header class="header-fixed">

    <div class="header-limiter">

        <h1 style="color:#9e10c1;"><a href="#">ICREON <span>Jira Portal</span></a></h1>

    </div>

</header>

<div class="topnav sticky">


    <a href="home"><i class="fa fa-fw fa-home"></i>Home</a>
    <a href="approvedWorklogs">Approved Worklogs</a>
    <a href="unApprovedWorklogs">Pending Worklogs</a>
    <a href="rejectedWorklogs">Rejected Worklogs</a>
    <a href="logout" style="float:right">Logout</a>




</div>

<!-- <b>#6b1381</b> -->
<style>
    .header-fixed {
        background-color:#6b1381 ;
        box-shadow:0 1px 1px #ccc;
        padding: 20px 40px;
        height: 80px;
        color: #ffffff;
        box-sizing: border-box;
        top:-100px;

        -webkit-transition:top 0.3s;
        transition:top 0.3s;
    }

    .header-fixed .header-limiter {
        max-width: 1200px;
        text-align: center;
        margin: 0 auto;
    }

    /*	The header placeholder. It is displayed when the header is fixed to the top of the
        browser window, in order to prevent the content of the page from jumping up. */

    .header-fixed-placeholder{
        height: 80px;
        display: none;
    }

    /* Logo */

    .header-fixed .header-limiter h1 {
        float: center;
        font: normal 28px Cookie, Arial, Helvetica, sans-serif;
        line-height: 40px;
        margin: 0;
    }

    .header-fixed .header-limiter h1 span {
        color: #5383d3;
    }

    /* The navigation links */

    .header-fixed .header-limiter a {
        color: #ffffff;
        text-decoration: none;
    }

    .header-fixed .header-limiter nav {
        font:16px Arial, Helvetica, sans-serif;
        line-height: 40px;
        float: right;
    }

    .header-fixed .header-limiter nav a{
        display: inline-block;
        padding: 0 5px;
        text-decoration:none;
        color: #ffffff;
        opacity: 0.9;
    }

    .header-fixed .header-limiter nav a:hover{
        opacity: 1;
    }

    .header-fixed .header-limiter nav a.selected {
        color: #608bd2;
        pointer-events: none;
        opacity: 1;
    }

    /* Fixed version of the header */

    body.fixed .header-fixed {
        padding: 10px 40px;
        height: 50px;
        position: fixed;
        width: 100%;
        top: 0;
        left: 0;
        z-index: 1;
    }

    body.fixed .header-fixed-placeholder {
        display: block;
    }

    body.fixed .header-fixed .header-limiter h1 {
        font-size: 24px;
        line-height: 30px;
    }

    body.fixed .header-fixed .header-limiter nav {
        line-height: 28px;
        font-size: 13px;
    }


    /* Making the header responsive */

    @media all and (max-width: 600px) {

        .header-fixed {
            padding: 20px 0;
            height: 75px;
        }

        .header-fixed .header-limiter h1 {
            float: none;
            margin: -8px 0 10px;
            text-align: center;
            font-size: 24px;
            line-height: 1;
        }

        .header-fixed .header-limiter nav {
            line-height: 1;
            float:none;
        }

        .header-fixed .header-limiter nav a {
            font-size: 13px;
        }

        body.fixed .header-fixed {
            display: none;
        }

    }

    /*
         We are clearing the body's margin and padding, so that the header fits properly.
         We are also adding a height to demonstrate the scrolling behavior. You can remove
         these styles.
     */

    body {
        margin: 0;
        padding: 0;
        height: 500px;
    }
</style>




<form action="getSelectedWorklogs" method="post">
    <!-- You need this element to prevent the content of the page from jumping up -->




    <!-- TOP NAV WITH LOGO -->




    <div class="container1 container-White py-10">

        <a href="index.jsp"><-- Back to Search</a>

        <div class="row">
            <div class="col-md-10 mx-auto">
                <div class="form-group row">

                    <div class="col-sm-4">
                        <label for="" class="thick"><b>Select Project</b><span style="color:red;">*</span></label>
                        <select name="projects" size="1" id="projects" required="" class="form-control">
                            <option value="<%=request.getParameter("projects")%>" ><%= request.getParameter("projects")%></option>
                            <%
                                try
                                {
                                    String username = (String)session.getAttribute("username");
                                    String password = (String)session.getAttribute("password");



                                    GetProjects gp=new GetProjects();
                                    JSONArray jsonResults=gp.getProjectsInfo(username,password);
                                    for(int i=0; i < jsonResults.length();i++){

                            %>
                            <option value=<%=jsonResults.getJSONObject(i).get("key")%>><%=jsonResults.getJSONObject(i).get("name") %></option>
                            <%
                                    }//for
                                }
                                catch(Exception e)
                                {
                                    e.printStackTrace();
                                }
                            %>

                        </select>
                    </div>

                    <div class="col-sm-4">
                        <label for="" class="thick"><b>Select Issue</b><span style="color:red;">*</span></label>
                        <select name="issues" size="1" id="issues" class="form-control" required>
                            <option value="<%=request.getParameter("issue")%>" ><%=request.getParameter("issue")%></option>
                        </select>
                    </div>

                    <div class="col-sm-4">
                        <label for="" class="thick"><b>Select Resource</b></label>
                        <select name="user" size="1" id="user" class="form-control">
                            <option value="0" >Select</option>
                            <!-- <option value="Ravi Kumar">Ravi Kumar</option> -->
                            <!-- <option value="Rohit Phutane">Rohit Phutane</option> -->
                        </select>
                    </div>
                </div>

                <div class="form-group row">

                    <div class="col-sm-4">
                        <label for="" class="thick"><b>From Date</b><span style="color:red;"></span></label>
                        <input class="form-control" type="date"  autocomplete="off" name="FromDate" value="" placeholder="Enter From Date"  id="FromDate" />
                    </div>

                    <div class="col-sm-4">
                        <label for="" class="thick"><b>To Date</b><span style="color:red;"></span></label>
                        <input class="form-control" type="date" autocomplete="off" value="" name="ToDate" placeholder="Enter To Date" id="ToDate" />
                    </div>

                    <div class="col-sm-4">
                        <label for="" class="thick"><b>Status</b><span style="color:red;"></span></label>
                        <select name="status" size="1" id="status" required="" class="form-control">
                            <option value="-1" >Select</option>
                            <option value="1">Approved Worklogs</option>
                            <option value="2">Pending Worklogs</option>
                            <option value="0">Rejected Worklogs</option>
                        </select>
                    </div>



                </div>


                <p>All (<span style="color:red;">*</span>) fields are mandatory.

                <div class="form-group row" >
                    <div class="col-sm-5"></div>
                    <input class="btn btn-primary" type="submit"  value="Submit" id="submit_button"/>&nbsp;&nbsp;
                    <input class="btn btn-primary" type="reset"  value="Reset" id="reset"/>
                </div>

            </div>

        </div>
    </div>




</form>

<br>

<form>





    <div class="container1 container-White py-10">

        <!--   Modal -->
        <!--         <div id="myModal" class="modal fade modal-sm " role="dialog" align="center" id="modal_id"> -->
        <!--             <div class="modal-dialog modal-dialog-centered modal-sm"> -->

        <!--                 Modal content -->
        <!--                 <div class="modal-content"> -->
        <!--                     <div class="modal-header"> -->

        <!--                  <img src="resources/loading.gif" height="2%" width="2%" id="loading_img"> -->
        <!--                  <br>  -->
        <!--                   <h6><b><span style=color:#6b1381>Please click <input class="btn btn-primary" type="button" value="Approve All" disabled> carefully,<br> -->
        <!--                   Once approved....changes can't be recovered.</span></b></h6> -->



        <!--                         <button type="button" class="close" data-dismiss="modal">&times;</button> -->
        <!--                         <h4 class="modal-title"></h4> -->
        <!--                     </div> -->
        <!--                     <div class="" align="center"> -->

        <!--                       <div style="clear:both"> -->

        <!--                        Hello -->
        <!-- </div> -->

        <!--                         <div class="modal-footer" align="center"> -->
        <!--                             <button type="button" id="bulkApprove" class="btn btn-default btn-primary">APPROVE ALL</button> -->


        <!--                         </div> -->
        <!--                     </div> -->

        <!--                 </div> -->
        <!--             </div> -->
        <!--         </div>   -->


        <%-- <div id="divImage" style="display: none;height:75px;width:75px">
             <img src="https://media.giphy.com/media/3oEjI6SIIHBdRxXI40/giphy.gif" >
         </div>--%>

        <!-- The Modal -->
        <div id="myModal" class="modal">

            <!-- Modal content -->
            <div class="modal-content">
                <div id="divImage" style="height:50px;width:50px">
                    <img src="https://media.giphy.com/media/xTk9ZvMnbIiIew7IpW/giphy.gif" >
                </div>
                <p>Processing... Please wait (It may take few seconds)</p>
            </div>

        </div>



        <div class="col-sm-12">


            <!--    <div align="left"> -->
            <!-- <button align="right" type="button" class="btn btn-default btn-primary" data-toggle="modal" data-target="#myModal" id="show_doc">Bulk Approve</button>  -->
            <!--  </div> -->
            <br>

            <!-- Example DataTables Card-->
            <div class="card mb-3">

                <div class="card-header">



                    <table class="table table-bordered py10" id="ex1" width="100%" cellspacing="0" >

                        <thead>
                        <tr class="warning" >
                            <td ><h6>Sr. No</h6></td>
                            <td ><h6>Project</h6></td>
                            <!--                     <td ><h6>Jira ID</h6></td> -->
                            <td ><h6>Issue Name</h6></td>
                            <td ><h6>Date</h6></td>
                            <!--                       <td ><h6>Updated At</h6></td> -->
                            <td ><h6>Description</h6></td>
                            <td ><h6>Resource</h6></td>
                            <td ><h6>Time Logged</h6></td>
                            <td><h6>Status</h6></td>

                        </tr>
                        </thead>



                        <%
                            try{

                                //GetWorklogs gw=new GetWorklogs();
                                if(request.getAttribute("JSON_RESULT")==null || request.getAttribute("JSON_RESULT")=="")
                                {
                                   // out.println("Action Not Allowed");
                                    response.sendRedirect("home");
                                }
                                else
                                {
                                   %>
                        <input type="hidden" id="JSON_RESULT" value="<%=request.getAttribute("JSON_RESULT")%>">
                                  <%  List<Object[]> l=(List<Object[]>)request.getAttribute("JSON_RESULT");


                                    int j=0;
                                    for(Object[] obj : l)
                                    {
                                        ++j;

                                        String project_id=(String)obj[0];
                                        String worklog_id=(String)obj[1];
                                        String issue_id=(String)obj[2];
                        %>


                        <td><%=j %></td>
                        <td><%=obj[0]%></td>

                     <%--   <td><%=obj[2]%></td>--%>
                        <td><%=obj[1]%></td>
                        <td><%=obj[3]%></td>

                        <td class ="expand_hover"><%=obj[4]%></td>
                        <td><%=obj[5]%></td>
                        <td><%=obj[6]%> hours</td>


                        <td>
                            <%
                                int status=(Integer)obj[7];
                                if(status==2)
                                {
                            %>
                            <input type="hidden" id="p_project<%=j%>" value="<%=project_id%>" >
                            <input type="hidden" id="p_worklog<%=j%>" value="<%=worklog_id%>" >
                            <input type="hidden" id="p_issue<%=j%>" value="<%=issue_id%>" >
                            <input class="btn btn-primary" type="button" value="Approve" id="approve_button<%=j%>"
                                   onclick="confirmation('p_project<%=j%>','p_worklog<%=j%>','p_issue<%=j%>','approve_button<%=j%>','reject_button<%=j%>')" />
                            <input class="btn btn-primary" type="button" value="Reject" id="reject_button<%=j%>"
                                   onclick="rejection('p_project<%=j%>','p_worklog<%=j%>','p_issue<%=j%>','reject_button<%=j%>','approve_button<%=j%>')" />
                            <b style="display:none;">Not Approved</b>

                            <%  }
                            %>

                            <%    if(status==1)
                            {
                            %>
                            <input class="btn btn-primary" type="button"  value="Approved" id="" disabled/>
                            <b style="display:none;">Approved</b>
                            <%  }

                                if(status==0)
                                {
                            %>
                            <input class="btn btn-primary" type="button"  value="Rejected" id="" disabled/>
                            <b style="display:none;">Rejected</b>
                            <%  }
                            %>






                        </td>
                        </tr>
                        <%
                                    }
                                }
                            }
                            catch(Throwable e)
                            {
                                e.printStackTrace();
                            }
                        %>



                    </table>




                </div>
            </div>


        </div>
        <!--          </section> -->
        <!--          </div> -->
    </div>
</form>
<br>
<div class="footer">
    <br>
    <p class="footer-company-name">© 2018 COPYRIGHT ICREON</p>
</div>

<script src="resources/js/jquery-1.8.3.min.js"></script>

<script type="text/javascript">
    $('#submit_button').on("click",function() {
        if (document.getElementById('projects').value=="0") {
            document.getElementById('projects').focus();
            alert("Please select project");
            return false;
        }

        if (document.getElementById('issues').value=="0") {
            document.getElementById('issues').focus();
            alert("Please select issue");
            return false;
        }
    }); </script>



<script type="text/javascript">
    $category = $('#projects');

    $category.change (

        function() {

            //	alert('Calling Controller');

            $.ajax({
                type: "POST",
                url: "getAllIssuesInProject",
                data: {projects: document.getElementById('projects').value },
                success: function(data){
                    $('#issues').empty();
                    //	alert(data);
                    var list = "";
                    var list = jQuery.parseJSON(data);
                    if(list=='')
                    {
                        alert('Records Not Available for Selected Data');
                    }
                    if(list!=''){
                        $('#issues').append('<option value="0">Select</option>');
                        for (var i = 0; i < list.length; i++) {
                            $('#issues').append('<option value="' + list[i] + '">' + list[i]+ '</option>');

                        }

                    }


                }
            });

        }
    );

</script>


<script type="text/javascript">
    $category = $('#issues');

    $category.change (

        function() {

            //	alert('Calling Controller');

            $.ajax({
                type: "POST",
                url: "getAuthors",
                data: {issue: document.getElementById('issues').value },
                success: function(data){
                    $('#user').empty();
                    //	alert(data);
                    var  issueName=document.getElementById('issues').value;
                    var list = "";
                    var list = jQuery.parseJSON(data);
                    if(list=='')
                    {
                        $('#user').append('<option value="0">Select</option>');
                        alert('No Resources are Associated with '+issueName);
                    }
                    if(list!=''){
                        $('#user').append('<option value="0">Select</option>');
                        for (var i = 0; i < list.length; i++) {
                            $('#user').append('<option value="' + list[i] + '">' + list[i]+ '</option>');

                        }

                    }


                }
            });

        }
    );

</script>


<script>
    function confirmation(p,w,i,ab,st)
    {

        /*  $("#divImage").show();*/

        // Get the modal
        var modal = document.getElementById('myModal');
        modal.style.display = "block";

        /*   window.scrollTo(0,0);*/

        var x=document.getElementById(p).value;
        var y=document.getElementById(w).value;
        var z=document.getElementById(i).value;
        //  alert(x);
        //  alert(y);
        //   alert(z);
        //alert(ab);
        $.ajax({
            type: 'GET',
            url: "updateApproveStatus",
            data: {
                project_id:x,
                worklog_id:y,
                issue_id:z
            },
            success:function(data)
            {
               // $("#divImage").hide();
                //	alert(data);
                var list = "";
                var list = jQuery.parseJSON(data);
                if(list==1)
                {
                  //  alert('Approved and Sent Notification by Mail');

                    //$("#st").hide();
                    document.getElementById(ab).value='Approved';
                    document.getElementById(st).style.visibility = "hidden";
                    document.getElementById(ab).disabled = true;

                    modal.style.display = "none";

                    location.reload(false);

                }




            }
        });
    }
</script>


<script>
    function rejection(p,w,i,ab,st1)
    {
        /*  $("#divImage").show();*/
        // Get the modal
        var modal = document.getElementById('myModal');
        modal.style.display = "block";

        var x=document.getElementById(p).value;
        var y=document.getElementById(w).value;
        var z=document.getElementById(i).value;
        //  alert(x);
        //  alert(y);
        //   alert(z);
        //alert(ab);
        $.ajax({
            type: 'GET',
            url: "updateApproveStatusToReject",
            data: {
                project_id:x,
                worklog_id:y,
                issue_id:z
            },
            success:function(data)
            {
               // $("#divImage").hide();
                //	alert(data);
                var list = "";
                var list = jQuery.parseJSON(data);
                if(list==1)
                {
                 //   alert('Rejected Sent Notification by Mail');
                    // 	$('#ab').val('Hello');

                    document.getElementById(ab).value='Rejected';
                    document.getElementById(st1).style.visibility = "hidden";
                    document.getElementById(ab).disabled = true;
                    //document.getElementById(st1).disabled = true;

                    modal.style.display = "none";
                    location.reload(false);
                    //window.location.href = window.location.href + "?search=" + escape( $("#someId").val());
                //    window.location.href = "new_worklogs.jsp"; JSON_RESULT
                /*    alert(document.getElementById("#JSON_RESULT").valueOf());
                    window.location.href ="new_worklogs.jsp"+"?"+"JSON_RESULT="+escape( $("#JSON_RESULT").val());*/
                //    window.location.href = window.location.href + "?search=" + escape( $("#someId").val());
                }




            }
        });
    }
</script>


<!-- Bootstrap core JavaScript-->
<script src="resources/resources/vendor/jquery/jquery.min.js"></script>
<script src="resources/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="resources/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
<!-- Page level plugin JavaScript-->
<script src="resources/resources/vendor/datatables/jquery.dataTables.js"></script>
<script src="resources/resources/vendor/datatables/dataTables.bootstrap4.js"></script>
<!-- Custom scripts for all pages-->
<script src="resources/resources/js/sb-admin.min.js"></script>
<!-- Custom scripts for this page-->
<script src="resources/resources/js/sb-admin-datatables.min.js"></script>


<script type="text/javascript" src="resources/js/responsee.js"></script>


<script type="text/javascript" src="resources/resources/js/jquery-1.12.4.js"></script>


<script type="text/javascript" src="resources/resources/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="resources/resources/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="resources/resources/js/buttons.flash.min.js"></script>
<script type="text/javascript" src="resources/resources/js/jszip.min.js"></script>
<script type="text/javascript" src="resources/resources/js/pdfmake.min.js"></script>
<script  type="text/javascript" src="resources/resources/js/vfs_fonts.js"></script>
<script type="text/javascript" src="resources/resources/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="resources/resources/js/buttons.print.min.js"></script>


<script  type="text/javascript">
    $(document).ready(function () {
        $('#ex1').DataTable({
            language: {
                paginate: {
                    next: '&#8594;', // or '→'
                    previous: '&#8592;' // or '←'
                }
            },
            "fnDrawCallback": function(oSettings) {
                if ($('#ex1 tr').length < 24) {
                    $('.dataTables_paginate').hide();
                }
            },
            "lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]],

            dom: 'Bfrtip',
            buttons: [
                'excel', 'print'
            ],

        });

        $('#ex1').on( 'page.dt', function () {
            $('html, body').animate({
                scrollTop: 0
            }, 300);
        } );
    });


    //   $(document).ready(function() {
    //	    $("#bulkApprove").click(function(){
    //	        alert("Reocrds Successfully Approved");
    //	        window.location.href = "approvedWorklogs.jsp";
    //	    }); 
    //	});
</script>


<script type="text/javascript">
    $('#reset').on("click",function() {

        $('#projects').empty();
        $('#projects').append('<option value="0">Select</option>');

        $('#issues').empty();
        $('#issues').append('<option value="0">Select</option>');

    }); </script>






</body>
</html>