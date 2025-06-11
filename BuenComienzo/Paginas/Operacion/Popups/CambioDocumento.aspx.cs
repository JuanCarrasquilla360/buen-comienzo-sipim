using BuenComienzo.Core;
using BuenComienzo.Core.Operacion;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BuenComienzo.Paginas.Operacion.Popups
{
    public partial class CambioDocumento : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["IdDocumento"] != null)
                {
                    txtIdDocumento.Value = Request.QueryString["IdDocumento"].ToString();
                }                
                if (Request.QueryString["Nombre"] != null)
                {
                    txtPrimerNombre.Value = Request.QueryString["Nombre"].ToString();
                }
               
            }

        }
                
    }
}