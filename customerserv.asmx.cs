using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
namespace authwebpart
{
    /// <summary>
    /// Summary description for WebService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {

        [WebMethod]
        public List<string> GetCustomerNames(string scust)
        {
            string cs = ConfigurationManager.ConnectionStrings["v0scon"].ConnectionString;
            List < string > cnames= new List<string>();
            using (SqlConnection scon = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("searchp",scon);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter parameter = new SqlParameter("@scust",scust);
                cmd.Parameters.Add(parameter);
                scon.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while(rdr.Read())
                {
                    cnames.Add(rdr["c_name"].ToString());
                   // cnames.Add(rdr["city"].ToString());

                }
                return cnames;
            }
        }
    }
}
