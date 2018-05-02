using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.SessionState;

namespace authwebpart
{
    public class Global : System.Web.HttpApplication
    {
        //public static string cons = WebConfigurationManager.ConnectionStrings["authuserConnectionString"].ConnectionString;
        //SqlConnection myConnection = new SqlConnection(cons);
        protected void Application_Start(object sender, EventArgs e)
        {
            Application["LiveSessionsCount"] = 0;
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Application.Lock();
            Application["LiveSessionsCount"] = ((int)Application["LiveSessionsCount"]) + 1;
            Application.UnLock();
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
            Application.Lock();

            Application["LiveSessionsCount"] = ((int)Application["LiveSessionsCount"]) - 1;
    
         /*   using (myConnection)
            {
                myConnection.Open();
                string que = "SELECT * FROM dumcust_mor  where c_id=0";
                SqlCommand ccmd = new SqlCommand(que, myConnection);
                SqlDataReader reader = ccmd.ExecuteReader();
                if (reader.HasRows)
                {
                    reader.Close();

                    string dropquery = "TRUNCATE TABLE dumcust_mor ";
                    SqlCommand drcmd = new SqlCommand(dropquery, myConnection);
                    drcmd.ExecuteNonQuery();

                }
                reader.Close();
            }*/
                Application.UnLock();

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}