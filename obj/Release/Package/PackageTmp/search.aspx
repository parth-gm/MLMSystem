<%@ Page Language="C#"  MasterPageFile="~/Site1.Master"  AutoEventWireup="true" CodeBehind="search.aspx.cs" Inherits="authwebpart.search" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="searchID" runat="server">

   
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
                          <i class="fa fa-align-justify"></i> Search account
                        </div>
                        <div class="card-body">

                            <div class="form-group">
                                <label class="form-control-label" for="appendedInputButton">Search</label>
                                <div class="controls">
                                    <div class="input-group">
                                        <asp:TextBox ID="TextBox1" runat="server" TextMode="Search" AutoCompleteType="Enabled" CssClass="form-control"></asp:TextBox>
                                        <span class="input-group-btn">
                                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Search" CssClass="btn btn-secondary" />
                                        </span>
                                    </div>
                                </div>
                            </div>
                           <div style="clear:both;position:relative;zoom:1">
                               <div data-jiis="uc">
                                   <div class="card-header">
                                       <strong>
                                       <asp:Label runat="server" EnableViewState="false" CssClass="form-control-label" ID="searchnotID" Text="" Visible="false">
                                           
                                       </asp:Label>
                                           </strong>
                                   </div>
                               </div>

                           </div>
                            <asp:GridView ID="GridView1" OnRowDataBound="GridView1_RowDataBound" CssClass="table table-striped" runat="server" AutoGenerateColumns="False" DataKeyNames="c_id" Enabled="False" Visible="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="c_id" InsertVisible="False" SortExpression="c_id">
                            
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" OnClick="LinkButton1_Click" runat="server" Text='<%# Eval("c_id") %>'></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="c_name" SortExpression="c_fname">
                                                  
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
                                    <asp:BoundField DataField="email_id" HeaderText="email id" SortExpression="email_id" Visible="false" />
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
                                    
                               
                            <asp:GridView ID="GridView2" CssClass="table table-striped" runat="server" AutoGenerateColumns="False" DataKeyNames="c_id" Enabled="False" Visible="False" OnRowDataBound="GridView2_RowDataBound" >
                                <Columns>
                                    <asp:TemplateField HeaderText="c_id" InsertVisible="False" SortExpression="c_id">
                          
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton2" OnClick="LinkButton2_Click" runat="server" Text='<%# Eval("c_id") %>'></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="c_name" SortExpression="c_fname">
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
                                    
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:v0scon %>" DataSourceMode="DataReader" SelectCommand="SELECT * FROM [customer] WHERE ([mobile_no] = @mobile_no) ORDER BY [create_date] DESC">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="TextBox1" Name="mobile_no" PropertyName="Text" Type="Decimal" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                                    
                            <asp:GridView ID="GridView3" CssClass="searchID_GridView3 table table-striped" runat="server" AutoGenerateColumns="False" DataKeyNames="c_id" Enabled="False" Visible="False" OnRowDataBound="GridView3_RowDataBound" >
                                <Columns>
                                    <asp:TemplateField HeaderText="c_id" InsertVisible="False" SortExpression="c_id">
                          
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton3" OnClick="LinkButton3_Click" runat="server" Text='<%# Eval("c_id") %>'></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                        
                                    <asp:TemplateField HeaderText="c_name" SortExpression="c_fname">
                                        <ItemTemplate>
                                            <a href="/view.aspx?c_id=<%#Eval("c_id") %>">
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("c_fname") %>'></asp:Label>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("c_mname") %>'></asp:Label>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("c_lname") %>'></asp:Label>
                                            </a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                                                        
                                    <asp:BoundField DataField="address" HeaderText="address" SortExpression="address" Visible="False" />
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