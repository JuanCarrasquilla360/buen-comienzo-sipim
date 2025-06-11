using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BuenComienzo.Core;
using BuenComienzo.Core.Administracion.To;

namespace BuenComienzo.Paginas.Administracion
{
    public partial class Seguridad : System.Web.UI.Page
    {
        BuenComienzo.Core.Administracion.Seguridad objSeguridad = new BuenComienzo.Core.Administracion.Seguridad();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                CargarGrid();
            }
            catch (Exception ex)
            {
                string idUsuario = ((UsuarioTO)Session[VariablesSession.DatosUsuario]).IdDocumento;
                Logging.log(idUsuario, ex.Message);
                Utilidades.MostrarMensaje("Ha ocurrido un error en el sistema. Por favor contacte al administrador del sistema", TipoMensaje.Error, false);
            }
        }

        private void CargarGrid()
        {
            DataTable dtPerfiles = objSeguridad.ConsultarTablaSeguridad();
            grdSeguridad.DataSource = dtPerfiles;
            grdSeguridad.DataBind();
            grdSeguridad.PreRender += grdSeguridad_PreRender;
        }

        protected void grdSeguridad_PreRender(object sender, EventArgs e)
        {
            grdSeguridad.UseAccessibleHeader = true;
            grdSeguridad.HeaderRow.TableSection = TableRowSection.TableHeader;
            foreach (TableCell celda in grdSeguridad.HeaderRow.Cells)
            {
                celda.Style.Add("vertical-align", "middle");
                celda.Style.Add("text-align", "center");
            }
        }

        protected void grdSeguridad_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LiteralControl checkBox;
                for (int i = 2; i < e.Row.Cells.Count; i++)
                {
                    string activado = (e.Row.Cells[i].Text == "1") ? "checked='checked'" : "";
                    string id = grdSeguridad.DataKeys[e.Row.RowIndex]["IdPermiso"].ToString() + "_" + grdSeguridad.HeaderRow.Cells[i].Text;
                    checkBox = new LiteralControl("<label><input id='" + id + "' type='checkbox' class='flat-red' style='opacity: 0;'" + activado + " change=\"editarPermiso('" + id + "')\" ></label>");
                    e.Row.Cells[i].Controls.Clear();
                    e.Row.Cells[i].HorizontalAlign = HorizontalAlign.Center;
                    e.Row.Cells[i].Controls.Add(checkBox);
                }
            }

            //Se oculta la columna que contiene el código
            e.Row.Cells[0].Visible = false;
            e.Row.Cells[1].Font.Bold = true;
        }
    }
}