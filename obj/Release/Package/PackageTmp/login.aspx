<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="authwebpart.login" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <!-- <link rel="shortcut icon" href="assets/ico/favicon.png"> -->

    <title>MLM Login</title>

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
                            <form id="form2" runat="server">
                                <h1>Login</h1>
                                <p class="text-muted">Sign In to your account</p>

                                <p class="invalid-feedback"><asp:label ID="errorlbl" runat="server"></asp:label></p>
                                <p class=""><asp:label ID="registerlbl" Visible="false" runat="server" Text=""></asp:label> </p>

                                <div class="input-group mb-3">
                                    <span class="input-group-addon"><i class="icon-user"></i>
                                    </span>
                                 <!--  -->
                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="input-group mb-4">
                                    <span class="input-group-addon"><i class="icon-lock"></i>
                                    </span>
                                    <asp:TextBox ID="TextBox2" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="row">
                                    <div class="col-6">
                                        <asp:Button ID="Button2" runat="server" OnClick="Button1_Click" Text="Submit" CssClass="btn btn-primary px-4" />
                                    </div>
                                </div>
                                
                                
                            </form>
                        </div>
                        
                        <div class="card-footer p-4">
                            <h2>Sign up</h2>
                            <a href="register.aspx" class="btn btn-primary active mt-3">Register</a>
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

