using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace authwebpart
{
    public partial class approved : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["suser"] != null)
            {
                int LiveSessionsCount = (int)Application["LiveSessionsCount"];
                // Response.Write("No Of User Active:" + LiveSessionsCount);

            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }
    }
}