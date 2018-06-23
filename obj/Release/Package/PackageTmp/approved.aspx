<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="approved.aspx.cs" Inherits="authwebpart.approved" %>
<asp:Content ID="Content1" ContentPlaceHolderID="approvalID" runat="server">
    <ol class="breadcrumb">
        <li class="breadcrumb-item">
            <asp:LinkButton ID="LinkButton6" runat="server" PostBackUrl="~/dashboard.aspx">Home</asp:LinkButton>
        </li>
        <li class="breadcrumb-item">
            Admin
        </li>
        <li class="breadcrumb-item">
            <asp:LinkButton ID="LinkButton2" runat="server" PostBackUrl="~/approved.aspx">Users List</asp:LinkButton>
        </li>
    </ol>

    <div class="container-fluid">
        <div class="animated fadeIn">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header">
                          <i class="fa fa-align-justify"></i> Users List
                        </div>
                        <div class="card-body">
                            <asp:GridView ID="GridView2" runat="server" CssClass="table table-striped" AutoGenerateColumns="False" DataKeyNames="reg_id" DataSourceID="SqlDataSource3">
                                <Columns>
                                    
                                    <asp:BoundField DataField="reg_id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="reg_id" />
                                    <asp:BoundField DataField="reg_uname" HeaderText="Username" SortExpression="reg_uname" />
                                    <asp:BoundField DataField="email_id" HeaderText="Email" SortExpression="email_id" />
                                    <asp:BoundField DataField="mobile_no" HeaderText="Mobile" SortExpression="mobile_no" />
                                    <asp:BoundField DataField="reg_date" HeaderText="Date" SortExpression="reg_date" />
                                    <asp:CheckBoxField DataField="isvalid" HeaderText="Active" SortExpression="isvalid" />
                                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" HeaderText="Actions" />
                                </Columns>
                            </asp:GridView>
                          <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:v0scon %>" DeleteCommand="DELETE FROM [reg_user] WHERE [reg_id] = @reg_id" InsertCommand="INSERT INTO [reg_user] ([reg_uname], [email_id], [mobile_no], [reg_date], [isvalid]) VALUES (@reg_uname, @email_id, @mobile_no, @reg_date, @isvalid)" ProviderName="<%$ ConnectionStrings:v0scon.ProviderName %>" SelectCommand="SELECT [reg_id], [reg_uname], [email_id], [mobile_no], [reg_date], [isvalid] FROM [reg_user] WHERE ([isvalid] = @isvalid) ORDER BY [reg_date] DESC" UpdateCommand="UPDATE [reg_user] SET [reg_uname] = @reg_uname, [email_id] = @email_id, [mobile_no] = @mobile_no, [reg_date] = @reg_date, [isvalid] = @isvalid WHERE [reg_id] = @reg_id">
                                <DeleteParameters>
                                    <asp:Parameter Name="reg_id" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="reg_uname" Type="String" />
                                    <asp:Parameter Name="email_id" Type="String" />
                                    <asp:Parameter Name="mobile_no" Type="Decimal" />
                                    <asp:Parameter Name="reg_date" Type="DateTime" />
                                    <asp:Parameter Name="isvalid" Type="Boolean" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="True" Name="isvalid" Type="Boolean" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="reg_uname" Type="String" />
                                    <asp:Parameter Name="email_id" Type="String" />
                                    <asp:Parameter Name="mobile_no" Type="Decimal" />
                                    <asp:Parameter Name="reg_date" Type="DateTime" />
                                    <asp:Parameter Name="isvalid" Type="Boolean" />
                                    <asp:Parameter Name="reg_id" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>