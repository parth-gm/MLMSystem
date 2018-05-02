<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Site1.Master"  CodeBehind="verify_user.aspx.cs" Inherits="authwebpart.verify_user" %>
<asp:Content ID="Content1" ContentPlaceHolderID="verify_userID" runat="server">
    <ol class="breadcrumb">
        <li class="breadcrumb-item">
            <asp:LinkButton ID="LinkButton6" runat="server" PostBackUrl="~/dashboard.aspx">Home</asp:LinkButton>
        </li>
        <li class="breadcrumb-item">
            Admin
        </li>
        <li class="breadcrumb-item">
            <asp:LinkButton ID="LinkButton2" runat="server" PostBackUrl="~/verify_user.aspx">Approve users</asp:LinkButton>
        </li>
    </ol>

    <div class="container-fluid">
        <div class="animated fadeIn">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header">
                          <i class="fa fa-align-justify"></i> Pending Approvals
                        </div>
                        <div class="card-body">
                            <asp:GridView ID="GridView1" runat="server" CssClass="table table-stiped" EmptyDataText="No User Request Is Pending" ShowHeader="true" AutoGenerateColumns="False" DataKeyNames="reg_id" DataSourceID="SqlDataSource1" ShowHeaderWhenEmpty="True">
                                <Columns>
                                    
                                    <asp:BoundField DataField="reg_id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="reg_id" />
                                    <asp:BoundField DataField="reg_uname" HeaderText="Username" SortExpression="reg_uname" />
                                    <asp:BoundField DataField="email_id" HeaderText="Email" SortExpression="email_id" />
                                    <asp:BoundField DataField="mobile_no" HeaderText="Mobile" SortExpression="mobile_no" />
                                    <asp:BoundField DataField="reg_date" HeaderText="Date" SortExpression="reg_date" />
                                    <asp:CheckBoxField DataField="isvalid" HeaderText="Active" SortExpression="isvalid" />
                                    <asp:CommandField ShowDeleteButton="True" ShowSelectButton="True" HeaderText="Actions" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header">
                          <i class="fa fa-align-justify"></i> User Add/Update
                        </div>
                        <div class="card-body">
                            <asp:FormView ID="FormView1" CssClass="table" runat="server" DataKeyNames="reg_id" DataSourceID="SqlDataSource2">
                                <EditItemTemplate>
                                    <div class="form-group row">
                                        <label class="col-md-3 col-lg-3">Id:</label>
                                        <div class="col-md-9 col-lg-9">
                                            <asp:Label ID="reg_idLabel1" runat="server" Text='<%# Eval("reg_id") %>' CssClass="form-control" />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-3 col-lg-3">Mobile:</label>
                                        <div class="col-md-9 col-lg-9">
                                            <asp:TextBox ID="mobile_noTextBox" runat="server" Text='<%# Bind("mobile_no") %>' CssClass="form-control" MaxLength="10" TextMode="Phone"  />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-3 col-lg-3">Email:</label>
                                        <div class="col-md-9 col-lg-9">
                                            <asp:TextBox ID="email_idTextBox" runat="server" Text='<%# Bind("email_id") %>' CssClass="form-control" TextMode="Email" />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-3 col-lg-3">Active:</label>
                                        <div class="col-md-9 col-lg-9">
                                            <asp:CheckBox ID="isvalidCheckBox" runat="server" Checked='<%# Bind("isvalid") %>' CssClass="form-control" />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-3 col-lg-3">Username:</label>
                                        <div class="col-md-9 col-lg-9">
                                            <asp:TextBox ID="reg_unameTextBox" runat="server" Text='<%# Bind("reg_uname") %>' CssClass="form-control"  />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-3 col-lg-3">Registration Date:</label>
                                        <div class="col-md-9 col-lg-9">
                                            <asp:TextBox ID="reg_dateTextBox" runat="server" Text='<%# Bind("reg_date") %>' CssClass="form-control" Enabled="False" TextMode="DateTime" />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-3 col-lg-3">Registration Role id:</label>
                                        <div class="col-md-9 col-lg-9">
                                            <asp:TextBox ID="role_idTextBox" runat="server" Text='<%# Bind("role_id") %>' CssClass="form-control"  />
                                        </div>
                                    </div>
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn btn-primary" />
                                    <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="ml-4 btn btn-secondary" />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <div class="form-group row">
                                        <label class="col-md-3 col-lg-3">Mobile:</label>
                                        <div class="col-md-9 col-lg-9">
                                        <asp:TextBox ID="mobile_noTextBox" runat="server" Text='<%# Bind("mobile_no") %>' CssClass="form-control" />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-3 col-lg-3">Email:</label>
                                        <div class="col-md-9 col-lg-9">
                                        <asp:TextBox ID="email_idTextBox" runat="server" Text='<%# Bind("email_id") %>' CssClass="form-control" />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-3 col-lg-3">Active:</label>
                                        <div class="col-md-9 col-lg-9">
                                        <asp:CheckBox ID="isvalidCheckBox" runat="server" Checked='<%# Bind("isvalid") %>' CssClass="form-control" />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-3 col-lg-3">Username:</label>
                                        <div class="col-md-9 col-lg-9">
                                        <asp:TextBox ID="reg_unameTextBox" runat="server" Text='<%# Bind("reg_uname") %>' CssClass="form-control" />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-3 col-lg-3">Registratio Date:</label>
                                        <div class="col-md-9 col-lg-9">
                                        <asp:TextBox ID="reg_dateTextBox" runat="server" Text='<%# Bind("reg_date") %>' CssClass="form-control" />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-3 col-lg-3">Role id:</label>
                                        <div class="col-md-9 col-lg-9">
                                        <asp:TextBox ID="role_idTextBox" runat="server" Text='<%# Bind("role_id") %>' CssClass="form-control" />
                                        </div>
                                    </div>
                                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" CssClass="btn btn-primary" />
                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="ml-4 btn btn-secondary" />
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <p>
                                        Id:
                                        <asp:Label ID="reg_idLabel" runat="server" Text='<%# Eval("reg_id") %>' />
                                    </p>
                                    <p>
                                        Mobile:
                                        <asp:Label ID="mobile_noLabel" runat="server" Text='<%# Bind("mobile_no") %>' />
                                    </p>
                                    <p>
                                        Email:
                                        <asp:Label ID="email_idLabel" runat="server" Text='<%# Bind("email_id") %>' />
                                    </p>
                                    <p>
                                        Active:
                                        <asp:CheckBox ID="isvalidCheckBox" runat="server" Checked='<%# Bind("isvalid") %>' Enabled="false" />
                                    </p>
                                    <p>
                                        Username:
                                        <asp:Label ID="reg_unameLabel" runat="server" Text='<%# Bind("reg_uname") %>' />
                                    </p>
                                    <p>
                                        Reggistration Date:
                                        <asp:Label ID="reg_dateLabel" runat="server" Text='<%# Bind("reg_date") %>' />
                                    </p>
                                    <p>
                                        Role Id:
                                        <asp:Label ID="role_idLabel" runat="server" Text='<%# Bind("role_id") %>' />
                                    </p>
                                    <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" CssClass="btn btn-primary" />
                                    &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" CssClass="ml-4 btn btn-warning" />
                                    &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" CssClass="ml-4 btn btn-secondary" />
                                </ItemTemplate>
                            </asp:FormView>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-header">
                          <i class="fa fa-align-justify"></i> Active user(s)
                                         <div class="card-body">
                            <p>
                                <strong>Active user(s):</strong>
                                <asp:Label ID="activecount" runat="server"></asp:Label>                            
                            </p>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

     <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:v0scon %>" DeleteCommand="DELETE FROM [reg_user] WHERE [reg_id] = @reg_id" InsertCommand="INSERT INTO [reg_user] ([reg_uname], [email_id], [mobile_no], [reg_date]) VALUES (@reg_uname, @email_id, @mobile_no, @reg_date)" ProviderName="<%$ ConnectionStrings:v0scon.ProviderName %>" SelectCommand="SELECT reg_id, reg_uname, email_id, mobile_no, reg_date, isvalid FROM reg_user WHERE (isvalid = @isvalid) ORDER BY reg_date" UpdateCommand="UPDATE [reg_user] SET [reg_uname] = @reg_uname, [email_id] = @email_id, [mobile_no] = @mobile_no, [reg_date] = @reg_date WHERE [reg_id] = @reg_id">
        <DeleteParameters>
            <asp:Parameter Name="reg_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="reg_uname" Type="String" />
            <asp:Parameter Name="email_id" Type="String" />
            <asp:Parameter Name="mobile_no" Type="Decimal" />
            <asp:Parameter Name="reg_date" Type="DateTime" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter DefaultValue="False" Name="isvalid" Type="Boolean" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="reg_uname" Type="String" />
            <asp:Parameter Name="email_id" Type="String" />
            <asp:Parameter Name="mobile_no" Type="Decimal" />
            <asp:Parameter Name="reg_date" Type="DateTime" />
            <asp:Parameter Name="reg_id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:v0scon %>" DeleteCommand="DELETE FROM [reg_user] WHERE [reg_id] = @reg_id" InsertCommand="INSERT INTO [reg_user] ([reg_uname], [email_id], [mobile_no], [reg_date], [role_id], [isvalid]) VALUES (@reg_uname, @email_id, @mobile_no, @reg_date, @role_id, @isvalid)" SelectCommand="SELECT [reg_id], [reg_uname], [email_id], [mobile_no], [reg_date], [role_id], [isvalid] FROM [reg_user] WHERE ([reg_id] = @reg_id) ORDER BY [reg_date] DESC" UpdateCommand="UPDATE [reg_user] SET [reg_uname] = @reg_uname, [email_id] = @email_id, [mobile_no] = @mobile_no, [reg_date] = @reg_date, [role_id] = @role_id, [isvalid] = @isvalid WHERE [reg_id] = @reg_id" ProviderName="<%$ ConnectionStrings:v0scon.ProviderName %>">
        <DeleteParameters>
            <asp:Parameter Name="reg_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="reg_uname" Type="String" />
            <asp:Parameter Name="email_id" Type="String" />
            <asp:Parameter Name="mobile_no" Type="Decimal" />
            <asp:Parameter Name="reg_date" Type="DateTime" />
            <asp:Parameter Name="role_id" Type="Decimal" />
            <asp:Parameter Name="isvalid" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" Name="reg_id" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="reg_uname" Type="String" />
            <asp:Parameter Name="email_id" Type="String" />
            <asp:Parameter Name="mobile_no" Type="Decimal" />
            <asp:Parameter Name="reg_date" Type="DateTime" />
            <asp:Parameter Name="role_id" Type="Decimal" />
            <asp:Parameter Name="isvalid" Type="Boolean" />
            <asp:Parameter Name="reg_id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>