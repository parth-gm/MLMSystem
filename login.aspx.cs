using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace authwebpart
{
    public partial class login : System.Web.UI.Page
    {

        public static string cons = WebConfigurationManager.ConnectionStrings["v0scon"].ConnectionString;
        public SqlConnection myConnection = new SqlConnection(cons);
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["suser"]!=null)
            {
                
                Session.Abandon();
                Session.Remove(Session["suser"].ToString());
            }
            if (Request.UrlReferrer != null)
            {
                string previousPageUrl = Request.UrlReferrer.AbsoluteUri;
                string previousPageName = System.IO.Path.GetFileName(Request.UrlReferrer.AbsolutePath);
                if (previousPageName.Contains("register.aspx"))
                {
                    errorlbl.Visible = false;
                    registerlbl.Visible = true;
                    registerlbl.Text = "Your account will be activated by Admin very soon.";
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {


            using (myConnection)
            {

                myConnection.Open();

                string s = TextBox1.Text;
                if (s != "" && s != null && TextBox2.Text != null && TextBox2.Text != "")
                {


                    string selcquery = "SELECT * FROM reg_user where reg_uname='" + s.ToString() + "'";
                    SqlCommand sccmd1 = new SqlCommand(selcquery, myConnection);
                    SqlDataReader myReader;
                    myReader = sccmd1.ExecuteReader();



                    if (myReader != null && myReader.HasRows)
                    {

                        myReader.Read();
                        string ruser = myReader["reg_uname"].ToString();
                        string pass = myReader["reg_pass"].ToString();




                        if (Boolean.Parse(myReader["isvalid"].ToString()))
                        {
                            if (pass == TextBox2.Text)
                            {
                                if (Int32.Parse(myReader["role_id"].ToString()) == 1)
                                {
                                    Session["suser"] = ruser;
                                    Session["roleid"] = 1;

                                    Response.Redirect("verify_user.aspx");

                                }
                                else
                                {
                                    Session["suser"] = ruser;
                                    Session["roleid"] = 0;
                                    FormsAuthentication.RedirectFromLoginPage(TextBox1.Text, true);
                                }
                            }
                            else
                            {
                                errorlbl.Text = "Invalid Credentials.";
                            }
                        }
                        else
                        {
                            errorlbl.Text = "Your account will be activated by Admin very soon.";
                        }
                    }
                    else
                    {
                        errorlbl.Text = "Invalid Credentials.";
                    }

                }
                else
                {
                    errorlbl.Text = "Invalid Credentials.";
                }
                    
            }
            /* authuserEntities ae = new authuserEntities();
             string s = TextBox1.Text.ToString();
             reg_user ruser = ae.reg_user.Where(r=>r.reg_uname==s ).FirstOrDefault<reg_user>();
            */
        }
    }
}