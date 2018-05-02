using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data.SqlClient;
namespace authwebpart
{
    public partial class cust_list : System.Web.UI.Page
    {
        public static string s = WebConfigurationManager.ConnectionStrings["v0scon"].ConnectionString;


        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["suser"] == null)
            {
                Response.Redirect("login.aspx");
            }
            if (!IsPostBack)
            {

                /* using (scon)
                 {
                     scon.Open();
                     string query = " SELECT c_id, c_fname, c_mname, c_lname, city, create_date FROM  customer where isactive=@isactive ORDER BY c_id DESC";
                     SqlCommand sqc = new SqlCommand(query, scon);
                     sqc.Parameters.AddWithValue("@isactive", true);
                     GridView2.DataSource = sqc.ExecuteReader();
                      GridView2.DataBind();

                     rdr.Close();
                    }
               */

            }
        }
        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/view.aspx?c_id=" + ((LinkButton)sender).Text);
        }

        protected void GridView2_RowDataBound1(object sender, GridViewRowEventArgs e)
        {
            //diplay customer list and transection info

            if (e.Row.RowType == DataControlRowType.DataRow)
            {



                using (SqlConnection scon = new SqlConnection(s))
                {
                    scon.Open();
                    int rowcid = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "c_id"));
                   // Response.Write("customer id"+rowcid);
                   
                    string tdquery = "SELECT  SUM(t_amount) FROM transection where (c_id=@c_id AND t_type=@t_type) GROUP BY c_id ";

                    SqlCommand tdmycmd = new SqlCommand(tdquery, scon);
                    tdmycmd.Parameters.AddWithValue("@c_id", rowcid);
                    tdmycmd.Parameters.AddWithValue("@t_type","d");
                    object totald = tdmycmd.ExecuteScalar();
                    string ss = Convert.ToString(totald);


                    string tcquery = "SELECT  SUM(t_amount) FROM transection where (c_id=@c_id AND t_type=@t_type) GROUP BY c_id ";

                    SqlCommand tcmycmd = new SqlCommand(tcquery, scon);
                    tcmycmd.Parameters.AddWithValue("@c_id", rowcid);
                    tcmycmd.Parameters.AddWithValue("@t_type", "c");
                    object totalc = tcmycmd.ExecuteScalar();
                    string ss1 = Convert.ToString(totalc);

                    //double rss = Math.Round(double.Parse(ss), 2);
                    //double rss1 = Math.Round(ss1, 2);
                    e.Row.Cells[5].Text = ss.ToString();
                    e.Row.Cells[4].Text = ss1.ToString();
                }


            }

        }
    }
}