<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reston Real Estate Web Database</title>
    <!-- Static navbar -->
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="#">Reston Real Estate</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li><a href="Customers.aspx">Customers</a></li>
                    <li><a href="Agents.aspx">Agents</a></li>
                    <li><a href="Homes.aspx">Homes</a></li>
                    <li><a href="Sales.aspx">Sales</a></li>
                </ul>
            </div>
            <!--/.nav-collapse -->
        </div>
        <!--/.container-fluid -->
    </nav>
</head>
<body>
    <form id="form1" runat="server">
        <div class="jumbotron">
            <div class="container">
                <h3>Reston Real Estate is the <strong>leading</strong> real estate agent in the United States!</h3>
            </div>
        </div>
    </form>
</body>
</html>
