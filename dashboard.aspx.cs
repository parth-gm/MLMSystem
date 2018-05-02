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
    public partial class dashboard : System.Web.UI.Page
    {

        public static string s = WebConfigurationManager.ConnectionStrings["v0scon"].ConnectionString;

        private SqlConnection scon = new SqlConnection(s);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["suser"] == null)
            {
                Response.Redirect("login.aspx");

            }
            if (!IsPostBack)
            {
                using (scon)
                {
                    scon.Open();
                    string ts = "select  sum(gross_weight) from cust_mor WHERE (cust_mor.c_id IN (select customer.c_id from customer where customer.isactive=1) AND cust_mor.item_type=@item_type) GROUP BY cust_mor.item_type";

                    SqlCommand cmdts = new SqlCommand(ts, scon);
                    cmdts.Parameters.AddWithValue("@item_type", "silver");
                    object totals = cmdts.ExecuteScalar();
                    string ss = Convert.ToString(totals);
                   // Response.Write(ss);
                    string tg = "select  sum(gross_weight) from cust_mor WHERE (cust_mor.c_id IN (select customer.c_id from customer where customer.isactive=1) AND cust_mor.item_type=@item_type) GROUP BY cust_mor.item_type";
                    SqlCommand cmdtg = new SqlCommand(tg, scon);
                    cmdtg.Parameters.AddWithValue("@item_type", "gold");
                    object totalg = cmdtg.ExecuteScalar();
                    string sg = Convert.ToString(totalg);

                    string to = "select  sum(gross_weight) from cust_mor WHERE (cust_mor.c_id IN (select customer.c_id from customer where customer.isactive=1) AND cust_mor.item_type=@item_type) GROUP BY cust_mor.item_type";
                    SqlCommand cmdto = new SqlCommand(to, scon);
                    cmdto.Parameters.AddWithValue("@item_type", "other");
                    object totalo = cmdto.ExecuteScalar();
                    string so = Convert.ToString(totalo);
                    if (so == "")
                        so = "0";
                    if (sg == "")
                        sg = "0";
                    if (ss == "")
                        ss = "0";
                    
                    double dss = Double.Parse(ss)/1000;
                    double dsg = Double.Parse(sg)/1000;
                    double dso = Double.Parse(so)/1000;

                    //Decimal dsokg = Convert.ToDecimal(dso / 1000);
                    double rdsokg = Math.Round(dso,2);

                   // Decimal dsgkg = Convert.ToDecimal(dsg / 1000);
                    double rdsgkg = Math.Round(dsg, 2);

                    //Decimal dsskg = Convert.ToDecimal(dss / 1000);
                    double rdsskg = Math.Round(dss, 2);

                    LabelSilver.Text = rdsskg+"";
                    LabelGold.Text = rdsgkg+"";
                    LabelOther.Text = rdsokg+"";

                  

                    string totcq = "select  sum(t_amount) from transection where (transection.c_id in (select customer.c_id from customer where customer.isactive=1) AND t_type=@t_type) GROUP BY t_type";
                    SqlCommand cmdtotc = new SqlCommand(totcq, scon);
                    cmdtotc.Parameters.AddWithValue("@t_type", "c");
                    object totc = cmdtotc.ExecuteScalar();
                    string stc = Convert.ToString(totc);


                    string totdq = "select  sum(t_amount) from transection where (transection.c_id in (select customer.c_id from customer where customer.isactive=1) AND t_type=@t_type) GROUP BY t_type";
                    SqlCommand cmdtotd = new SqlCommand(totdq, scon);
                    cmdtotd.Parameters.AddWithValue("@t_type", "d");
                    object totd = cmdtotd.ExecuteScalar();
                    string std = Convert.ToString(totd);
                    double rstc = Math.Round(double.Parse(stc), 2);
                    double rstd = Math.Round(double.Parse(std), 2);
                    LabelCredit.Text = rstd.ToString() ;
                    LabelDebit.Text = rstc.ToString();
                    

                }
            }
        }

      
    }
}