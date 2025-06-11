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
    public class EntregaPaquetesDetalle
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

        public DataTable ConsultarEntregaPaquetesDetalle(string idEntregaPaquetes, string ordenar, string where, int desde, string hasta)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdEntregaPaquetes", Valor = idEntregaPaquetes, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Ordenar", Valor = ordenar, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Where", Valor = where, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Desde", Valor = (desde + 1).ToString(), Tipo = typeof(string) },
                    new Parametro { NombreParametro = "@Hasta", Valor = hasta, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_Get_ENTREGAPAQUETESDETALLE", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public DataTable ObtenerEntregaPaqueteDetalle(string idEntregaPaqueteDetalle)
        {
            try
            {
                DataTable dtDatos;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "@IdEntregaPaqueteDetalle", Valor = idEntregaPaqueteDetalle, Tipo = typeof(string) }
                };

                dtDatos = objBd.ejecutarProcedimientoDS("dbop_GetTBL_ENTREGAPAQUETESDETALLE", parametros).Tables[0];
                return dtDatos;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public string InsertarEntregaPaqueteDetalle(string idEntregaPaquete, string numeroIdentificacion, string idCicloVital,
                                                    string paquete, string bienestarina, string complemento, string idUsuarioCreacion)
        {
            try
            {
                Object resp;
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "IdEntregaPaquete", Valor = idEntregaPaquete, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "IdCicloVital", Valor = idCicloVital, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "Paquete", Valor = paquete, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "Bienestarina", Valor = bienestarina, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "Complemento", Valor = complemento, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "IdUsuarioCreacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "FechaCreacion", Valor = fechaCreacion, Tipo = typeof(DateTime) },
                };

                resp = objBd.ejecutarProcedimiento("dbop_AddTBL_ENTREGAPAQUETESDETALLE", parametros, "IdEntregaPaqueteDetalle", DbType.Int32, 10);
                return resp.ToString();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return null;
            }
        }

        public bool ActualizarEntregaPaqueteDetalle(string idEntregaPaqueteDetalle, string idEntregaPaquete, string numeroIdentificacion, string idCicloVital,
                                                    string paquete, string bienestarina, string complemento, string idUsuarioCreacion)
        {
            try
            {
                DateTime fechaCreacion = DateTime.Now;

                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "IdEntregaPaqueteDetalle", Valor = idEntregaPaqueteDetalle, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "IdEntregaPaquete", Valor = idEntregaPaquete, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "NumeroIdentificacion", Valor = numeroIdentificacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "IdCicloVital", Valor = idCicloVital, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "Paquete", Valor = paquete, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "Bienestarina", Valor = bienestarina, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "Complemento", Valor = complemento, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "IdUsuarioModificacion", Valor = idUsuarioCreacion, Tipo = typeof(string) },
                    new Parametro { NombreParametro = "FechaModificacion", Valor = fechaCreacion, Tipo = typeof(DateTime) },
                };

                objBd.ejecutarProcedimiento("dbop_UpdateTBL_ENTREGAPAQUETESDETALLE", parametros);
                return true;
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public bool EliminarEntregaPaqueteDetalle(string idEntregaPaqueteDetalle)
        {
            try
            {
                Object resp;
                parametros = new List<Parametro>
                {
                    new Parametro { NombreParametro = "IdEntregaPaqueteDetalle", Valor = idEntregaPaqueteDetalle, Tipo = typeof(string) }
                };

                resp = objBd.ejecutarProcedimiento("dbop_DeleteTBL_ENTREGAPAQUETESDETALLE", parametros);
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
