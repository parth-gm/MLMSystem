<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master"   CodeBehind="cust_list.aspx.cs" Inherits="authwebpart.cust_list" %>
<asp:Content ID="Content1" ContentPlaceHolderID="custListID" runat="server">

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
                          <i class="fa fa-align-justify"></i> Customer List
                        </div>
                        <div class="card-body">
       
                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" OnRowDataBound="GridView2_RowDataBound1" CssClass="table table-striped" DataSourceID="SqlDataSource1"  >
                            <Columns>
                                    <asp:TemplateField HeaderText="Id" >
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton2" OnClick="LinkButton2_Click"  Text='<%#Eval("c_id") %>'  runat="server">LinkButton</asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    
                                    <asp:TemplateField HeaderText="Name">
                                        <ItemTemplate>
                                            <a href="/view.aspx?c_id=<%#Eval("c_id") %>">
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("c_fname") %>'></asp:Label>
                                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("c_mname") %>'></asp:Label>
                                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("c_lname") %>'></asp:Label>
                                            </a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                   
                                    
                                 
                                    <asp:BoundField DataField="city" HeaderText="City"  />
                                    <asp:BoundField DataField="create_date" HeaderText="Date" DataFormatString="{0:d}" />
                                    <asp:TemplateField HeaderText="Credit.(in Rs)">
                                       
                                </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Debit.(in Rs)">
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:v0scon %>" SelectCommand="SELECT [c_id], [c_fname], [c_mname], [c_lname], [city], [create_date] FROM [customer] WHERE ([isactive] = @isactive) ORDER BY [create_date] DESC ,[c_id] DESC">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="True" Name="isactive" Type="Boolean" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</asp:Content>