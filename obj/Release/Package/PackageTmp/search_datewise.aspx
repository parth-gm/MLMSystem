<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Site1.Master" CodeBehind="search_datewise.aspx.cs" Inherits="authwebpart.search_datewise" %>


<asp:Content ID="Content1" ContentPlaceHolderID="searchDateID" runat="server">
    <ol class="breadcrumb">
        <li class="breadcrumb-item">
            <asp:LinkButton ID="LinkButton6" runat="server" PostBackUrl="~/dashboard.aspx">Home</asp:LinkButton>
        </li>
        <li class="breadcrumb-item">
            <asp:LinkButton ID="LinkButton2" runat="server" PostBackUrl="~/search.aspx">Search account</asp:LinkButton>
        </li>
    </ol>

    <div class="container-fluid">
        <div class="animated fadeIn">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header">
                          <i class="fa fa-align-justify"></i> Search between dates
                        </div>
                        <div class="card-body">

                            <div class="row form-group">
                                <div class="input-daterange input-group datepicker col-md-6 col-sm-6 col-lg-6">
                                    <span class="input-group-addon pl-4 pr-4">From</span>

                                    <asp:TextBox ID="fromSearchTextBox" runat="server" CssClass="input-sm form-control"></asp:TextBox>
                                    <span class="input-group-addon pl-4 pr-4">To</span>
                                
                                    <asp:TextBox ID="toSearchTextBox" runat="server" CssClass="input-sm form-control"></asp:TextBox>
                                
                                </div>
                                <div class="col-md-6 col-lg-6 col-sm-6">
                                    <span class="input-group-btn">
                                        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Search" CssClass="btn btn-secondary" Width="103px" ValidationGroup="sbtn" />
                                    </span>
                                </div>
                               
                            </div>
                            
                            <div class="alert-info">
                                  <asp:CompareValidator ID="CompareValidatorDate" runat="server" ForeColor="Red" ErrorMessage="Invalid From And To Date Range" ControlToValidate="toSearchTextBox" Operator="GreaterThanEqual" ControlToCompare="fromSearchTextBox" ValidationGroup="sbtn" Type="Date"></asp:CompareValidator>
                            </div>
                            
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:v0scon %>" SelectCommand="SELECT * FROM [customer] WHERE (([create_date] &lt; @create_date2) AND ([create_date] &gt; @create_date))" ProviderName="<%$ ConnectionStrings:v0scon.ProviderName %>">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="toSearchTextBox" Name="create_date2" PropertyName="Text" Type="DateTime" />
                                    <asp:ControlParameter ControlID="fromSearchTextBox" Name="create_date" PropertyName="Text" Type="DateTime" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                                    
                            <asp:GridView ID="GridView1" CssClass="table table-striped" runat="server" AutoGenerateColumns="False" DataKeyNames="c_id" DataSourceID="SqlDataSource1" OnRowDataBound="GridView1_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="c_id" InsertVisible="False" SortExpression="c_id">
                                  
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" OnClick="LinkButton1_Click" runat="server" Text='<%# Eval("c_id") %>'></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Name" SortExpression="c_fname">
                                        <ItemTemplate>
                                            <a href="/view.aspx?c_id=<%#Eval("c_id") %>">
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("c_fname") %>'></asp:Label>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("c_mname") %>'></asp:Label>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("c_lname") %>'></asp:Label>
                                            </a>
                                            </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="address" HeaderText="address" SortExpression="address" Visible="false" />
                                    <asp:BoundField DataField="city" HeaderText="city" SortExpression="city" />
                                    <asp:BoundField DataField="email_id" HeaderText="email id" SortExpression="email_id" Visible="false"/>
                                    <asp:BoundField DataField="mobile_no" HeaderText="mobile no" SortExpression="mobile_no" Visible="false" />
                                    <asp:BoundField DataField="cphoto_path" HeaderText="cphoto path" SortExpression="cphoto_path" Visible="false" />
                                    <asp:BoundField DataField="mphoto_path" HeaderText="mphoto path" SortExpression="mphoto_path" Visible="false"/>
                                    <asp:BoundField DataField="create_date" HeaderText="create date" SortExpression="create_date" />
                                    <asp:BoundField DataField="created_date" HeaderText="created date" SortExpression="created_date" Visible="false" />
                                    <asp:BoundField DataField="updated_date" HeaderText="updated date" SortExpression="updated_date" Visible="false"/>
                                    <asp:BoundField DataField="interest_rate" HeaderText="interest rate" SortExpression="interest_rate" Visible="false" />
                                    <asp:BoundField DataField="debit_limit" HeaderText="debit limit" SortExpression="debit_limit" Visible="false" />
                                    <asp:CheckBoxField DataField="isactive" HeaderText="isactive" SortExpression="isactive" Visible="false" />
                                    <asp:TemplateField HeaderText="Total Credit.(in Rs)"></asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total Debit.(in Rs)"></asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
 </asp:Content>