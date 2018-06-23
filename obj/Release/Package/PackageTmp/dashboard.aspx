<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="authwebpart.dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="dashboardID" runat="server">
    <ol class="breadcrumb">
        <li class="breadcrumb-item">
            <asp:LinkButton ID="LinkButton6" runat="server" PostBackUrl="~/dashboard.aspx">Home</asp:LinkButton>
        </li>
        <li class="breadcrumb-item">
            Admin
        </li>
        <li class="breadcrumb-item">
            <asp:LinkButton ID="LinkButton2" runat="server" PostBackUrl="~/dashboard.aspx">Dashboard</asp:LinkButton>
        </li>
    </ol>

     <div class="container-fluid">
        <div class="animated fadeIn">
            <div class="row">

                <div class="col-sm-6 col-lg-4 col-md-4">
                  <div class="card text-white bg-secondary">
                    <div class="card-body pb-0">
                      <h4 class="mb-0">
                          <asp:Label ID="LabelSilver" runat="server" Text="Label"></asp:Label>   Kg.
                      </h4>
                      <p>Silver</p>
                    </div>
                  </div>
                </div>

                 <div class="col-sm-6 col-lg-4 col-md-4">
                  <div class="card text-white bg-warning">
                    <div class="card-body pb-0">
                      <h4 class="mb-0">
                        <asp:Label ID="LabelGold" runat="server" Text="Label"></asp:Label> Kg.
                      </h4>
                      <p>Gold</p>
                    </div>
                  </div>
                </div>

                <div class="col-sm-6 col-lg-4 col-md-4">
                  <div class="card text-white bg-info">
                    <div class="card-body pb-0">
                      <h4 class="mb-0">
                        <asp:Label ID="LabelOther" runat="server" Text="Label"></asp:Label> Kg.
                      </h4>
                      <p>Other</p>
                    </div>
                  </div>
                </div>

                 <div class="col-sm-6 col-lg-6 col-md-6">
                  <div class="card text-white bg-primary">
                    <div class="card-body pb-0">
                      <h4 class="mb-0">
                        <asp:Label ID="LabelCredit" runat="server" Text="Label"></asp:Label> &#8377;
                      </h4>
                      <p>Debit</p>
                    </div>
                  </div>
                </div>

                <div class="col-sm-6 col-lg-6 col-md-6">
                  <div class="card text-white bg-danger">
                    <div class="card-body pb-0">
                      <h4 class="mb-0">
                         <asp:Label ID="LabelDebit" runat="server" Text="Label"></asp:Label> &#8377;
                      </h4>
                      <p>Credit</p>
                    </div>
                  </div>
                </div>

                <div class="col-sm-12 col-lg-12 col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <i class="fa fa-align-justify"></i> Recently Created Account
                            <span class="pull-right">
                                <asp:LinkButton ID="LinkButton7" runat="server" PostBackUrl="~/cust_list.aspx">View All</asp:LinkButton>
                            </span>
                        </div>
                        <div class="card-body">
                            <asp:GridView ID="GridView2" runat="server"  CssClass="table table-striped" AutoGenerateColumns="False" DataKeyNames="c_id" DataSourceID="SqlDataSource2">
                                <Columns>

                                    <asp:BoundField DataField="c_id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="c_id" />
                                    <asp:TemplateField HeaderText="First Name" SortExpression="c_fname">
                                        <ItemTemplate>
                                            <a href="/view.aspx?c_id=<%#Eval("c_id") %>">
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("c_fname") %>'></asp:Label>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("c_mname") %>'></asp:Label>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("c_lname") %>'></asp:Label>
                                            </a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="city" HeaderText="City" SortExpression="city" />
                                    <asp:BoundField DataField="create_date" HeaderText="Date" SortExpression="create_date" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:v0scon %>" ProviderName="<%$ ConnectionStrings:v0scon.ProviderName %>" SelectCommand="SELECT TOP 10  [c_id], [c_fname], [c_mname], [c_lname], [city], [create_date] FROM [customer] WHERE ([isactive] = @isactive) ORDER BY [create_date] DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="True" Name="isactive" Type="Boolean" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12 col-lg-12 col-md-12">

                     <div class="card">
                        <div class="card-header">
                            <i class="fa fa-align-justify"></i> Recently Closed Account
                            <span class="pull-right">
                                <asp:LinkButton ID="LinkButton8" runat="server" PostBackUrl="~/closed_acc.aspx">View All</asp:LinkButton>
                            </span>
                        </div>
                        <div class="card-body">
                             <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped" AutoGenerateColumns="False" DataKeyNames="c_id" DataSourceID="SqlDataSource1">
                                <Columns>
                                    <asp:BoundField DataField="c_id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="c_id" />
                                    <asp:BoundField DataField="c_fname" HeaderText="First Name" SortExpression="c_fname" />
                                    <asp:BoundField DataField="c_mname" HeaderText="M Name" SortExpression="c_mname" />
                                    <asp:BoundField DataField="c_lname" HeaderText="Last Name" SortExpression="c_lname" />
                                    <asp:BoundField DataField="city" HeaderText="City" SortExpression="city" />
                                    <asp:BoundField DataField="updated_date" HeaderText="Updated Date" SortExpression="updated_date" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:v0scon %>" ProviderName="<%$ ConnectionStrings:v0scon.ProviderName %>" SelectCommand="SELECT TOP  10  [c_id], [c_fname], [c_mname], [c_lname], [city], [updated_date] FROM [customer] WHERE ([isactive] = @isactive) ORDER BY updated_date">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="False" Name="isactive" Type="Boolean" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
