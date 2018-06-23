<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="authwebpart.register" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <!-- <link rel="shortcut icon" href="assets/ico/favicon.png"> -->

    <title>MLM Register</title>

    <!-- Icons -->
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <link href="css/simple-line-icons.css" rel="stylesheet" />

    <!-- Main styles for this application -->
    <link href="css/style.css" rel="stylesheet" />
</head>
    

    
    <body class="app flex-row align-items-center">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card-group mb-0">
                    <div class="card">
                        <div class="card-body">
                            <form id="form1" runat="server" class="form-horizontal">
                                <h1>Register</h1>
                                <p class="text-muted">Sign up to your account</p>

                                <p class="invalid-feedback"><asp:label ID="errorlbl" runat="server" Visible="False"></asp:label></p>


                                <div class="form-group row">
                                    <label for="TextBox1" class="col-md-3 col-lg-3">Username</label>
                                    <div class="col-md-9 col-lg-9">
                                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>

                                
                                <div class="form-group row">
                                    <label for="TextBox2" class="col-md-3 col-lg-3">Password</label>
                                    <div class="col-md-9 col-lg-9">
                                        <asp:TextBox ID="TextBox2" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="TextBox3" class="col-md-3 col-lg-3">Re-Password</label>
                                    <div class="col-md-9 col-lg-9">
                                        <asp:TextBox ID="TextBox3" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                           <asp:CompareValidator ID="CompareValidatorPasswrd" runat="server" ForeColor="Red" ErrorMessage="Password Mis-match" ControlToValidate="TextBox3" Operator="Equal" ControlToCompare="TextBox2" ValidationGroup="rbtn" Type="String"></asp:CompareValidator>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="TextBox4" class="col-md-3 col-lg-3">Email</label>
                                    <div class="col-md-9 col-lg-9">
                                        <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="TextBox5" class="col-md-3 col-lg-3">Phone</label>
                                    <div class="col-md-9 col-lg-9">
                                        <asp:TextBox ID="TextBox5" type="number" runat="server" CssClass="form-control" MaxLength="10" TextMode="Phone"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-6">
                                        <asp:Button ID="Button1" runat="server" ValidationGroup="rbtn"  OnClick="Button1_Click" Text="Submit"  CssClass="btn btn-primary px-4" />
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="card-footer">
                            <h2>Sign in</h2>
                            <a href="login.aspx" class="btn btn-primary active mt-3">Login</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
        
    <!-- Bootstrap and necessary plugins -->
    <script src="js/libs/jquery.min.js"></script>
    <script src="js/libs/tether.min.js"></script>
    <script src="js/libs/bootstrap.min.js"></script>



    </body>



</html>
