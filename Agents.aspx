<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Agents.aspx.cs" Inherits="_Default" %>

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
                    <li class="active"><a href="#">Agents</a></li>
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
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Agents</h3>
                </div>
                <div class="panel-body">
                    <% 
                        //Declares the table header, only if the application has one or more result. 
                        int rowNumber = AgentsView.Rows.Count;
                        if (rowNumber > 0)
                        {
                            AgentsView.HeaderRow.TableSection = TableRowSection.TableHeader;
                        } %>
                    <asp:GridView ID="AgentsView" runat="server" AllowPaging="True" DataKeyNames="AGENT_ID" DataSourceID="AgentsDB" CssClass="table table-hover table-condensed" GridLines="None" RowHeaderColumn="AGENT_ID" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="AGENT_ID" HeaderText="ID" ReadOnly="True" SortExpression="AGENT_ID" />
                            <asp:TemplateField HeaderText="Name" SortExpression="NAME_FIRST">
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("NAME_FIRST") %>'></asp:Label>
                                    &nbsp;<asp:Label ID="Label15" runat="server" Text='<%# Eval("NAME_LAST") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="TITLE" HeaderText="Title" SortExpression="TITLE" />
                            <asp:BoundField DataField="OFFICE_PHONE" HeaderText="Phone (office)" SortExpression="OFFICE_PHONE" />
                            <asp:BoundField DataField="CELL_PHONE" HeaderText="Phone (cell)" SortExpression="CELL_PHONE" />
                            <asp:BoundField DataField="HOME_PHONE" HeaderText="Phone (home)" SortExpression="HOME_PHONE" />
                            <asp:BoundField DataField="HIRE_DATE" HeaderText="Hire Date" SortExpression="HIRE_DATE" />
                            <asp:CommandField ButtonType="Button" ShowSelectButton="True">
                                <ControlStyle CssClass="btn btn-info btn-xs" />
                            </asp:CommandField>
                        </Columns>
                        <SelectedRowStyle CssClass="info" />
                    </asp:GridView>
                    <!-- GRID VIEW DATA SOURCE -->
                    <asp:SqlDataSource ID="AgentsDB" runat="server"
                        ConnectionString="<%$ ConnectionStrings:OracleConnString %>"
                        OldValuesParameterFormatString="original_{0}"
                        ProviderName="<%$ ConnectionStrings:OracleConnString.ProviderName %>"
                        SelectCommand="SELECT * FROM &quot;AGENTS&quot;"></asp:SqlDataSource>
                    <!-- END GRID VIEW DATA SOURCE -->
                    <asp:LinkButton ID="NewRecordButton" runat="server" CssClass="btn btn-primary btn-xs pull-right" OnClick="NewRecordButton_Click">New Agent</asp:LinkButton>
                </div>
            </div>
            <asp:FormView ID="AgentsFormView" runat="server" DataSourceID="AgentFormViewSource" DataKeyNames="AGENT_ID" CssClass="col-lg-4" OnItemInserted="AgentFormView_ItemInserted" OnItemDeleted="AgentFormView_ItemDeleted" OnItemUpdated="AgentFormView_ItemUpdated">
                <EditItemTemplate>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">Editing Agent <%# Eval("AGENT_ID") %>
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
                                    <label for="TitleEditText" class="control-label">Title:</label>
                                    <asp:TextBox ID="TitleEditText" runat="server" Text='<%# Bind("TITLE") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="TitleEditValidator" runat="server" ControlToValidate="TitleEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter official title." OnServerValidate="NotEmpty_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="OfficePhoneEditText" class="control-label">Phone (office):</label>
                                    <asp:TextBox ID="OfficePhoneEditText" runat="server" Text='<%# Bind("OFFICE_PHONE") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="OfficePhoneEditValidator" runat="server" ControlToValidate="OfficePhoneEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter office phone number." OnServerValidate="NotEmpty_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="CellPhoneEditText" class="control-label">Phone (cell):</label>
                                    <asp:TextBox ID="CellPhoneEditText" runat="server" Text='<%# Bind("CELL_PHONE") %>' CssClass="form-control col-sm-6 input-sm" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="HomePhoneEditText" class="control-label">Phone (home):</label>
                                    <asp:TextBox ID="HomePhoneEditText" runat="server" Text='<%# Bind("HOME_PHONE") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="HomePhoneEditValidator" runat="server" ControlToValidate="HomePhoneEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter home phone number." OnServerValidate="NotEmpty_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="HireDateEditText" class="control-label">Hire Date:</label>
                                    <asp:TextBox ID="HireDateEditText" runat="server" Text='<%# Bind("HIRE_DATE") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="HireDateEditValidator" runat="server" ControlToValidate="HireDateEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter valid date of hire (mm/dd/yyyy)" OnServerValidate="HireDate_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">Create a New Agent
                                <div class="btn-group pull-right" role="group">
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" CssClass="btn btn-success btn-xs" />
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
                                    <label for="TitleEditText" class="control-label">Title:</label>
                                    <asp:TextBox ID="TitleEditText" runat="server" Text='<%# Bind("TITLE") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="TitleEditValidator" runat="server" ControlToValidate="TitleEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter official title." OnServerValidate="NotEmpty_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="OfficePhoneEditText" class="control-label">Phone (office):</label>
                                    <asp:TextBox ID="OfficePhoneEditText" runat="server" Text='<%# Bind("OFFICE_PHONE") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="OfficePhoneEditValidator" runat="server" ControlToValidate="OfficePhoneEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter office phone number." OnServerValidate="NotEmpty_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="CellPhoneEditText" class="control-label">Phone (cell):</label>
                                    <asp:TextBox ID="CellPhoneEditText" runat="server" Text='<%# Bind("CELL_PHONE") %>' CssClass="form-control col-sm-6 input-sm" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="HomePhoneEditText" class="control-label">Phone (home):</label>
                                    <asp:TextBox ID="HomePhoneEditText" runat="server" Text='<%# Bind("HOME_PHONE") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="HomePhoneEditValidator" runat="server" ControlToValidate="HomePhoneEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter home phone number." OnServerValidate="NotEmpty_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                                <div class="form-group-sm">
                                    <label for="HireDateEditText" class="control-label">Hire Date:</label>
                                    <asp:TextBox ID="HireDateEditText" runat="server" Text='<%# Bind("HIRE_DATE") %>' CssClass="form-control col-sm-6 input-sm" />
                                    <asp:CustomValidator ID="HireDateEditValidator" runat="server" ControlToValidate="HireDateEditText" CssClass="label label-warning  pull-right" ErrorMessage="Please enter valid date of hire (mm/dd/yyyy)" OnServerValidate="HireDate_ServerValidate" ValidateEmptyText="true" SetFocusOnError="True"></asp:CustomValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                </InsertItemTemplate>
                <ItemTemplate>
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">Viewing Agent <%# Eval("AGENT_ID") %>
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
                                    <label for="TitleLabel" class="control-label col-sm-6">Referrer:</label>
                                    <asp:Label ID="TitleLabel" runat="server" Text='<%# Bind("TITLE") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="EMPLOYERLabel" class="control-label col-sm-6">Phone (office):</label>
                                    <asp:Label ID="EMPLOYERLabel" runat="server" Text='<%# Bind("OFFICE_PHONE") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="DATE_OF_BIRTHLabel" class="control-label col-sm-6">Phone (cell):</label>
                                    <asp:Label ID="DATE_OF_BIRTHLabel" runat="server" Text='<%# Bind("CELL_PHONE") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="ADDRESS_STREETLabel" class="control-label col-sm-6">Phone (home):</label>
                                    <asp:Label ID="ADDRESS_STREETLabel" runat="server" Text='<%# Bind("HOME_PHONE") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                                <div class="form-group-sm">
                                    <label for="ADDRESS_CITYLabel" class="control-label col-sm-6">Hire Date:</label>
                                    <asp:Label ID="ADDRESS_CITYLabel" runat="server" Text='<%# Bind("HIRE_DATE") %>' CssClass="form-control-static col-sm-6" />
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:FormView>
            <!-- BEGINNING OF FORMVIEW DATA SOURCE -->
            <asp:SqlDataSource ID="AgentFormViewSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:OracleConnString %>"
                SelectCommand="SELECT * FROM AGENTS WHERE AGENT_ID = :AGENT_IDSelected"
                ProviderName="<%$ ConnectionStrings:OracleConnString.ProviderName %>"
                DeleteCommand="DELETE FROM AGENTS WHERE AGENT_ID = :AGENT_ID"
                InsertCommand="INSERT INTO AGENTS (NAME_FIRST, NAME_MI, NAME_LAST, TITLE, OFFICE_PHONE, CELL_PHONE, HOME_PHONE, HIRE_DATE) VALUES (:NAME_FIRST, :NAME_MI, :NAME_LAST, :TITLE, :OFFICE_PHONE, :CELL_PHONE, :HOME_PHONE, :HIRE_DATE)"
                UpdateCommand="UPDATE AGENTS SET NAME_FIRST = :NAME_FIRST, NAME_MI = :NAME_MI, NAME_LAST = :NAME_LAST, TITLE = :TITLE, OFFICE_PHONE = :OFFICE_PHONE, CELL_PHONE = :CELL_PHONE, HOME_PHONE = :HOME_PHONE, HIRE_DATE = :HIRE_DATE WHERE AGENT_ID = :AGENT_ID">
                <DeleteParameters>
                    <asp:Parameter Name="AGENT_ID" Type="Decimal" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="AgentsView" Name="AGENT_IDSelected" Type="Decimal" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="NAME_FIRST" Type="String" />
                    <asp:Parameter Name="NAME_MI" Type="String" />
                    <asp:Parameter Name="NAME_LAST" Type="String" />
                    <asp:Parameter Name="TITLE" Type="String" />
                    <asp:Parameter Name="OFFICE_PHONE" Type="String" />
                    <asp:Parameter Name="CELL_PHONE" Type="String" />
                    <asp:Parameter Name="HOME_PHONE" Type="String" />
                    <asp:Parameter Name="HIRE_DATE" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="NAME_FIRST" Type="String" />
                    <asp:Parameter Name="NAME_MI" Type="String" />
                    <asp:Parameter Name="NAME_LAST" Type="String" />
                    <asp:Parameter Name="TITLE" Type="String" />
                    <asp:Parameter Name="OFFICE_PHONE" Type="String" />
                    <asp:Parameter Name="CELL_PHONE" Type="String" />
                    <asp:Parameter Name="HOME_PHONE" Type="String" />
                    <asp:Parameter Name="HIRE_DATE" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <!-- END OF FORMVIEW DATA SOURCE-->
        </div>
    </form>
</body>
</html>
