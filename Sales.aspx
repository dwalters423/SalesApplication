<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Sales.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reston Real Estate Web Database</title>
    <!-- Static navbar -->
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="Default.aspx">Reston Real Estate</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li><a href="Customers.aspx">Customers</a></li>
                    <li><a href="agents.aspx">Agents</a></li>
                    <li><a href="Homes.aspx">Homes</a></li>
                    <li class="active"><a href="#">Sales</a></li>
                </ul>
            </div>
            <!--/.nav-collapse -->
        </div>
        <!--/.container-fluid -->
    </nav>
</head>
<body>
    <form id="form1" runat="server" class="form-horizontal">
        <div class="container">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Sales</h3>
                </div>
                <div class="panel-body">
                    <% 
                        //Declares the table header, only if the application has one or more result. 
                        int rowNumber = SalesView.Rows.Count;
                        if (rowNumber > 0)
                        {
                            SalesView.HeaderRow.TableSection = TableRowSection.TableHeader;
                        } %>
                    <asp:GridView ID="SalesView" runat="server" AllowPaging="True" DataKeyNames="SALE_ID" DataSourceID="SalesDB" CssClass="table table-hover table-condensed" GridLines="None" RowHeaderColumn="SALE_ID" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="SALE_ID" HeaderText="ID" ReadOnly="True" SortExpression="SALE_ID" />
                            <asp:BoundField DataField="CUST_ID" HeaderText="Customer ID" SortExpression="CUST_ID" />
                            <asp:BoundField DataField="AGENT_ID" HeaderText="Agent ID" SortExpression="AGENT_ID" />
                            <asp:BoundField DataField="HOME_ID" HeaderText="Home ID" SortExpression="HOME_ID" />
                            <asp:BoundField DataField="SALE_DATE" HeaderText="Sale Date" SortExpression="SALE_DATE" />
                            <asp:BoundField DataField="SALE_AMT" HeaderText="Sale Amount" SortExpression="SALE_AMT" DataFormatString="{0:c2}"/>
                            <asp:CommandField ButtonType="Button" ShowSelectButton="True">
                                <ControlStyle CssClass="btn btn-info btn-xs" />
                            </asp:CommandField>
                        </Columns>
                        <SelectedRowStyle CssClass="info" />
                    </asp:GridView>
                    <!-- GRID VIEW DATA SOURCE -->
                    <asp:SqlDataSource ID="SalesDB" runat="server"
                        ConnectionString="<%$ ConnectionStrings:OracleConnString %>"
                        OldValuesParameterFormatString="original_{0}"
                        ProviderName="<%$ ConnectionStrings:OracleConnString.ProviderName %>"
                        SelectCommand="SELECT * FROM &quot;SALES&quot;"></asp:SqlDataSource>
                    <!-- END GRID VIEW DATA SOURCE -->
                    <asp:LinkButton ID="NewRecordButton" runat="server" CssClass="btn btn-primary btn-xs pull-right" OnClick="NewRecordButton_Click">New Home</asp:LinkButton>
                </div>
            </div>
            <asp:FormView ID="SalesFormView" runat="server" DataSourceID="SaleFormViewSource" DataKeyNames="SALE_ID" CssClass="col-lg-4" OnItemInserted="SaleFormView_ItemInserted" OnItemDeleted="SaleFormView_ItemDeleted" OnItemUpdated="SaleFormView_ItemUpdated">
                <EditItemTemplate>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">Editing Sale <%# Eval("SALE_ID") %>
                                <div class="btn-group pull-right" role="group">
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-success btn-xs" />
                                    <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-warning btn-xs" />
                                </div>
                                <h3></h3>
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="form-horizontal">
                                <div class="form-group-sm">
                                    <label for="CustomerEditText" class="control-label">Customer:</label>
                                    <asp:DropDownList ID="CustomerEditText" runat="server" AppendDataBoundItems="True" CssClass="form-control col-sm-6 input-sm" DataSourceID="CustomerDataSource" DataTextField="CUST_ID" DataValueField="CUST_ID" SelectedValue='<%# Bind("CUST_ID") %>'>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="CustomerDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:OracleConnString %>" ProviderName="<%$ ConnectionStrings:OracleConnString.ProviderName %>" SelectCommand="SELECT &quot;CUST_ID&quot; FROM &quot;CUSTOMERS&quot;"></asp:SqlDataSource>
                                </div>
                                <div class="form-group-sm">
                                    <label for="AgentEditText" class="control-label">Agent:</label>
                                    <asp:DropDownList ID="AgentEditText" runat="server" AppendDataBoundItems="True" CssClass="form-control col-sm-6 input-sm" DataSourceID="AgentDataSource" DataTextField="AGENT_ID" DataValueField="AGENT_ID" SelectedValue='<%# Bind("AGENT_ID") %>'>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="AgentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:OracleConnString %>" ProviderName="<%$ ConnectionStrings:OracleConnString.ProviderName %>" SelectCommand="SELECT &quot;AGENT_ID&quot; FROM &quot;AGENTS&quot;"></asp:SqlDataSource>
                                </div>
                                <div class="form-group-sm">
                                    <label for="HomeEditText" class="control-label">Home:</label>
                                    <asp:DropDownList ID="HomeEditText" runat="server" AppendDataBoundItems="True" CssClass="form-control col-sm-6 input-sm" DataSourceID="HomeDataSource" DataTextField="HOME_ID" DataValueField="HOME_ID" SelectedValue='<%# Bind("HOME_ID") %>'>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="HomeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:OracleConnString %>" ProviderName="<%$ ConnectionStrings:OracleConnString.ProviderName %>" SelectCommand="SELECT &quot;HOME_ID&quot; FROM &quot;HOMES&quot;"></asp:SqlDataSource>
                                </div>
                                <div class="form-group-sm">
                                    <label for="SaleDateEditText" class="control-label">Sale Date:</label>
                                    <asp:TextBox ID="SaleDateEditText" runat="server" Text='<%# Bind("SALE_DATE") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="CityEditValidator" runat="server" ControlToValidate="SaleDateEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter valid date of sale (dd/mm/yyyy)" OnServerValidate="SaleDate_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="SalePriceEditText" class="control-label">Sale Amount:</label>
                                    <div class="input-group">
                                        <span class="input-group-addon">$</span>
                                        <asp:TextBox ID="SalePriceEditText" runat="server" Text='<%# Bind("SALE_AMT") %>' CssClass="form-control col-sm-6 input-sm" />
                                        <span class="input-group-addon">.00</span>
                                    </div>
                                    <asp:CustomValidator ID="PriceEditValidator" runat="server" ControlToValidate="SalePriceEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter sale amount in $USD." OnServerValidate="IsNumeric_ServerValidate" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">New Sale
                                <div class="btn-group pull-right" role="group">
                                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" CssClass="btn btn-success btn-xs" />
                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-warning btn-xs" />
                                </div>
                            </h3>
                        </div>
                         <div class="panel-body">
                            <div class="form-horizontal">
                                <div class="form-group-sm">
                                    <label for="CustomerEditText" class="control-label">Customer:</label>
                                    <asp:DropDownList ID="CustomerEditText" runat="server" AppendDataBoundItems="True" CssClass="form-control col-sm-6 input-sm" DataSourceID="CustomerDataSource" DataTextField="CUST_ID" DataValueField="CUST_ID" SelectedValue='<%# Bind("CUST_ID") %>'>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="CustomerDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:OracleConnString %>" ProviderName="<%$ ConnectionStrings:OracleConnString.ProviderName %>" SelectCommand="SELECT &quot;CUST_ID&quot; FROM &quot;CUSTOMERS&quot;"></asp:SqlDataSource>
                                </div>
                                <div class="form-group-sm">
                                    <label for="AgentEditText" class="control-label">Agent:</label>
                                    <asp:DropDownList ID="AgentEditText" runat="server" AppendDataBoundItems="True" CssClass="form-control col-sm-6 input-sm" DataSourceID="AgentDataSource" DataTextField="AGENT_ID" DataValueField="AGENT_ID" SelectedValue='<%# Bind("AGENT_ID") %>'>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="AgentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:OracleConnString %>" ProviderName="<%$ ConnectionStrings:OracleConnString.ProviderName %>" SelectCommand="SELECT &quot;AGENT_ID&quot; FROM &quot;AGENTS&quot;"></asp:SqlDataSource>
                                </div>
                                <div class="form-group-sm">
                                    <label for="HomeEditText" class="control-label">Home:</label>
                                    <asp:DropDownList ID="HomeEditText" runat="server" AppendDataBoundItems="True" CssClass="form-control col-sm-6 input-sm" DataSourceID="HomeDataSource" DataTextField="HOME_ID" DataValueField="HOME_ID" SelectedValue='<%# Bind("HOME_ID") %>'>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="HomeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:OracleConnString %>" ProviderName="<%$ ConnectionStrings:OracleConnString.ProviderName %>" SelectCommand="SELECT &quot;HOME_ID&quot; FROM &quot;HOMES&quot;"></asp:SqlDataSource>
                                </div>
                                <div class="form-group-sm">
                                    <label for="SaleDateEditText" class="control-label">Sale Date:</label>
                                    <asp:TextBox ID="SaleDateEditText" runat="server" Text='<%# Bind("SALE_DATE") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="CityEditValidator" runat="server" ControlToValidate="SaleDateEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter valid date of sale (dd/mm/yyyy)" OnServerValidate="SaleDate_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="SalePriceEditText" class="control-label">Sale Amount:</label>
                                    <div class="input-group">
                                        <span class="input-group-addon">$</span>
                                        <asp:TextBox ID="SalePriceEditText" runat="server" Text='<%# Bind("SALE_AMT") %>' CssClass="form-control col-sm-6 input-sm" />
                                        <span class="input-group-addon">.00</span>
                                    </div>
                                    <asp:CustomValidator ID="PriceEditValidator" runat="server" ControlToValidate="SalePriceEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter sale amount in $USD." OnServerValidate="IsNumeric_ServerValidate" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                </InsertItemTemplate>
                <ItemTemplate>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">Viewing Sale <%# Eval("SALE_ID") %>
                                <div class="btn-group pull-right" role="group">
                                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" CssClass="btn btn-info btn-xs" />
                                    <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" CssClass="btn btn-warning btn-xs" />
                                </div>
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="form-horizontal">
                                <div class="form-group-sm">
                                    <label for="CustLabel" class="control-label col-sm-6">Customer ID:</label>
                                    <asp:Label ID="CustLabel" runat="server" Text='<%# Bind("CUST_ID") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="AgentLabel" class="control-label col-sm-6">Agent ID:</label>
                                    <asp:Label ID="AgentLabel" runat="server" Text='<%# Bind("AGENT_ID") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="HomeLabel" class="control-label col-sm-6">Home ID:</label>
                                    <asp:Label ID="HomeLabel" runat="server" Text='<%# Bind("HOME_ID") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="SaleLabel" class="control-label col-sm-6">Sale Date</label>
                                    <asp:Label ID="SaleLabel" runat="server" Text='<%# Bind("SALE_DATE") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="SaleAmtLabel" class="control-label col-sm-6">Sale Amount:</label>
                                    <asp:Label ID="SaleAmtLabel" runat="server" Text='<%# ((decimal)Eval("SALE_AMT")).ToString("C") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="SaleFormViewSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:OracleConnString %>"
                SelectCommand="SELECT * FROM &quot;SALES&quot; WHERE SALE_ID = :SALE_IDSelected"
                ProviderName="<%$ ConnectionStrings:OracleConnString.ProviderName %>"
                DeleteCommand="DELETE FROM &quot;SALES&quot; WHERE &quot;SALE_ID&quot; = :SALE_ID"
                InsertCommand="INSERT INTO &quot;SALES&quot; (&quot;CUST_ID&quot;, &quot;AGENT_ID&quot;, &quot;HOME_ID&quot;, &quot;SALE_DATE&quot;, &quot;SALE_AMT&quot;) VALUES (:CUST_ID, :AGENT_ID, :HOME_ID, :SALE_DATE, :SALE_AMT)"
                UpdateCommand="UPDATE &quot;SALES&quot; SET &quot;CUST_ID&quot; = :CUST_ID, &quot;AGENT_ID&quot; = :AGENT_ID, &quot;HOME_ID&quot; = :HOME_ID, &quot;SALE_DATE&quot; = :SALE_DATE, &quot;SALE_AMT&quot; = :SALE_AMT WHERE &quot;SALE_ID&quot; = :SALE_ID">
                <DeleteParameters>
                    <asp:Parameter Name="SALE_ID" Type="Decimal" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="SalesView" Name="Sale_IDSelected" Type="Decimal" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="CUST_ID" Type="Decimal" />
                    <asp:Parameter Name="AGENT_ID" Type="Decimal" />
                    <asp:Parameter Name="HOME_ID" Type="Decimal" />
                    <asp:Parameter Name="SALE_DATE" Type="String" />
                    <asp:Parameter Name="SALE_AMT" Type="Decimal" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="CUST_ID" Type="Decimal" />
                    <asp:Parameter Name="AGENT_ID" Type="Decimal" />
                    <asp:Parameter Name="HOME_ID" Type="Decimal" />
                    <asp:Parameter Name="SALE_DATE" Type="String" />
                    <asp:Parameter Name="SALE_AMT" Type="Decimal" />
                    <asp:Parameter Name="SALE_ID" Type="Decimal" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
