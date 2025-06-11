using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BuenComienzo.Core;
using BuenComienzo.Core.Operacion.To;
using BuenComienzo.Core.Maestros;
using BuenComienzo.Core.Administracion;
using BuenComienzo.Core.Administracion.To;
using System.Text.RegularExpressions;

namespace BuenComienzo.Paginas.Administracion.Popups
{
    public partial class EditarLugar : System.Web.UI.Page
    {
        BuenComienzo.Core.Administracion.Lugares objLugares = new Core.Administracion.Lugares();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarListas();
                if (Request.QueryString["idLugar"] != null)
                {
                    string idLugar = Request.QueryString["idLugar"];
                    DataTable dtLugar = objLugares.ObtenerLugar(idLugar);

                    if (dtLugar != null && dtLugar.Rows.Count == 1)
                    {
                        LugaresTO lugar = Utilidades.ToList<LugaresTO>(dtLugar)[0];
                                               
                        txtDane.Value = lugar.IdDane;
                        txtNit.Value = lugar.IdNit;
                        ddlTipoLugar.Value = lugar.TipoLugar;
                        ddlTipoModalidad.Value = lugar.TipoModalidad;
                        txtNombreLugar.Value = lugar.NombreLugar;
                        ddlEntorno.Value = lugar.IdEntorno;
                        ddlComuna.Value = lugar.IdComuna;
                        ddlBarrio.Value = lugar.IdBarrio;

                        List<string> direccion = dtLugar.Rows[0]["Direccion"].ToString().Split(' ').ToList<string>();

                        int numeral = direccion.FindIndex(d => d.Contains("#"));

                        if (numeral == 2)
                            direccion.Insert(2, " ");

                        for (int i = 0; i <= 5; i++)
                        {
                            if (i > direccion.Count - 1)
                                break;

                            switch (i)
                            {
                                case 0:
                                    Utilidades.SeleccionarItem(direccion[0].ToUpper(), ddlTipoVia);
                                    break;
                                case 1:
                                    string via1 = Regex.Replace(direccion[1], @"[\d+]", "");
                                    string apendice1 = Regex.Replace(direccion[1], @"[\d+]", "");

                                    if (via1.Length <= 2)
                                        via1 = Regex.Replace(direccion[1], @"[^\d]", "");
                                    else
                                    {
                                        apendice1 = "";
                                        ddlApendice1.Disabled = ddlCardinalidad.Disabled = true;
                                    }

                                    txtVia1.Value = via1;
                                    Utilidades.SeleccionarItem(apendice1.ToUpper(), ddlApendice1);
                                    break;
                                case 2:
                                    if (!ddlCardinalidad.Disabled)
                                        Utilidades.SeleccionarItem(direccion[2].ToUpper() + " ", ddlCardinalidad);
                                    break;
                                case 3:
                                    string via2 = Regex.Replace(direccion[3], @"[^\d]", "");
                                    string apendice2 = Regex.Replace(direccion[3].Replace("#", ""), @"[\d+]", "");

                                    txtVia2.Value = via2;
                                    Utilidades.SeleccionarItem(apendice2.ToUpper(), ddlApendice2);
                                    break;
                                case 5:
                                    string placa = Regex.Replace(direccion[5], @"[^\d]", "");
                                    txtPlaca.Value = placa;
                                    break;
                            }
                        }

                        txtTelefono1.Value = lugar.Telefono1;
                        txtTelefono2.Value = lugar.Telefono2;
                        txtNombreResponsable.Value = lugar.NombreResponsable;

                    }
                }

            }

        }

        private void cargarListas()
        {
            
            //Se carga la lista de Comunas
            Comunas objComunas = new Comunas();
            DataTable dtComunas = objComunas.ConsultarComunas();
            Utilidades.CargarLista(ddlComuna, dtComunas, "IdComuna", "NombreComuna", true);

            //Se carga la lista de Barrios
            Barrios objBarrios = new Barrios();
            DataTable dtBarrios = objBarrios.ConsultarBarrios();
            Utilidades.CargarLista(ddlBarrio, dtBarrios, "IdBarrio", "NombreBarrio", true);

            //Se carga Entornos
            Entorno objEntorno = new Entorno();
            DataTable dtEntorno = objEntorno.ConsultarEntorno();
            Utilidades.CargarLista(ddlEntorno, dtEntorno, "IdEntorno", "NombreEntorno", true);

        }
    }
}