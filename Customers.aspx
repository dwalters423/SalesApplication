<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Customers.aspx.cs" Inherits="_Default" %>

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
                    <li class="active"><a href="#">Customers</a></li>
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
    <form id="form1" runat="server" class="form-horizontal">
        <div class="container">
            <!-- BEGINNING OF GRID VIEW -->
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Customers</h3>
                </div>
                <div class="panel-body">
                    <% 
                        //Declares the table header, only if the application has one or more result. 
                        int rowNumber = CustomersView.Rows.Count;
                        if (rowNumber > 0)
                        {
                            CustomersView.HeaderRow.TableSection = TableRowSection.TableHeader;
                        } %>
                    <asp:GridView ID="CustomersView" runat="server" AllowPaging="True" DataKeyNames="CUST_ID" DataSourceID="CustomersDB" CssClass="table table-hover table-condensed" GridLines="None" RowHeaderColumn="CUST_ID" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="CUST_ID" HeaderText="ID" ReadOnly="True" SortExpression="CUST_ID" />
                            <asp:TemplateField HeaderText="Name" SortExpression="NAME_FIRST">
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("NAME_FIRST") %>'></asp:Label>
                                    &nbsp;<asp:Label ID="Label15" runat="server" Text='<%# Eval("NAME_LAST") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Referrer" SortExpression="REFERRER">
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("REFERRER") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Employer" SortExpression="EMPLOYER">
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("EMPLOYER") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Birth Date" SortExpression="DATE_OF_BIRTH">
                                <ItemTemplate>
                                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("DATE_OF_BIRTH") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Address" SortExpression="ADDRESS_STREET">
                                <ItemTemplate>
                                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("ADDRESS_STREET") %>'></asp:Label>
                                    ,<asp:Label ID="Label16" runat="server" Text='<%# Eval("ADDRESS_CITY") %>'></asp:Label>
                                    ,<asp:Label ID="Label17" runat="server" Text='<%# Eval("ADDRESS_STATE") %>'></asp:Label>
                                    ,<asp:Label ID="Label18" runat="server" Text='<%# Eval("ADDRESS_ZIP") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Phone (cell)" SortExpression="CELL_PHONE">
                                <ItemTemplate>
                                    <asp:Label ID="Label12" runat="server" Text='<%# Bind("CELL_PHONE") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Phone (home)" SortExpression="HOME_PHONE">
                                <ItemTemplate>
                                    <asp:Label ID="Label13" runat="server" Text='<%# Bind("HOME_PHONE") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Agent" SortExpression="AGENT_ID">
                                <ItemTemplate>
                                    <asp:Label ID="Label14" runat="server" Text='<%# Bind("AGENT_ID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ButtonType="Button" ShowSelectButton="True">
                                <ControlStyle CssClass="btn btn-info btn-xs" />
                            </asp:CommandField>
                        </Columns>
                        <SelectedRowStyle CssClass="info" />
                    </asp:GridView>
                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-primary btn-xs pull-right" OnClick="NewRecordButton_Click">New Customer</asp:LinkButton>
                </div>
            </div>
            <!-- GRID VIEW DATA SOURCE -->
            <asp:SqlDataSource ID="CustomersDB" runat="server"
                ConnectionString="<%$ ConnectionStrings:OracleConnString %>"
                OldValuesParameterFormatString="original_{0}"
                ProviderName="<%$ ConnectionStrings:OracleConnString.ProviderName %>"
                SelectCommand="SELECT * FROM CUSTOMERS"></asp:SqlDataSource>
            <!-- END GRID VIEW DATA SOURCE -->

            <!--END OF GRID VIEW -->
            <!-- BEGINNING OF FORM VIEW-->
            <asp:FormView ID="CustFormView" runat="server" DataSourceID="CustomerFormViewSource" DataKeyNames="CUST_ID" CssClass="col-lg-4" OnItemInserted="CustFormView_ItemInserted" OnItemDeleted="CustFormView_ItemDeleted" OnItemUpdated="CustFormView_ItemUpdated">
                <EditItemTemplate>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">Editing Customer <%# Eval("CUST_ID") %>
                                <div class="btn-group pull-right" role="group">
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-success btn-xs" />
                                    <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-warning btn-xs" />
                                </div>
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="form-horizontal">
                                <div class="form-group-sm">
                                    <label for="NAME_FIRSTEditText" class="control-label">First Name:</label>
                                    <asp:TextBox ID="NAME_FIRSTEditText" runat="server" Text='<%# Bind("NAME_FIRST") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="FirstNameEditValidator" runat="server" ControlToValidate="NAME_FIRSTEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter first name" OnServerValidate="NotEmpty_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="NAME_MIEditText" class="control-label">Middle Initial:</label>
                                    <asp:TextBox ID="NAME_MIEditText" runat="server" Text='<%# Bind("NAME_MI") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="MiddleIEditValidator" runat="server" ControlToValidate="NAME_MIEditText" CssClass="label label-warning  pull-right" ErrorMessage="Middle initial must be 1 character" OnServerValidate="MI_ServerValidate" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="NAME_LASTEditText" class="control-label">Last Name:</label>
                                    <asp:TextBox ID="NAME_LASTEditText" runat="server" Text='<%# Bind("NAME_LAST") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="LastNameEditValidator" runat="server" ControlToValidate="NAME_LastEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter last name." OnServerValidate="NotEmpty_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="REFERREEditText" class="control-label">Referrer:</label>
                                    <asp:TextBox ID="REFERREREditText" runat="server" Text='<%# Bind("REFERRER") %>' CssClass="form-control col-sm-6 input-sm" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="EMPLOYEREditText" class="control-label">Employer:</label>
                                    <asp:TextBox ID="EMPLOYEREditText" runat="server" Text='<%# Bind("EMPLOYER") %>' CssClass="form-control col-sm-6 input-sm" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="DATE_OF_BIRTHEditText" class="control-label">Date of Birth:</label>
                                    <asp:TextBox ID="DATE_OF_BIRTHEditText" runat="server" Text='<%# Bind("DATE_OF_BIRTH") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="DateOfBirthEditValidator" runat="server" ControlToValidate="DATE_OF_BIRTHEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter valid date of birth (dd/mm/yyyy)" OnServerValidate="DOB_ServerValidate" SetFocusOnError="True"></asp:CustomValidator>
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
                                <div class="form-group-sm">
                                    <label for="CELL_PHONEEditText" class="control-label">Phone (cell):</label>
                                    <asp:TextBox ID="CELL_PHONEEditText" runat="server" Text='<%# Bind("CELL_PHONE") %>' CssClass="form-control col-sm-6 input-sm" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="HOME_PHONEEditText" class="control-label">Phone (home):</label>
                                    <asp:TextBox ID="HOME_PHONEEditText" runat="server" Text='<%# Bind("HOME_PHONE") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="HomePhoneEditValidator" runat="server" ControlToValidate="HOME_PHONEEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter a valid home phone number." OnServerValidate="NotEmpty_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="AGENT_IDEditText" class="control-label">Agent:</label>
                                    <asp:DropDownList ID="AGENT_IDEditText" runat="server" AppendDataBoundItems="True" CssClass="form-control col-sm-6 input-sm" DataSourceID="AgentsDataSource" DataTextField="AGENT_ID" DataValueField="AGENT_ID" SelectedValue='<%# Bind("AGENT_ID") %>'>
                                    </asp:DropDownList>
                                </div>
                            </div>

                        </div>
                    </div>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">Create a New Customer
                                <div class="btn-group pull-right" role="group">
                                    <asp:LinkButton ID="Insert" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" CssClass="btn btn-success btn-xs" />
                                    <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn btn-warning btn-xs" />
                                </div>
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="form-horizontal">
                                <div class="form-group-sm">
                                    <label for="NAME_FIRSTEditText" class="control-label">First Name:</label>
                                    <asp:TextBox ID="NAME_FIRSTEditText" runat="server" Text='<%# Bind("NAME_FIRST") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="FirstNameEditValidator" runat="server" ControlToValidate="NAME_FIRSTEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter first name" OnServerValidate="NotEmpty_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="NAME_MIEditText" class="control-label">Middle Initial:</label>
                                    <asp:TextBox ID="NAME_MIEditText" runat="server" Text='<%# Bind("NAME_MI") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="MiddleIEditValidator" runat="server" ControlToValidate="NAME_MIEditText" CssClass="label label-warning  pull-right" ErrorMessage="Middle initial must be 1 character" OnServerValidate="MI_ServerValidate" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="NAME_LASTEditText" class="control-label">Last Name:</label>
                                    <asp:TextBox ID="NAME_LASTEditText" runat="server" Text='<%# Bind("NAME_LAST") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="LastNameEditValidator" runat="server" ControlToValidate="NAME_LastEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter last name." OnServerValidate="NotEmpty_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="REFERREEditText" class="control-label">Referrer:</label>
                                    <asp:TextBox ID="REFERREREditText" runat="server" Text='<%# Bind("REFERRER") %>' CssClass="form-control col-sm-6 input-sm" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="EMPLOYEREditText" class="control-label">Employer:</label>
                                    <asp:TextBox ID="EMPLOYEREditText" runat="server" Text='<%# Bind("EMPLOYER") %>' CssClass="form-control col-sm-6 input-sm" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="DATE_OF_BIRTHEditText" class="control-label">Date of Birth:</label>
                                    <asp:TextBox ID="DATE_OF_BIRTHEditText" runat="server" Text='<%# Bind("DATE_OF_BIRTH") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="DateOfBirthEditValidator" runat="server" ControlToValidate="DATE_OF_BIRTHEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter valid date of birth (dd/mm/yyyy)" OnServerValidate="DOB_ServerValidate" SetFocusOnError="True"></asp:CustomValidator>
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
                                <div class="form-group-sm">
                                    <label for="CELL_PHONEEditText" class="control-label">Phone (cell):</label>
                                    <asp:TextBox ID="CELL_PHONEEditText" runat="server" Text='<%# Bind("CELL_PHONE") %>' CssClass="form-control col-sm-6 input-sm" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="HOME_PHONEEditText" class="control-label">Phone (home):</label>
                                    <asp:TextBox ID="HOME_PHONEEditText" runat="server" Text='<%# Bind("HOME_PHONE") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="HomePhoneEditValidator" runat="server" ControlToValidate="HOME_PHONEEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter a valid home phone number." OnServerValidate="NotEmpty_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="AGENT_IDEditText" class="control-label">Agent:</label>
                                    <asp:DropDownList ID="AGENT_IDEditText" runat="server" AppendDataBoundItems="True" CssClass="form-control col-sm-6 input-sm" DataSourceID="AgentsDataSource" DataTextField="AGENT_ID" DataValueField="AGENT_ID" SelectedValue='<%# Bind("AGENT_ID") %>'>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                </InsertItemTemplate>
                <ItemTemplate>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">Viewing Customer <%# Eval("CUST_ID") %>
                                <div class="btn-group pull-right" role="group">
                                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" CssClass="btn btn-info btn-xs" />
                                    <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" CssClass="btn btn-warning btn-xs" />
                                </div>
                            </h3>
                        </div>
                        <div class="panel-body">
                            <div class="form-horizontal">
                                <div class="form-group-sm">
                                    <label for="NAME_FIRSTLabel" class="control-label col-sm-6">First Name:</label>
                                    <asp:Label ID="NAME_FIRSTLabel" runat="server" Text='<%# Bind("NAME_FIRST") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="NAME_MILabel" class="control-label col-sm-6">Middle Initial:</label>
                                    <asp:Label ID="NAME_MILabel" runat="server" Text='<%# Bind("NAME_MI") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="NAME_LASTLabel" class="control-label col-sm-6">Last Name:</label>
                                    <asp:Label ID="NAME_LASTLabel" runat="server" Text='<%# Bind("NAME_LAST") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="REFERRERLabel" class="control-label col-sm-6">Referrer:</label>
                                    <asp:Label ID="REFERRERLabel" runat="server" Text='<%# Bind("REFERRER") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="EMPLOYERLabel" class="control-label col-sm-6">Employer:</label>
                                    <asp:Label ID="EMPLOYERLabel" runat="server" Text='<%# Bind("EMPLOYER") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="DATE_OF_BIRTHLabel" class="control-label col-sm-6">Date of Birth:</label>
                                    <asp:Label ID="DATE_OF_BIRTHLabel" runat="server" Text='<%# Bind("DATE_OF_BIRTH") %>' CssClass="form-control-static col-sm-6" />
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
                                <div class="form-group-sm">
                                    <label for="CELL_PHONELabel" class="control-label col-sm-6">Phone (cell):</label>
                                    <asp:Label ID="CELL_PHONELabel" runat="server" Text='<%# Bind("CELL_PHONE") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="HOME_PHONELabel" class="control-label col-sm-6">Phone (home):</label>
                                    <asp:Label ID="HOME_PHONELabel" runat="server" Text='<%# Bind("HOME_PHONE") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="AGENT_IDLabel" class="control-label col-sm-6">Agent:</label>
                                    <asp:Label ID="AGENT_IDLabel" runat="server" Text='<%# Bind("AGENT_ID") %>' CssClass="form-control-static" />
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:FormView>
            <!--AGENTS DATA SOURCE -->
            <asp:SqlDataSource ID="AgentsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:OracleConnString %>" ProviderName="<%$ ConnectionStrings:OracleConnString.ProviderName %>" SelectCommand="SELECT &quot;AGENT_ID&quot; FROM &quot;AGENTS&quot;"></asp:SqlDataSource>


            <!-- BEGINNING OF FORMVIEW DATA SOURCE -->
            <asp:SqlDataSource ID="CustomerFormViewSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:OracleConnString %>"
                DeleteCommand="DELETE FROM CUSTOMERS WHERE CUST_ID = :CUST_ID"
                InsertCommand="INSERT INTO CUSTOMERS(NAME_FIRST, NAME_MI, NAME_LAST, REFERRER, EMPLOYER, DATE_OF_BIRTH, ADDRESS_STREET, ADDRESS_CITY, ADDRESS_STATE, ADDRESS_ZIP, CELL_PHONE, HOME_PHONE, AGENT_ID) VALUES (:NAME_FIRST, :NAME_MI, :NAME_LAST, :REFERRER, :EMPLOYER, :DATE_OF_BIRTH, :ADDRESS_STREET, :ADDRESS_CITY, :ADDRESS_STATE, :ADDRESS_ZIP, :CELL_PHONE, :HOME_PHONE, :AGENT_ID)"
                SelectCommand="SELECT * FROM CUSTOMERS WHERE CUST_ID = :CUST_IDSelected"
                ProviderName="<%$ ConnectionStrings:OracleConnString.ProviderName %>"
                UpdateCommand="UPDATE CUSTOMERS SET NAME_FIRST = :NAME_FIRST, NAME_MI = :NAME_MI, NAME_LAST = :NAME_LAST, REFERRER = :REFERRER, EMPLOYER = :EMPLOYER, DATE_OF_BIRTH = :DATE_OF_BIRTH, ADDRESS_STREET = :ADDRESS_STREET, ADDRESS_CITY = :ADDRESS_CITY, ADDRESS_STATE = :ADDRESS_STATE, ADDRESS_ZIP = :ADDRESS_ZIP, CELL_PHONE = :CELL_PHONE, HOME_PHONE = :HOME_PHONE, AGENT_ID = :AGENT_ID WHERE CUST_ID = :CUST_ID">
                <DeleteParameters>
                    <asp:Parameter Name="CUST_ID" Type="Decimal" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="CustomersView" Name="CUST_IDSelected" Type="Decimal" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="NAME_FIRST" Type="String" />
                    <asp:Parameter Name="NAME_MI" Type="String" />
                    <asp:Parameter Name="NAME_LAST" Type="String" />
                    <asp:Parameter Name="REFERRER" Type="String" />
                    <asp:Parameter Name="EMPLOYER" Type="String" />
                    <asp:Parameter Name="DATE_OF_BIRTH" Type="String" />
                    <asp:Parameter Name="ADDRESS_STREET" Type="String" />
                    <asp:Parameter Name="ADDRESS_CITY" Type="String" />
                    <asp:Parameter Name="ADDRESS_STATE" Type="String" />
                    <asp:Parameter Name="ADDRESS_ZIP" Type="String" />
                    <asp:Parameter Name="CELL_PHONE" Type="String" />
                    <asp:Parameter Name="HOME_PHONE" Type="String" />
                    <asp:Parameter Name="AGENT_ID" Type="Decimal" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="NAME_FIRST" Type="String" />
                    <asp:Parameter Name="NAME_MI" Type="String" />
                    <asp:Parameter Name="NAME_LAST" Type="String" />
                    <asp:Parameter Name="REFERRER" Type="String" />
                    <asp:Parameter Name="EMPLOYER" Type="String" />
                    <asp:Parameter Name="DATE_OF_BIRTH" Type="String" />
                    <asp:Parameter Name="ADDRESS_STREET" Type="String" />
                    <asp:Parameter Name="ADDRESS_CITY" Type="String" />
                    <asp:Parameter Name="ADDRESS_STATE" Type="String" />
                    <asp:Parameter Name="ADDRESS_ZIP" Type="String" />
                    <asp:Parameter Name="CELL_PHONE" Type="String" />
                    <asp:Parameter Name="HOME_PHONE" Type="String" />
                    <asp:Parameter Name="AGENT_ID" Type="Decimal" />
                    <asp:Parameter Name="CUST_ID" Type="Decimal" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <!-- END OF FORMVIEW DATA SOURCE-->
        </div>
        <!--END OF CONTAINER -->
    </form>
</body>
</html>
