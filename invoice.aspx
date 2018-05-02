<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master"  CodeBehind="invoice.aspx.cs" Inherits="authwebpart.invoice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="invoiceID" runat="server">

<div class="col-sm-12 col-lg-12 col-md-12">
	<div class="card">
		<div class="card-header">
			INVOICE
		</div>
		<div class="card-body">

            <div class="row">
                <div class="col-md-6 col-sm-6 col-lg-6">
                    <div class="form-group row">
                        <label class="col-lg-3 col-md-3" for="invoice-number-container">Invoice#</label>
                        <div class="col-md-9 col-lg-9">
                            <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control" Enabled="False"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row datepicker">
                        <label class="col-lg-3 col-md-3">Date</label>
                        <div class="col-md-9 col-lg-9">
                            <asp:TextBox ID="billDate" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 col-sm-6 col-lg-6">
                    <asp:Image ID="Image1" runat="server" CssClass="pull-right" ImageUrl="img/logo.png" Width="180px" Height="100px" />
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6 col-sm-6 col-lg-6">
                    <div class="form-group row">
                        <label class="col-lg-3 col-md-3">Customer ID</label>
                        <div class="col-md-9 col-lg-9">
                            <asp:TextBox ID="TextBox6" runat="server" CssClass="form-control" OnTextChanged="TextBox6_TextChanged" AutoPostBack="True" TextMode="Number"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-3 col-md-3">Name</label>
                        <div class="col-md-9 col-lg-9">
                            <asp:TextBox ID="TextBox7" runat="server" CssClass="form-control" EnableViewState="False"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red" ErrorMessage="*" ControlToValidate="TextBox7" ValidationGroup="subc"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-3 col-md-3">Address</label>
                        <div class="col-md-9 col-lg-9">
                            <asp:TextBox ID="TextBox8" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-3 col-md-3">City</label>
                        <div class="col-md-9 col-lg-9">
                            <asp:TextBox ID="TextBox9" CssClass="form-control" runat="server"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red" ErrorMessage="*" ControlToValidate="TextBox9" ValidationGroup="subc"></asp:RequiredFieldValidator>
                          </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-lg-3 col-md-3">Mobile No</label>
                        <div class="col-md-9 col-lg-9">
                            <asp:TextBox ID="TextBox10" CssClass="form-control" runat="server" MaxLength="10" TextMode="Phone"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red" ErrorMessage="*" ControlToValidate="TextBox10" ValidationGroup="subc"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-sm-6 col-lg-6">
                    &nbsp;
                </div>
            </div>
                   
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:v0scon %>" DeleteCommand="DELETE FROM [dinvoice] WHERE [Id] = @Id" InsertCommand="INSERT INTO [dinvoice] ([product_name], [quantity], [rate]) VALUES (@product_name, @quantity, @rate)" SelectCommand="SELECT [Id], [product_name], [quantity], [rate] FROM [dinvoice]" UpdateCommand="UPDATE [dinvoice] SET [product_name] = @product_name, [quantity] = @quantity, [rate] = @rate WHERE [Id] = @Id" ProviderName="<%$ ConnectionStrings:v0scon.ProviderName %>">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="product_name" Type="String" />
                    <asp:Parameter Name="quantity" Type="Int32" />
                    <asp:Parameter Name="rate" Type="Int32" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="product_name" Type="String" />
                    <asp:Parameter Name="quantity" Type="Int32" />
                    <asp:Parameter Name="rate" Type="Int32" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th><asp:Label ID="Label1" runat="server" Text="Product Name"></asp:Label></th>
                        <th><asp:Label ID="Label2" runat="server" Text="Qunatity"></asp:Label></th>
                        <th><asp:Label ID="Label3" runat="server" Text="Price"></asp:Label></th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox></td>
                        <td><asp:TextBox ID="TextBox2" runat="server" TextMode="Number" CssClass="form-control"></asp:TextBox></td>
                        <td><asp:TextBox ID="TextBox3" runat="server" TextMode="Number" CssClass="form-control"></asp:TextBox></td>
                        <td><asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Add" CssClass="btn btn-primary" /></td>
                    </tr>
                </tbody>
            </table>

            <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource1" OnRowDataBound="GridView1_RowDataBound" ShowHeaderWhenEmpty="True" >
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    <asp:TemplateField HeaderText="No." ItemStyle-Width="100">
                    <ItemTemplate>
                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                    </ItemTemplate>

                    <ItemStyle Width="100px"></ItemStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="product_name" HeaderText="Product Name" SortExpression="product_name" />
                    <asp:BoundField DataField="quantity" HeaderText="Quantity" SortExpression="quantity" />
                    <asp:BoundField DataField="rate" HeaderText="Price" SortExpression="rate" />
                    <asp:TemplateField HeaderText="Id" Visible="false" InsertVisible="False" SortExpression="Id">
                        <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total">
                    <ItemTemplate></ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
    
            <div class="row">
                <div class="col-sm-12 col-lg-12 col-md-12">
                    <div class="row">
                        <div class="col-md-6 col-lg-6 col-sm-6 text-right">
                            Sub Total:
                        </div>
                        <div class="col-md-6 col-lg-6 col-sm-6 text-left">
                            <asp:Label ID="Label4" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6 col-sm-6 text-right">
                      CGST(%):
                        </div>
                        <div class="col-md-6 col-lg-6 col-sm-6 text-left">
                            <asp:TextBox ID="TextBox4" runat="server" AutoPostBack="True" OnTextChanged="TextBox4_TextChanged" Width="91px" Height="16px">0</asp:TextBox>
                            <asp:Label ID="Label5" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                     <div class="row">
                        <div class="col-md-6 col-lg-6 col-sm-6 text-right">
                      SGST(%):
                        </div>
                        <div class="col-md-6 col-lg-6 col-sm-6 text-left">
                            <asp:TextBox ID="TextBox11" runat="server" OnTextChanged="TextBox11_TextChanged" AutoPostBack="True"  Width="91px" Height="16px">0</asp:TextBox>
                            <asp:Label ID="Label8" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-lg-6 col-sm-6 text-right">
                            Total Payment:
                        </div>
                        <div class="col-md-6 col-lg-6 col-sm-6 text-left">
                            <asp:Label ID="Label6" runat="server" Text=""></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
            
            
		</div>
        <div class="card-footer">
            <asp:Button ID="Button3" runat="server" Text="Save" OnClick="Button3_Click" ValidationGroup="subc" CssClass="btn btn-secondary" />
            <button value="print"  onclick="PrintGridData1();" class="ml-4 btn btn-primary">Print</button>
              <script type="text/javascript">
                                    function PrintGridData1() {
                                        var prtGrid = document.getElementById('<%=GridView1.ClientID %>');
                                        var prtDate = document.getElementById('<%=billDate.ClientID %>'); 
                                        var prtID = document.getElementById('<%=TextBox6.ClientID %>'); 
                                        var prtName = document.getElementById('<%=TextBox7.ClientID %>');
                                        var prtAdd = document.getElementById('<%=TextBox8.ClientID %>');
                                        var city = document.getElementById('<%=TextBox9.ClientID %>');
                                        var mobile = document.getElementById('<%=TextBox10.ClientID %>');
                                        var subtotal = document.getElementById('<%=Label4.ClientID %>');
                                        var grdtotal = document.getElementById('<%=Label6.ClientID %>');
                                        var gst = document.getElementById('<%=TextBox4.ClientID %>');
                                        var gstamt = document.getElementById('<%=Label5.ClientID %>');
                                        prtGrid.border = 0;
                                        var prtwin = window.open('', 'PrintGridViewData', 'left=100,top=100,width=1000,height=1000,tollbar=0,scrollbars=1,status=0,resizable=1');
                                        prtwin.document.write("Date : " + prtDate.value + "<br>");
                                        prtwin.document.write("Customer ID : " + prtID.value + "<br>");
                                        prtwin.document.write("Name : " + prtName.value + "<br>");
                                        prtwin.document.write("Address : " + prtAdd.value + "<br>");
                                        prtwin.document.write("City : " + city.value + "<br>");
                                        prtwin.document.write("Mobile No. : " + mobile.value + "<br>");
                                        prtwin.document.write("<br><br>");
                                      

                                        

                                        
                                      
                                        
                                        prtwin.document.write(prtGrid.outerHTML);
                                        prtwin.document.write("<br><br>");
                                        prtwin.document.write("Sub Total : " + "&#8377; " + subtotal.outerHTML + "<br>");
                                        prtwin.document.write("GST : " + gst.value + "%" + "<br>");
                                        prtwin.document.write("GST Amount: " + "&#8377; " + gstamt.outerHTML + "<br>");
                                        prtwin.document.write("Grand Total : " + "&#8377; " + grdtotal.outerHTML + "<br>");
                                        
                                        prtwin.document.close();
                                        prtwin.focus();
                                        prtwin.print();
                                        prtwin.close();
                                    }
                                </script>

            <asp:Label ID="Label7" runat="server" Visible="False"></asp:Label>
        </div>
	</div>
</div>

</asp:Content>