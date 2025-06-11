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
    public class EncuentroEducativoDetalle
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

        public DataTable ConsultarEncuentroEducativoDetalle(string idEncuentroEducativo, string ordenar, string where, int desde, string hasta)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdEncuentroEducativo", Valor = idEncuentroEducativo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Ordenar", Valor = ordenar, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Where", Valor = where, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Desde", Valor = (desde + 1).ToString(), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Hasta", Valor = hasta, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_ENCUENTROEDUCATIVODETALLE", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ObtenerEncuentroEducativoDetalle(string idEncuentroEducativoDetalle)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdEncuentroEducativoDetalle", Valor = idEncuentroEducativoDetalle, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_ENCUENTROEDUCATIVODETALLE", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public string InsertarEncuentroEducativoDetalle(string idEncuentroEducativo, string numeroIdentificacion, string idCicloVital,
                                                    string asistencia, string idMotivoInasistencia, string tieneExcusa, string peso, string talla, string dXNutricional,
                                                    string idLactancia, string idMesLactanciaExclusiva, string idPorqueSinLactancia, string perimetroBraquial, 
                                                    string perimetroCefalico, string observaciones, string idUsuarioCreacion)
        {
            try
            {
                Object resp;
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "IdEncuentroEducativo", Valor = idEncuentroEducativo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "IdCicloVital", Valor = idCicloVital, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "Asistencia", Valor = asistencia, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "IdMotivoInasistencia", Valor = string.IsNullOrEmpty(idMotivoInasistencia) ? null : idMotivoInasistencia, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "TieneExcusa", Valor = tieneExcusa, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "Peso", Valor = string.IsNullOrEmpty(peso) ? null : peso.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "Talla", Valor = string.IsNullOrEmpty(talla) ? null : talla.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "DXNutricional", Valor = string.IsNullOrEmpty(dXNutricional) ? null : dXNutricional, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "IdLactancia", Valor = string.IsNullOrEmpty(idLactancia) ? null : idLactancia, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "IdMesLactanciaExclusiva", Valor = string.IsNullOrEmpty(idMesLactanciaExclusiva) ? null : idMesLactanciaExclusiva, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "IdPorqueSinLactancia", Valor = string.IsNullOrEmpty(idPorqueSinLactancia) ? null : idPorqueSinLactancia, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "PerimetroBraquial", Valor = string.IsNullOrEmpty(perimetroBraquial) ? null : perimetroBraquial.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "PerimetroCefalico", Valor = string.IsNullOrEmpty(perimetroCefalico) ? null : perimetroCefalico.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "Observaciones", Valor = string.IsNullOrEmpty(observaciones) ? null : observaciones, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "IdUsuarioCreacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "FechaCreacion", Valor = fechaCreacion, Tipo = typeof(DateTime) },
                };

                resp = objBd.ejecutarProcedimiento("dbop_AddTBL_ENCUENTROEDUCATIVODETALLE", parametros, "IdEncuentroEducativoDetalle", DbType.Int32, 10);
                return resp.ToString();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool ActualizarEncuentroEducativoDetalle(string idEncuentroEducativoDetalle, string idEncuentroEducativo, string numeroIdentificacion, string idCicloVital,
                                                    string asistencia, string idMotivoInasistencia, string tieneExcusa, string peso, string talla, string dXNutricional,
                                                    string idLactancia, string idMesLactanciaExclusiva, string idPorqueSinLactancia, 
                                                    string perimetroBraquial, string perimetroCefalico, string observaciones, string idUsuarioCreacion)
        {
            try
            {
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "IdEncuentroEducativoDetalle", Valor = idEncuentroEducativoDetalle, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "IdEncuentroEducativo", Valor = idEncuentroEducativo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "IdCicloVital", Valor = idCicloVital, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "Asistencia", Valor = asistencia, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "IdMotivoInasistencia", Valor = string.IsNullOrEmpty(idMotivoInasistencia) ? null : idMotivoInasistencia, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "TieneExcusa", Valor = tieneExcusa, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "Peso", Valor = string.IsNullOrEmpty(peso) ? null : peso.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "Talla", Valor = string.IsNullOrEmpty(talla) ? null : talla.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "DXNutricional", Valor = string.IsNullOrEmpty(dXNutricional) ? null : dXNutricional, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "IdLactancia", Valor = string.IsNullOrEmpty(idLactancia) ? null : idLactancia, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "IdMesLactanciaExclusiva", Valor = string.IsNullOrEmpty(idMesLactanciaExclusiva) ? null : idMesLactanciaExclusiva, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "IdPorqueSinLactancia", Valor = string.IsNullOrEmpty(idPorqueSinLactancia) ? null : idPorqueSinLactancia, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "PerimetroBraquial", Valor = string.IsNullOrEmpty(perimetroBraquial) ? null : perimetroBraquial.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "PerimetroCefalico", Valor = string.IsNullOrEmpty(perimetroCefalico) ? null : perimetroCefalico.Replace(",", "."), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "Observaciones", Valor = string.IsNullOrEmpty(observaciones) ? null : observaciones, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "IdUsuarioModificacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "FechaModificacion", Valor = fechaCreacion, Tipo = typeof(DateTime) },
                };

                objBd.ejecutarProcedimiento("dbop_UpdateTBL_ENCUENTROEDUCATIVODETALLE", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public bool EliminarEncuentroEducativoDetalle(string idEncuentroEducativoDetalle)
        {
            try
            {
                Object resp;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdEncuentroEducativoDetalle", Valor = idEncuentroEducativoDetalle, Tipo = typeof(string) }
                };

                resp = objBd.ejecutarProcedimiento("dbop_DeleteTBL_ENCUENTROEDUCATIVODETALLE", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public bool ExisteEncuentroEducativoDetalle(string idEncuentroEducativo, string numeroIdentificacion)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdEncuentroEducativo", Valor = idEncuentroEducativo, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Val_ENCUENTROEDUCATIVODETALLE", parametros).Tables[0];

                if (dtDatos.Rows.Count > 0)
                    return true;
                else
                    return false;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

    }
}
