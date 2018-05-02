using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace authwebpart
{
    public partial class invoice : System.Web.UI.Page
    {


        public static string cons = WebConfigurationManager.ConnectionStrings["v0scon"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(cons);
        public double gtotal = 0.0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["suser"] == null)
            {
                Response.Redirect("login.aspx");

            }

            if (!IsPostBack)
            {
                using (myConnection)
                {
                    myConnection.Open();
                    string que = "SELECT IDENT_CURRENT('invoice_customer')+1; ";
                    SqlCommand ccmd = new SqlCommand(que, myConnection);
                    object totals = ccmd.ExecuteScalar();


                    int ncid = Convert.ToInt32(totals);

                    TextBox5.Text = ncid + "";
                }
            }
        }
        protected void Button1_Click(object sender, EventArgs e)//add to list of bill
        {
            using (myConnection)
            {
                string query = "insert into dinvoice(invoice_id,product_name,quantity, rate)";
                query += "values(@invoice_id,@product_name,@quantity, @rate)";
                myConnection.Open();
                SqlCommand cmd = new SqlCommand(query, myConnection);
                cmd.Parameters.AddWithValue("@invoice_id", Int32.Parse(TextBox5.Text));
                cmd.Parameters.AddWithValue("@product_name", TextBox1.Text);
                cmd.Parameters.AddWithValue("@quantity", Int32.Parse(TextBox2.Text));
                cmd.Parameters.AddWithValue("@rate", Int32.Parse(TextBox3.Text));
                cmd.ExecuteNonQuery();
                GridView1.DataBind();
            }
            TextBox1.Text = "";
            TextBox2.Text = "";
            TextBox3.Text = "";
        }

        protected void TextBox6_TextChanged(object sender, EventArgs e)//retrive customer info
        {
            using (myConnection)
            {
                myConnection.Open();
                string que = "SELECT * from customer where c_id=@c_id ";
                SqlCommand ccmd = new SqlCommand(que, myConnection);
                if (TextBox6.Text != "" && TextBox6.Text != null)
                {
                    ccmd.Parameters.AddWithValue("@c_id", Int32.Parse(TextBox6.Text));
                    SqlDataReader rdr = ccmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        TextBox7.Text = rdr["c_fname"].ToString() + " " + rdr["c_mname"].ToString() + " " + rdr["c_lname"].ToString();
                        TextBox9.Text = rdr["city"].ToString();
                        TextBox8.Text = rdr["address"].ToString();
                        TextBox10.Text = rdr["mobile_no"].ToString();

                    }
                }
                else
                {
                    TextBox7.Text = "";
                    TextBox9.Text = "";
                    TextBox8.Text = "";
                    TextBox10.Text = "";

                }

            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)//bill item table
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                double dt = Double.Parse((e.Row.DataItem as DataRowView).Row["quantity"].ToString()) * Double.Parse((e.Row.DataItem as DataRowView).Row["rate"].ToString());
                e.Row.Cells[6].Text = dt.ToString();
                gtotal = gtotal + dt;
                TextBox4.Text = "";
                Label4.Text = gtotal.ToString();
                Label5.Text = "" + 0;

                Label6.Text = Label4.Text;

            }


        }

        protected void TextBox4_TextChanged(object sender, EventArgs e)//calculate bill amounts
        {
            Response.Write(TextBox4.Text);
            if (TextBox4.Text == "")
            {
                Label6.Text = Label4.Text;
            }
            else
            {
                double ptot = Double.Parse(Label4.Text) * (Double.Parse(TextBox4.Text) / 100);
                Label5.Text = ptot.ToString();
                double tp = Double.Parse(Label4.Text) + Double.Parse(Label5.Text);
                Label6.Text = tp.ToString();

            }

        }

        protected void TextBox11_TextChanged(object sender, EventArgs e)//calculate bill amounts
        {
        }


            protected void Button3_Click(object sender, EventArgs e)
        {
            using (myConnection)
            {
                myConnection.Open();

                string que = "insert into invoice_customer (c_id,c_name,address,city,mobile_no,date) ";
                que += "values(@c_id,@c_name,@address,@city,@mobile_no,@date)";

                SqlCommand ccmd = new SqlCommand(que, myConnection);
                if (TextBox6.Text != "" && TextBox6.Text != null)
                    ccmd.Parameters.AddWithValue("@c_id", Int32.Parse(TextBox6.Text));



                //ccmd.Parameters.AddWithValue("@date",);
                ccmd.Parameters.AddWithValue("@c_name", TextBox7.Text);
                if(TextBox8.Text!="")
                    ccmd.Parameters.AddWithValue("@address", TextBox8.Text);
                else
                    ccmd.Parameters.AddWithValue("@address", "none");
                ccmd.Parameters.AddWithValue("@city", TextBox9.Text);
                ccmd.Parameters.AddWithValue("@mobile_no", Decimal.Parse(TextBox10.Text));
                ccmd.Parameters.AddWithValue("@date", DateTime.Parse(billDate.Text));
                ccmd.ExecuteNonQuery();
                Response.Write("updated detail");


                string insq = "INSERT INTO invoice (invoice_id,product_name,quantity,rate) SELECT invoice_id,product_name,quantity,rate FROM dinvoice ";
                SqlCommand copcmd = new SqlCommand(insq, myConnection);
                copcmd.ExecuteNonQuery();


                string dropquery = "TRUNCATE TABLE dinvoice ";



                SqlCommand drcmd = new SqlCommand(dropquery, myConnection);
                drcmd.ExecuteNonQuery();



            }
            Label7.Text = "data is saved-take your print";
            Label7.Visible = true;

        }


    }
}