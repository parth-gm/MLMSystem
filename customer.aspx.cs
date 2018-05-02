using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace authwebpart
{
    public partial class customer : System.Web.UI.Page
    {
        public static string cons = WebConfigurationManager.ConnectionStrings["v0scon"].ConnectionString;
        SqlConnection myConnection = new SqlConnection(cons);
        double totw = 0;
        double tota = 0;

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
                    string que = "SELECT IDENT_CURRENT('customer')+1; "; // to get next auto increment customer id c_id

                    SqlCommand ccmd = new SqlCommand(que, myConnection);
                    object totals = ccmd.ExecuteScalar();


                    int ncid = Convert.ToInt32(totals);

                    TextBox8.Text = ncid + "";
                    Session.Add("c_id", ncid);

                }

            }
        }







        static string cfpath="none";
        static string mfpath ="none";
        protected void Wizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e)
        {



            using (myConnection)
            {


                myConnection.Open();
                //insert into customer table
                string cquery = "insert into customer ( c_fname,c_mname,c_lname,address,city,mobile_no,email_id,create_date,created_date,interest_rate,debit_limit,cphoto_path,mphoto_path)";
                cquery += "values(@c_fname,@c_mname,@c_lname,@address,@city,@mobile_no,@email_id,@create_date,@created_date,@interest_rate,@debit_limit,@cphoto_path,@mphoto_path)";
                SqlCommand ccmd = new SqlCommand(cquery, myConnection);
                ccmd.Parameters.AddWithValue("@c_fname", TextBox1.Text.ToString());
                ccmd.Parameters.AddWithValue("@c_mname", TextBox2.Text.ToString());
                ccmd.Parameters.AddWithValue("@c_lname", TextBox3.Text.ToString());
                if (string.IsNullOrWhiteSpace(this.TextBox4.Text))
                {
                    ccmd.Parameters.AddWithValue("@address", "none");
                }
                else
                {
                       ccmd.Parameters.AddWithValue("@address", TextBox4.Text.ToString());
                }
                
                ccmd.Parameters.AddWithValue("@city", DropDownList3.Text.ToString());
                ccmd.Parameters.AddWithValue("@mobile_no", Decimal.Parse(TextBox7.Text.ToString()));
                if (Calendar12.Text != "" && Calendar12.Text != null)
                    ccmd.Parameters.AddWithValue("@create_date", DateTime.Parse(Calendar12.Text));
                else
                    ccmd.Parameters.AddWithValue("@create_date", System.DateTime.Now);
                if (TextBox6.Text != "" && TextBox6.Text != null)
                    ccmd.Parameters.AddWithValue("@email_id", TextBox6.Text);
                else
                    ccmd.Parameters.AddWithValue("@email_id", "none");

                ccmd.Parameters.AddWithValue("@created_date", System.DateTime.Now);
                ccmd.Parameters.AddWithValue("@interest_rate", Decimal.Parse(TextBox19.Text.ToString()));
                ccmd.Parameters.AddWithValue("@debit_limit", Decimal.Parse(TextBox18.Text.ToString()));

                
                    ccmd.Parameters.AddWithValue("@cphoto_path", cfpath);

                
                    ccmd.Parameters.AddWithValue("@mphoto_path", mfpath);


                ccmd.ExecuteNonQuery();

                //insert mortgage items to c_id
                string insq = "INSERT INTO cust_mor(c_id,item_type,item_name,gross_weight,rate,amount) SELECT @c_id,item_type,item_name,gross_weight,rate,amount FROM dumcust_mor ";
                SqlCommand copcmd = new SqlCommand(insq, myConnection);
                copcmd.Parameters.AddWithValue("@c_id", Int32.Parse(TextBox8.Text.ToString()));
                copcmd.ExecuteNonQuery();


                string dropquery = "TRUNCATE TABLE dumcust_mor ";
                //flush buffer table


                SqlCommand drcmd = new SqlCommand(dropquery, myConnection);
                drcmd.ExecuteNonQuery();
                //  Response.Write("drop succesfully");

                


                string tquery = "insert into transection (c_id,t_type,t_date,t_amount)";
                tquery += "values (@c_id,@t_type,@t_date,@t_amount)";
                SqlCommand tcmd = new SqlCommand(tquery, myConnection);


                tcmd.Parameters.AddWithValue("@c_id", Int32.Parse(TextBox8.Text.ToString()));
                tcmd.Parameters.AddWithValue("@t_type", "d");
                tcmd.Parameters.AddWithValue("@t_date", DateTime.Parse(Calendar12.Text));
                tcmd.Parameters.AddWithValue("@t_amount", Decimal.Parse(TextBox20.Text.ToString()));
                tcmd.ExecuteNonQuery();

                myConnection.Close();
                Response.Redirect("cust_list.aspx");

            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                string filext = System.IO.Path.GetExtension(FileUpload1.FileName);
                Response.Write(filext);
                if(filext==".jpeg" || filext == ".png" || filext == ".jpg")
                { 
                    try
                    {
                            string filename = Path.GetFileName(FileUpload1.FileName);
                            FileUpload1.SaveAs(Server.MapPath("~/photos/") + "c"+Session["c_id"].ToString()+ filext);
                        cfpath = "~/photos/"+ "c"+Session["c_id"].ToString()+ filext;
                        Label22.Text = "Upload status: File uploaded!";
                        
                        
                        
                    }
                    catch (Exception ex)
                    {
                    Label22.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
                    }
                }
                else
                    Label22.Text = "Upload status: Only Image files are accepted!";
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {

            if (FileUpload2.HasFile)
            {
                string filext = System.IO.Path.GetExtension(FileUpload2.FileName);
                if (filext == ".jpeg" || filext == ".png" || filext == ".jpg")
                {
                    try
                    {
                        string filename = Path.GetFileName(FileUpload2.FileName);
                        FileUpload2.SaveAs(Server.MapPath("~/photos/") +"m"+ Session["c_id"].ToString()+filext);
                        mfpath = "~/photos/" +"m"+ Session["c_id"].ToString()+ filext;
                        Label23.Text = "Upload status: File uploaded!";



                    }
                    catch (Exception ex)
                    {
                        Label23.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
                    }
                }
                else
                    Label23.Text = "Upload status: Only Image files are accepted!";
            }

        }







        protected void Wizard1_NextButtonClick(object sender, WizardNavigationEventArgs e)
        {
            if (e.NextStepIndex == 2)
            {
                lblName.Text = TextBox1.Text + " " + TextBox2.Text + " " + TextBox3.Text;
                lblCity.Text = DropDownList3.SelectedValue;
                lblMobile.Text = TextBox7.Text;
                lblEmail.Text = TextBox6.Text;
                lblAdd.Text = TextBox4.Text;
                lblId.Text = TextBox8.Text;
                GridView2.DataBind();
                System.Text.RegularExpressions.Regex mobile = new System.Text.RegularExpressions.Regex("^[789]\\d{9}$");
                System.Text.RegularExpressions.Regex email = new System.Text.RegularExpressions.Regex("^\\w+([\\.-]?\\w+)*@\\w+([\\.-]?\\w+)*(\\.\\w{2,3})+$");
                if (string.IsNullOrWhiteSpace(this.TextBox1.Text) || string.IsNullOrWhiteSpace(this.TextBox2.Text) || string.IsNullOrWhiteSpace(this.TextBox3.Text) || !email.IsMatch(TextBox6.Text)|| !mobile.IsMatch(TextBox7.Text) || DropDownList3.SelectedValue=="--SELECT--") 
                {
                    erlbl.Visible = true;
                    erlbl.Text = "Step1-Invalid Credential";
                }else
                {
                    Button b = (Button)Wizard1.FindControl("FinishNavigationTemplateContainerID").FindControl("FinishButton");
                    b.Enabled = true;
                }
               

            }
            if (e.NextStepIndex == 1)
            {

                TextBox9.Text = TextBox1.Text + " " + TextBox2.Text + " " + TextBox3.Text;
                
            }
        }



        protected void linkInsert_Click(object sender, EventArgs e)
        {

    
                SqlDataSource3.InsertParameters["item_name"].DefaultValue = txtItem.Text;

                SqlDataSource3.InsertParameters["rate"].DefaultValue = txtRate.Text;
         
                SqlDataSource3.InsertParameters["item_type"].DefaultValue = dropItem.SelectedValue.ToString();
                SqlDataSource3.InsertParameters["gross_weight"].DefaultValue = txtGross.Text;

                SqlDataSource3.InsertParameters["amount"].DefaultValue = txtAmount.Text;
                SqlDataSource3.Insert();
            //    Response.Write("inserter");

            
                txtAmount.Text = "";
                txtGross.Text = "";
                txtItem.Text = "";
                txtRate.Text = "";
           


        }

        protected void GridView3_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                //header portion
            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                double dtw = Double.Parse((e.Row.DataItem as DataRowView).Row["gross_weight"].ToString());
                double dta = Double.Parse((e.Row.DataItem as DataRowView).Row["amount"].ToString());
                //retrive gridview Coloumn

                tota = dta + tota;
                totw = dtw + totw;
                
            }
            else if (e.Row.RowType == DataControlRowType.Footer)
            {
                //lbl total mortgage amount and total weight
                Label albl = (Label)e.Row.FindControl("lbltota");
                Label wlbl = (Label)e.Row.FindControl("lbltotw");

                string famt = string.Format(new System.Globalization.CultureInfo("en-IN"), "{0:c}", tota);
                
                wlbl.Text =(totw/1000) + "/-kg";
                albl.Text = famt;

                Label12.Text = (totw/1000) + "/-kg";
                Label13.Text = famt;
                
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (Wizard1.ActiveStepIndex == 0)
                TextBox1.Focus();//set focus
            else if (Wizard1.ActiveStepIndex == 1)
            {
                /*  Button btn = (Button)Wizard1.FindControl("StepNavigationTemplateContainerID").FindControl("StepNextButton");
                    btn.OnClientClick = "return confirm('Are You Sure Want to go to Next Step?')";
                    btn.CausesValidation = true;
                    btn.ValidationGroup = "nbtn";*/
                Calendar12.Focus();
            }
                
        }

       
    }
}