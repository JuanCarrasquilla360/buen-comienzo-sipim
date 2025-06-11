using BuenComienzo.Core;
using BuenComienzo.Core.Administracion;
using BuenComienzo.Core.Administracion.To;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BuenComienzo.Paginas.Administracion
{
    public partial class ReportesDinamicos : System.Web.UI.Page
    {
        BuenComienzo.Core.Administracion.Usuarios objUsuarios = new BuenComienzo.Core.Administracion.Usuarios();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarListas();
            }

        }

        private void CargarListas()
        {
            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];

            //Se carga la lista de Modalidades
            ReporteDinamico objAdminReportes = new ReporteDinamico();
            DataTable dtReportes = objAdminReportes.ConsultarReportesPerfiles(Convert.ToInt32(objUsuario.IdPerfil));

            if (dtReportes != null)
            {
                if (dtReportes.Rows.Count > 0)
                {
                    Utilidades.CargarLista(ddlReporte, dtReportes, "idReporte", "Nombre", true);
                }
            }

            ddlMeses.Items.Add(new ListItem() { Value = "", Text = "--Seleccione--" });
            ddlMeses.Items.Add(new ListItem() { Value = "1", Text = "Enero" });
            ddlMeses.Items.Add(new ListItem() { Value = "2", Text = "Febrero" });
            ddlMeses.Items.Add(new ListItem() { Value = "3", Text = "Marzo" });
            ddlMeses.Items.Add(new ListItem() { Value = "4", Text = "Abril" });
            ddlMeses.Items.Add(new ListItem() { Value = "5", Text = "Mayo" });
            ddlMeses.Items.Add(new ListItem() { Value = "6", Text = "Junio" });
            ddlMeses.Items.Add(new ListItem() { Value = "7", Text = "Julio" });
            ddlMeses.Items.Add(new ListItem() { Value = "8", Text = "Agosto" });
            ddlMeses.Items.Add(new ListItem() { Value = "9", Text = "Septiembre" });
            ddlMeses.Items.Add(new ListItem() { Value = "10", Text = "Octubre" });
            ddlMeses.Items.Add(new ListItem() { Value = "11", Text = "Noviembre" });
            ddlMeses.Items.Add(new ListItem() { Value = "12", Text = "Diciembre" });


            //Operadores objOperadores = new Operadores();
            //DataTable dtOperadores = objOperadores.ConsultarOperadores();
            //Utilidades.CargarLista(ddlOperador, dtOperadores, "IdNitOperador", "NombreOperador", true);

            DataTable dtCoordinadores = objUsuarios.ConsultarCoordinadoresU();
            Utilidades.CargarLista(ddlUnidadServicio, dtCoordinadores, "IdCoordinador", "Nombre", true);


        }

    }
}