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
    public partial class view : System.Web.UI.Page
    {
        double grdTotal = 0.00;
        double wTotal = 0.00;
        public double totalmor = 0.00;
        public  double totaldeb = 0.00;
        public double totcr = 0.00;
        public static string s = WebConfigurationManager.ConnectionStrings["v0scon"].ConnectionString;

        private SqlConnection scon= new SqlConnection(s);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["suser"] == null)
            {
                Response.Redirect("login.aspx");
            }

            if (Session["roleid"].ToString() == "1")
            {
                Button5.Enabled = true;
                Button5.Visible = true;
            }

            if (!IsPostBack)
            {
               

                //query string pass to hidden field
                string dc_id = Request.QueryString["c_id"];

                Session.Add("c_id", dc_id);
                
                HiddenField1.Value = dc_id;
                
                if (dc_id == null)
                {
                    Response.Redirect("cust_list.aspx");
                }
              
                using (scon)
                {
                    scon.Open();
                    string query = "select * FROM  customer where c_id=@c_id";

                    SqlCommand sqc = new SqlCommand(query, scon);
                    
                    sqc.Parameters.AddWithValue("@c_id", Int32.Parse(HiddenField1.Value.ToString()));



                    using (SqlDataReader rdr = sqc.ExecuteReader())
                    {
                        if (rdr.HasRows)//check customer exist
                        {
                            rdr.Read();

                            Label25.Text = rdr["c_id"].ToString();
                            Label19.Text = rdr["c_fname"].ToString() + " " + rdr["c_mname"].ToString() + " " + rdr["c_lname"].ToString();
                            Label21.Text = rdr["city"].ToString();
                            Label20.Text = rdr["address"].ToString();
                            Label22.Text = rdr["mobile_no"].ToString();
                            Label23.Text = rdr["interest_rate"].ToString();
                            Label24.Text = rdr["debit_limit"].ToString();
                            Label26.Text =rdr["updated_date"].ToString();
                            Label27.Text =  rdr["created_date"].ToString();
                            Label28.Text =  rdr["create_date"].ToString();
                            if (rdr["isactive"].ToString()=="False")//for close account
                            {
                                GridView1.Enabled = false;
                                GridView2.Enabled = false;
                                RadioButtonList1.Enabled = false;
                                creditdebitDate.Enabled = false;
                                TextBox17.Enabled = false;
                                Button2.Enabled = false;
                                Button3.Enabled = false;
                                TextBox10.Enabled = false;
                                TextBox12.Enabled = false;
                                TextBox14.Enabled = false;
                                TextBox16.Enabled = false;
                                Button4.Enabled = false;
                                DropDownList1.Enabled = false;
                            }
                           
                        }
                        else
                        {
                            Response.Redirect("~/cust_list.aspx");
                        }

                    }
                   
                }
            }
            mortgageCalc();//calculate return amount

        }

        public  void mortgageCalc()//mortgage logic
        {
            int i=0;
            double intrate = 36.00;
            double famt=0.0, pramt=0.00;
            DateTime  lcrdate,ldebat=System.DateTime.Now;
            DateTime dtnow = System.DateTime.Now;
            using (SqlConnection scon2 = new SqlConnection(s))
            {
                scon2.Open();
                //Response.Write("mortgage calculation begin..");
                DateTime curdate = System.DateTime.Now;

                /*take interest rate:start*/


                string intquery = "select * FROM customer where c_id=@c_id";

                SqlCommand sqint = new SqlCommand(intquery, scon2);
                sqint.Parameters.AddWithValue("@c_id", Int32.Parse(HiddenField1.Value.ToString()));
                using (SqlDataReader rdrint = sqint.ExecuteReader())
                {

                    if (rdrint.HasRows)
                    {
                        rdrint.Read();
                        string ints = rdrint["interest_rate"].ToString();
                        intrate = double.Parse(ints);
                    }
                    else
                    {
                        intrate = 36.00;
                    }
                }

                /*take interest rate:end*/

                string query = "select * FROM transection where c_id=@c_id ORDER BY t_date ASC";

                SqlCommand sqc = new SqlCommand(query, scon2);

                sqc.Parameters.AddWithValue("@c_id", Int32.Parse(HiddenField1.Value.ToString()));
                using (SqlDataReader rdr = sqc.ExecuteReader())
                {
                   
                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            string rdrdate = rdr["t_date"].ToString();
                            string rdrtype = rdr["t_type"].ToString();
                            string rdramt = rdr["t_amount"].ToString();
                            DateTime pastdt = Convert.ToDateTime(rdrdate);
                           
                            if(i==0)
                            {
                                pramt=Double.Parse(rdramt);
                                ldebat = Convert.ToDateTime(rdrdate);
                                i++;
                            }
                                
                            if (rdrtype=="d")
                            {
                              
                             //ldebdate = pastdt;
                                pramt = Double.Parse(rdramt);
                               // totaldeb = totaldeb + Double.Parse(rdramt); 
                                string diffdays = (dtnow - pastdt).TotalDays.ToString();
                                Response.Write("days"+diffdays);
                                double dday = Double.Parse(diffdays);
                              

                                int ddays = (int)dday;
                                Response.Write("ddays" + ddays);
                                double diffyears = ddays / 365;


                                ////
                                if (diffyears > 1)
                                {
                                    double dd =  pramt * Math.Pow((1 + (intrate / 100)), diffyears);
                                    famt = famt + dd;

                                }
                                else
                                {
                                    ///////

                                    double diffmonths = ddays / (double)30.00;
                                   // Response.Write("diffmonths" + diffmonths);
                                    int idiffmon = (int)diffmonths;
                                    double dgap = (diffmonths - idiffmon) * 30;
                                    //Response.Write("new dgap" + dgap);
                                    double intamtm = pramt + pramt * (intrate / (12 * 100)) * idiffmon;
                                   // Response.Write("intamtm" + intamtm);
                                   // Response.Write("dcamt" + dcamount);
                                    double intamtd = pramt * (intrate / (12 * 30 * 100)) * dgap;
                                   // Response.Write(intamtd);
                                    double result = intamtd + intamtm;
                                    // double dd = dcamount * Math.Pow((1 + (intrate / 100) diffyears);
                                    famt = famt + result;
                                    
                                    ///////
                                }
                                     

                                Response.Write("\\"+famt+"-debit");

                            }
                            else
                            {
                                lcrdate=pastdt;
                                famt = famt - Double.Parse(rdramt);
                                //Response.Write("\\\\"+famt + "-principle credit");
                                string diffdays = (lcrdate - ldebat).TotalDays.ToString();
                                double ddays = Double.Parse(diffdays);
                                double diffyears = ddays /365;
                                famt = famt * Math.Pow((1 + intrate/100), diffyears);
                                //Response.Write("afetr credit total" + famt+"\\");
                            }
                        }
                        //Response.Write("final-"+famt);
                        double rfamt = Math.Round(famt, 2);
                        if(rfamt<0)
                        {
                            lblpayamt.Text = "0";
                        }
                        else
                        {
                            lblpayamt.Text = rfamt.ToString();
                        }
                        
                        //lblpayamt.Text = famt.ToString();
                    }

                }
            }
        }
        protected void Button2_Click(object sender, EventArgs e)//add transection detail
        {
            //if (TextBox12.Text != "" && TextBox14.Text != "" && TextBox10.Text != "" && TextBox16.Text != "" && DropDownList1.SelectedIndex > -1 && DropDownList1.SelectedIndex != 0)
            // {
            if (TextBox17.Text != "" && TextBox17 != null)
            {

                using (scon)
                {
                    scon.Open();
                   
                   
                    //update customer account transection
                    string tquery = "insert into transection (c_id,t_type,t_date,t_amount)";
                    tquery += "values (@c_id,@t_type,@t_date,@t_amount)";
                    string upcustq= "UPDATE customer SET updated_date=@updated_date where c_id = @c_id";
                    SqlCommand custcmd = new SqlCommand(upcustq, scon);
                    if(creditdebitDate.Text!="" && creditdebitDate.Text != null)
                    {
                        DateTime updt = DateTime.Parse(creditdebitDate.Text);
                        custcmd.Parameters.AddWithValue("@updated_date", updt);
                        custcmd.Parameters.AddWithValue("@c_id", Int32.Parse(HiddenField1.Value.ToString()));
                        custcmd.ExecuteNonQuery();
                        //Response.Write("updated date added");
                    }

                    SqlCommand tcmd = new SqlCommand(tquery, scon);
                    
                    tcmd.Parameters.AddWithValue("@c_id", Int32.Parse(HiddenField1.Value.ToString()));
                    if (creditdebitDate.Text != "" && creditdebitDate.Text != null)
                           tcmd.Parameters.AddWithValue("@t_date", DateTime.Parse(creditdebitDate.Text));
                    else
                        tcmd.Parameters.AddWithValue("@t_date", System.DateTime.Now);

                    //  if (TextBox17.Text != "" && TextBox17 != null)
                    //   {
                    tcmd.Parameters.AddWithValue("t_amount", Decimal.Parse(TextBox17.Text.ToString()));
                    
                    if (RadioButtonList1.SelectedIndex == 0)
                        {
                            tcmd.Parameters.AddWithValue("@t_type", "c");
                            tcmd.ExecuteNonQuery();
                             GridView2.DataBind();
                          //  Response.Write(" credit transection is added succesfully...");
                    }
                    else if (RadioButtonList1.SelectedIndex == 1)
                    {
                            tcmd.Parameters.AddWithValue("@t_type", "d");
                            tcmd.ExecuteNonQuery();
                         GridView2.DataBind();
                         //   Response.Write(" debit transection is added succesfully...");
                    }
                    else
                    {
                      //  Response.Write("select transection type!!!");
                    }
                    TextBox17.Text = "";
                    creditdebitDate.Text = "";
                }
            }
            else
            {
                //Response.Write("empty  ttransection amount field ");
            }
            Response.Redirect("~/view.aspx?c_id=" + HiddenField1.Value.ToString());
        }
        protected void Button3_Click(object sender, EventArgs e)//submit and close customer account
        {
            using (scon)
            {
                scon.Open();
                string upquery = "UPDATE customer SET isactive = @isactive,updated_date=@updated_date where c_id=@c_id";
                SqlCommand cmd = new SqlCommand(upquery, scon);
                cmd.Parameters.AddWithValue("@c_id", Int32.Parse(HiddenField1.Value.ToString()));
                cmd.Parameters.AddWithValue("@updated_date", System.DateTime.Now);
                cmd.Parameters.AddWithValue("@isactive", false);
                cmd.ExecuteNonQuery();

            }

            Response.Redirect("~/cust_list.aspx");
        }

        protected void Button4_Click(object sender, EventArgs e)//add mortgage to grid
        {
            if (TextBox12.Text != "" && TextBox14.Text != "" && TextBox10.Text != "" && TextBox16.Text != "" && DropDownList1.SelectedIndex > -1 && DropDownList1.SelectedIndex != 0)
            {
                using (scon)
                {
                   // Response.Write("start");
                    scon.Open();
                    string query = "insert into cust_mor (c_id,item_type,item_name,gross_weight,rate,amount)";
                    query += "values(@c_id,@item_type,@item_name,@gross_weight,@rate,@amount)";
                    SqlCommand cmd = new SqlCommand(query, scon);
                    cmd.Parameters.AddWithValue("@c_id", Int32.Parse(HiddenField1.Value.ToString()));

                    cmd.Parameters.AddWithValue("@item_type", DropDownList1.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@item_name", TextBox10.Text.ToString());
                    cmd.Parameters.AddWithValue("@gross_weight", Decimal.Parse(TextBox12.Text.ToString()));
                    cmd.Parameters.AddWithValue("@rate", Decimal.Parse(TextBox14.Text.ToString()));
                    cmd.Parameters.AddWithValue("@amount", Decimal.Parse(TextBox16.Text.ToString()));
                     cmd.ExecuteNonQuery();
                    Response.Redirect("~/view.aspx?c_id=" + HiddenField1.Value.ToString());
                    //Response.Write("finish");
                }
            }
            else
            {
               // Response.Write("Database Error....");
            }
        }

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)//transection gridview
        {
            double intrate = 36.00;


            /*take interest rate:start*/

            using (SqlConnection scon2 = new SqlConnection(s))
            {
                scon2.Open();
                string intquery = "select * FROM customer where c_id=@c_id";

                SqlCommand sqint = new SqlCommand(intquery, scon2);
                sqint.Parameters.AddWithValue("@c_id", Int32.Parse(HiddenField1.Value.ToString()));
                using (SqlDataReader rdrint = sqint.ExecuteReader())
                {

                    if (rdrint.HasRows)
                    {
                        rdrint.Read();
                        string ints = rdrint["interest_rate"].ToString();
                        intrate = double.Parse(ints);
                    }
                    else
                    {
                        intrate = 36.00;
                    }
                }
            }
            /*take interest rate:end*/

            
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[3].Visible = false;
                e.Row.Cells[4].Visible = false;
            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //calculate total debit and credit amount and mortgage on debit
                double dcamount = Convert.ToDouble(e.Row.Cells[4].Text);
                string dctype = e.Row.Cells[3].Text;
                double rdcamt = Math.Round(dcamount, 2);
                string culs = string.Format(new System.Globalization.CultureInfo("en-IN"), "{0:c}", rdcamt);
                e.Row.Cells[3].Visible = false;
                e.Row.Cells[4].Visible = false;
                if (dctype == "d")
                {
                    totaldeb = totaldeb + dcamount;
                    e.Row.Cells[2].Text = culs;
                    DateTime dtnow = System.DateTime.Now;
                    DateTime pastdt = Convert.ToDateTime(DataBinder.Eval(e.Row.DataItem, "t_date"));
                    string diffdays = (dtnow - pastdt).TotalDays.ToString();
                    Response.Write("days"+diffdays);

                    double dday = Double.Parse(diffdays);
                    int ddays = (int)dday;
                    Response.Write("ddays"+ddays);
                    double diffyears = ddays / 365;
                    if(diffyears>1)
                    {
                        double dd =dcamount * Math.Pow((1 + (intrate / 100)), diffyears);
                        double rdd = Math.Round(dd, 2);
                        string famt = string.Format(new System.Globalization.CultureInfo("en-IN"), "{0:c}", rdd);
                        e.Row.Cells[5].Text = famt;

                        totalmor = totalmor + Convert.ToDouble(dd.ToString());
                    }
                    else
                    {
                        
                        double diffmonths = ddays / (double)30.00;
                        Response.Write("diffmonths"+diffmonths);
                        int idiffmon = (int)diffmonths;
                        double dgap = (diffmonths - idiffmon)*30;
                        Response.Write("new dgap" + dgap);
                        double intamtm = dcamount+dcamount * (intrate / (12 * 100)) * idiffmon;
                        Response.Write("intamtm"+intamtm);
                        Response.Write("dcamt"+dcamount);
                        double intamtd = dcamount * (intrate / (12 *30* 100)) * dgap;
                        Response.Write(intamtd);
                        double result = intamtd + intamtm;
                        // double dd = dcamount * Math.Pow((1 + (intrate / 100) diffyears);
                        double rdd = Math.Round(result, 2);
                        string famt = string.Format(new System.Globalization.CultureInfo("en-IN"), "{0:c}", rdd);
                        e.Row.Cells[5].Text = famt;

                        totalmor = totalmor + Convert.ToDouble(result.ToString());
                    }
                   /* double dd = dcamount * Math.Pow((1 + (intrate/100)), diffyears);
                    double rdd = Math.Round(dd, 2);
                    string famt = string.Format(new System.Globalization.CultureInfo("en-IN"), "{0:c}", rdd);
                    e.Row.Cells[5].Text = famt;
                    
                    totalmor = totalmor + Convert.ToDouble(dd.ToString());
                    ///Response.Write("total mor grid view" + totalmor);
                    */

                }
                else
                {
                    totcr = totcr + dcamount;
                    e.Row.Cells[1].Text = culs;
                }



            } else if (e.Row.RowType == DataControlRowType.Footer){
                double rtdeb = Math.Round(totaldeb, 2);
                if(rtdeb<0)
                {
                    rtdeb = 0.0;
                }
                double rtcr = Math.Round(totcr, 2);
                if (rtcr < 0)
                {
                    rtcr = 0.0;
                }
                double rtmor = Math.Round(totalmor, 2);
                if (rtmor < 0)
                {
                    rtmor = 0.0;
                }
                double diff = (totalmor - totaldeb);
                double rtint = Math.Round(diff, 2);
                if (rtint < 0)
                {
                    rtint = 0.0;
                }
                lbltotdeb.Text = rtdeb.ToString();
                lbltotcr.Text = rtcr.ToString();
                lbltotmor.Text = rtmor.ToString();
                lbltotint.Text = rtint.ToString();
            }

        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)//mortgage gridview

        {

             if (e.Row.RowType == DataControlRowType.DataRow)

             {

                 double rowTotal = Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "amount"));
                double wrowTotal = Convert.ToDouble(DataBinder.Eval(e.Row.DataItem, "gross_weight"));
                grdTotal = grdTotal + rowTotal;
                wTotal = wTotal + wrowTotal;
             }
             else if (e.Row.RowType == DataControlRowType.Footer)
             {

                  Label albl = (Label)e.Row.FindControl("lblactotal");
                Label wlbl = (Label)e.Row.FindControl("lblgrtotal");
                double rgrdt = Math.Round(grdTotal, 2);
                if(rgrdt<0)
                {
                    rgrdt = 0.0;
                }
                string famt = string.Format(new System.Globalization.CultureInfo("en-IN"), "{0:c}", rgrdt);
                double rwdt = Math.Round(wTotal, 2);
                double rwdtkg = rwdt / 1000;
                wlbl.Text = rwdtkg.ToString()+"/-kg";

                albl.Text = famt;
             }

        }

        protected void Button5_Click(object sender, EventArgs e)//delete customer account
        {

            using (scon)
            {
             
                scon.Open();
                string dquery = "DELETE FROM customer WHERE c_id = @c_id";
                SqlCommand dcmd = new SqlCommand(dquery, scon);
                dcmd.Parameters.AddWithValue("@c_id", Int32.Parse(HiddenField1.Value.ToString()));
                dcmd.ExecuteNonQuery();
            }
                Response.Redirect("~/cust_list.aspx");
        }
    }
}