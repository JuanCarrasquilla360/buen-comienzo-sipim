using BuenComienzo.Core;
using BuenComienzo.Core.Administracion;
using BuenComienzo.Core.Administracion.To;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using System.Text;
using BuenComienzo.Core.Operacion;
using BuenComienzo.Core.Operacion.To;
using BuenComienzo.Core.BusquedaActiva;
using BuenComienzo.Core.Remision;
using System.Linq;
using System.Reflection;
using BuenComienzo.Core.Maestros;
using BuenComienzo.Core.Maestros.To;
using Microsoft.AspNet.SignalR;
using BuenComienzo.SignalR;
using Newtonsoft.Json;
using System.Web.UI.WebControls;
using System.Security.Cryptography.Xml;
using System.IO;
using System.Configuration;
using System.Web.Hosting;
using System.Data.SqlTypes;

namespace BuenComienzo.Paginas
{
    public partial class WebMethods : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        { }

        #region Varios

        [WebMethod(EnableSession = true)]
        public static void FinalizarSesion()
        {
            if (HttpContext.Current.Session[VariablesSession.DatosUsuario] != null)
            {
                HttpContext.Current.Session.Clear();
                HttpContext.Current.Session.Abandon();
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ObtenerContadoresBaseDatos()
        {
            Varios objVarios = new Varios();
            ContadoresTO contadores = new ContadoresTO();
            string idUsuario = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;
            byte? idPerfil = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdPerfil;
            DataTable dtDatos = objVarios.ObtenerContadoresBaseDatos(idUsuario, idPerfil);
            contadores = Utilidades.ToList<ContadoresTO>(dtDatos)[0];

            string myJsonString = (new JavaScriptSerializer()).Serialize(contadores);
            return myJsonString;
        }

        #endregion

        #region Usuarios

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarUsuarios()
        {
            Usuarios objUsuarios = new Usuarios();
            string[] campos = new string[] { "IdDocumento", "Nombre", "Celular", "Perfil", "Estado", "CambioPassword" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];

            DataTable dtDatos = objUsuarios.ConsultarUsuarios(orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    if (campos[i] == "Estado" || campos[i] == "CambioPassword")
                    {
                        string si = "";
                        if (campos[i] == "Estado")
                            si = (fila[campos[i]].ToString() == "ACTIVO") ? "checked='checked'" : "";
                        else
                            si = (fila[campos[i]].ToString() != "" && fila[campos[i]].ToString() == "1") ? "checked='checked'" : "";

                        string checkbox = "<label><input name='" + campos[i] + "' type='checkbox' class='flat-red' style='opacity: 0;'" + si + " ></label>";
                        sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), checkbox);
                    }
                    else
                        sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                string btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""Editar('" + fila[3].ToString() + @"'); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }

        [WebMethod(EnableSession = true)]
        public static string ActualizarUsuario(string nuevo, string idDocumento, string tipoDocumento, string idPerfil,
                                                string password, string cambioPassword, string primerNombre,
                                                string segundoNombre, string primerApellido, string segundoApellido, string fechaNacimiento,
                                                string telefono, string celular, string correoElectronico, string correoElectronicoLaboral,
                                                string idCoordinador, string estado)
        {
            Usuarios objUsuarios = new Usuarios();
            RespuestaTO objRespuesta;
            string myJsonString;
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;

            DateTime? pFechaNacimiento/*, pFechaInicioContrato*/;
            bool? pCambioPassword = false;
            //DateTime? pFechaNacimiento, pFechaIngresoModalidadesPrimeraInfanciaIcbf, pFechaInactivacion, pFechaVinculacionUnidadServicio, pFechaDesvinculacionUnidadServicio;
            string pEstado;
            pEstado = (estado == "true") ? "ACTIVO" : "INACTIVO";
            pCambioPassword = (cambioPassword == "true") ? true : false;
            pFechaNacimiento = (fechaNacimiento != "") ? DateTime.ParseExact(fechaNacimiento, "dd/MM/yyyy", null) : (DateTime?)null;
            //pFechaInicioContrato = (fechaInicioContrato != "") ? DateTime.ParseExact(fechaInicioContrato, "dd/MM/yyyy", null) : (DateTime?)null;

            //pFechaNacimiento = (fechaNacimiento != "") ? DateTime.ParseExact(fechaNacimiento, "dd/MM/yyyy", null) : (DateTime?)null;
            //pFechaIngresoModalidadesPrimeraInfanciaIcbf = (fechaIngresoModalidadesPrimeraInfanciaIcbf != "") ? DateTime.ParseExact(fechaIngresoModalidadesPrimeraInfanciaIcbf, "dd/MM/yyyy", null) : (DateTime?)null;
            //pFechaInactivacion = (fechaInactivacion != "") ? DateTime.ParseExact(fechaInactivacion, "dd/MM/yyyy", null) : (DateTime?)null;
            //pFechaVinculacionUnidadServicio = (fechaVinculacionUnidadServicio != "") ? DateTime.ParseExact(fechaVinculacionUnidadServicio, "dd/MM/yyyy", null) : (DateTime?)null;
            //pFechaDesvinculacionUnidadServicio = (fechaDesvinculacionUnidadServicio != "") ? DateTime.ParseExact(fechaDesvinculacionUnidadServicio, "dd/MM/yyyy", null) : (DateTime?)null;


            try
            {
                if (nuevo == "S")
                {
                    if (objUsuarios.InsertarUsuario(idDocumento, tipoDocumento, byte.Parse(idPerfil), password, pCambioPassword, primerNombre,
                                                    segundoNombre, primerApellido, segundoApellido, pFechaNacimiento, telefono, celular, correoElectronico,
                                                    correoElectronicoLaboral, idCoordinador, idUsuarioCreacion, idUsuarioCreacion, pEstado))

                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertó el usuario satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objUsuarios.Error, tipoMensaje = "Error" };
                }
                else
                {
                    if (objUsuarios.ActualizarUsuario(idDocumento, tipoDocumento, byte.Parse(idPerfil), password, pCambioPassword, primerNombre,
                                                    segundoNombre, primerApellido, segundoApellido, pFechaNacimiento, telefono, celular, correoElectronico,
                                                    correoElectronicoLaboral, idCoordinador, idUsuarioCreacion, pEstado))

                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se actualizó el usuario satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objUsuarios.Error, tipoMensaje = "Error" };
                }

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;


            }
        }

        [WebMethod(EnableSession = true)]
        public static string ConsultarCoordinadores()
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            string myJsonString = "";

            try
            {
                Usuarios objUsuarios = new Usuarios();

                DataTable dtDatos = objUsuarios.ConsultarCoordinadores();

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaCoordinadores = (from DataRow dr in dtDatos.Rows
                                              select new
                                              {
                                                  idDocumento = dr["IdCoordinador"].ToString(),
                                                  nombre = dr["Nombre"].ToString(),
                                              }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaCoordinadores);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string ConsultarCoordinadoresTransversales()
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            string myJsonString = "";

            try
            {
                Usuarios objUsuarios = new Usuarios();

                DataTable dtDatos = objUsuarios.ConsultarCoordinadoresTransversales();

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaCoordinadores = (from DataRow dr in dtDatos.Rows
                                            select new
                                            {
                                                IdCoordinador = dr["IdCoordinador"].ToString(),
                                                nombre = dr["Nombre"].ToString(),
                                            }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaCoordinadores);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string EsAdmin()
        {
            RespuestaTO objRespuesta = new RespuestaTO();

            if (((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdPerfil.Value == 1)
                objRespuesta.resultado = true;
            else
                objRespuesta.resultado = false;

            string resultado = JsonConvert.SerializeObject(objRespuesta);
            return resultado;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string NoEsAdmin()
        {
            RespuestaTO objRespuesta = new RespuestaTO();

            if (((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdPerfil.Value != 0)
                objRespuesta.resultado = true;
            else
                objRespuesta.resultado = false;

            string resultado = JsonConvert.SerializeObject(objRespuesta);
            return resultado;
        }


        #endregion

        #region Caracterizacion

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarCaracterizacion()
        {
            Caracterizacion objCaracterizacion = new Caracterizacion();
            string[] campos = new string[] { "NumeroIdentificacion", "TipoIdentificacion", "Nombre", "FechaNacimiento", "Celular", "CicloVital", "Cuentame", "IdMatricula", "Coordinador", "Sede", "Uba" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];

            DataTable dtDatos = objCaracterizacion.ConsultarCaracterizacion(orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                //sb.Append(",");

                string btnBotones = "";

                if (((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdPerfil.Value == 1)
                {
                    sb.Append(",");
                    btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""Editar('" + fila[3].ToString() + @"', 'N'); return false;\"" ></span>&nbsp;<span class='ion-document-text icono-grid' title='Matricula' onclick=\""Matricula('" + fila[3].ToString() + "','" + fila[5].ToString() + "','" + fila[14].ToString() + @"'); return false;\"" ></span> &nbsp;<span class='glyphicon glyphicon-paperclip icono-grid2' title='Subir Archivo' onclick=\""SubirArchivo('" + fila[3].ToString() + "', '" + fila[5].ToString() + @"'); return false;\"" ></span> &nbsp;<span class='glyphicon glyphicon-user icono-grid2' title='Cambio de documento' onclick=\""CambioDocumento('" + fila[3].ToString() + "', '" + fila[5].ToString() + @"'); return false;\"" ></span> </div>";
                }
                else if (((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdPerfil.Value == 2)
                {
                    sb.Append(",");
                    btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""Editar('" + fila[3].ToString() + @"', 'N'); return false;\"" ></span>&nbsp;<span class='ion-document-text icono-grid' title='Matricula' onclick=\""Matricula('" + fila[3].ToString() + "','" + fila[5].ToString() + "','" + fila[14].ToString() + @"'); return false;\"" ></span> &nbsp;<span class='glyphicon glyphicon-paperclip icono-grid2' title='Subir Archivo' onclick=\""SubirArchivo('" + fila[3].ToString() + "', '" + fila[5].ToString() + @"'); return false;\"" ></span></div>";
                }
                else
                {
                    sb.Append(",");
                    btnBotones = @"<div style='text-align: center;'><span class='glyphicon glyphicon-paperclip icono-grid2' title='Subir Archivo' onclick=\""SubirArchivo('" + fila[3].ToString() + "', '" + fila[5].ToString() + @"'); return false;\"" ></span></div>";
                }
               // string btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""Editar('" + fila[3].ToString() + @"', 'N'); return false;\"" ></span>&nbsp;&nbsp;<span class='ion-document-text icono-grid' title='Matricula' onclick=\""Matricula('" + fila[3].ToString() + "','" + fila[5].ToString() + "','" + fila[14].ToString() + @"'); return false;\"" ></span> &nbsp;&nbsp;<span class='glyphicon glyphicon-paperclip icono-grid2' title='Subir Archivo' onclick=\""SubirArchivo('" + fila[3].ToString() + "', '" + fila[5].ToString() + @"'); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }

        [WebMethod]
        public static string ObtenerCaracterizacion(string numeroIdentificacion)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                Caracterizacion objCaracterizacion = new Caracterizacion();

                DataTable dtDatos = objCaracterizacion.ObtenerCaracterizacion(numeroIdentificacion);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaCaracterizacion = (from DataRow dr in dtDatos.Rows
                                                select new
                                                {
                                                    fechaRegistroCaracterizacion = DateTime.Parse(dr["FechaRegistroCaracterizacion"].ToString()).ToString("dd/MM/yyyy"),
                                                    idCuentame = dr["IdCuentame"].ToString(),
                                                    idTipoIdentificacion = dr["IdTipoIdentificacion"].ToString(),
                                                    numeroIdentificacion = dr["NumeroIdentificacion"].ToString(),
                                                    nombreFamiResponsable = dr["NombreFamiResponsable"].ToString(),
                                                    primerNombre = dr["PrimerNombre"].ToString(),
                                                    segundoNombre = dr["SegundoNombre"].ToString(),
                                                    primerApellido = dr["PrimerApellido"].ToString(),
                                                    segundoApellido = dr["SegundoApellido"].ToString(),
                                                    fechaNacimiento = DateTime.Parse(dr["FechaNacimiento"].ToString()).ToString("dd/MM/yyyy"),
                                                    idSexo = dr["IdSexo"].ToString(),
                                                    idNacionalidad = dr["IdNacionalidad"].ToString(),
                                                    telefono = dr["Telefono"].ToString(),
                                                    celular = dr["Celular"].ToString(),
                                                    direccion = dr["Direccion"].ToString(),
                                                    idComuna = dr["IdComuna"].ToString(),
                                                    idBarrio = dr["IdBarrio"].ToString(),
                                                    observacionesDireccion = dr["ObservacionesDireccion"].ToString(),
                                                    idCicloVital = dr["IdCicloVital"].ToString(),
                                                    semanasGestacion = dr["SemanasGestacion"].ToString(),
                                                    asisteCPNoCXNoVI = dr["AsisteCPNoCXNoVI"].ToString(),
                                                    idEsquemaVacunacion = dr["IdEsquemaVacunacion"].ToString(),
                                                    idMadreAdolescente = dr["IdMadreAdolescente"].ToString(),
                                                    //numeroVacunas = dr["NumeroVacunas"].ToString(),
                                                    idTipoAfiliacion = dr["IdTipoAfiliacion"].ToString(),
                                                    idEAPB = dr["IdEAPB"].ToString(),
                                                    idParentescoRedApoyo = dr["IdParentescoRedApoyo"].ToString(),
                                                    nombreCompletoRedApoyo = dr["NombreCompletoRedApoyo"].ToString(),
                                                    celularRedApoyo = dr["CelularRedApoyo"].ToString(),
                                                    idMatricula = dr["IdMatricula"].ToString()
                                                }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaCaracterizacion);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string ActualizarCaracterizacion(string nuevo, string fechaRegistroCaracterizacion, string idCuentame, string idTipoIdentificacion, string numeroIdentificacion,
                                                string nombreFamiResponsable, string primerNombre, string segundoNombre, string primerApellido, string segundoApellido,
                                                string fechaNacimiento, string idSexo, string idNacionalidad, string telefono, string celular,
                                                string direccion, string idComuna, string idBarrio, string observacionesDireccion, string idCicloVital,
                                                string semanasGestacion, string asisteCPNoCXNoVI, string idEsquemaVacunacion, string idMadreAdolescente,
                                                string idTipoAfiliacion, string idEAPB, string idParentescoRedApoyo, string nombreCompletoRedApoyo,
                                                string celularRedApoyo)
        {
            Caracterizacion objCaracterizacion = new Caracterizacion();
            RespuestaTO objRespuesta;
            string myJsonString;
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;
            DateTime pFechaRegistroCaracterizacion = DateTime.ParseExact(fechaRegistroCaracterizacion, "dd/MM/yyyy", null);
            DateTime pFechaNacimiento = DateTime.ParseExact(fechaNacimiento, "dd/MM/yyyy", null);

            try
            {
                if (nuevo == "S")
                {
                    if (objCaracterizacion.InsertarCaracterizacion(pFechaRegistroCaracterizacion, idCuentame, idTipoIdentificacion, numeroIdentificacion,
                                                nombreFamiResponsable, primerNombre, segundoNombre, primerApellido, segundoApellido,
                                                pFechaNacimiento, idSexo, idNacionalidad, telefono, celular,
                                                direccion, idComuna, idBarrio, observacionesDireccion, idCicloVital,
                                                semanasGestacion, asisteCPNoCXNoVI, idEsquemaVacunacion, idMadreAdolescente,
                                                idTipoAfiliacion, idEAPB, idParentescoRedApoyo, nombreCompletoRedApoyo,
                                                celularRedApoyo, idUsuarioCreacion))
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertó la caracterización satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objCaracterizacion.Error, tipoMensaje = "Error" };
                }
                else
                {
                    if (objCaracterizacion.ActualizarCaracterizacion(pFechaRegistroCaracterizacion, idCuentame, idTipoIdentificacion, numeroIdentificacion,
                                                    nombreFamiResponsable, primerNombre, segundoNombre, primerApellido, segundoApellido,
                                                    pFechaNacimiento, idSexo, idNacionalidad, telefono, celular,
                                                    direccion, idComuna, idBarrio, observacionesDireccion, idCicloVital,
                                                    semanasGestacion, asisteCPNoCXNoVI, idEsquemaVacunacion, idMadreAdolescente,
                                                    idTipoAfiliacion, idEAPB, idParentescoRedApoyo, nombreCompletoRedApoyo,
                                                    celularRedApoyo, idUsuarioCreacion))
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se actualizó la caracterización satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objCaracterizacion.Error, tipoMensaje = "Error" };
                }

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ObtenerMadresLactantes()
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            string myJsonString = "";

            try
            {
                Caracterizacion objCaracterizacion = new Caracterizacion();

                DataTable dtDatos = objCaracterizacion.ObtenerMadresLactantes();

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaCoordinadores = (from DataRow dr in dtDatos.Rows
                                              select new
                                              {
                                                  numeroIdentificacion = dr["NumeroIdentificacion"].ToString(),
                                                  nombre = dr["NumeroIdentificacion"].ToString() + " - " + dr["Nombre"].ToString(),
                                              }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaCoordinadores);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string InsertarMatricula(string numeroIdentificacion, string fecha, string idTipoAccion, string tipoAccion, string idMotivoRetiro, string idCoordinador,
            string idSede, string idUba, string idCicloVital, string numeroIdentificacionMadre)
        {
            Caracterizacion objCaracterizacion = new Caracterizacion();
            RespuestaTO objRespuesta;
            string myJsonString;
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;
            DateTime pFecha = DateTime.ParseExact(fecha, "dd/MM/yyyy", null);

            try
            {
                string id = objCaracterizacion.InsertarMatricula(numeroIdentificacion, pFecha, idTipoAccion, idMotivoRetiro, idCoordinador,
                    idSede, idUba, idCicloVital, numeroIdentificacionMadre, idUsuarioCreacion);
                if (!string.IsNullOrEmpty(id))
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se realizó " + tipoAccion + " satisfactoriamente", tipoMensaje = "Exito" };
                else
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objCaracterizacion.Error, tipoMensaje = "Error" };


                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ObtenerParticipantesCoordinador()
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            string myJsonString = "";

            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];
            string IdCoodinador = "";

            //Toma los coordinadores asociados al agente
            if (((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdPerfil.Value != 1)
            {
                CoordinadorAgentes objCoordinadorAgentes = new CoordinadorAgentes();
                DataTable dtCoordinadores = objCoordinadorAgentes.ObtenerCoordiandoresAgente(objUsuario.IdDocumento);

                foreach (DataRow fila in dtCoordinadores.Rows)
                    IdCoodinador += fila["IdCoordinador"] + ",";

                IdCoodinador = IdCoodinador.Substring(0, IdCoodinador.Length - 1);

            }

            try
            {
                Caracterizacion objCaracterizacion = new Caracterizacion();

                DataTable dtDatos = objCaracterizacion.ObtenerParticipantesCoordinador(IdCoodinador);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaCoordinadores = (from DataRow dr in dtDatos.Rows
                                              select new
                                              {
                                                  numeroIdentificacion = dr["NumeroIdentificacion"].ToString(),
                                                  nombre = dr["NumeroIdentificacion"].ToString() + " - " + dr["Nombre"].ToString(),
                                                  idMatricula = dr["IdMatricula"].ToString(),
                                                  idCoordinador = dr["IdCoordinador"].ToString(),
                                                  EEHNumero = dr["EEHNumero"].ToString(),
                                              }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaCoordinadores);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string ConsultarParticipantesEncuentro(string idEncuentroEducativo, string idProgramacionActividades, string extemporaneo)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];
            string myJsonString = "";

            try
            {
                Caracterizacion objCaracterizacion = new Caracterizacion();

                DataTable dtDatos = objCaracterizacion.ConsultarParticipantesEncuentro(idEncuentroEducativo, idProgramacionActividades, extemporaneo);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaParticipantes = (from DataRow dr in dtDatos.Rows
                                              select new
                                              {
                                                  numeroIdentificacion = dr["NumeroIdentificacion"].ToString(),
                                                  nombre = dr["NumeroIdentificacion"].ToString() + " - " + dr["Nombre"].ToString() + " - " + dr["Uba"].ToString(),
                                              }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaParticipantes);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string ConsultarParticipantesEntregaPaquete(string idCoordinador, string idEntregaPaquete, string idUba, string extemporaneo)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];
            string myJsonString = "";

            try
            {
                Caracterizacion objCaracterizacion = new Caracterizacion();

                DataTable dtDatos = objCaracterizacion.ConsultarParticipantesEntregaPaquete(idCoordinador, idEntregaPaquete, idUba, extemporaneo);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaParticipantes = (from DataRow dr in dtDatos.Rows
                                              select new
                                              {
                                                  numeroIdentificacion = dr["NumeroIdentificacion"].ToString(),
                                                  nombre = dr["NumeroIdentificacion"].ToString() + " - " + dr["Nombre"].ToString() + " - " + dr["Uba"].ToString(),
                                              }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaParticipantes);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string ObtenerCicloVitalParticipante(string numeroDocumento)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            string myJsonString = "";

            try
            {
                Caracterizacion objCaracterizacion = new Caracterizacion();

                string data = objCaracterizacion.ObtenerCicloVitalParticipante(numeroDocumento);

                if (!string.IsNullOrEmpty(data))
                {
                    objRespuesta.resultado = true;
                    objRespuesta.mensaje = data;
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string ActualizarDocumentoIdentidad(string idDocumento, string idTipoIdentificacion, string numeroIdentificacion)
        {
            Caracterizacion objCaracterizacion = new Caracterizacion();
            RespuestaTO objRespuesta;
            string myJsonString;
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;            

            try
            {                
                if (objCaracterizacion.ActualizarDocumentoIdentidad(idDocumento, idTipoIdentificacion, numeroIdentificacion, idUsuarioCreacion))

                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se actualizó el tipo y número de identificación satisfactoriamente", tipoMensaje = "Exito" };
                else
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Error. " + objCaracterizacion.Error, tipoMensaje = "Error" };


                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }


        #endregion

        #region Caracterización Buen Comienzo

        [WebMethod]
        public static string ObtenerCaracterizacionBuenComienzo(string numeroIdentificacion)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                CaracterizacionBuenComienzo objCaracterizacionBuenComienzo = new CaracterizacionBuenComienzo();

                DataTable dtDatos = objCaracterizacionBuenComienzo.ObtenerCaracterizacionBuenComienzo(numeroIdentificacion);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaCaracterizacionBuenComienzo = (from DataRow dr in dtDatos.Rows
                                                            select new
                                                            {
                                                                TIPO_DOCUMENTO = dr["TIPO_DOCUMENTO"].ToString(),
                                                                IDENTIFICACION = dr["IDENTIFICACION"].ToString(),
                                                                PRIMER_NOMBRE = dr["PRIMER_NOMBRE"].ToString(),
                                                                SEGUNDO_NOMBRE = dr["SEGUNDO_NOMBRE"].ToString(),
                                                                PRIMER_APELLIDO = dr["PRIMER_APELLIDO"].ToString(),
                                                                SEGUNDO_APELLIDO = dr["SEGUNDO_APELLIDO"].ToString(),
                                                                FECHA_NACIMIENTO = DateTime.ParseExact(dr["FECHA_NACIMIENTO"].ToString(), "dd/MM/yyyy", null).ToString("dd/MM/yyyy"),
                                                                NACIONALIDAD = dr["NACIONALIDAD"].ToString(),
                                                                TELEFONO_FIJO = dr["TELEFONO_FIJO"].ToString(),
                                                                CELULAR = dr["CELULAR"].ToString(),
                                                                DIRECCION = dr["DIRECCION"].ToString(),
                                                                COMUNA = dr["COMUNA"].ToString(),
                                                                BARRIO = dr["BARRIO"].ToString(),
                                                                SEXO = dr["SEXO"].ToString(),
                                                                TIPO_PARTICIPANTE = dr["TIPO_PARTICIPANTE"].ToString(),
                                                                CICLO_VITAL = dr["CICLO_VITAL"].ToString(),
                                                                EDAD_GESTACIONAL = dr["EDAD_GESTACIONAL"].ToString(),
                                                                ASISTE_PROGRAMA_CXD = dr["ASISTE_PROGRAMA_CXD"].ToString(),
                                                                ESQUEMA_VACUNACION = dr["ESQUEMA_VACUNACION"].ToString(),
                                                                NUMERO_DE_VACUNAS = dr["NUMERO_DE_VACUNAS"].ToString(),
                                                                AFILIACION_SGSSS = dr["AFILIACION_SGSSS"].ToString(),
                                                                EPS = dr["EPS"].ToString(),
                                                                FAMILIARES_PARENTESCO = dr["FAMILIARES.PARENTESCO"].ToString(),
                                                                FAMILIARES_PRIMER_NOMBRE = dr["FAMILIARES.PRIMER_NOMBRE"].ToString(),
                                                                FAMILIARES_SEGUNDO_NOMBRE = dr["FAMILIARES.SEGUNDO_NOMBRE"].ToString(),
                                                                FAMILIARES_PRIMER_APELLIDO = dr["FAMILIARES.PRIMER_APELLIDO"].ToString(),
                                                                FAMILIARES_SEGUNDO_APELLIDO = dr["FAMILIARES.SEGUNDO_APELLIDO"].ToString(),
                                                                FAMILIARES_CELULAR = dr["FAMILIARES.CELULAR"].ToString()
                                                            }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaCaracterizacionBuenComienzo);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        #endregion

        #region Ubas

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarUbas()
        {
            Ubas objUbas = new Ubas();
            string[] campos = new string[] { "IdUba", "Uba", "IdTipoUba", "UbaSistema", "UsuarioCreacion", "FechaCreacion", "Activo" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];

            DataTable dtDatos = objUbas.ConsultarUbas(orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    if (campos[i] == "Activo")
                    {
                        string si = (fila[campos[i]].ToString() == "Si") ? "checked='checked'" : "";

                        string checkbox = "<label><input name='" + campos[i] + "' type='checkbox' class='flat-red' style='opacity: 0;'" + si + " ></label>";
                        sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), checkbox);
                    }
                    else
                        sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                string btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""Editar('" + fila[3].ToString() + @"', 'N'); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarUbasCoordinador()
        {
            Ubas objUbas = new Ubas();
            string[] campos = new string[] { "IdUba", "Uba", "IdTipoUba", "UbaSistema", "Activo" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];
            string idCoordinador = HttpContext.Current.Request.Params["idCoordinador"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];

            DataTable dtDatos = objUbas.ConsultarUbasCoordinador(idCoordinador, orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    //if (campos[i] == "Activo")
                    //{
                    //    string si = (fila[campos[i]].ToString() == "Si") ? "checked='checked'" : "";

                    //    string checkbox = "<label><input name='" + campos[i] + "' type='checkbox' class='flat-red' style='opacity: 0;'" + si + " ></label>";
                    //    sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), checkbox);
                    //}
                    //else
                    sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                string btnBotones = @"<div style='text-align: center;'><span class='ion-android-delete icono-grid' title='Eliminar' onclick=\""EliminarUba('" + fila[3].ToString() + "','" + fila[4].ToString() + @"'); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }

        [WebMethod(EnableSession = true)]
        public static string ConsultarUba(string idUba)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            string myJsonString = "";

            try
            {
                Ubas objUbas = new Ubas();

                DataTable dtDatos = objUbas.ObtenerUba(idUba);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaGeneralidad = (from DataRow dr in dtDatos.Rows
                                            select new
                                            {
                                                idUba = dr["IdUba"].ToString(),
                                                uba = dr["Uba"].ToString(),
                                                idTipoUba = dr["IdTipoUba"].ToString(),
                                                UbaSistema = dr["UbaSistema"].ToString(),
                                                Activo = dr["Activo"].ToString(),
                                            }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaGeneralidad);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarUbasDisponibles()
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            string myJsonString = "";

            try
            {
                Ubas objUbas = new Ubas();

                DataTable dtDatos = objUbas.ConsultarUbasDisponibles();

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaGeneralidad = (from DataRow dr in dtDatos.Rows
                                            select new
                                            {
                                                idUba = dr["IdUba"].ToString(),
                                                uba = dr["Uba"].ToString(),
                                            }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaGeneralidad);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string ObtenerUbas()
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            string myJsonString = "";

            try
            {
                Ubas objUbas = new Ubas();

                DataTable dtDatos = objUbas.ObtenerUbas();

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaGeneralidad = (from DataRow dr in dtDatos.Rows
                                            select new
                                            {
                                                idUba = dr["IdUba"].ToString(),
                                                uba = dr["Uba"].ToString(),
                                            }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaGeneralidad);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string ActualizarUba(string nuevo, string idUba, string uba, string tipoUba, string ubaSistema, string activo)
        {
            Ubas objUbas = new Ubas();
            RespuestaTO objRespuesta;
            string myJsonString;
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;

            bool pActivo;
            pActivo = (activo == "true") ? true : false;

            try
            {
                if (nuevo == "S")
                {
                    string id = objUbas.InsertarUba(uba, tipoUba, ubaSistema, pActivo, idUsuarioCreacion);
                    if (!string.IsNullOrEmpty(id))
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertó la uba [" + id + "] satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objUbas.Error, tipoMensaje = "Error" };
                }
                else
                {
                    if (objUbas.ActualizarUba(idUba, pActivo, idUsuarioCreacion))

                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se actualizó la uba [" + uba + "] satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objUbas.Error, tipoMensaje = "Error" };
                }

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        #endregion

        #region Sedes

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarSedes()
        {
            Sedes objSedes = new Sedes();
            string[] campos = new string[] { "IdSede", "NombreSede", "CodigoSedeSIBC", "Direccion", "Telefono", "Celular", "Comuna", "Barrio", "Correo", "TenenciaInmueble", "UsuarioCreacion", "FechaCreacion", "Activo" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];

            DataTable dtDatos = objSedes.ConsultarSedes(orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    if (campos[i] == "Activo")
                    {
                        string si = (fila[campos[i]].ToString() == "Si") ? "checked='checked'" : "";

                        string checkbox = "<label><input name='" + campos[i] + "' type='checkbox' class='flat-red' style='opacity: 0;'" + si + " ></label>";
                        sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), checkbox);
                    }
                    else
                        sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                string btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""Editar('" + fila[3].ToString() + @"', 'N'); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarSedesCoordinador()
        {
            string idCoordinador = HttpContext.Current.Request.Params["idCoordinador"];
            Sedes objSedes = new Sedes();
            string[] campos = new string[] { "IdSede", "NombreSede", "CodigoSedeSIBC", "Direccion", "Celular", "Comuna", "Barrio", "Correo", "Activo" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];

            DataTable dtDatos = objSedes.ConsultarSedesCoordinador(idCoordinador, orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    //if (campos[i] == "Activo")
                    //{
                    //    string si = (fila[campos[i]].ToString() == "Si") ? "checked='checked'" : "";

                    //    string checkbox = "<label><input name='" + campos[i] + "' type='checkbox' class='flat-red' style='opacity: 0;'" + si + " ></label>";
                    //    sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), checkbox);
                    //}
                    //else
                    sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                string btnBotones = @"<div style='text-align: center;'><span class='ion-android-delete icono-grid' title='Eliminar' onclick=\""EliminarSede('" + fila[3].ToString() + "','" + fila[4].ToString() + @"'); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }

        [WebMethod]
        public static string ConsultarSedesDisponibles(string idCoordinador)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            string myJsonString = "";

            try
            {
                Sedes objSedes = new Sedes();

                DataTable dtDatos = objSedes.ObtenerSedesDisponibles(idCoordinador);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaGeneralidad = (from DataRow dr in dtDatos.Rows
                                            select new
                                            {
                                                idSede = dr["IdSede"].ToString(),
                                                nombreSede = dr["NombreSede"].ToString(),
                                            }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaGeneralidad);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string ObtenerSedes()
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            string myJsonString = "";

            try
            {
                Sedes objSedes = new Sedes();

                DataTable dtDatos = objSedes.ObtenerSedes();

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaGeneralidad = (from DataRow dr in dtDatos.Rows
                                            select new
                                            {
                                                idSede = dr["IdSede"].ToString(),
                                                nombreSede = dr["NombreSede"].ToString(),
                                            }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaGeneralidad);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }


        [WebMethod(EnableSession = true)]
        public static string ActualizarSede(string nuevo, string IdSede, string NombreSede, string CodigoSedeSIBC, string Direccion, string Telefono,
            string Celular, string IdComuna, string IdBarrio, string Correo, string IdTenenciaInmueble, string Activo)
        {
            Sedes objSedes = new Sedes();
            RespuestaTO objRespuesta;
            string myJsonString;
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;

            bool pActivo;
            pActivo = (Activo == "true") ? true : false;

            try
            {
                if (nuevo == "S")
                {
                    string id = objSedes.InsertarSede(NombreSede.ToUpper(), CodigoSedeSIBC, Direccion.ToUpper(), Telefono, Celular, IdComuna,
                        IdBarrio, Correo, IdTenenciaInmueble, pActivo, idUsuarioCreacion);
                    if (!string.IsNullOrEmpty(id))
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertó la sede [" + NombreSede.ToUpper() + "] satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objSedes.Error, tipoMensaje = "Error" };
                }
                else
                {
                    if (objSedes.ActualizarSede(IdSede, NombreSede.ToUpper(), CodigoSedeSIBC, Direccion.ToUpper(), Telefono, Celular, IdComuna,
                        IdBarrio, Correo, IdTenenciaInmueble, pActivo, idUsuarioCreacion))

                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se actualizó la sede [" + NombreSede.ToUpper() + "] satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objSedes.Error, tipoMensaje = "Error" };
                }

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string ConsultarSede(string IdSede)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            string myJsonString = "";

            try
            {
                Sedes objSedes = new Sedes();

                DataTable dtDatos = objSedes.ObtenerSede(IdSede);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaGeneralidad = (from DataRow dr in dtDatos.Rows
                                            select new
                                            {
                                                idSede = dr["IdSede"].ToString(),
                                                nombreSede = dr["NombreSede"].ToString(),
                                                codigoSedeSIBC = dr["CodigoSedeSIBC"].ToString(),
                                                direccion = dr["Direccion"].ToString(),
                                                telefono = dr["Telefono"].ToString(),
                                                celular = dr["Celular"].ToString(),
                                                idComuna = dr["IdComuna"].ToString(),
                                                idBarrio = dr["IdBarrio"].ToString(),
                                                correo = dr["Correo"].ToString(),
                                                idTenenciaInmueble = dr["IdTenenciaInmueble"].ToString(),
                                                activo = dr["Activo"].ToString(),
                                            }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaGeneralidad);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        #endregion

        #region Coordinadores Sedes y Ubas

        [WebMethod(EnableSession = true)]
        public static string AsociarUbas(string idUbas, string idCoordinador)
        {
            CoordinadorUbas objCoordinadorUbas = new CoordinadorUbas();
            RespuestaTO objRespuesta;
            string myJsonString;

            try
            {
                string resp = objCoordinadorUbas.InsertarCoordinadorUbas(idUbas, idCoordinador);
                if (string.IsNullOrEmpty(objCoordinadorUbas.Error))
                {
                    if (string.IsNullOrEmpty(resp))
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertaron las ubas seleccionadas satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertaron las ubas seleccionadas satisfactoriamente. <br/><br/>" + resp, tipoMensaje = "Advertencia" };
                }
                else
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + resp, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string AsociarSedes(string idSedes, string idCoordinador)
        {
            CoordinadorSedes objCoordinadorSedes = new CoordinadorSedes();
            RespuestaTO objRespuesta;
            string myJsonString;

            try
            {
                string resp = objCoordinadorSedes.InsertarCoordinadorSedes(idSedes, idCoordinador);
                if (string.IsNullOrEmpty(objCoordinadorSedes.Error))
                {
                    if (string.IsNullOrEmpty(resp))
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertaron las sedes seleccionadas satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertaron las sedes seleccionadas satisfactoriamente. <br/><br/>" + resp, tipoMensaje = "Advertencia" };
                }
                else
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + resp, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string AsociarAgentes(string idAgentes, string idCoordinador)
        {
            CoordinadorAgentes objCoordinadorAgentes = new CoordinadorAgentes();
            RespuestaTO objRespuesta;
            string myJsonString;

            try
            {
                string resp = objCoordinadorAgentes.InsertarCoordinadorAgentes(idAgentes, idCoordinador);
                if (string.IsNullOrEmpty(objCoordinadorAgentes.Error))
                {
                    if (string.IsNullOrEmpty(resp))
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertaron los agentes seleccionadas satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertaron los agentes seleccionadas satisfactoriamente. <br/><br/>" + resp, tipoMensaje = "Advertencia" };
                }
                else
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + resp, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string EliminarCoordinadorAgente(string idAgente, string idCoordinador, string nombre)
        {
            CoordinadorAgentes objCoordinadorAgentes = new CoordinadorAgentes();
            RespuestaTO objRespuesta;
            string myJsonString;

            try
            {
                bool resp = objCoordinadorAgentes.EliminarCoordinadorAgentes(idAgente, idCoordinador);
                if (resp)
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se desasoció el agente " + nombre + " satisfactoriamente", tipoMensaje = "Exito" };
                else
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + resp, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string EliminarCoordinadorUba(string idUba, string nombre)
        {
            CoordinadorUbas objCoordinadorUbas = new CoordinadorUbas();
            RespuestaTO objRespuesta;
            string myJsonString;

            try
            {
                bool resp = objCoordinadorUbas.EliminarCoordinadorUba(idUba);
                if (resp)
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se desasoció las uba " + nombre + " satisfactoriamente", tipoMensaje = "Exito" };
                else
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + resp, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string EliminarCoordinadorSede(string idSede, string idCoordinador, string nombre)
        {
            CoordinadorSedes objCoordinadorSedes = new CoordinadorSedes();
            RespuestaTO objRespuesta;
            string myJsonString;

            try
            {
                bool resp = objCoordinadorSedes.EliminarCoordinadorSede(idSede, idCoordinador);
                if (resp)
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se desasoció la sede " + nombre + " satisfactoriamente", tipoMensaje = "Exito" };
                else
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + resp, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod]
        public static string ConsultarCoordinadorSedes(string idCoordinador)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            string myJsonString = "";

            try
            {
                Sedes objSedes = new Sedes();

                DataTable dtDatos = objSedes.ConsultarSedesCoordinador(idCoordinador, "IdSede asc", "", 0, "200");

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaGeneralidad = (from DataRow dr in dtDatos.Rows
                                            select new
                                            {
                                                idSede = dr["IdSede"].ToString(),
                                                nombreSede = dr["NombreSede"].ToString(),
                                            }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaGeneralidad);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod]
        public static string ConsultarCoordinadorUbas(string idCoordinador)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            string myJsonString = "";

            try
            {
                Ubas objUbas = new Ubas();

                DataTable dtDatos = objUbas.ConsultarUbasCoordinador(idCoordinador, "IdUba asc", "", 0, "200");

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaGeneralidad = (from DataRow dr in dtDatos.Rows
                                            select new
                                            {
                                                idUba = dr["IdUba"].ToString(),
                                                uba = dr["Uba"].ToString(),
                                            }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaGeneralidad);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        #endregion

        #region Coordinador x Agentes

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarCoordinadorAgentes2()
        {
            string idCoordinador = HttpContext.Current.Request.Params["idCoordinador"];
            CoordinadorAgentes objCoordinadorAgentes = new CoordinadorAgentes();
            string[] campos = new string[] { "IdDocumento", "Nombre", "Celular", "Perfil", "Estado" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];

            DataTable dtDatos = objCoordinadorAgentes.ConsultarCoordinadorAgentes(idCoordinador, orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    //if (campos[i] == "Activo")
                    //{
                    //    string si = (fila[campos[i]].ToString() == "Si") ? "checked='checked'" : "";

                    //    string checkbox = "<label><input name='" + campos[i] + "' type='checkbox' class='flat-red' style='opacity: 0;'" + si + " ></label>";
                    //    sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), checkbox);
                    //}
                    //else
                    sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                string btnBotones = @"<div style='text-align: center;'><span class='ion-android-delete icono-grid' title='Eliminar' onclick=\""EliminarAgente('" + fila[3].ToString() + "','" + fila[4].ToString() + @"'); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }

        [WebMethod]
        public static string ConsultarCoordinadorAgentes(string idCoordinador)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                CoordinadorAgentes objCoordinadorAgentes = new CoordinadorAgentes();

                DataTable dtDatos = objCoordinadorAgentes.ConsultarCoordinadorAgentes(idCoordinador);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaGeneralidad = (from DataRow dr in dtDatos.Rows
                                            select new
                                            {
                                                idAgente = dr["IdAgente"].ToString(),
                                                nombre = dr["Nombre"].ToString()
                                            }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaGeneralidad);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string ConsultarCoordinadorAgentesTransversales(string idCoordinador)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                CoordinadorAgentes objCoordinadorAgentes = new CoordinadorAgentes();

                DataTable dtDatos = objCoordinadorAgentes.ConsultarCoordinadorAgentesTransversales(idCoordinador);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaGeneralidad = (from DataRow dr in dtDatos.Rows
                                            select new
                                            {
                                                idAgente = dr["IdUsuario"].ToString(),
                                                nombre = dr["Nombre"].ToString()
                                            }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaGeneralidad);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string ConsultarCoordinadoresAgente(string esTraslado)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];
                CoordinadorAgentes objCoordinadorAgentes = new CoordinadorAgentes();
                Usuarios objUsuarios = new Usuarios();
                byte? idPerfil = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdPerfil.Value;
                DataTable dtDatos;

                if (idPerfil.Value == 1 || esTraslado == "S")
                    dtDatos = objUsuarios.ConsultarCoordinadores();
                else
                    dtDatos = objCoordinadorAgentes.ObtenerCoordiandoresAgente(objUsuario.IdDocumento);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaCoordinadores = (from DataRow dr in dtDatos.Rows
                                              select new
                                              {
                                                  idCoordinador = dr["IdCoordinador"].ToString(),
                                                  nombre = dr["Nombre"].ToString()
                                              }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaCoordinadores);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        [WebMethod]
        public static string ConsultarAgentesCoordinador()
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];
                CoordinadorAgentes objCoordinadorAgentes = new CoordinadorAgentes();

                string idAgente = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;

                DataTable dtDatos = objCoordinadorAgentes.ObtenerAgentesCoordinador(idAgente);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaGeneralidad = (from DataRow dr in dtDatos.Rows
                                            select new
                                            {
                                                idProfesionalRemision = dr["IdDocumento"].ToString(),
                                                nombre = dr["Nombre"].ToString()
                                            }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaGeneralidad);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        #endregion

        #region Generalidades

        [WebMethod]
        public static string ConsultarGeneralidades(string idTipoGeneralidad)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                Generalidades objGeneralidades = new Generalidades();

                DataTable dtDatos = objGeneralidades.ObtenerGeneralidades(idTipoGeneralidad);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaGeneralidad = (from DataRow dr in dtDatos.Rows
                                            select new
                                            {
                                                IdGeneralidad = dr["IdGeneralidad"].ToString(),
                                                Descripcion = dr["Descripcion"].ToString(),
                                                Abreviacion = dr["Abreviacion"].ToString(),
                                                Orden = dr["Orden"].ToString(),
                                            }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaGeneralidad);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        [WebMethod]
        public static string ConsultarTipoAccion(string numeroIdentificacion)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                Generalidades objGeneralidades = new Generalidades();

                DataTable dtDatos = objGeneralidades.ObtenerTipoAccion(numeroIdentificacion);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaGeneralidad = (from DataRow dr in dtDatos.Rows
                                            select new
                                            {
                                                IdGeneralidad = dr["IdGeneralidad"].ToString(),
                                                Descripcion = dr["Descripcion"].ToString(),
                                                Abreviacion = dr["Abreviacion"].ToString(),
                                                Orden = dr["Orden"].ToString(),
                                            }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaGeneralidad);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        #endregion

        #region Comunas

        [WebMethod]
        public static string ConsultarComunas()
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                Comunas objComunas = new Comunas();

                DataTable dtDatos = objComunas.ConsultarComunas();

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaGeneralidad = (from DataRow dr in dtDatos.Rows
                                            select new
                                            {
                                                IdComuna = dr["IdComuna"].ToString(),
                                                NombreComuna = dr["NombreComuna"].ToString(),
                                            }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaGeneralidad);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        #endregion

        #region Barrios

        [WebMethod]
        public static string ConsultarBarrios(string idComuna)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                Barrios objBarrios = new Barrios();

                DataTable dtDatos = objBarrios.ConsultarBarriosByComuna(idComuna);
                objRespuesta.resultado = true;

                if (dtDatos.Rows.Count > 0)
                {
                    var listaGeneralidad = (from DataRow dr in dtDatos.Rows
                                            select new
                                            {
                                                IdBarrio = dr["IdBarrio"].ToString(),
                                                NombreBarrio = dr["NombreBarrio"].ToString(),
                                            }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaGeneralidad);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        #endregion

        #region Login

        [WebMethod(EnableSession = true)]
        public static string Ingresar(string usuario, string password)
        {
            RespuestaTO objRespuesta;
            string myJsonString;

            try
            {
                Usuarios objUsuarios = new Usuarios();

                UsuarioTO objUsuario = objUsuarios.RegistrarIngreso(usuario, password);

                if (objUsuario != null)
                {
                    HttpContext.Current.Session[VariablesSession.DatosUsuario] = objUsuario;
                    HttpContext.Current.Session.Timeout = 120;
                    if (objUsuario.Estado.ToUpper() == "INACTIVO")
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "El usuario no está activo. Por favor comunicarse con el administrador del sistema.", tipoMensaje = "Error" };
                    else if (objUsuario.CambioPassword != null && objUsuario.CambioPassword.Value)
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "CambiarPassword", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Ingresar", tipoMensaje = "Exito" };

                    myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                    return myJsonString;
                }
                else
                {
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Usuario y/o contraseña incorrectos. Asegúrate de ingresar los datos correctamente e inténtalo de nuevo.", tipoMensaje = "Error" };

                    myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                    return myJsonString;
                }
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string CambiarClave(string idUsuario, string password)
        {
            RespuestaTO objRespuesta;
            string myJsonString;
            bool inicio = true;
            UsuarioTO objUsuario;

            try
            {
                Usuarios objUsuarios = new Usuarios();

                if (string.IsNullOrEmpty(idUsuario))
                {
                    idUsuario = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;
                    inicio = false;
                }

                if (objUsuarios.CambioClave(idUsuario, password))
                {
                    if (inicio)
                    {
                        objUsuario = objUsuarios.RegistrarIngreso(idUsuario, password);
                        HttpContext.Current.Session[VariablesSession.DatosUsuario] = objUsuario;
                        HttpContext.Current.Session.Timeout = 120;
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se ha realizado el cambio de clave satisfactoriamente. En breve momento será redireccionado al sitio principal.", tipoMensaje = "Exito" };
                    }
                    else
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se ha realizado el cambio de clave satisfactoriamente.", tipoMensaje = "Exito" };
                }
                else
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objUsuarios.Error, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        #endregion

        #region Seguridad

        [WebMethod(EnableSession = true)]
        public static string ActualizarSeguridad(string permiso, string quitar)
        {
            Seguridad objSeguridad = new Seguridad();
            RespuestaTO objRespuesta;
            string myJsonString;

            try
            {
                int idPermiso = int.Parse(permiso.Split('_')[0]);
                string nombrePerfil = permiso.Split('_')[1];
                bool quitarPermiso = (quitar == "true") ? false : true;

                if (objSeguridad.ActualizarSeguridad(idPermiso, nombrePerfil, quitarPermiso))
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se actualizó el perfil satisfactoriamente", tipoMensaje = "Exito" };
                else
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objSeguridad.Error, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        #endregion

        #region Reportes

        [WebMethod(EnableSession = true)]
        public static string InsertarReporte(string nombre, string descripcion, string query, string Hdcampos)
        {
            RespuestaTO objRespuesta;
            string myJsonString = string.Empty;
            ReporteDinamico objReportes = new ReporteDinamico();
            try
            {
                if (query.IndexOf("DELETE FROM") > -1 || query.IndexOf("DROP ") > -1 ||
                   query.IndexOf("INSERT INTO") > -1 || query.IndexOf("UPDATE ") > -1)
                {
                    // Utilidades.MostrarMensajeModal("El query tiene palabras que no son permitidas, por favor verifique.", Core.TipoMensaje.Error, false, true);
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "El query tiene palabras que no son permitidas, por favor verifique.", tipoMensaje = "Error" };
                    myJsonString = Newtonsoft.Json.JsonConvert.SerializeObject(objRespuesta);
                    return myJsonString;
                }

                DataTable dtCampos = new DataTable();

                dtCampos.Columns.Add(new DataColumn { ColumnName = "IdTipoCampo", DataType = typeof(byte) });
                dtCampos.Columns.Add(new DataColumn { ColumnName = "Campo", DataType = typeof(string) });

                if (!string.IsNullOrEmpty(Hdcampos))
                {
                    string[] campos = Hdcampos.Split('|');

                    foreach (string campo in campos)
                    {
                        string[] datos = campo.Split(',');
                        string nombreCampo = datos[1].Substring(datos[1].IndexOf('=') + 1);
                        DataRow fila = dtCampos.NewRow();
                        fila["IdTipoCampo"] = byte.Parse(datos[0]);
                        fila["Campo"] = nombreCampo.Trim();

                        dtCampos.Rows.Add(fila);
                    }
                }

                if (objReportes.InsertarReporte(nombre, descripcion, query, dtCampos))
                {
                    Utilidades.MostrarMensaje("Se ha guardado exitosamente el nuevo reporte", Core.TipoMensaje.Exito, true);
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se ha guardado exitosamente el nuevo reporte", tipoMensaje = "Exito" };
                    myJsonString = Newtonsoft.Json.JsonConvert.SerializeObject(objRespuesta);
                    return myJsonString;
                }
                else
                {
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = objReportes.Error.Replace("'", "\\'").Replace("\r\n", " "), tipoMensaje = "Error" };
                    myJsonString = Newtonsoft.Json.JsonConvert.SerializeObject(objRespuesta);
                    return myJsonString;
                }
            }
            catch (Exception ex)
            {

                objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Ocurrió un error al insertar el reporte, Error: " + ex.Message, tipoMensaje = "Error" };
                myJsonString = Newtonsoft.Json.JsonConvert.SerializeObject(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string ActualizarReporte(string idReporte, string nombre, string descripcion, string query, string Hdcampos)
        {
            RespuestaTO objRespuesta;
            string myJsonString = string.Empty;
            ReporteDinamico objReportes = new ReporteDinamico();
            try
            {
                if (query.IndexOf("DELETE FROM") > -1 || query.IndexOf("DROP ") > -1 ||
                   query.IndexOf("INSERT INTO") > -1 || query.IndexOf("UPDATE ") > -1)
                {
                    // Utilidades.MostrarMensajeModal("El query tiene palabras que no son permitidas, por favor verifique.", Core.TipoMensaje.Error, false, true);
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "El query tiene palabras que no son permitidas, por favor verifique.", tipoMensaje = "Error" };
                    myJsonString = Newtonsoft.Json.JsonConvert.SerializeObject(objRespuesta);
                    return myJsonString;
                }

                DataTable dtCampos = new DataTable();

                dtCampos.Columns.Add(new DataColumn { ColumnName = "IdTipoCampo", DataType = typeof(byte) });
                dtCampos.Columns.Add(new DataColumn { ColumnName = "Campo", DataType = typeof(string) });

                if (!string.IsNullOrEmpty(Hdcampos))
                {
                    string[] campos = Hdcampos.Split('|');

                    foreach (string campo in campos)
                    {
                        string[] datos = campo.Split(',');
                        string nombreCampo = datos[1].Substring(datos[1].IndexOf('=') + 1);
                        DataRow fila = dtCampos.NewRow();
                        fila["IdTipoCampo"] = byte.Parse(datos[0]);
                        fila["Campo"] = nombreCampo.Trim();

                        dtCampos.Rows.Add(fila);
                    }
                }

                if (objReportes.ActualizarReporte(Convert.ToInt32(idReporte), nombre, descripcion, query, dtCampos))
                {
                    //Utilidades.MostrarMensaje("Se ha guardado exitosamente el nuevo reporte", Core.TipoMensaje.Exito, true);
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se ha guardado exitosamente el nuevo reporte", tipoMensaje = "Exito" };
                    myJsonString = Newtonsoft.Json.JsonConvert.SerializeObject(objRespuesta);
                    return myJsonString;
                }
                else
                {
                    //Se debe tomar el error del objeto objPerfiles y mostrarlo
                    //Utilidades.MostrarMensajeModal(objReportes.Error.Replace("'", "\\'").Replace("\r\n", " "), Core.TipoMensaje.Error, false, true);

                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = objReportes.Error.Replace("'", "\\'").Replace("\r\n", " "), tipoMensaje = "Error" };
                    myJsonString = Newtonsoft.Json.JsonConvert.SerializeObject(objRespuesta);
                    return myJsonString;
                }
            }
            catch (Exception ex)
            {

                objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Ocurrió un error al insertar el reporte, Error: " + ex.Message, tipoMensaje = "Error" };
                myJsonString = Newtonsoft.Json.JsonConvert.SerializeObject(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string EliminarReporte(string idReporte)
        {
            RespuestaTO objRespuesta;
            string myJsonString = string.Empty;
            ReporteDinamico objReportes = new ReporteDinamico();
            try
            {

                if (objReportes.EliminarReporte(Convert.ToInt32(idReporte)))
                {
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se ha eliminado exitosamente el reporte", tipoMensaje = "Exito" };
                    myJsonString = Newtonsoft.Json.JsonConvert.SerializeObject(objRespuesta);
                    return myJsonString;
                }
                else
                {
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = objReportes.Error.Replace("'", "\\'").Replace("\r\n", " "), tipoMensaje = "Error" };
                    myJsonString = Newtonsoft.Json.JsonConvert.SerializeObject(objRespuesta);
                    return myJsonString;
                }
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Ocurrió un error al insertar el reporte, Error: " + ex.Message, tipoMensaje = "Error" };
                myJsonString = Newtonsoft.Json.JsonConvert.SerializeObject(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarReportes()
        {
            ReporteDinamico objAdminReportes = new ReporteDinamico();
            string[] campos = new string[] { "IdReporte", "Nombre", "Descripcion" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? "[" + campos[i] + "]" + " LIKE " : " OR " + "[" + campos[i] + "]" + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = "[" + campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + "] " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            DataTable dtDatos = objAdminReportes.ConsultarReportes(orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;
            if (dtDatos != null)
            {
                foreach (DataRow fila in dtDatos.Rows)
                {
                    if (totalRecords.Length == 0)
                    {
                        totalRecords = fila["TotalRows"].ToString();
                        totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                    }

                    sb.Append("{");
                    sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                    sb.Append(",");
                    sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                    sb.Append(",");

                    for (int i = 0; i < campos.Length; i++)
                    {
                        if (i != 0)
                            sb.Append(",");

                        sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\"").Replace("\r\n", " ").Replace("\r", " ")
                  .Replace("\n", " ")
                  .Replace("\\", "\\\\")
                  .Replace("\"", "\\\"")); ;
                    }

                    sb.Append(",");

                    string btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""Editar('" + fila["IdReporte"].ToString() + @"'); return false;\"" ></span> <span class='ion-android-delete icono-grid' title='Eliminar' onclick=\""Eliminar('" + fila["IdReporte"].ToString() + @"'); return false;\"" ></span></div>";

                    sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                    sb.Append("},");
                }
            }
            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }

        [WebMethod(EnableSession = true)]
        public static string ConsultarReporte(string idReporte)
        {
            RespuestaTO objRespuesta;
            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];
            ReporteDinamico objAdminReportes = new ReporteDinamico();
            DataSet dsReporte = objAdminReportes.ObtenerReporteCompleto(idReporte);

            if (dsReporte != null && dsReporte.Tables.Count > 0)
            {
                Core.Reportes.To.ReporteTo reporte = Utilidades.ToList<Core.Reportes.To.ReporteTo>(dsReporte.Tables[0])[0];

                reporte.IdPerfil = Convert.ToInt32(objUsuario.IdPerfil);
                //reporte.IdNitOperador = objUsuario.IdOperador;
                //reporte.IdMunicipioOperacion = objUsuario.IdMunicipioOperacion;

                if (dsReporte.Tables.Count == 2)
                    reporte.CamposReporte = Utilidades.ToList<Core.Reportes.To.CamposReporteTo>(dsReporte.Tables[1]);

                string myJsonString = (new JavaScriptSerializer()).Serialize(reporte);
                return myJsonString;
            }
            else
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error al consultar el reporte. Si el problema persiste por favor contacte al administrador del sistema", tipoMensaje = "Error" };
                string myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }
        #endregion

        #region Lugares

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarLugares()
        {
            Lugares objLugares = new Lugares();
            string[] campos = new string[] { "IdLugar", "IdDane", "IdNit", "TipoLugar", "NombreLugar", "Comuna", "Barrio", "Direccion", "Responsable" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];
            string idDocumento = objUsuario.IdDocumento;
            byte idPerfil = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdPerfil.Value;

            DataTable dtDatos = objLugares.ConsultarLugares(orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                //string btnBotones = @"<div style='text-align: center;'><span class='ion-android-open icono-grid' title='Más información' onclick=\""Ver('" + fila["IdDocumento"].ToString() + @"'); return false;\""></span></span>&nbsp;<span class='glyphicon glyphicon-paperclip icono-grid' title='Subir Archivo' onclick=\""SubirArchivo('" + fila["IdDocumento"].ToString() + @"','"+ fila["TipoBeneficiario"].ToString() + @"','"+ fila["TipoDocumento"].ToString() + @"','"+ fila["Nombre"].ToString() + @"'); return false;\"" ></span></div>";
                string btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""Editar('" + fila[3].ToString() + @"',''); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }

        [WebMethod(EnableSession = true)]
        public static string ActualizarLugar(string idLugar, string nuevo, string dane, string nit, string tipoLugar,
                                              string tipoModalidad, string nombreLugar, string entorno, string comuna, string barrio,
                                              string direccion, string telefono1, string telefono2, string nombreResponsable)

        {
            Lugares objLugares = new Lugares();
            RespuestaTO objRespuesta;
            string myJsonString;
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;

            try
            {
                if (nuevo == "S")
                {
                    if (objLugares.InsertarLugar(dane, nit, tipoLugar, tipoModalidad, nombreLugar,
                                              entorno, comuna, barrio, direccion, telefono1, telefono2, nombreResponsable,
                                              idUsuarioCreacion, idUsuarioCreacion))

                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertó el Lugar satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objLugares.Error, tipoMensaje = "Error" };
                }
                else
                {
                    if (objLugares.ActualizarLugar(idLugar, dane, nit, tipoLugar, tipoModalidad, nombreLugar,
                                              entorno, comuna, barrio, direccion, telefono1, telefono2, nombreResponsable,
                                              idUsuarioCreacion))

                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se actualizó el Lugar satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objLugares.Error, tipoMensaje = "Error" };
                }

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        #endregion

        #region Cronograma

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarCronograma()
        {
            Cronograma objCronograma = new Cronograma();
            string[] campos = new string[] { "IdProgramacionActividades", "Coordinador", "Sede", "TipoEncuentro", "Ubas", "FechaHora", "AgenteEducativo1", "AgenteEducativo2", "MotivoReprogramacion", "UsuarioCreacion", "FechaCreacion" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];
            string IdCoodinador = "";

            if (((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdPerfil.Value != 1)
            {
                CoordinadorAgentes objCoordinadorAgentes = new CoordinadorAgentes();
                DataTable dtCoordinadores = objCoordinadorAgentes.ObtenerCoordiandoresAgente(objUsuario.IdDocumento);

                foreach (DataRow fila in dtCoordinadores.Rows)
                    IdCoodinador += fila["IdCoordinador"] + ",";

                IdCoodinador = IdCoodinador.Substring(0, IdCoodinador.Length - 1);

            }

            DataTable dtDatos = objCronograma.ConsultarCronograma(IdCoodinador, orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                string btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""Editar('" + fila[3].ToString() + @"','N'); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }


        [WebMethod(EnableSession = true)]
        public static string ActualizarCronograma(string nuevo, string idProgramacionActividades, string idCoordinador, string idSede,
                                              string idTipoEncuentro, string idUbas, string fecha, string idAgenteEducativo1, string idAgenteEducativo2,
                                              string puntoReferencia, string motivoReprogramacion, string observacionesReprogramacion)

        {
            Cronograma objCronograma = new Cronograma();
            RespuestaTO objRespuesta;
            string myJsonString;
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;

            DateTime pFecha;
            pFecha = DateTime.ParseExact(fecha, "dd/MM/yyyy HH:mm", null);

            try
            {
                if (nuevo == "S")
                {

                    if (!objCronograma.ExisteCronograma(idCoordinador, idSede, idTipoEncuentro, pFecha))
                    {
                        idProgramacionActividades = objCronograma.InsertarCronograma(idCoordinador, idSede, idTipoEncuentro, pFecha, idAgenteEducativo1, idAgenteEducativo2,
                                                puntoReferencia, idUsuarioCreacion);

                        if (!string.IsNullOrEmpty(idProgramacionActividades))
                        {
                            CronogramaUbas objCronogramaUbas = new CronogramaUbas();

                            if (objCronogramaUbas.InsertarCronogramaUbas(idUbas, idProgramacionActividades))
                                objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertó el cronograma [" + idProgramacionActividades + "] satisfactoriamente", tipoMensaje = "Exito" };
                            else
                                objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertó el cronograma [" + idProgramacionActividades + "] satisfactoriamente, sin embargo hubo un error al intentar asociar las ubas al cronograma. <br/><br/>" + objCronograma.Error, tipoMensaje = "Exito" };

                        }
                        else
                            objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objCronograma.Error, tipoMensaje = "Error" };
                    }
                    else
                    {
                        if (string.IsNullOrEmpty(objCronograma.Error))
                            objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ya existe un cronograma en nuestro sistema con las mismas características de coordinador, sede, tipo encuentro y fecha y hora del que intentas ingresar.", tipoMensaje = "Error" };
                        else
                            objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objCronograma.Error, tipoMensaje = "Error" };
                    }




                }
                else
                {
                    if (objCronograma.ActualizarCronograma(idProgramacionActividades, motivoReprogramacion, observacionesReprogramacion, idUsuarioCreacion))

                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se actualizó el cronograma [" + idProgramacionActividades + "] satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objCronograma.Error, tipoMensaje = "Error" };
                }

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod]
        public static string ObtenerCronograma(string idProgramacionActividades)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                Cronograma objCronograma = new Cronograma();
                CronogramaUbas objCronogramaUbas = new CronogramaUbas();

                DataTable dtDatos = objCronograma.ObtenerCronograma(idProgramacionActividades);
                DataTable dtDatosUbas = objCronogramaUbas.ObtenerCronogramaUbas(idProgramacionActividades);
                string ubas = "";

                if (dtDatosUbas.Rows.Count > 0)
                {
                    var listaUbas = (from DataRow dr in dtDatosUbas.Rows
                                     select new
                                     {
                                         idUba = dr["IdUba"].ToString(),
                                     }).ToList();

                    ubas = String.Join("|", listaUbas.Select(l => l.idUba));
                }

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaCronograma = (from DataRow dr in dtDatos.Rows
                                           select new
                                           {
                                               idProgramacionActividades = dr["IdProgramacionActividades"].ToString(),
                                               idCoordinador = dr["IdCoordinador"].ToString(),
                                               idSede = dr["IdSede"].ToString(),
                                               idTipoEncuentro = dr["IdTipoEncuentro"].ToString(),
                                               fechaHora = DateTime.Parse(dr["FechaHora"].ToString()).ToString("dd/MM/yyyy HH:mm"),
                                               idAgenteEducativo1 = dr["IdAgenteEducativo1"].ToString(),
                                               idAgenteEducativo2 = dr["IdAgenteEducativo2"].ToString(),
                                               puntoReferencia = dr["PuntoReferencia"].ToString(),
                                               idMotivoReprogramacion = dr["IdMotivoReprogramacion"].ToString(),
                                               observacionesReprogramacion = dr["ObservacionesReprogramacion"].ToString(),
                                               idUbas = ubas,
                                           }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaCronograma);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ObtenerCronogramaEncuentro()
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                Cronograma objCronograma = new Cronograma();
                UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];
                string IdCoodinador = "";

                if (((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdPerfil.Value != 1)
                {
                    CoordinadorAgentes objCoordinadorAgentes = new CoordinadorAgentes();
                    DataTable dtCoordinadores = objCoordinadorAgentes.ObtenerCoordiandoresAgente(objUsuario.IdDocumento);

                    foreach (DataRow fila in dtCoordinadores.Rows)
                        IdCoodinador += fila["IdCoordinador"] + ",";

                    IdCoodinador = IdCoodinador.Substring(0, IdCoodinador.Length - 1);

                }

                DataTable dtDatos = objCronograma.ObtenerCronogramaEncuentro(IdCoodinador, "");

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaCronograma = (from DataRow dr in dtDatos.Rows
                                           select new
                                           {
                                               idProgramacionActividades = dr["IdProgramacionActividades"].ToString(),
                                               fechaHora = DateTime.Parse(dr["FechaHora"].ToString()).ToString("dd/MM/yyyy HH:mm") + " - " + dr["NombreSede"].ToString() + " - " + dr["Ubas"].ToString() + " - " + dr["TipoEncuentro"].ToString(),
                                               idTipoEncuentro = dr["IdTipoEncuentro"].ToString(),
                                           }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaCronograma);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        [WebMethod]
        public static string ObtenerCronogramaEncuentroEditar(string idProgramacionActividades)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                Cronograma objCronograma = new Cronograma();

                DataTable dtDatos = objCronograma.ObtenerCronogramaEncuentro("", idProgramacionActividades);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaCronograma = (from DataRow dr in dtDatos.Rows
                                           select new
                                           {
                                               idProgramacionActividades = dr["IdProgramacionActividades"].ToString(),
                                               fechaHora = DateTime.Parse(dr["FechaHora"].ToString()).ToString("dd/MM/yyyy HH:mm") + " - " + dr["NombreSede"].ToString() + " - " + dr["Ubas"].ToString(),
                                               fecha = DateTime.Parse(dr["FechaHora"].ToString()).ToString("dd/MM/yyyy HH:mm"),
                                               idTipoEncuentro = dr["IdTipoEncuentro"].ToString()
                                           }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaCronograma);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarCronogramaBusquedaActiva()
        {
            try
            {
                CronogramaBusquedaActiva objCronogramaBusquedaActiva = new CronogramaBusquedaActiva();
            string[] campos = new string[] { "IdCronograma", "FechaEncuentro", "Coordinador", "TipoActividad", "Actividad", "Comuna", "Barrio", "AgenteEducativo1", "AgenteEducativo2", "PuntoReferencia", "Observaciones", "MotivoReprogramacion", "UsuarioCreacion", "FechaCreacion" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            // Para BusquedaActiva, mostrar todos los cronogramas sin restricción de coordinador
            string IdCoordinador = "";

            DataTable dtDatos = objCronogramaBusquedaActiva.ConsultarCronogramaBusquedaActiva(IdCoordinador, orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            // Validar que dtDatos no sea null
            if (dtDatos == null)
            {
                // Retornar respuesta vacía en caso de error
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                return sb.ToString();
            }

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                string btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""Editar('" + fila["IdCronograma"].ToString() + @"','N'); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
            }
            catch (Exception ex)
            {
                // En caso de error, retornar respuesta vacía
                var sb = new StringBuilder();
                int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
                
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                return sb.ToString();
            }
        }

        [WebMethod]
        public static string ObtenerCronogramaBusquedaActiva(string idCronograma)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                CronogramaBusquedaActiva objCronogramaBusquedaActiva = new CronogramaBusquedaActiva();

                DataTable dtDatos = objCronogramaBusquedaActiva.ObtenerCronogramaBusquedaActivaPorId(idCronograma);

                if (dtDatos != null && dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaCronograma = (from DataRow dr in dtDatos.Rows
                                           select new
                                           {
                                               idCronograma = dr["IdCronograma"].ToString(),
                                               idTipoActividad = dr["IdTipoActividad"].ToString(),
                                               idActividad = dr["IdActividad"].ToString(),
                                               idCoordinador = dr["IdCoordinador"].ToString(),
                                               idBarrio = dr["IdBarrio"].ToString(),
                                               idComuna = dr["IdComuna"].ToString(),
                                               fechaEncuentro = dr["FechaEncuentroFormatted"].ToString(),
                                               idAgenteEducativo1 = dr["IdAgenteEducativo1"].ToString(),
                                               idAgenteEducativo2 = dr["IdAgenteEducativo2"].ToString(),
                                               puntoReferencia = dr["PuntoReferencia"].ToString(),
                                               observaciones = dr["Observaciones"].ToString(),
                                               idMotivoReprogramacion = dr["IdMotivoReprogramacion"].ToString(),
                                               observacionesReprogramacion = dr["ObservacionesReprogramacion"].ToString(),
                                           }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaCronograma);
                }
                else
                {
                    objRespuesta.resultado = false;
                    if (dtDatos == null)
                    {
                        objRespuesta.mensaje = "Error al consultar el cronograma de búsqueda activa: " + objCronogramaBusquedaActiva.Error;
                    }
                    else
                    {
                        objRespuesta.mensaje = "No se encontró el cronograma de búsqueda activa con ID: " + idCronograma;
                    }
                    objRespuesta.tipoMensaje = "Error";
                }
                
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inesperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string ActualizarCronogramaBusquedaActiva(string nuevo, string IdCronograma, string idCoordinador, 
                                                               string fecha, string idAgenteEducativo1, string idAgenteEducativo2,
                                                               string puntoReferencia, string observaciones, string motivoReprogramacion, 
                                                               string observacionesReprogramacion, string idActividad, string idTipoActividad, 
                                                               string idComuna, string idBarrio)
        {
            CronogramaBusquedaActiva objCronogramaBusquedaActiva = new CronogramaBusquedaActiva();
            RespuestaTO objRespuesta;
            string myJsonString;
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;

            // Solo parsear y validar fecha en modo nuevo
            DateTime fechaEncuentro = DateTime.Now; // Valor por defecto
            
            if (nuevo == "S")
            {
                // Parsear la fecha solo en modo nuevo
                fechaEncuentro = DateTime.ParseExact(fecha, "dd/MM/yyyy HH:mm", null);

                // Validar que la fecha esté dentro del rango permitido
                DateTime hoy = DateTime.Today;
                DateTime finDelMes = new DateTime(hoy.Year, hoy.Month, DateTime.DaysInMonth(hoy.Year, hoy.Month), 23, 59, 59);

                if (fechaEncuentro.Date < hoy)
                {
                    objRespuesta = new RespuestaTO() 
                    { 
                        resultado = false, 
                        mensaje = "La fecha del encuentro no puede ser anterior a hoy", 
                        tipoMensaje = "Error" 
                    };
                    return JsonConvert.SerializeObject(objRespuesta);
                }

                if (fechaEncuentro > finDelMes)
                {
                    objRespuesta = new RespuestaTO() 
                    { 
                        resultado = false, 
                        mensaje = "La fecha del encuentro no puede ser posterior al final del mes actual", 
                        tipoMensaje = "Error" 
                    };
                    return JsonConvert.SerializeObject(objRespuesta);
                }
            }

            try
            {
                if (nuevo == "S")
                {
                    // Convertir idComuna a byte? si no está vacío
                    byte? idComunaByte = null;
                    if (!string.IsNullOrEmpty(idComuna))
                    {
                        if (byte.TryParse(idComuna, out byte comunaValue))
                            idComunaByte = comunaValue;
                    }

                    // Verificar si ya existe un cronograma con las mismas características
                    if (!objCronogramaBusquedaActiva.ExisteCronogramaBusquedaActiva(idCoordinador, idTipoActividad, idActividad, idBarrio, idComunaByte))
                    {
                        string idCronogramaGenerado = objCronogramaBusquedaActiva.InsertarCronogramaBusquedaActiva(idTipoActividad, idActividad, idCoordinador,
                                                                                                                  idBarrio, idComunaByte, fechaEncuentro,
                                                                                                                  idAgenteEducativo1, idAgenteEducativo2, 
                                                                                                                  puntoReferencia, observaciones, idUsuarioCreacion);

                        if (!string.IsNullOrEmpty(idCronogramaGenerado))
                        {
                            objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertó el cronograma de búsqueda activa [" + idCronogramaGenerado + "] satisfactoriamente", tipoMensaje = "Exito" };
                        }
                        else
                        {
                            objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inesperado. " + objCronogramaBusquedaActiva.Error, tipoMensaje = "Error" };
                        }
                    }
                    else
                    {
                        if (string.IsNullOrEmpty(objCronogramaBusquedaActiva.Error))
                            objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ya existe un cronograma de búsqueda activa en nuestro sistema con las mismas características de coordinador, tipo de actividad, actividad y ubicación del que intentas ingresar.", tipoMensaje = "Error" };
                        else
                            objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inesperado. " + objCronogramaBusquedaActiva.Error, tipoMensaje = "Error" };
                    }
                }
                else
                {
                    // Modo edición - solo permitir reprogramación
                    if (!string.IsNullOrEmpty(motivoReprogramacion))
                    {
                        if (objCronogramaBusquedaActiva.ActualizarReprogramacionCronogramaBusquedaActiva(IdCronograma, motivoReprogramacion, observacionesReprogramacion, idUsuarioCreacion))
                        {
                            objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se reprogramó el cronograma de búsqueda activa [" + IdCronograma + "] satisfactoriamente", tipoMensaje = "Exito" };
                        }
                        else
                        {
                            objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inesperado. " + objCronogramaBusquedaActiva.Error, tipoMensaje = "Error" };
                        }
                    }
                    else
                    {
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Debe seleccionar un motivo de reprogramación para editar el cronograma", tipoMensaje = "Error" };
                    }
                }

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inesperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        #endregion

        #region Entrega Paquetes

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarEntregaPaquetes()
        {
            EntregaPaquetes objEntregaPaquetes = new EntregaPaquetes();
            string[] campos = new string[] { "IdEntregaPaquete", "Fecha", "Uba", "Coordinador", "UsuarioCreacion", "FechaCreacion" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];
            string IdCoodinador = "";

            if (((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdPerfil.Value != 1)
            {
                CoordinadorAgentes objCoordinadorAgentes = new CoordinadorAgentes();
                DataTable dtCoordinadores = objCoordinadorAgentes.ObtenerCoordiandoresAgente(objUsuario.IdDocumento);

                foreach (DataRow fila in dtCoordinadores.Rows)
                    IdCoodinador += fila["IdCoordinador"] + ",";

                IdCoodinador = IdCoodinador.Substring(0, IdCoodinador.Length - 1);
            }

            DataTable dtDatos = objEntregaPaquetes.ConsultarEntregaPaquetes(IdCoodinador, orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                string btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""Editar('" + fila[3].ToString() + @"','N'); return false;\"" ></span>&nbsp;&nbsp;<span class='ion-android-delete icono-grid' title='Eliminar' onclick=\""Eliminar('" + fila[3].ToString() + "','" + fila[4].ToString() + @"'); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }

        [WebMethod(EnableSession = true)]
        public static string ActualizarEntregaPaquete(string nuevo, string idEntregaPaquete, string fecha, string idCoordinador, string idUba,
                                                        string nombreArchivoGuid, string fileName)
        {
            EntregaPaquetes objEntregaPaquetes = new EntregaPaquetes();
            RespuestaTO objRespuesta = new RespuestaTO();
            string myJsonString;
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;

            DateTime pFecha;
            pFecha = DateTime.ParseExact(fecha, "dd/MM/yyyy", null);

            try
            {
                if (nuevo == "S")
                {
                    string id = objEntregaPaquetes.InsertarEntregaPaquete(pFecha, idCoordinador, idUba, nombreArchivoGuid, fileName, idUsuarioCreacion);
                    if (!string.IsNullOrEmpty(id))
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = id };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objEntregaPaquetes.Error, tipoMensaje = "Error" };
                }

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod]
        public static string ObtenerEntregaPaquete(string idEntregaPaquete)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                EntregaPaquetes objEntregaPaquetes = new EntregaPaquetes();

                DataTable dtDatos = objEntregaPaquetes.ObtenerEntregaPaquete(idEntregaPaquete);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaEntregaPaquetes = (from DataRow dr in dtDatos.Rows
                                                select new
                                                {
                                                    idEntregaPaquete = dr["IdEntregaPaquete"].ToString(),
                                                    fecha = DateTime.Parse(dr["Fecha"].ToString()).ToString("dd/MM/yyyy"),
                                                    idUba = dr["IdUba"].ToString(),
                                                    idCoordinador = dr["IdCoordinador"].ToString(),
                                                    nombreArchivoGuid = dr["NombreArchivoGuid"].ToString(),
                                                    nombreArchivo = dr["NombreArchivo"].ToString()
                                                }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaEntregaPaquetes);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string EliminarEntregaPaquete(string idEntregaPaquete)
        {
            EntregaPaquetes objEntregaPaquetes = new EntregaPaquetes();
            RespuestaTO objRespuesta;
            string myJsonString;

            try
            {
                bool resp = objEntregaPaquetes.EliminarEntregaPaquete(idEntregaPaquete);
                if (resp)
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se eliminó la entrega de paquetes con código: " + idEntregaPaquete + " satisfactoriamente", tipoMensaje = "Exito" };
                else
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + resp, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        #endregion

        #region Entrega Paquete Detalle

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarEntregaPaquetesDetalle()
        {
            EntregaPaquetesDetalle objEntregaPaquetesDetalle = new EntregaPaquetesDetalle();
            string[] campos = new string[] { "IdEntregaPaqueteDetalle", "NumeroIdentificacion", "NombreParticipante", "CicloVital", "Paquete", "Bienestarina", "Complemento" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];
            string idEntregaPaquete = HttpContext.Current.Request.Params["idEntregaPaquete"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            DataTable dtDatos = objEntregaPaquetesDetalle.ConsultarEntregaPaquetesDetalle(idEntregaPaquete, orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                string btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""$('#framePrincipal')[0].contentWindow.btnAgregar('" + fila[3].ToString() + @"','N'); return false;\"" ></span>&nbsp;&nbsp;<span class='ion-android-delete icono-grid' title='Eliminar' onclick=\""$('#framePrincipal')[0].contentWindow.EliminarParticipante('" + fila[3].ToString() + "','" + fila[5].ToString() + @"'); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }

        [WebMethod(EnableSession = true)]
        public static string ActualizarEntregaPaqueteDetalle(string nuevo, string idEntregaPaqueteDetalle, string idEntregaPaquete, string numeroIdentificacion, string idCicloVital,
                                                    string paquete, string bienestarina, string complemento)
        {
            EntregaPaquetesDetalle objEntregaPaquetesDetalle = new EntregaPaquetesDetalle();
            RespuestaTO objRespuesta;
            string myJsonString;
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;

            try
            {
                if (nuevo == "S")
                {
                    string id = objEntregaPaquetesDetalle.InsertarEntregaPaqueteDetalle(idEntregaPaquete, numeroIdentificacion, idCicloVital,
                                                    paquete, bienestarina, complemento, idUsuarioCreacion);
                    if (!string.IsNullOrEmpty(id))
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = id };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objEntregaPaquetesDetalle.Error, tipoMensaje = "Error" };
                }
                else
                {
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = "" };
                    bool resp = objEntregaPaquetesDetalle.ActualizarEntregaPaqueteDetalle(idEntregaPaqueteDetalle, idEntregaPaquete, numeroIdentificacion,
                                                    idCicloVital, paquete, bienestarina, complemento, idUsuarioCreacion);
                    if (resp)
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se actualizó el participante satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objEntregaPaquetesDetalle.Error, tipoMensaje = "Error" };
                }

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod]
        public static string ObtenerEntregaPaqueteDetalle(string idEntregaPaqueteDetalle)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                EntregaPaquetesDetalle objEntregaPaquetesDetalle = new EntregaPaquetesDetalle();

                DataTable dtDatos = objEntregaPaquetesDetalle.ObtenerEntregaPaqueteDetalle(idEntregaPaqueteDetalle);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaEntregaPaquetesDetalle = (from DataRow dr in dtDatos.Rows
                                                       select new
                                                       {
                                                           idEntregaPaqueteDetalle = dr["IdEntregaPaqueteDetalle"].ToString(),
                                                           idEntregaPaquete = dr["IdEntregaPaquete"].ToString(),
                                                           numeroIdentificacion = dr["NumeroIdentificacion"].ToString(),
                                                           idCicloVital = dr["IdCicloVital"].ToString(),
                                                           paquete = dr["Paquete"].ToString(),
                                                           bienestarina = dr["Bienestarina"].ToString(),
                                                           complemento = dr["Complemento"].ToString()
                                                       }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaEntregaPaquetesDetalle);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string EliminarEntregaPaqueteDetalle(string idEntregaPaqueteDetalle, string nombre)
        {
            EntregaPaquetesDetalle objEntregaPaquetesDetalle = new EntregaPaquetesDetalle();
            RespuestaTO objRespuesta;
            string myJsonString;

            try
            {
                bool resp = objEntregaPaquetesDetalle.EliminarEntregaPaqueteDetalle(idEntregaPaqueteDetalle);
                if (resp)
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se eliminó el participante " + nombre + " satisfactoriamente", tipoMensaje = "Exito" };
                else
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + resp, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        #endregion

        #region Encuentro Educativo

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarEncuentroEducativo()
        {
            EncuentroEducativo objEncuentroEducativo = new EncuentroEducativo();
            string[] campos = new string[] { "IdEncuentroEducativo", "FechaHora", "Tema", "Coordinador", "Sede", "TipoEncuentro", "AgenteEducativo1", "Uba", "UsuarioCreacion", "FechaCreacion" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];
            string IdCoodinador = "";

            if (((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdPerfil.Value != 1)
            {
                CoordinadorAgentes objCoordinadorAgentes = new CoordinadorAgentes();
                DataTable dtCoordinadores = objCoordinadorAgentes.ObtenerCoordiandoresAgente(objUsuario.IdDocumento);

                foreach (DataRow fila in dtCoordinadores.Rows)
                    IdCoodinador += fila["IdCoordinador"] + ",";

                IdCoodinador = IdCoodinador.Substring(0, IdCoodinador.Length - 1);
            }

            DataTable dtDatos = objEncuentroEducativo.ConsultarEncuentroEducativo(IdCoodinador, orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    if (campos[i] == "EEHEfectivo")
                    {
                        string si = (fila[campos[i]].ToString() == "Si") ? "checked='checked'" : "";

                        string checkbox = "<label><input name='" + campos[i] + "' type='checkbox' class='flat-red' style='opacity: 0;'" + si + " ></label>";
                        sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), checkbox);
                    }
                    else
                        sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                string btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""Editar('" + fila[3].ToString() + @"','N'); return false;\"" ></span>&nbsp;&nbsp;<span class='ion-android-delete icono-grid' title='Eliminar' onclick=\""Eliminar('" + fila[3].ToString() + "','" + fila[4].ToString() + @"'); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }

        [WebMethod(EnableSession = true)]
        public static string ActualizarEncuentroEducativo(string nuevo, string idEncuentroEducativo, string idProgramacionActividades, string idTema,
                                                        string nombreArchivoGuid, string fileName)
        {
            EncuentroEducativo objEncuentroEducativo = new EncuentroEducativo();
            RespuestaTO objRespuesta = new RespuestaTO();
            string myJsonString;
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;

            try
            {
                if (nuevo == "S")
                {
                    if (!objEncuentroEducativo.ExisteEncuentroEducativo(idProgramacionActividades))
                    {
                        string id = objEncuentroEducativo.InsertarEncuentroEducativo(idProgramacionActividades, idTema, nombreArchivoGuid, fileName, idUsuarioCreacion);
                        if (!string.IsNullOrEmpty(id))
                            objRespuesta = new RespuestaTO() { resultado = true, mensaje = id };
                        else
                            objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objEncuentroEducativo.Error, tipoMensaje = "Error" };
                    }
                    else
                    {
                        if (string.IsNullOrEmpty(objEncuentroEducativo.Error))
                            objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ya existe un Encuentro Educativo en nuestro sistema para la programación de actividades que intentas ingresar.", tipoMensaje = "Error" };
                        else
                            objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objEncuentroEducativo.Error, tipoMensaje = "Error" };
                    }
                }

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod]
        public static string ObtenerEncuentroEducativo(string idEncuentroEducativo)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                EncuentroEducativo objEncuentroEducativo = new EncuentroEducativo();

                DataTable dtDatos = objEncuentroEducativo.ObtenerEncuentroEducativo(idEncuentroEducativo);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaEncuentroEducativo = (from DataRow dr in dtDatos.Rows
                                                   select new
                                                   {
                                                       idEncuentroEducativo = dr["IdEncuentroEducativo"].ToString(),
                                                       idProgramacionActividades = dr["IdProgramacionActividades"].ToString(),
                                                       idTema = dr["IdTema"].ToString(),
                                                       nombreArchivoGuid = dr["NombreArchivoGuid"].ToString(),
                                                       nombreArchivo = dr["NombreArchivo"].ToString()
                                                   }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaEncuentroEducativo);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string EliminarEncuentroEducativo(string idEncuentroEducativo)
        {
            EncuentroEducativo objEncuentroEducativo = new EncuentroEducativo();
            RespuestaTO objRespuesta;
            string myJsonString;

            try
            {
                bool resp = objEncuentroEducativo.EliminarEncuentroEducativo(idEncuentroEducativo);
                if (resp)
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se eliminó el encuentro educativo con código: " + idEncuentroEducativo + " satisfactoriamente", tipoMensaje = "Exito" };
                else
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + resp, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        #endregion

        #region Encuentro Educativo Detalle

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarEncuentroEducativoDetalle()
        {
            EncuentroEducativoDetalle objEncuentroEducativoDetalle = new EncuentroEducativoDetalle();
            string[] campos = new string[] { "IdEncuentroEducativoDetalle", "NumeroIdentificacion", "NombreParticipante", "CicloVital", "Asistencia", "MotivoInasistencia", "TieneExcusa", "Peso", "Talla", "DXNutricional", "Uba" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];
            string idEncuentroEducativo = HttpContext.Current.Request.Params["idEncuentroEducativo"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            DataTable dtDatos = objEncuentroEducativoDetalle.ConsultarEncuentroEducativoDetalle(idEncuentroEducativo, orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    if (campos[i] == "Asistencia" || campos[i] == "TieneExcusa")
                    {
                        string si = (fila[campos[i]].ToString() == "Si") ? "checked='checked'" : "";

                        string checkbox = "<label><input name='" + campos[i] + "' type='checkbox' class='flat-red' style='opacity: 0;'" + si + " ></label>";
                        sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), checkbox);
                    }
                    else
                        sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                string btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""$('#framePrincipal')[0].contentWindow.btnAgregar('" + fila[3].ToString() + @"','N'); return false;\"" ></span>&nbsp;&nbsp;<span class='ion-android-delete icono-grid' title='Eliminar' onclick=\""$('#framePrincipal')[0].contentWindow.EliminarParticipante('" + fila[3].ToString() + "','" + fila[5].ToString() + @"'); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }

        [WebMethod(EnableSession = true)]
        public static string ActualizarEncuentroEducativoDetalle(string nuevo, string idEncuentroEducativoDetalle, string idEncuentroEducativo, string numeroIdentificacion, string idCicloVital,
                                                    string asistencia, string idMotivoInasistencia, string tieneExcusa, string peso, string talla, string dXNutricional,
                                                    string idLactancia, string idMesLactanciaExclusiva, string idPorqueSinLactancia, string perimetroBraquial, string perimetroCefalico, string observaciones)
        {
            EncuentroEducativoDetalle objEncuentroEducativoDetalle = new EncuentroEducativoDetalle();
            RespuestaTO objRespuesta;
            string myJsonString;
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;

            try
            {
                if (nuevo == "S")
                {
                    if (!objEncuentroEducativoDetalle.ExisteEncuentroEducativoDetalle(idEncuentroEducativo, numeroIdentificacion))
                    {
                        string id = objEncuentroEducativoDetalle.InsertarEncuentroEducativoDetalle(idEncuentroEducativo, numeroIdentificacion, idCicloVital,
                                                    asistencia, idMotivoInasistencia, tieneExcusa, peso, talla, dXNutricional,
                                                    idLactancia, idMesLactanciaExclusiva, idPorqueSinLactancia, perimetroBraquial, perimetroCefalico, observaciones, idUsuarioCreacion);
                        if (!string.IsNullOrEmpty(id))
                            objRespuesta = new RespuestaTO() { resultado = true, mensaje = id };
                        else
                            objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objEncuentroEducativoDetalle.Error, tipoMensaje = "Error" };
                    }
                    else
                    {
                        if (string.IsNullOrEmpty(objEncuentroEducativoDetalle.Error))
                            objRespuesta = new RespuestaTO() { resultado = false, mensaje = "El participante ya existe en nuestro sistema para la programación de actividades que intentas ingresar.", tipoMensaje = "Error" };
                        else
                            objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objEncuentroEducativoDetalle.Error, tipoMensaje = "Error" };
                    }
                }
                else
                {
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = "" };
                    bool resp = objEncuentroEducativoDetalle.ActualizarEncuentroEducativoDetalle(idEncuentroEducativoDetalle, idEncuentroEducativo, numeroIdentificacion, idCicloVital,
                                                    asistencia, idMotivoInasistencia, tieneExcusa, peso, talla, dXNutricional,
                                                    idLactancia, idMesLactanciaExclusiva, idPorqueSinLactancia, perimetroBraquial, perimetroCefalico, observaciones, idUsuarioCreacion);
                    if (resp)
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se actualizó el participante satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objEncuentroEducativoDetalle.Error, tipoMensaje = "Error" };
                }

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string EliminarEncuentroEducativoDetalle(string idEncuentroEducativoDetalle, string nombre)
        {
            EncuentroEducativoDetalle objEncuentroEducativoDetalle = new EncuentroEducativoDetalle();
            RespuestaTO objRespuesta;
            string myJsonString;

            try
            {
                bool resp = objEncuentroEducativoDetalle.EliminarEncuentroEducativoDetalle(idEncuentroEducativoDetalle);
                if (resp)
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se eliminó el participante " + nombre + " satisfactoriamente", tipoMensaje = "Exito" };
                else
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + resp, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod]
        public static string ObtenerEncuentroEducativoDetalle(string idEncuentroEducativoDetalle)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                EncuentroEducativoDetalle objEncuentroEducativoDetalle = new EncuentroEducativoDetalle();

                DataTable dtDatos = objEncuentroEducativoDetalle.ObtenerEncuentroEducativoDetalle(idEncuentroEducativoDetalle);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaEncuentroEducativoDetalle = (from DataRow dr in dtDatos.Rows
                                                          select new
                                                          {
                                                              idEncuentroEducativoDetalle = dr["IdEncuentroEducativoDetalle"].ToString(),
                                                              idEncuentroEducativo = dr["IdEncuentroEducativo"].ToString(),
                                                              numeroIdentificacion = dr["NumeroIdentificacion"].ToString(),
                                                              idCicloVital = dr["IdCicloVital"].ToString(),
                                                              asistencia = dr["Asistencia"].ToString(),
                                                              idMotivoInasistencia = dr["IdMotivoInasistencia"].ToString(),
                                                              tieneExcusa = dr["TieneExcusa"].ToString(),
                                                              peso = dr["Peso"].ToString(),
                                                              talla = dr["Talla"].ToString(),
                                                              dXNutricional = dr["DXNutricional"].ToString(),
                                                              idLactancia = dr["IdLactancia"].ToString(),
                                                              idMesLactanciaExclusiva = dr["IdMesLactanciaExclusiva"].ToString(),
                                                              idPorqueSinLactancia = dr["IdPorqueSinLactancia"].ToString(),
                                                              perimetroBraquial = dr["PerimetroBraquial"].ToString(),
                                                              perimetroCefalico = dr["PerimetroCefalico"].ToString(),
                                                              observaciones = dr["Observaciones"].ToString()
                                                          }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaEncuentroEducativoDetalle);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        #endregion

        #region Encuentro Educativo Hogar

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarEncuentroEducativoHogar()
        {
            EncuentroEducativoHogar objEncuentroEducativoHogar = new EncuentroEducativoHogar();
            string[] campos = new string[] { "IdEncuentroEducativoHogar", "NumeroIdentificacion", "NombreParticipante", "FechaHora", "EEHNumero", "MotivoEEH", "EEHEfectivo", "Coordinador", "UsuarioCreacion", "FechaCreacion" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];
            string IdCoodinador = "";

            if (((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdPerfil.Value != 1)
            {
                CoordinadorAgentes objCoordinadorAgentes = new CoordinadorAgentes();
                DataTable dtCoordinadores = objCoordinadorAgentes.ObtenerCoordiandoresAgente(objUsuario.IdDocumento);

                foreach (DataRow fila in dtCoordinadores.Rows)
                    IdCoodinador += fila["IdCoordinador"] + ",";

                IdCoodinador = IdCoodinador.Substring(0, IdCoodinador.Length - 1);
            }

            DataTable dtDatos = objEncuentroEducativoHogar.ConsultarEncuentroEducativoHogar(IdCoodinador, orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    if (campos[i] == "EEHEfectivo")
                    {
                        string si = (fila[campos[i]].ToString() == "Si") ? "checked='checked'" : "";

                        string checkbox = "<label><input name='" + campos[i] + "' type='checkbox' class='flat-red' style='opacity: 0;'" + si + " ></label>";
                        sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), checkbox);
                    }
                    else
                        sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                string btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""Editar('" + fila[3].ToString() + @"','N'); return false;\"" ></span>&nbsp;&nbsp;<span class='ion-android-delete icono-grid' title='Eliminar' onclick=\""Eliminar('" + fila[3].ToString() + "','" + fila[6].ToString() + @"'); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }

        [WebMethod(EnableSession = true)]
        public static string ActualizarEncuentroEducativoHogar(string nuevo, string idEncuentroEducativoHogar, string numeroIdentificacion, string fechaHora, string idTipoEEH,
                                        string EEHNumero, string idMotivoEEH, string EEHEfectivo, string idMotivoNoEfectivo, string observaciones, string idMatricula,
                                        string idCoordinador)
        {
            EncuentroEducativoHogar objEncuentroEducativoHogar = new EncuentroEducativoHogar();
            RespuestaTO objRespuesta;
            string myJsonString;
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;
            DateTime pFecha = DateTime.ParseExact(fechaHora, "dd/MM/yyyy HH:mm", null);

            try
            {
                if (nuevo == "S")
                {
                    string id = objEncuentroEducativoHogar.InsertarEncuentroEducativoHogar(numeroIdentificacion, pFecha, idTipoEEH, EEHNumero, idMotivoEEH, EEHEfectivo,
                        idMotivoNoEfectivo, observaciones, idMatricula, idCoordinador, idUsuarioCreacion);
                    if (!string.IsNullOrEmpty(id))
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertó el Encuentro Educativo en el Hogar [" + id + "] satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objEncuentroEducativoHogar.Error, tipoMensaje = "Error" };
                }
                else
                {
                    bool resp = objEncuentroEducativoHogar.ActualizarEncuentroEducativoHogar(idEncuentroEducativoHogar, numeroIdentificacion, pFecha, idTipoEEH, EEHNumero, idMotivoEEH, EEHEfectivo,
                            idMotivoNoEfectivo, observaciones, idMatricula, idCoordinador, idUsuarioCreacion);
                    if (resp)
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se actualizó el Encuentro Educativo en el Hogar [" + idEncuentroEducativoHogar + "] satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objEncuentroEducativoHogar.Error, tipoMensaje = "Error" };
                }

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod]
        public static string ObtenerEncuentroEducativoHogar(string idEncuentroEducativoHogar)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                EncuentroEducativoHogar objEncuentroEducativoHogar = new EncuentroEducativoHogar();

                DataTable dtDatos = objEncuentroEducativoHogar.ObtenerEncuentroEducativoHogar(idEncuentroEducativoHogar);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaEncuentroEducativoHogar = (from DataRow dr in dtDatos.Rows
                                                        select new
                                                        {
                                                            idEncuentroEducativoHogar = dr["IdEncuentroEducativoHogar"].ToString(),
                                                            numeroIdentificacion = dr["NumeroIdentificacion"].ToString(),
                                                            fechaHora = DateTime.Parse(dr["FechaHora"].ToString()).ToString("dd/MM/yyyy HH:mm"),
                                                            idTipoEEH = dr["IdTipoEEH"].ToString(),
                                                            EEHNumero = dr["EEHNumero"].ToString(),
                                                            idMotivoEEH = dr["IdMotivoEEH"].ToString(),
                                                            EEHEfectivo = dr["EEHEfectivo"].ToString(),
                                                            idMotivoNoEfectivo = dr["IdMotivoNoEfectivo"].ToString(),
                                                            observaciones = dr["Observaciones"].ToString(),
                                                            idMatricula = dr["IdMatricula"].ToString(),
                                                            idCoordinador = dr["IdCoordinador"].ToString(),
                                                            idUsuarioCreacion = dr["IdUsuarioCreacion"].ToString(),
                                                            fechaCreacion = dr["FechaCreacion"].ToString(),
                                                            idUsuarioModificacion = dr["IdUsuarioModificacion"].ToString(),
                                                            fechaModificacion = dr["FechaModificacion"].ToString()
                                                        }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaEncuentroEducativoHogar);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string EliminarEncuentroEducativoHogar(string idEncuentroEducativoHogar)
        {
            EncuentroEducativoHogar objEncuentroEducativoHogar = new EncuentroEducativoHogar();
            RespuestaTO objRespuesta;
            string myJsonString;

            try
            {
                bool resp = objEncuentroEducativoHogar.EliminarEncuentroEducativoHogar(idEncuentroEducativoHogar);
                if (resp)
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se eliminó el Encuentro Educativo en el Hogar con código " + idEncuentroEducativoHogar + " satisfactoriamente", tipoMensaje = "Exito" };
                else
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + resp, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        #endregion

        #region Personas


        [WebMethod(EnableSession = true)]
        public static PersonasTO ConsultarPersona(string idDocumento)
        {
            Personas objPersona = new Personas();
            DataTable dtPersona = objPersona.ObtenerPersonas(idDocumento);
            List<PersonasTO> lsBen = Utilidades.ToList<PersonasTO>(dtPersona);
            if (lsBen != null && lsBen.Count > 0)
            {
                return lsBen[0];
            }
            return null;
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarDocumentosPersona(string IdDocumento)
        {
            Personas objPersona = new Personas();
            string[] campos = new string[] { "IdArchivoPersona", "TipoDocumento", "NombreArchivo", "UsuarioCreacion", "FechaCreacion" };

            var sb = new StringBuilder();

            DataTable dtDatos = objPersona.ConsultarDocumentosPersona(IdDocumento);
            string outputJson = string.Empty;

            foreach (DataRow fila in dtDatos.Rows)
            {
                sb.Append("{");

                string btnEliminar = @"<input type='image' id='btnEliminar' title='Eliminar documento' alt='Eliminar documento' src='./img/iconos/btn_eliminar.png' style='cursor: pointer; width:25px; height:25px;' />";
                sb.AppendFormat(@"""0"": ""{0}""", btnEliminar);

                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    if (campos[i] == "NombreArchivo")
                    {
                        string linkArchivo = "<a href='Paginas/Operacion/Popups/VerArchivo.aspx?tipoArchivo=DocumentoPersona&id=" + fila["IdArchivoPersona"].ToString() + "&rutaArchivo=" + fila[campos[i]].ToString() + "&Extension=" + fila["Extension"].ToString() + "' target='_blank'>" + fila[campos[i]].ToString() + "</a>";
                        sb.AppendFormat(@"""{0}"": ""{1}""", (i + 1).ToString(), linkArchivo);
                    }
                    else
                        sb.AppendFormat(@"""{0}"": ""{1}""", (i + 1).ToString(), fila[campos[i]].ToString().Replace("\"", "\\\"").Replace(System.Environment.NewLine, ""));
                }

                sb.Append("},");
            }

            if (dtDatos.Rows.Count == 0)
            {
                sb.Append("{");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();
                return outputJson;
            }

            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();
            sb.Append("{");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }


        [WebMethod]
        public static string EliminarDocumentoPersona(string IdArchivoPersona)
        {
            Personas objPersona = new Personas();
            RespuestaTO objRespuesta;
            try
            {
                if (objPersona.EliminarDocumentoPersona(int.Parse(IdArchivoPersona)))
                {
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Archivo eliminado satisfactoriamente", datos = "", tipoMensaje = "Exito" };
                }
                else
                {
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objPersona.Error, tipoMensaje = "Error" };
                }
                string myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                string myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }


        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarAgentes()
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                Usuarios objUsuarios = new Usuarios();

                DataTable dtDatos = objUsuarios.ConsultarAgentes();

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaGeneralidad = (from DataRow dr in dtDatos.Rows
                                            select new
                                            {
                                                idAgente = dr["IdDocumento"].ToString(),
                                                nombre = dr["Nombre"].ToString()
                                            }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaGeneralidad);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        #endregion

        #region Visita Cabeza de Hogar

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarVisitaCabezaHogar()
        {
            VisitaCabezaHogar objVisitaCabezaHogar = new VisitaCabezaHogar();
            string[] campos = new string[] { "IdCabezaHogar", "IdDocumento", "Nombre", "Comuna", "Barrio", "Direccion", "Telefono", "Celular" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];
            string idDocumento = objUsuario.IdDocumento;
            byte idPerfil = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdPerfil.Value;

            DataTable dtDatos = objVisitaCabezaHogar.ConsultarVisitaCabezaHogar(/*idDocumento, idPerfil,*/ orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                //string btnBotones = @"<div style='text-align: center;'><span class='ion-android-open icono-grid' title='Más información' onclick=\""Ver('" + fila["IdDocumento"].ToString() + @"'); return false;\""></span></span>&nbsp;<span class='glyphicon glyphicon-paperclip icono-grid' title='Subir Archivo' onclick=\""SubirArchivo('" + fila["IdDocumento"].ToString() + @"','"+ fila["TipoBeneficiario"].ToString() + @"','"+ fila["TipoDocumento"].ToString() + @"','"+ fila["Nombre"].ToString() + @"'); return false;\"" ></span></div>";
                string btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""Editar('" + fila[4].ToString() + @"',''); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }


        [WebMethod(EnableSession = true)]
        public static string ActualizarVisitaCabezaHogar(string idDocumento, string nuevo, string tipoDocumento, string primerNombre, string segundoNombre,
                                              string primerApellido, string segundoApellido, string fechaNacimiento, string sexo, string comuna, string barrio,
                                              string direccion, string direccionObservaciones, string celular, string telefono,
                                              string nivelEducativo, string tipologiaFamiliar, string tipoSeguridadSocial, string eAPB, string observaciones)

        {
            VisitaCabezaHogar objVisitaCabezaHogar = new VisitaCabezaHogar();
            RespuestaTO objRespuesta;
            string myJsonString;
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;

            DateTime? pFechaNacimiento;
            pFechaNacimiento = (fechaNacimiento != "") ? DateTime.ParseExact(fechaNacimiento, "dd/MM/yyyy", null) : (DateTime?)null;

            try
            {
                if (nuevo == "S")
                {
                    if (objVisitaCabezaHogar.InsertarVisitaCabezaHogar(idDocumento, tipoDocumento, primerNombre, segundoNombre, primerApellido,
                                              segundoApellido, pFechaNacimiento, sexo, comuna, barrio, direccion, direccionObservaciones,
                                              celular, telefono, nivelEducativo, tipologiaFamiliar, tipoSeguridadSocial, eAPB,
                                               observaciones, idUsuarioCreacion, idUsuarioCreacion))

                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertó la cabeza de hogar satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objVisitaCabezaHogar.Error, tipoMensaje = "Error" };
                }
                else
                {
                    if (objVisitaCabezaHogar.ActualizarVisitaCabezaHogar(idDocumento, tipoDocumento, primerNombre, segundoNombre, primerApellido,
                                              segundoApellido, pFechaNacimiento, sexo, comuna, barrio, direccion, direccionObservaciones,
                                              celular, telefono, nivelEducativo, tipologiaFamiliar, tipoSeguridadSocial, eAPB,
                                               observaciones, idUsuarioCreacion))

                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se actualizó la cabeza de hogar satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objVisitaCabezaHogar.Error, tipoMensaje = "Error" };
                }

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        #endregion

        #region Visita

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarVisita()
        {
            Visita objVisita = new Visita();
            string[] campos = new string[] { "IdVisita", "IdDocumento", "Nombre", "DocumentoCabezaHogar", "NombreCabezaHogar", "FechaVisita", "Programa", "Efectiva", "Profesional", "Perfil" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];
            string idDocumento = objUsuario.IdDocumento;
            byte idPerfil = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdPerfil.Value;

            DataTable dtDatos = objVisita.ConsultarVisita(idDocumento, idPerfil, orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                //string btnBotones = @"<div style='text-align: center;'><span class='ion-android-open icono-grid' title='Más información' onclick=\""Ver('" + fila["IdDocumento"].ToString() + @"'); return false;\""></span></span>&nbsp;<span class='glyphicon glyphicon-paperclip icono-grid' title='Subir Archivo' onclick=\""SubirArchivo('" + fila["IdDocumento"].ToString() + @"','"+ fila["TipoBeneficiario"].ToString() + @"','"+ fila["TipoDocumento"].ToString() + @"','"+ fila["Nombre"].ToString() + @"'); return false;\"" ></span></div>";
                string btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""Editar('" + fila[3].ToString() + @"',''); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }

        [WebMethod(EnableSession = true)]
        public static string ActualizarVisita(string idVisita, string nuevo, string documentoCabezaHogar, string idDocumento, string tipoDocumento,
                                              string primerNombre, string segundoNombre, string primerApellido, string segundoApellido,
                                              string fechaNacimiento, string sexo, string celular, string telefono, string fechaVisita, string programa, string actividadVisita,
                                              string efectiva, string enfermeria, string nutricion, string saludBucal, string saludAmbiental, string saludMental,
                                              string spa, string areaSocial, string observaciones)

        {
            Visita objVisita = new Visita();
            RespuestaTO objRespuesta;
            string myJsonString;
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;

            DateTime? pFechaNacimiento, pFechaVisita;
            pFechaNacimiento = (fechaNacimiento != "") ? DateTime.ParseExact(fechaNacimiento, "dd/MM/yyyy", null) : (DateTime?)null;
            pFechaVisita = (fechaVisita != "") ? DateTime.ParseExact(fechaVisita, "dd/MM/yyyy", null) : (DateTime?)null;

            try
            {
                if (nuevo == "S")
                {
                    if (objVisita.InsertarVisita(documentoCabezaHogar, idDocumento, tipoDocumento, primerNombre, segundoNombre, primerApellido,
                                              segundoApellido, pFechaNacimiento, sexo, celular, telefono, pFechaVisita, programa, actividadVisita, efectiva, enfermeria,
                                              nutricion, saludBucal, saludAmbiental, saludMental, spa, areaSocial, observaciones,
                                              idUsuarioCreacion, idUsuarioCreacion))

                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertó la visita satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objVisita.Error, tipoMensaje = "Error" };
                }
                else
                {
                    if (objVisita.ActualizarVisita(idVisita, documentoCabezaHogar, idDocumento, tipoDocumento, primerNombre, segundoNombre, primerApellido,
                                              segundoApellido, pFechaNacimiento, sexo, celular, telefono, pFechaVisita, programa, actividadVisita, efectiva, enfermeria,
                                              nutricion, saludBucal, saludAmbiental, saludMental, spa, areaSocial, observaciones,
                                              idUsuarioCreacion))

                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se actualizó la visita satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objVisita.Error, tipoMensaje = "Error" };
                }

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static VisitaCabezaHogarTO ConsultarCabezaHogar(string idDocumento)
        {
            Visita objVisita = new Visita();
            DataTable dtCabezaHogar = objVisita.ObtenerCabezaHogar(idDocumento);
            List<VisitaCabezaHogarTO> lsBen = Utilidades.ToList<VisitaCabezaHogarTO>(dtCabezaHogar);
            if (lsBen != null && lsBen.Count > 0)
            {
                return lsBen[0];
            }
            return null;
        }

        #endregion

        #region Visita Priorizada

        [WebMethod(EnableSession = true)]
        public static string ActualizarVisitaPriorizada(int idVisitaPriorizada, string idDocumento, string Fecha, int IdMaeVisitaPrioritaria, string IdDXCIE10,
            string HaConsumidoBebidasAlcoholicasTabacoAlgunaVezVida, string EdadPrimerConsumo, string HaConsumidoAlgunOtroTipoSustanciaAlteraEstadoAnimoConciencia,
            string HaVueltoAConsumir, string ConQueFrecuencia, string PresentaIdeasRecurrentesDeseoMorirQuitarseLaVida, string EnFamiliaOCirculoCercanoHaMuertoPorSuicidio,
            string PresentaSintomasDepresion, string AlgunaVezHaTenidoIntentoSuicidio, string TuvoIntentoSuicidioReciente, string FueAtendidoEnUrgenicasPorIntentoSuicidioReciente,
            string OyeVocesSinSaberDondeVienenOQueOtrasPersonasNoPuedenOir, string EsVictimaConflictoArmado, string AlgunaVezHaRecibidoAtencionPsicosocialEnSaludMentalPorSerVictima,
            string PresentaOHaPresentadoUltimoMesAlgunSintoma, string AlInteriorGrupoFamiliarAlgunMiembro, string Observaciones, string HabilidadesParaLaVida, string TipoOrientacion,
            string SeguimientoIntervenciones, string Desarrollo, string Logros, string FechaIntervencionBreve)

        {
            VisitaPriorizada visitaPriorizada;
            RespuestaTO objRespuesta = null;
            string myJsonString;
            string idUsuarioCreacion;
            DateTime? pFecha;
            DateTime? pFechaIntervencionBreve;
            int intError = 0;
            string strError = "";

            try
            {
                visitaPriorizada = new VisitaPriorizada();
                pFecha = (Fecha != "") ? DateTime.ParseExact(Fecha, "dd/MM/yyyy", null) : (DateTime?)null;
                pFechaIntervencionBreve = (FechaIntervencionBreve != "") ? DateTime.ParseExact(FechaIntervencionBreve, "dd/MM/yyyy", null) : (DateTime?)null;
                idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;

                if (idVisitaPriorizada == -1)
                {
                    idVisitaPriorizada = visitaPriorizada.Insertar(idDocumento, pFecha, IdMaeVisitaPrioritaria, IdDXCIE10,
                    HaConsumidoBebidasAlcoholicasTabacoAlgunaVezVida, EdadPrimerConsumo, HaConsumidoAlgunOtroTipoSustanciaAlteraEstadoAnimoConciencia,
                    HaVueltoAConsumir, ConQueFrecuencia, PresentaIdeasRecurrentesDeseoMorirQuitarseLaVida, EnFamiliaOCirculoCercanoHaMuertoPorSuicidio,
                    PresentaSintomasDepresion, AlgunaVezHaTenidoIntentoSuicidio, TuvoIntentoSuicidioReciente, FueAtendidoEnUrgenicasPorIntentoSuicidioReciente,
                    OyeVocesSinSaberDondeVienenOQueOtrasPersonasNoPuedenOir, EsVictimaConflictoArmado, AlgunaVezHaRecibidoAtencionPsicosocialEnSaludMentalPorSerVictima,
                    PresentaOHaPresentadoUltimoMesAlgunSintoma, AlInteriorGrupoFamiliarAlgunMiembro, Observaciones, HabilidadesParaLaVida,
                    TipoOrientacion, SeguimientoIntervenciones, Desarrollo, Logros, pFechaIntervencionBreve, idUsuarioCreacion, ref intError, ref strError);

                    if (idVisitaPriorizada != 0)
                    {
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertó la visita priorizada satisfactoriamente", tipoMensaje = "Exito", datos = idVisitaPriorizada.ToString(), code = (int)RespuestaTO.ErrorCodeResponse.QueryOK };
                    }
                    else
                    {
                        if (intError == -999)
                        {
                            strError = "Ya existe una visita priorizada para este documento";
                        }
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Error al insertar el registro. Error: " + strError, tipoMensaje = "Error", datos = idVisitaPriorizada.ToString(), code = intError };
                    }
                }
                else
                {
                    if (visitaPriorizada.Actualizar(idVisitaPriorizada, idDocumento, pFecha, IdMaeVisitaPrioritaria, IdDXCIE10,
                    HaConsumidoBebidasAlcoholicasTabacoAlgunaVezVida, EdadPrimerConsumo, HaConsumidoAlgunOtroTipoSustanciaAlteraEstadoAnimoConciencia,
                    HaVueltoAConsumir, ConQueFrecuencia, PresentaIdeasRecurrentesDeseoMorirQuitarseLaVida, EnFamiliaOCirculoCercanoHaMuertoPorSuicidio,
                    PresentaSintomasDepresion, AlgunaVezHaTenidoIntentoSuicidio, TuvoIntentoSuicidioReciente, FueAtendidoEnUrgenicasPorIntentoSuicidioReciente,
                    OyeVocesSinSaberDondeVienenOQueOtrasPersonasNoPuedenOir, EsVictimaConflictoArmado, AlgunaVezHaRecibidoAtencionPsicosocialEnSaludMentalPorSerVictima,
                    PresentaOHaPresentadoUltimoMesAlgunSintoma, AlInteriorGrupoFamiliarAlgunMiembro, Observaciones, HabilidadesParaLaVida,
                    TipoOrientacion, SeguimientoIntervenciones, Desarrollo, Logros, pFechaIntervencionBreve, idUsuarioCreacion, ref intError, ref strError) != 0)
                    {
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se actualizó la visita priorizada satisfactoriamente", tipoMensaje = "Exito", datos = idVisitaPriorizada.ToString(), code = (int)RespuestaTO.ErrorCodeResponse.QueryOK };
                    }
                    else
                    {
                        if (intError == -999)
                        {
                            strError = "Error al actualizar, El documento ya existe ";
                            objRespuesta = new RespuestaTO() { resultado = false, mensaje = strError, tipoMensaje = "Error", datos = idVisitaPriorizada.ToString(), code = (int)RespuestaTO.ErrorCodeResponse.QueryError };
                        }
                        else
                        {
                            objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + strError, tipoMensaje = "Error", datos = idVisitaPriorizada.ToString() };
                        }
                    }
                }
                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                BuenComienzo.Loggin.Logger.Error("webMethods.ActualizarVisitaPriorizada Error: " + ex.Message);
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarVisitaPriorizada()
        {
            VisitaPriorizada objVisitaPrioritaria = new VisitaPriorizada();
            string[] campos = new string[] { "IdVisitaPriorizada", "Fecha", "IdDocumento", "Nombre", "TipoVisitaPriorizada", "ProfesionalEncargado" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];
            string idUsuario = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? "[" + campos[i] + "]" + " LIKE " : " OR " + "[" + campos[i] + "]" + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = "[" + campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + "] " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            DataTable dtDatos = objVisitaPrioritaria.ConsultarVisitasPriorizadas(orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;
            if (dtDatos != null)
            {
                foreach (DataRow fila in dtDatos.Rows)
                {
                    if (totalRecords.Length == 0)
                    {
                        totalRecords = fila["TotalRows"].ToString();
                        totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                    }

                    sb.Append("{");
                    sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                    sb.Append(",");
                    sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                    sb.Append(",");

                    for (int i = 0; i < campos.Length; i++)
                    {
                        if (i != 0)
                            sb.Append(",");

                        sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\"").Replace("\r\n", " ").Replace("\r", " ")
                  .Replace("\n", " ")
                  .Replace("\\", "\\\\")
                  .Replace("\"", "\\\"")); ;
                    }

                    sb.Append(",");

                    //string btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""Editar('" + fila["IdActivacionRuta"].ToString() + @"','N'); return false;\"" ></span> <span class='ion-android-delete icono-grid' title='Eliminar' onclick=\""EliminarCaracterizacion('" + fila["IdActivacionRuta"].ToString() + @"'); return false;\"" ></span></div>";
                    string btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""Editar('" + fila["IdVisitaPriorizada"].ToString() + @"','N'); return false;\"" ></div>";

                    sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                    sb.Append("},");
                }
            }
            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }

        #endregion

        #region EAPB

        [WebMethod]
        public static string ObtenerEAPB(string idTipoAseguramiento)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                EAPB objEAPB = new EAPB();

                DataTable dtDatos = objEAPB.ObtenerEAPB(idTipoAseguramiento);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaEAPB = (from DataRow dr in dtDatos.Rows
                                     select new
                                     {
                                         idMaeEAPB = dr["IdMaeEAPB"].ToString(),
                                         nombreEapb = dr["NombreEapb"].ToString(),
                                     }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaEAPB);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }

        #endregion

        #region Session

        [WebMethod(EnableSession = true)]
        public static string getSession(int id)
        {
            string myJsonString;
            RespuestaTO objRespuesta;
            try
            {
                string idUsuarioActual = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;
                //throw new Exception("Error");
                objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Session Activa. Id Usuario:" + idUsuarioActual, tipoMensaje = "", code = (int)RespuestaTO.ErrorCodeResponse.Session_OK };
                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;

            }
            catch (Exception ex)
            {
                BuenComienzo.Loggin.Logger.Error("WebMethods.getSession Error: " + ex.Message);
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Session Expired ", tipoMensaje = "Error", code = (int)RespuestaTO.ErrorCodeResponse.Session_Expired };
                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        #endregion

        #region Orientación a servicios

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarOrientacionServicio()
        {
            OrientacionServicio objOrientacionServicio= new OrientacionServicio();
            string[] campos = new string[] { "IdOrientacionServicio", "NumeroIdentificacion", "NombreParticipante", "Fecha", "MotivoOrientacion", "Coordinador", "UsuarioCreacion", "FechaCreacion" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];
            string IdCoodinador = "";

            if (((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdPerfil.Value != 1)
            {
                CoordinadorAgentes objCoordinadorAgentes = new CoordinadorAgentes();
                DataTable dtCoordinadores = objCoordinadorAgentes.ObtenerCoordiandoresAgente(objUsuario.IdDocumento);

                foreach (DataRow fila in dtCoordinadores.Rows)
                    IdCoodinador += fila["IdCoordinador"] + ",";

                IdCoodinador = IdCoodinador.Substring(0, IdCoodinador.Length - 1);
            }

            DataTable dtDatos = objOrientacionServicio.ConsultarOrientacionServicio(IdCoodinador, orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                string btnBotones = @"<div style='text-align: center;'><span class='ion-edit icono-grid' title='Editar' onclick=\""Editar('" + fila[3].ToString() + @"','N'); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }


        [WebMethod(EnableSession = true)]
        public static string ActualizarOrientacionServicio(string nuevo, string idOrientacionServicio, string numeroIdentificacion, string fechaHora, string numeroIdentificacionCuidador,
                                        string nombreCuidador, string celularCuidador, string idTipoOS, string lugarRemite, string observaciones, string idMatricula, 
                                        string nombreArchivoGuid, string fileName, string fechaPrimerSeguimiento, string observacionPrimerSeguimiento, 
                                        string fechaSegundoSeguimiento, string observacionSegundoSeguimiento, string orientacionCerrada)
        {
            OrientacionServicio objOrientacionServicio = new OrientacionServicio();
            RespuestaTO objRespuesta;
            string myJsonString;
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;
            DateTime pFecha = DateTime.ParseExact(fechaHora, "dd/MM/yyyy HH:mm", null);            

            try
            {
                if (nuevo == "S")
                {
                    string id = objOrientacionServicio.InsertarOrientacionServicio(numeroIdentificacion, pFecha, numeroIdentificacionCuidador, nombreCuidador, celularCuidador, idTipoOS,
                        lugarRemite, observaciones, idMatricula, nombreArchivoGuid, fileName, orientacionCerrada, idUsuarioCreacion);
                    if (!string.IsNullOrEmpty(id))
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se insertó la orientación a servicio [" + id + "] satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objOrientacionServicio.Error, tipoMensaje = "Error" };
                }
                else
                {
                    DateTime pFechaPrimerSeguimiento = DateTime.ParseExact(fechaPrimerSeguimiento, "dd/MM/yyyy HH:mm", null);
                    DateTime pFechaSegundoSeguimiento = DateTime.ParseExact(fechaSegundoSeguimiento, "dd/MM/yyyy HH:mm", null);
                    bool resp = objOrientacionServicio.ActualizarOrientacionServicio(idOrientacionServicio, nombreArchivoGuid, fileName, pFechaPrimerSeguimiento, 
                        observacionPrimerSeguimiento, pFechaSegundoSeguimiento, observacionSegundoSeguimiento, orientacionCerrada, idUsuarioCreacion);
                    if (resp)
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se actualizó la orientación a servicio [" + idOrientacionServicio + "] satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objOrientacionServicio.Error, tipoMensaje = "Error" };
                }

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod]
        public static string ObtenerOrientacionServicio(string idOrientacionServicio)
        {
            RespuestaTO objRespuesta = new RespuestaTO();
            try
            {
                OrientacionServicio objOrientacionServicio = new OrientacionServicio();

                DataTable dtDatos = objOrientacionServicio.ObtenerOrientacionServicio(idOrientacionServicio);

                if (dtDatos.Rows.Count > 0)
                {
                    objRespuesta.resultado = true;

                    var listaOrientacionServicio = (from DataRow dr in dtDatos.Rows
                                                        select new
                                                        {
                                                            idOrientacionServicio = dr["IdOrientacionServicio"].ToString(),
                                                            numeroIdentificacion = dr["NumeroIdentificacion"].ToString(),
                                                            fechaHora = DateTime.Parse(dr["FechaHora"].ToString()).ToString("dd/MM/yyyy HH:mm"),
                                                            numeroIdentificacionCuidador = dr["IdentificacionCuidador"].ToString(),
                                                            nombreCuidador = dr["NombreCuidador"].ToString(),
                                                            celularCuidador = dr["CelularCuidador"].ToString(),
                                                            idTipoOS = dr["IdMotivoOrientacionServicio"].ToString(),
                                                            lugarRemite = dr["LugarRemite"].ToString(),
                                                            observaciones = dr["Observaciones"].ToString(),
                                                            idMatricula = dr["IdMatricula"].ToString(),
                                                            nombreArchivoGuid = dr["NombreArchivoGuid"].ToString(),
                                                            nombreArchivo = dr["NombreArchivo"].ToString(),
                                                            fechaPrimerSeguimiento = DateTime.Parse(dr["FechaPrimerSeguimiento"].ToString()).ToString("dd/MM/yyyy HH:mm"),
                                                            observacionPrimerSeguimiento = dr["ObservacionPrimerSeguimiento"].ToString(),
                                                            fechaSegundoSeguimiento = DateTime.Parse(dr["FechaSegundoSeguimiento"].ToString()).ToString("dd/MM/yyyy HH:mm"),
                                                            observacionSegundoSeguimiento = dr["ObservacionSegundoSeguimiento"].ToString(),
                                                            orientacionCerrada = dr["OrientacionCerrada"].ToString(),
                                                            idUsuarioCreacion = dr["IdUsuarioCreacion"].ToString(),
                                                            fechaCreacion = dr["FechaCreacion"].ToString(),
                                                            idUsuarioModificacion = dr["IdUsuarioModificacion"].ToString(),
                                                            fechaModificacion = dr["FechaModificacion"].ToString()
                                                        }).ToList();

                    objRespuesta.mensaje = JsonConvert.SerializeObject(listaOrientacionServicio);
                }
                string resultado = JsonConvert.SerializeObject(objRespuesta);
                return resultado;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };
                objRespuesta.resultado = false;

                string resultado = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return resultado;
            }
        }


        #endregion

        #region Remisión Interna

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarRemisionInterna()
        {
            RemisionInterna objRemisionInterna = new RemisionInterna();
            string[] campos = new string[] { "IdRemisionInterna", "NumeroIdentificacion", "NombreParticipante", "FechaHora", "MotivoRemision", "Observacion", "ProfesionalRemite", "ProfesionalAQuienRemite" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];
            string IdProfesional = objUsuario.IdDocumento ;
            string IdCoodinador = "";

            if (((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdPerfil.Value != 1)
            {
                CoordinadorAgentes objCoordinadorAgentes = new CoordinadorAgentes();
                DataTable dtCoordinadores = objCoordinadorAgentes.ObtenerCoordiandoresAgente(objUsuario.IdDocumento);

                foreach (DataRow fila in dtCoordinadores.Rows)
                    IdCoodinador += fila["IdCoordinador"] + ",";

                IdCoodinador = IdCoodinador.Substring(0, IdCoodinador.Length - 1);
            }

            DataTable dtDatos = objRemisionInterna.ConsultarRemisionInterna(IdCoodinador, IdProfesional, orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    if (campos[i] == "EEHEfectivo")
                    {
                        string si = (fila[campos[i]].ToString() == "Si") ? "checked='checked'" : "";

                        string checkbox = "<label><input name='" + campos[i] + "' type='checkbox' class='flat-red' style='opacity: 0;'" + si + " ></label>";
                        sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), checkbox);
                    }
                    else
                        sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                string btnBotones = @"<div style='text-align: center;'><span class='ion-android-delete icono-grid' title='Eliminar' onclick=\""Eliminar('" + fila[3].ToString() + @"','N'); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }

        [WebMethod(EnableSession = true)]
        public static string ActualizarRemisionInterna(string nuevo, string numeroIdentificacion, string idMotivoRemisionInterna, string idProfesionalRemision,
                                        string observacion, string idMatricula, string idCoordinador)
        {
            RemisionInterna objRemisionInterna = new RemisionInterna();
            RespuestaTO objRespuesta = null;
            string myJsonString;
            string idUsuarioCreacion = ((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdDocumento;

            try
            {
                if (nuevo == "S")
                {
                    string id = objRemisionInterna.InsertarRemisionInterna(numeroIdentificacion, idMotivoRemisionInterna, idProfesionalRemision, observacion, idMatricula,
                        idCoordinador, idUsuarioCreacion);
                    if (!string.IsNullOrEmpty(id))
                        objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se creó la remisión interna [" + id + "] satisfactoriamente", tipoMensaje = "Exito" };
                    else
                        objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + objRemisionInterna.Error, tipoMensaje = "Error" };
                }                

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;

            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        public static string EliminarRemisionInterna(string idRemisionInterna)
        {
            RemisionInterna objRemisionInterna = new RemisionInterna();
            RespuestaTO objRespuesta;
            string myJsonString;

            try
            {
                bool resp = objRemisionInterna.EliminarRemisionInterna(idRemisionInterna);
                if (resp)
                    objRespuesta = new RespuestaTO() { resultado = true, mensaje = "Se eliminó la remisión interna con código " + idRemisionInterna + " satisfactoriamente", tipoMensaje = "Exito" };
                else
                    objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + resp, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
            catch (Exception ex)
            {
                objRespuesta = new RespuestaTO() { resultado = false, mensaje = "Ha ocurrido un error inseperado. " + ex.Message, tipoMensaje = "Error" };

                myJsonString = (new JavaScriptSerializer()).Serialize(objRespuesta);
                return myJsonString;
            }
        }

        [WebMethod(EnableSession = true)]
        [ScriptMethod(UseHttpGet = true)]
        public static string ConsultarRemisionesPendientes()
        {
            RemisionInterna objRemisionInterna = new RemisionInterna();
            string[] campos = new string[] { "IdRemisionInterna", "NumeroIdentificacion", "NombreParticipante", "CicloVital", "Uba", "Celular", "Telefono", "Direccion", "BarrioResidencia", "FechaHora", "MotivoRemision", "Observacion", "ProfesionalRemite" };
            int sEcho = Utilidades.ToInt(HttpContext.Current.Request.Params["sEcho"]);
            int iDisplayLength = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayLength"]);
            int iDisplayStart = Utilidades.ToInt(HttpContext.Current.Request.Params["iDisplayStart"]);
            string rawSearch = HttpContext.Current.Request.Params["sSearch"];

            var sb = new StringBuilder();
            var filteredWhere = string.Empty;
            var wrappedSearch = "'%" + rawSearch + "%'";

            if (!string.IsNullOrEmpty(rawSearch) && rawSearch.Length > 0)
            {
                sb.Append(" WHERE ");
                for (int i = 0; i < campos.Length; i++)
                {
                    sb.Append((i == 0) ? campos[i] + " LIKE " : " OR " + campos[i] + " LIKE ");
                    sb.Append(wrappedSearch);
                }

                filteredWhere = sb.ToString();
            }

            string orderByClause = campos[(Utilidades.ToInt(HttpContext.Current.Request.Params["iSortCol_0"]))] + " " + HttpContext.Current.Request.Params["sSortDir_0"];

            sb.Clear();

            var numberOfRowsToReturn = "";
            numberOfRowsToReturn = iDisplayLength == -1 ? "TotalRows" : (iDisplayStart + iDisplayLength).ToString();

            UsuarioTO objUsuario = (UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario];
            string IdProfesional = objUsuario.IdDocumento;
            string IdCoodinador = "";

            if (((UsuarioTO)HttpContext.Current.Session[VariablesSession.DatosUsuario]).IdPerfil.Value != 1)
            {
                CoordinadorAgentes objCoordinadorAgentes = new CoordinadorAgentes();
                DataTable dtCoordinadores = objCoordinadorAgentes.ObtenerCoordiandoresAgente(objUsuario.IdDocumento);

                foreach (DataRow fila in dtCoordinadores.Rows)
                    IdCoodinador += fila["IdCoordinador"] + ",";

                IdCoodinador = IdCoodinador.Substring(0, IdCoodinador.Length - 1);
            }

            DataTable dtDatos = objRemisionInterna.ConsultarRemisionesPendientes(IdCoodinador, IdProfesional, orderByClause, filteredWhere, iDisplayStart, numberOfRowsToReturn);

            var totalDisplayRecords = "";
            var totalRecords = "";
            string outputJson = string.Empty;

            var rowClass = "";
            var count = 0;

            foreach (DataRow fila in dtDatos.Rows)
            {
                if (totalRecords.Length == 0)
                {
                    totalRecords = fila["TotalRows"].ToString();
                    totalDisplayRecords = fila["TotalDisplayRows"].ToString();
                }

                sb.Append("{");
                sb.AppendFormat(@"""DT_RowId"": ""{0}""", count++);
                sb.Append(",");
                sb.AppendFormat(@"""DT_RowClass"": ""{0}""", rowClass);
                sb.Append(",");

                for (int i = 0; i < campos.Length; i++)
                {
                    if (i != 0)
                        sb.Append(",");

                    if (campos[i] == "EEHEfectivo")
                    {
                        string si = (fila[campos[i]].ToString() == "Si") ? "checked='checked'" : "";

                        string checkbox = "<label><input name='" + campos[i] + "' type='checkbox' class='flat-red' style='opacity: 0;'" + si + " ></label>";
                        sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), checkbox);
                    }
                    else
                        sb.AppendFormat(@"""{0}"": ""{1}""", i.ToString(), fila[campos[i]].ToString().Replace("\"", "\\\""));
                }

                sb.Append(",");

                string btnBotones = @"<div style='text-align: center;'><span class='ion-android-delete icono-grid' title='Eliminar' onclick=\""Eliminar('" + fila[4].ToString() + @"','N'); return false;\"" ></span></div>";

                sb.AppendFormat(@"""{0}"": ""{1}""", campos.Length, btnBotones);

                sb.Append("},");
            }

            // handles zero records
            if (totalRecords.Length == 0)
            {
                sb.Append("{");
                sb.Append(@"""sEcho"": ");
                sb.AppendFormat(@"""{0}""", sEcho);
                sb.Append(",");
                sb.Append(@"""iTotalRecords"": 0");
                sb.Append(",");
                sb.Append(@"""iTotalDisplayRecords"": 0");
                sb.Append(", ");
                sb.Append(@"""aaData"": [ ");
                sb.Append("]}");
                outputJson = sb.ToString();

                return outputJson;
            }
            outputJson = sb.Remove(sb.Length - 1, 1).ToString();
            sb.Clear();

            sb.Append("{");
            sb.Append(@"""sEcho"": ");
            sb.AppendFormat(@"""{0}""", sEcho);
            sb.Append(",");
            sb.Append(@"""iTotalRecords"": ");
            sb.Append(totalRecords);
            sb.Append(",");
            sb.Append(@"""iTotalDisplayRecords"": ");
            sb.Append(totalDisplayRecords);
            sb.Append(", ");
            sb.Append(@"""aaData"": [ ");
            sb.Append(outputJson);
            sb.Append("]}");
            outputJson = sb.ToString();

            return outputJson;
        }

        #endregion

    }
}