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
    public partial class SubirArchivoPersona : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["IdDocumento"] != null)
                {
                    txtIdDocumento.Value = Request.QueryString["IdDocumento"].ToString();
                }
                //if (Request.QueryString["tipoBeneficiario"] != null)
                //{
                //    txtTipoBeneficiario.Value = Request.QueryString["tipoBeneficiario"].ToString();
                //}
                //if (Request.QueryString["tipoDocumento"] != null)
                //{
                //    txtTipoDocumento.Value = Request.QueryString["tipoDocumento"].ToString();
                //}
                if (Request.QueryString["Nombre"] != null)
                {
                    txtPrimerNombre.Value = Request.QueryString["Nombre"].ToString();
                }
                cargarListas();
            }

        }
        private void cargarListas()
        {
            TipoArchivoPersona tab = new TipoArchivoPersona();
            DataTable dtTipoArchivoPersona = tab.ConsultarTipoArchivoPersona();
            Utilidades.CargarLista(ddlTipoArchivoPersona, dtTipoArchivoPersona, "IdTipoArchivoPersona", "Descripcion", true);
        }
    }
}