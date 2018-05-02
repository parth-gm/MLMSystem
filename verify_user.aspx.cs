using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace authwebpart
{
    public partial class verify_user : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
          
            if(Session["suser"]!=null)
            {
                int LiveSessionsCount = (int)Application["LiveSessionsCount"];
                activecount.Text = LiveSessionsCount.ToString(); ;

            }
            else
            {
                Response.Redirect("login.aspx");
            }
           
        }
    }
}