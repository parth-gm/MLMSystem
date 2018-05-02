using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace authwebpart
{
    public partial class search_datewise : System.Web.UI.Page
    {
        public static string cons = WebConfigurationManager.ConnectionStrings["v0scon"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["suser"] == null)
            {
                Response.Redirect("login.aspx");
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            GridView1.DataBind();
          //  Response.Write(fromSearchTextBox.Text);
        }
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/view.aspx?c_id=" + ((LinkButton)sender).Text);
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            
                if (e.Row.RowType == DataControlRowType.DataRow)

                {

                    using (SqlConnection scon = new SqlConnection(cons))
                    {
                        scon.Open();
                        int rowcid = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "c_id"));
                        // Response.Write("hear idd"+rowcid);

                        string tdquery = "SELECT  SUM(t_amount) FROM transection where (c_id=@c_id AND t_type=@t_type) GROUP BY c_id ";

                        SqlCommand tdmycmd = new SqlCommand(tdquery, scon);
                        tdmycmd.Parameters.AddWithValue("@c_id", rowcid);
                        tdmycmd.Parameters.AddWithValue("@t_type", "d");
                        object totald = tdmycmd.ExecuteScalar();
                        string ss = Convert.ToString(totald);


                      
                        string tcquery = "SELECT  SUM(t_amount) FROM transection where (c_id=@c_id AND t_type=@t_type) GROUP BY c_id ";

                        SqlCommand tcmycmd = new SqlCommand(tcquery, scon);
                        tcmycmd.Parameters.AddWithValue("@c_id", rowcid);
                        tcmycmd.Parameters.AddWithValue("@t_type", "c");
                        object totalc = tcmycmd.ExecuteScalar();
                        string ss1 = Convert.ToString(totalc);



                        e.Row.Cells[15].Text = ss;
                        e.Row.Cells[14].Text = ss1;
                    }

                }

            
        }
    }
}