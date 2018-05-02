using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace authwebpart
{
    public partial class register : System.Web.UI.Page
    {
        public static string cons = WebConfigurationManager.ConnectionStrings["v0scon"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(cons);
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            using (myConnection)
            {
                myConnection.Open();
            
                string rquery = "insert into reg_user ( reg_uname,reg_pass,email_id,mobile_no,reg_date)";
                rquery += "values(@reg_uname,@reg_pass,@email_id,@mobile_no,@reg_date)";
                if (TextBox1.Text != "" && TextBox2.Text != "" && TextBox3.Text != "" && TextBox4.Text != "" && TextBox5.Text != "")
                {

                    string vuserquery = "SELECT * FROM reg_user where reg_uname='" + TextBox1.Text.ToString() + "'";
                    SqlCommand sccmd1 = new SqlCommand(vuserquery, myConnection);
                    SqlDataReader myReader;
                    myReader = sccmd1.ExecuteReader();

                    if (!myReader.HasRows)
                    {
                        myReader.Close();
                        SqlCommand regcmd = new SqlCommand(rquery, myConnection);
                        regcmd.Parameters.AddWithValue("@reg_uname", TextBox1.Text.ToString());
                        regcmd.Parameters.AddWithValue("@reg_pass", TextBox2.Text.ToString());
                        regcmd.Parameters.AddWithValue("@email_id", TextBox4.Text.ToString());
                        DateTime newDt = System.DateTime.Now;
                        regcmd.Parameters.AddWithValue("@reg_date", newDt);
                        regcmd.Parameters.AddWithValue("@mobile_no", Decimal.Parse(TextBox5.Text.ToString()));

                        regcmd.ExecuteNonQuery();
                        myConnection.Close();

                        Response.Redirect("~/login.aspx");
                    }
                    else
                    {
                        errorlbl.Visible = true;
                        errorlbl.Text = "Username already exist.";
                    }

                }
                else
                {
                    errorlbl.Visible = true;
                    errorlbl.Text = "Please enter correct values.";
                }

            }


           
          
        }
    }
}