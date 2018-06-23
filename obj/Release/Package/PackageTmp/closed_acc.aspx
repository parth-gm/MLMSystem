<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master"   CodeBehind="closed_acc.aspx.cs" Inherits="authwebpart.closed_acc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="closed_accID" runat="server">
    <ol class="breadcrumb">
        <li class="breadcrumb-item">
            <asp:LinkButton ID="LinkButton6" runat="server" PostBackUrl="~/dashboard.aspx">Home</asp:LinkButton>
        </li>
        <li class="breadcrumb-item">
            <asp:LinkButton ID="LinkButton2" runat="server" PostBackUrl="~/cust_list.aspx">List accounts</asp:LinkButton>
        </li>
    </ol>

    <div class="container-fluid">
        <div class="animated fadeIn">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header">
                          <i class="fa fa-align-justify"></i> Closed Accounts
                        </div>
                        <div class="card-body">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:v0scon %>" ProviderName="<%$ ConnectionStrings:v0scon.ProviderName %>" SelectCommand="SELECT [c_id], [c_fname], [c_mname], [c_lname], [city], [updated_date] FROM [customer] WHERE ([isactive] = @isactive) ORDER BY [updated_date] DESC" DeleteCommand="DELETE FROM [customer] WHERE [c_id] = @c_id" InsertCommand="INSERT INTO [customer] ([c_fname], [c_mname], [c_lname], [city], [updated_date]) VALUES (@c_fname, @c_mname, @c_lname, @city, @updated_date)" UpdateCommand="UPDATE [customer] SET [c_fname] = @c_fname, [c_mname] = @c_mname, [c_lname] = @c_lname, [city] = @city, [updated_date] = @updated_date WHERE [c_id] = @c_id">
                                <DeleteParameters>
                                    <asp:Parameter Name="c_id" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="c_fname" Type="String" />
                                    <asp:Parameter Name="c_mname" Type="String" />
                                    <asp:Parameter Name="c_lname" Type="String" />
                                    <asp:Parameter Name="city" Type="String" />
                                    <asp:Parameter Name="updated_date" Type="DateTime" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="False" Name="isactive" Type="Boolean" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="c_fname" Type="String" />
                                    <asp:Parameter Name="c_mname" Type="String" />
                                    <asp:Parameter Name="c_lname" Type="String" />
                                    <asp:Parameter Name="city" Type="String" />
                                    <asp:Parameter Name="updated_date" Type="DateTime" />
                                    <asp:Parameter Name="c_id" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            
                            <asp:GridView CssClass="table table-striped" ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="c_id" DataSourceID="SqlDataSource1" EmptyDataText="No Account Are Closed">
                                <Columns>

                                    <asp:CommandField ShowDeleteButton="True" />

                                    <asp:BoundField DataField="c_id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="c_id" />
                                    <asp:TemplateField HeaderText="Name" SortExpression="c_fname">
                      
                                        <ItemTemplate>
                                            <a href="/view.aspx?c_id=<%#Eval("c_id") %>">
                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("c_fname") %>'></asp:Label>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("c_mname") %>'></asp:Label>
                                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("c_lname") %>'></asp:Label>
                                            </a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                  
                                    <asp:BoundField DataField="city" HeaderText="City" SortExpression="city" />
                                    <asp:BoundField DataField="updated_date" HeaderText="Closed Date" SortExpression="updated_date" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>