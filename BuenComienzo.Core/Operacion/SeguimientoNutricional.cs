using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BuenComienzo.AccesoDatos;
using System.Data;
using BuenComienzo.Core.Administracion.To;
using System.Web.UI.WebControls;

namespace BuenComienzo.Core.Operacion
{
    public class SeguimientoNutricional
    {

        private string strError;
        List<Parametro> parametros;
        AccesoDatosSQL objBd = new AccesoDatosSQL();

        public string Error
        {
            get
            {
                return strError;
            }
        }

        public DataTable ConsultarSeguimientoNutricional(string idCoordinador, string ordenar, string where, int desde, string hasta)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Ordenar", Valor = ordenar, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Where", Valor = where, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Desde", Valor = (desde + 1).ToString(), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Hasta", Valor = hasta, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_SEGUIMIENTONUTRICIONAL", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public string InsertarSeguimientoNutricional(string numeroIdentificacion, DateTime fechaHora,
                                                    string idTipoAtencion, string idCicloVital, string peso, string talla, string perimetroBraquial,
                                                    string desviacionEstandar, string IMC, string dXNutricional, string dXEnfermedadBase, string enfermedades,
                                                    string signosFisicosCarenciales, string idInseguridadAlimentaria, string idAccesoServiciosPublicos,
                                                    string idAccesoServiciosSalud, string condicionesVivienda, string aspectosPsicosocialesVulneracionDerechos,
                                                    string idLactanciaMaterna, string accionesRealizadas, string idMatricula, string idCoordinador, string idUsuarioCreacion)
        {
            try
            {
                Object resp;
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaHora", Valor = fechaHora, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdTipoAtencion", Valor = idTipoAtencion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdCicloVital", Valor = string.IsNullOrEmpty(idCicloVital) ? null : idCicloVital, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Peso", Valor = string.IsNullOrEmpty(peso) ? null : peso.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Talla", Valor = string.IsNullOrEmpty(talla) ? null : talla.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@PerimetroBraquial", Valor = string.IsNullOrEmpty(perimetroBraquial) ? null : perimetroBraquial.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@DesviacionEstandar", Valor = string.IsNullOrEmpty(desviacionEstandar) ? null : desviacionEstandar.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IMC", Valor = string.IsNullOrEmpty(IMC) ? null : IMC.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@DXNutricional", Valor = string.IsNullOrEmpty(dXNutricional) ? null : dXNutricional, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@DXEnfermedadBase", Valor = dXEnfermedadBase, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Enfermedades", Valor = string.IsNullOrEmpty(enfermedades) ? null : enfermedades, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@SignosFisicosCarenciales", Valor = signosFisicosCarenciales, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdInseguridadAlimentaria", Valor = idInseguridadAlimentaria, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdAccesoServiciosPublicos", Valor = idAccesoServiciosPublicos, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdAccesoServiciosSalud", Valor = idAccesoServiciosSalud, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@CondicionesVivienda", Valor = condicionesVivienda, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@AspectosPsicosocialesVulneracionDerechos", Valor = aspectosPsicosocialesVulneracionDerechos, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdLactanciaMaterna", Valor = string.IsNullOrEmpty(idLactanciaMaterna) ? null : idLactanciaMaterna, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@AccionesRealizadas", Valor = accionesRealizadas, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdMatricula", Valor = idMatricula, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdCoordinador", Valor = idCoordinador, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUsuarioCreacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaCreacion", Valor = fechaCreacion, Tipo = typeof(DateTime) },
                };

                resp = objBd.ejecutarProcedimiento("dbop_AddTBL_SEGUIMIENTONUTRICIONAL", parametros, "IdSeguimientoNutricional", DbType.Int32, 10);
                return resp.ToString();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool ActualizarSeguimientoNutricional(string idSeguimientoNutricional, string numeroIdentificacion, DateTime fechaHora,
                                                    string idTipoAtencion, string idCicloVital, string peso, string talla, string perimetroBraquial,
                                                    string desviacionEstandar, string IMC, string dXNutricional, string dXEnfermedadBase, string enfermedades,
                                                    string signosFisicosCarenciales, string idInseguridadAlimentaria, string idAccesoServiciosPublicos,
                                                    string idAccesoServiciosSalud, string condicionesVivienda, string aspectosPsicosocialesVulneracionDerechos,
                                                    string idLactanciaMaterna, string accionesRealizadas, string idUsuarioCreacion)
        {
            try
            {
                Object resp;
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdSeguimientoNutricional", Valor = (idSeguimientoNutricional), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaHora", Valor = fechaHora, Tipo = typeof(DateTime) },
                    new Parametro { NombreParametro = "@IdTipoAtencion", Valor = idTipoAtencion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdCicloVital", Valor = string.IsNullOrEmpty(idCicloVital) ? null : idCicloVital, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Peso", Valor = string.IsNullOrEmpty(peso) ? null : peso.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Talla", Valor = string.IsNullOrEmpty(talla) ? null : talla.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@PerimetroBraquial", Valor = string.IsNullOrEmpty(perimetroBraquial) ? null : perimetroBraquial.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@DesviacionEstandar", Valor = string.IsNullOrEmpty(desviacionEstandar) ? null : desviacionEstandar.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IMC", Valor = string.IsNullOrEmpty(IMC) ? null : IMC.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@DXNutricional", Valor = string.IsNullOrEmpty(dXNutricional) ? null : dXNutricional, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@DXEnfermedadBase", Valor = dXEnfermedadBase, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Enfermedades", Valor = string.IsNullOrEmpty(enfermedades) ? null : enfermedades, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@SignosFisicosCarenciales", Valor = signosFisicosCarenciales, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdInseguridadAlimentaria", Valor = idInseguridadAlimentaria, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdAccesoServiciosPublicos", Valor = idAccesoServiciosPublicos, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdAccesoServiciosSalud", Valor = idAccesoServiciosSalud, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@CondicionesVivienda", Valor = condicionesVivienda, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@AspectosPsicosocialesVulneracionDerechos", Valor = aspectosPsicosocialesVulneracionDerechos, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdLactanciaMaterna", Valor = string.IsNullOrEmpty(idLactanciaMaterna) ? null : idLactanciaMaterna, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@AccionesRealizadas", Valor = accionesRealizadas, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@IdUsuarioModificacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@FechaModificacion", Valor = fechaCreacion, Tipo = typeof(DateTime) },
                };

                objBd.ejecutarProcedimiento("dbop_UpdateTBL_SEGUIMIENTONUTRICIONAL", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public DataTable ObtenerSeguimientoNutricional(string idSeguimientoNutricional)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdSeguimientoNutricional", Valor = (idSeguimientoNutricional), Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_SEGUIMIENTONUTRICIONAL", parametros).Tables[0];

                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool EliminarSeguimientoNutricional(string idSeguimientoNutricional)
        {
            try
            {
                Object resp;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdSeguimientoNutricional", Valor = idSeguimientoNutricional, Tipo = typeof(string) },
                };

                resp = objBd.ejecutarProcedimiento("dbop_DeleteTBL_SEGUIMIENTONUTRICIONAL", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }
    }
}
