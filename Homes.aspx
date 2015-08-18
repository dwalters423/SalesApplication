<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Homes.aspx.cs" Inherits="_Default" %>

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
                    <li><a href="Agents.aspx">Agents</a></li>
                    <li class="active"><a href="#">Homes</a></li>
                    <li><a href="Sales.aspx">Sales</a></li>
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
                    <h3 class="panel-title">Homes</h3>
                </div>
                <div class="panel-body">
                    <% 
                        //Declares the table header, only if the application has one or more result. 
                        int rowNumber = HomesView.Rows.Count;
                        if (rowNumber > 0)
                        {
                            HomesView.HeaderRow.TableSection = TableRowSection.TableHeader;
                        } %>
                    <asp:GridView ID="HomesView" runat="server" AllowPaging="True" DataKeyNames="HOME_ID" DataSourceID="HomesDB" CssClass="table table-hover table-condensed" GridLines="None" RowHeaderColumn="HOME_ID" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="HOME_ID" HeaderText="ID" ReadOnly="True" SortExpression="HOME_ID" />
                            <asp:BoundField DataField="LOT_SIZE" HeaderText="Size" SortExpression="LOT_SIZE" />
                            <asp:BoundField DataField="PRICE" HeaderText="Price" SortExpression="PRICE" DataFormatString="{0:c2}" />
                            <asp:TemplateField HeaderText="Address" SortExpression="ADDRESS_STREET">
                                <ItemTemplate>
                                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("ADDRESS_STREET") %>'></asp:Label>
                                    ,<asp:Label ID="Label16" runat="server" Text='<%# Eval("ADDRESS_CITY") %>'></asp:Label>
                                    ,<asp:Label ID="Label17" runat="server" Text='<%# Eval("ADDRESS_STATE") %>'></asp:Label>
                                    ,<asp:Label ID="Label18" runat="server" Text='<%# Eval("ADDRESS_ZIP") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ButtonType="Button" ShowSelectButton="True">
                                <ControlStyle CssClass="btn btn-info btn-xs" />
                            </asp:CommandField>
                        </Columns>
                        <SelectedRowStyle CssClass="info" />
                    </asp:GridView>
                    <!-- GRID VIEW DATA SOURCE -->
                    <asp:SqlDataSource ID="HomesDB" runat="server"
                        ConnectionString="<%$ ConnectionStrings:OracleConnString %>"
                        OldValuesParameterFormatString="original_{0}"
                        ProviderName="<%$ ConnectionStrings:OracleConnString.ProviderName %>"
                        SelectCommand="SELECT * FROM &quot;HOMES&quot;"></asp:SqlDataSource>
                    <!-- END GRID VIEW DATA SOURCE -->
                    <asp:LinkButton ID="NewRecordButton" runat="server" CssClass="btn btn-primary btn-xs pull-right" OnClick="NewRecordButton_Click">New Home</asp:LinkButton>
                </div>
            </div>
            <asp:FormView ID="HomesFormView" runat="server" DataSourceID="HomeFormViewSource" DataKeyNames="HOME_ID" CssClass="col-lg-4" OnItemInserted="HomeFormView_ItemInserted" OnItemDeleted="HomeFormView_ItemDeleted" OnItemUpdated="HomeFormView_ItemUpdated">
                <EditItemTemplate>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">Editing Home <%# Eval("Home_ID") %>
                                <div class="btn-group pull-right" role="group">
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-success btn-xs" />
                                    <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-warning btn-xs" />
                                </div>
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="form-horizontal">
                                <div class="form-group-sm">
                                    <label for="LotSizeEditText" class="control-label">Lot Size:</label>
                                    <asp:TextBox ID="LotSizeEditText" runat="server" Text='<%# Bind("LOT_SIZE") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="LotSizeEditValidator" runat="server" ControlToValidate="LotSizeEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter lot size in square meters." OnServerValidate="IsNumeric_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="PriceEditText" class="control-label">Price:</label>
                                    <div class="input-group">
                                        <span class="input-group-addon">$</span>
                                        <asp:TextBox ID="PriceEditText" runat="server" Text='<%# Bind("PRICE") %>' CssClass="form-control col-sm-6 input-sm" />
                                        <span class="input-group-addon">.00</span>
                                    </div>
                                    <asp:CustomValidator ID="PriceEditValidator" runat="server" ControlToValidate="PriceEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter price in $USD." OnServerValidate="IsNumeric_ServerValidate" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="ADDRESS_STREETEditText" class="control-label">Street Address:</label>
                                    <asp:TextBox ID="ADDRESS_STREETEditText" runat="server" Text='<%# Bind("ADDRESS_STREET") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="StreetAddressEditValidator" runat="server" ControlToValidate="ADDRESS_STREETEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter a street address." OnServerValidate="NotEmpty_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="ADDRESS_CITYEditText" class="control-label">City:</label>
                                    <asp:TextBox ID="ADDRESS_CITYEditText" runat="server" Text='<%# Bind("ADDRESS_CITY") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="CityEditValidator" runat="server" ControlToValidate="ADDRESS_CITYEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter a city." OnServerValidate="NotEmpty_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="StateEditDropDownList" class="control-label">State:</label>
                                    <asp:DropDownList ID="StateEditDropDownList" runat="server" SelectedValue='<%# Bind("ADDRESS_STATE") %>' CssClass="form-control col-sm-6 input-sm">
                                        <asp:ListItem Value="NONE">Choose State</asp:ListItem>
                                        <asp:ListItem Value="AL">Alabama</asp:ListItem>
                                        <asp:ListItem Value="AK">Alaska</asp:ListItem>
                                        <asp:ListItem Value="AZ">Arizona</asp:ListItem>
                                        <asp:ListItem Value="AR">Arkansas</asp:ListItem>
                                        <asp:ListItem Value="CA">California</asp:ListItem>
                                        <asp:ListItem Value="CO">Colorado</asp:ListItem>
                                        <asp:ListItem Value="CT">Connecticut</asp:ListItem>
                                        <asp:ListItem Value="DC">District of Columbia</asp:ListItem>
                                        <asp:ListItem Value="DE">Delaware</asp:ListItem>
                                        <asp:ListItem Value="FL">Florida</asp:ListItem>
                                        <asp:ListItem Value="GA">Georgia</asp:ListItem>
                                        <asp:ListItem Value="HI">Hawaii</asp:ListItem>
                                        <asp:ListItem Value="ID">Idaho</asp:ListItem>
                                        <asp:ListItem Value="IL">Illinois</asp:ListItem>
                                        <asp:ListItem Value="IN">Indiana</asp:ListItem>
                                        <asp:ListItem Value="IA">Iowa</asp:ListItem>
                                        <asp:ListItem Value="KS">Kansas</asp:ListItem>
                                        <asp:ListItem Value="KY">Kentucky</asp:ListItem>
                                        <asp:ListItem Value="LA">Louisiana</asp:ListItem>
                                        <asp:ListItem Value="ME">Maine</asp:ListItem>
                                        <asp:ListItem Value="MD">Maryland</asp:ListItem>
                                        <asp:ListItem Value="MA">Massachusetts</asp:ListItem>
                                        <asp:ListItem Value="MI">Michigan</asp:ListItem>
                                        <asp:ListItem Value="MN">Minnesota</asp:ListItem>
                                        <asp:ListItem Value="MS">Mississippi</asp:ListItem>
                                        <asp:ListItem Value="MO">Missouri</asp:ListItem>
                                        <asp:ListItem Value="MT">Montana</asp:ListItem>
                                        <asp:ListItem Value="NE">Nebraska</asp:ListItem>
                                        <asp:ListItem Value="NV">Nevada</asp:ListItem>
                                        <asp:ListItem Value="NH">New Hampshire</asp:ListItem>
                                        <asp:ListItem Value="NJ">New Jersey</asp:ListItem>
                                        <asp:ListItem Value="NM">New Mexico</asp:ListItem>
                                        <asp:ListItem Value="NY">New York</asp:ListItem>
                                        <asp:ListItem Value="NC">North Carolina</asp:ListItem>
                                        <asp:ListItem Value="ND">North Dakota</asp:ListItem>
                                        <asp:ListItem Value="OH">Ohio</asp:ListItem>
                                        <asp:ListItem Value="OK">Oklahoma</asp:ListItem>
                                        <asp:ListItem Value="OR">Oregon</asp:ListItem>
                                        <asp:ListItem Value="PA">Pennsylvania</asp:ListItem>
                                        <asp:ListItem Value="RI">Rhode Island</asp:ListItem>
                                        <asp:ListItem Value="SC">South Carolina</asp:ListItem>
                                        <asp:ListItem Value="SD">South Dakota</asp:ListItem>
                                        <asp:ListItem Value="TN">Tennessee</asp:ListItem>
                                        <asp:ListItem Value="TX">Texas</asp:ListItem>
                                        <asp:ListItem Value="UT">Utah</asp:ListItem>
                                        <asp:ListItem Value="VT">Vermont</asp:ListItem>
                                        <asp:ListItem Value="VA">Virginia</asp:ListItem>
                                        <asp:ListItem Value="WA">Washington</asp:ListItem>
                                        <asp:ListItem Value="WV">West Virginia</asp:ListItem>
                                        <asp:ListItem Value="WI">Wisconsin</asp:ListItem>
                                        <asp:ListItem Value="WY">Wyoming</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CustomValidator ID="StateEditValidator" runat="server" ControlToValidate="StateEditDropDownList" CssClass="label label-warning  pull-right" ErrorMessage="Please enter a state." OnServerValidate="State_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="ADDRESS_ZIPEditText" class="control-label">Postal Code:</label>
                                    <asp:TextBox ID="ADDRESS_ZIPEditText" runat="server" Text='<%# Bind("ADDRESS_ZIP") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="ZipEditValidator" runat="server" ControlToValidate="ADDRESS_ZIPEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter a valid zip code." OnServerValidate="IsNumeric_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">Insert a New Home
                                <div class="btn-group pull-right" role="group">
                                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" CssClass="btn btn-success btn-xs" />
                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-warning btn-xs" />
                                </div>
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="form-horizontal">
                                <div class="form-group-sm">
                                    <label for="LotSizeEditText" class="control-label">Lot Size:</label>
                                    <asp:TextBox ID="LotSizeEditText" runat="server" Text='<%# Bind("LOT_SIZE") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="LotSizeEditValidator" runat="server" ControlToValidate="LotSizeEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter lot size in square meters." OnServerValidate="IsNumeric_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="PriceEditText" class="control-label">Price:</label>
                                    <div class="input-group">
                                        <span class="input-group-addon">$</span>
                                        <asp:TextBox ID="PriceEditText" runat="server" Text='<%# Bind("PRICE") %>' CssClass="form-control col-sm-6 input-sm" />
                                        <span class="input-group-addon">.00</span>
                                    </div>
                                    <asp:CustomValidator ID="PriceEditValidator" runat="server" ControlToValidate="PriceEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter price in $USD." OnServerValidate="IsNumeric_ServerValidate" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="ADDRESS_STREETEditText" class="control-label">Street Address:</label>
                                    <asp:TextBox ID="ADDRESS_STREETEditText" runat="server" Text='<%# Bind("ADDRESS_STREET") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="StreetAddressEditValidator" runat="server" ControlToValidate="ADDRESS_STREETEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter a street address." OnServerValidate="NotEmpty_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="ADDRESS_CITYEditText" class="control-label">City:</label>
                                    <asp:TextBox ID="ADDRESS_CITYEditText" runat="server" Text='<%# Bind("ADDRESS_CITY") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="CityEditValidator" runat="server" ControlToValidate="ADDRESS_CITYEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter a city." OnServerValidate="NotEmpty_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="StateEditDropDownList" class="control-label">State:</label>
                                    <asp:DropDownList ID="StateEditDropDownList" runat="server" SelectedValue='<%# Bind("ADDRESS_STATE") %>' CssClass="form-control col-sm-6 input-sm">
                                        <asp:ListItem Value="NONE">Choose State</asp:ListItem>
                                        <asp:ListItem Value="AL">Alabama</asp:ListItem>
                                        <asp:ListItem Value="AK">Alaska</asp:ListItem>
                                        <asp:ListItem Value="AZ">Arizona</asp:ListItem>
                                        <asp:ListItem Value="AR">Arkansas</asp:ListItem>
                                        <asp:ListItem Value="CA">California</asp:ListItem>
                                        <asp:ListItem Value="CO">Colorado</asp:ListItem>
                                        <asp:ListItem Value="CT">Connecticut</asp:ListItem>
                                        <asp:ListItem Value="DC">District of Columbia</asp:ListItem>
                                        <asp:ListItem Value="DE">Delaware</asp:ListItem>
                                        <asp:ListItem Value="FL">Florida</asp:ListItem>
                                        <asp:ListItem Value="GA">Georgia</asp:ListItem>
                                        <asp:ListItem Value="HI">Hawaii</asp:ListItem>
                                        <asp:ListItem Value="ID">Idaho</asp:ListItem>
                                        <asp:ListItem Value="IL">Illinois</asp:ListItem>
                                        <asp:ListItem Value="IN">Indiana</asp:ListItem>
                                        <asp:ListItem Value="IA">Iowa</asp:ListItem>
                                        <asp:ListItem Value="KS">Kansas</asp:ListItem>
                                        <asp:ListItem Value="KY">Kentucky</asp:ListItem>
                                        <asp:ListItem Value="LA">Louisiana</asp:ListItem>
                                        <asp:ListItem Value="ME">Maine</asp:ListItem>
                                        <asp:ListItem Value="MD">Maryland</asp:ListItem>
                                        <asp:ListItem Value="MA">Massachusetts</asp:ListItem>
                                        <asp:ListItem Value="MI">Michigan</asp:ListItem>
                                        <asp:ListItem Value="MN">Minnesota</asp:ListItem>
                                        <asp:ListItem Value="MS">Mississippi</asp:ListItem>
                                        <asp:ListItem Value="MO">Missouri</asp:ListItem>
                                        <asp:ListItem Value="MT">Montana</asp:ListItem>
                                        <asp:ListItem Value="NE">Nebraska</asp:ListItem>
                                        <asp:ListItem Value="NV">Nevada</asp:ListItem>
                                        <asp:ListItem Value="NH">New Hampshire</asp:ListItem>
                                        <asp:ListItem Value="NJ">New Jersey</asp:ListItem>
                                        <asp:ListItem Value="NM">New Mexico</asp:ListItem>
                                        <asp:ListItem Value="NY">New York</asp:ListItem>
                                        <asp:ListItem Value="NC">North Carolina</asp:ListItem>
                                        <asp:ListItem Value="ND">North Dakota</asp:ListItem>
                                        <asp:ListItem Value="OH">Ohio</asp:ListItem>
                                        <asp:ListItem Value="OK">Oklahoma</asp:ListItem>
                                        <asp:ListItem Value="OR">Oregon</asp:ListItem>
                                        <asp:ListItem Value="PA">Pennsylvania</asp:ListItem>
                                        <asp:ListItem Value="RI">Rhode Island</asp:ListItem>
                                        <asp:ListItem Value="SC">South Carolina</asp:ListItem>
                                        <asp:ListItem Value="SD">South Dakota</asp:ListItem>
                                        <asp:ListItem Value="TN">Tennessee</asp:ListItem>
                                        <asp:ListItem Value="TX">Texas</asp:ListItem>
                                        <asp:ListItem Value="UT">Utah</asp:ListItem>
                                        <asp:ListItem Value="VT">Vermont</asp:ListItem>
                                        <asp:ListItem Value="VA">Virginia</asp:ListItem>
                                        <asp:ListItem Value="WA">Washington</asp:ListItem>
                                        <asp:ListItem Value="WV">West Virginia</asp:ListItem>
                                        <asp:ListItem Value="WI">Wisconsin</asp:ListItem>
                                        <asp:ListItem Value="WY">Wyoming</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CustomValidator ID="StateEditValidator" runat="server" ControlToValidate="StateEditDropDownList" CssClass="label label-warning  pull-right" ErrorMessage="Please enter a state." OnServerValidate="State_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="ADDRESS_ZIPEditText" class="control-label">Postal Code:</label>
                                    <asp:TextBox ID="ADDRESS_ZIPEditText" runat="server" Text='<%# Bind("ADDRESS_ZIP") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="ZipEditValidator" runat="server" ControlToValidate="ADDRESS_ZIPEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter a valid zip code." OnServerValidate="IsNumeric_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                </InsertItemTemplate>
                <ItemTemplate>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">Viewing Home <%# Eval("HOME_ID") %>
                                <div class="btn-group pull-right" role="group">
                                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" CssClass="btn btn-info btn-xs" />
                                    <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" CssClass="btn btn-warning btn-xs" />
                                </div>
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="form-horizontal">
                                <div class="form-group-sm">
                                    <label for="LotSizeLabel" class="control-label col-sm-6">Lot Size:</label>
                                    <asp:Label ID="LotSizeLabel" runat="server" Text='<%# Bind("LOT_SIZE") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="PriceLabel" class="control-label col-sm-6">Price:</label>
                                    <asp:Label ID="PriceLabel" runat="server" Text='<%# ((decimal)Eval("PRICE")).ToString("C") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="ADDRESS_STREETLabel" class="control-label col-sm-6">Street Address:</label>
                                    <asp:Label ID="ADDRESS_STREETLabel" runat="server" Text='<%# Bind("ADDRESS_STREET") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="ADDRESS_CITYLabel" class="control-label col-sm-6">City:</label>
                                    <asp:Label ID="ADDRESS_CITYLabel" runat="server" Text='<%# Bind("ADDRESS_CITY") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="ADDRESS_STATELabel" class="control-label col-sm-6">State:</label>
                                    <asp:Label ID="ADDRESS_STATELabel" runat="server" Text='<%# Bind("ADDRESS_STATE") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="ADDRESS_ZIPLabel" class="control-label col-sm-6">Postal Code:</label>
                                    <asp:Label ID="ADDRESS_ZIPLabel" runat="server" Text='<%# Bind("ADDRESS_ZIP") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="HomeFormViewSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:OracleConnString %>"
                SelectCommand="SELECT * FROM &quot;HOMES&quot; WHERE HOME_ID = :HOME_IDSelected"
                ProviderName="<%$ ConnectionStrings:OracleConnString.ProviderName %>"
                DeleteCommand="DELETE FROM &quot;HOMES&quot; WHERE &quot;HOME_ID&quot; = :HOME_ID"
                InsertCommand="INSERT INTO &quot;HOMES&quot; (&quot;LOT_SIZE&quot;, &quot;PRICE&quot;, &quot;ADDRESS_STREET&quot;, &quot;ADDRESS_CITY&quot;, &quot;ADDRESS_STATE&quot;, &quot;ADDRESS_ZIP&quot;) VALUES (:LOT_SIZE, :PRICE, :ADDRESS_STREET, :ADDRESS_CITY, :ADDRESS_STATE, :ADDRESS_ZIP)"
                UpdateCommand="UPDATE &quot;HOMES&quot; SET &quot;LOT_SIZE&quot; = :LOT_SIZE, &quot;PRICE&quot; = :PRICE, &quot;ADDRESS_STREET&quot; = :ADDRESS_STREET, &quot;ADDRESS_CITY&quot; = :ADDRESS_CITY, &quot;ADDRESS_STATE&quot; = :ADDRESS_STATE, &quot;ADDRESS_ZIP&quot; = :ADDRESS_ZIP WHERE &quot;HOME_ID&quot; = :HOME_ID">
                <DeleteParameters>
                    <asp:Parameter Name="HOME_ID" Type="Decimal" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="HomesView" Name="HOME_IDSelected" Type="Decimal" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="LOT_SIZE" Type="Decimal" />
                    <asp:Parameter Name="PRICE" Type="Decimal" />
                    <asp:Parameter Name="ADDRESS_STREET" Type="String" />
                    <asp:Parameter Name="ADDRESS_CITY" Type="String" />
                    <asp:Parameter Name="ADDRESS_STATE" Type="String" />
                    <asp:Parameter Name="ADDRESS_ZIP" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="LOT_SIZE" Type="Decimal" />
                    <asp:Parameter Name="PRICE" Type="Decimal" />
                    <asp:Parameter Name="ADDRESS_STREET" Type="String" />
                    <asp:Parameter Name="ADDRESS_CITY" Type="String" />
                    <asp:Parameter Name="ADDRESS_STATE" Type="String" />
                    <asp:Parameter Name="ADDRESS_ZIP" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
