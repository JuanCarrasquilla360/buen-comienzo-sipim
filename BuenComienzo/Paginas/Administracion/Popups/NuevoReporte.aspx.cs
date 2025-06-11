using BuenComienzo.Core.Administracion;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BuenComienzo.Paginas.Administracion.Popups
{
    public partial class NuevoReporte : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                ReporteDinamico objAdminReportes = new ReporteDinamico();
                CargarListas();

                //Se identifica si es un registro nuevo o se está editando
                if (Request.QueryString.Count > 0)
                {
                    idReporte.Value = Request.QueryString["idReporte"];

                    DataSet dsReporte = objAdminReportes.ObtenerReporteCompleto(idReporte.Value);
                    DataTable dtReporte = dsReporte.Tables[0];
                    DataTable dtCamposReporte = dsReporte.Tables[1];

                    if (dtReporte.Rows.Count > 0)
                    {
                        txtNombre.Value = dtReporte.Rows[0]["Nombre"].ToString();
                        txtDescripcion.Value = dtReporte.Rows[0]["Descripcion"].ToString();
                        txtQuery.Value = dtReporte.Rows[0]["Query"].ToString();

                        if (dtCamposReporte.Rows.Count > 0)
                        {
                            Core.Utilidades.CargarLista(ddlCampos, dtCamposReporte, "IdTipoCampo", "Campo", false);
                        }
                    }
                }
            }

        }

        private void CargarListas()
        {
            //Se carga la lista de Tipo de Campos Reporte
            TipoCamposReporte objTipoCamposReporte = new TipoCamposReporte();
            DataTable dtTipoCamposReporte = objTipoCamposReporte.ConsultarTipoCamposReporte();
            Core.Utilidades.CargarLista(ddlCampo, dtTipoCamposReporte, "IdTipoCampo", "Nombre", true);
        }

    }
}